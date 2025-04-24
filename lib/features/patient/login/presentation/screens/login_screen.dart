import 'package:doctorapp/features/forgot/presentation/screens/forgot_password_screen.dart';
import 'package:doctorapp/features/patient/home/presentation/screens/home_page.dart';
import 'package:doctorapp/features/patient/login/data/auth_repository.dart';
import 'package:doctorapp/features/patient/registerpatient/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(authRepository: AuthRepository()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade50,
                  Colors.white,
                ],
              ),
            ),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state.isSuccess && state.token != null) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('auth_token', state.token!);

                  if (state.user != null) {
                    await prefs.setInt('user_id', state.user!.id);
                    await prefs.setString('user_email', state.user!.email);
                    await prefs.setString('user_type', state.user!.userType);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('login_success'.tr()), backgroundColor: Colors.green),
                  );

                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, animation, __) {
                        return FadeTransition(
                          opacity: animation,
                          child: const HomePage(),
                        );
                      },
                    ),
                  );
                } else if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
                  );
                }
              },
              builder: (context, state) {
                final bloc = context.read<LoginBloc>();
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.2),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.medical_services_rounded, size: 60, color: Colors.blue),
                            ),
                            const SizedBox(height: 16),
                            Text('app_name'.tr(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue.shade800)),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Text('slogan'.tr(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blue.shade600)),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(child: Text('login'.tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade800))),
                                  const SizedBox(height: 24),
                                  Text('email'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _emailController,
                                    onChanged: (value) => bloc.add(LoginEmailChanged(value)),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'email_required'.tr();
                                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)) return 'email_invalid'.tr();
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.email, color: Colors.blue),
                                      hintText: 'email_hint'.tr(),
                                      filled: true,
                                      fillColor: Colors.blue.shade50,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text('password'.tr(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _passwordController,
                                    onChanged: (value) => bloc.add(LoginPasswordChanged(value)),
                                    obscureText: _obscurePassword,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'password_required'.tr();
                                      if (value.length < 6) return 'password_short'.tr();
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.blue),
                                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                      ),
                                      hintText: 'password_hint'.tr(),
                                      filled: true,
                                      fillColor: Colors.blue.shade50,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, animation, __) => FadeTransition(opacity: animation, child: const ForgotPasswordScreen()),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(foregroundColor: Colors.blue.shade700),
                                      child: Text('forgot_password'.tr()),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: state.isLoading ? null : () {
                                        if (_formKey.currentState!.validate()) bloc.add(LoginSubmitted());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue.shade700,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        elevation: 3,
                                      ),
                                      child: state.isLoading
                                          ? const CircularProgressIndicator(color: Colors.white)
                                          : Text('login'.tr(), style: const TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text('or_login_with'.tr(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () => bloc.add(LoginWithGoogle()),
                                borderRadius: BorderRadius.circular(50),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset('assets/imges/google (2).png', width: 30, height: 30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('no_account'.tr(), style: const TextStyle(color: Colors.grey)),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, animation, __) => FadeTransition(opacity: animation, child: const RegisterScreen()),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue.shade700,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text('register'.tr()),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    
  }
}
