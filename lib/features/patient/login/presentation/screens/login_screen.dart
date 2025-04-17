import 'package:doctorapp/features/forgot/presentation/screens/forgot_password_screen.dart';
import 'package:doctorapp/features/patient/home/presentation/screens/home_page.dart';
import 'package:doctorapp/features/patient/login/data/auth_repository.dart';
import 'package:doctorapp/features/patient/registerpatient/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state.isSuccess && state.token != null) {
                // حفظ التوكن ومعلومات المستخدم
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('auth_token', state.token!);

                // يمكن أيضاً حفظ معلومات المستخدم إذا كنت بحاجة إليها
                if (state.user != null) {
                  await prefs.setInt('user_id', state.user!.id);
                  await prefs.setString('user_email', state.user!.email);
                  await prefs.setString('user_type', state.user!.userType);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تسجيل الدخول بنجاح')),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              } else if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<LoginBloc>();
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Icon(Icons.medical_services_rounded, size: 70),
                      const SizedBox(height: 16),
                      const Text('صحتي', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('رعاية طبية في متناول يديك'),

                      const SizedBox(height: 32),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('البريد الإلكتروني', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        onChanged: (value) => bloc.add(LoginEmailChanged(value)),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الإلكتروني';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'الرجاء إدخال بريد إلكتروني صحيح';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'أدخل بريدك الإلكتروني',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('كلمة المرور', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordController,
                        onChanged: (value) => bloc.add(LoginPasswordChanged(value)),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          hintText: 'أدخل كلمة المرور',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                          },
                          child: const Text('نسيت كلمة المرور؟'),
                        ),
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              bloc.add(LoginSubmitted());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('تسجيل الدخول', style: TextStyle(fontSize: 18)),
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Text('أو التسجيل باستخدام'),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => bloc.add(LoginWithGoogle()),
                        child: Image.asset('assets/imges/google (2).png', width: 50),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('ليس لديك حساب؟'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
                            },
                            child: const Text('إنشاء حساب'),
                          ),
                        ],
                      ),
                    ],
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