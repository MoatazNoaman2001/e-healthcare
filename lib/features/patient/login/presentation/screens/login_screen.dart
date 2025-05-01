import 'package:doctorapp/features/forgot/presentation/screens/forgot_password_screen.dart';
import 'package:doctorapp/features/patient/home/presentation/screens/home_page.dart';
import 'package:doctorapp/features/patient/login/data/auth_repository.dart';
import 'package:doctorapp/features/patient/registerpatient/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _LoginViewState extends State<_LoginView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
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
    const Color primaryColor = Color.fromARGB(255, 19, 165, 184); // Deep blue
    const Color secondaryColor = Color.fromARGB(255, 35, 107, 216); // Cyan
    const Color textDarkColor = Color(0xFF212121);
    const Color textLightColor = Color(0xFF757575);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withOpacity(0.1),
                secondaryColor.withOpacity(0.2),
                Colors.white,
              ],
              stops: [0.0, 0.5, 1.0],
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
                  SnackBar(
                    content: Text('login_success'.tr()),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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
                    transitionDuration: const Duration(milliseconds: 600),
                  ),
                );
              } else if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<LoginBloc>();
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Logo
                          // ScaleTransition(
                          //   scale: _scaleAnimation,
                          //   child: Container(
                          //     padding: const EdgeInsets.all(20),
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       gradient: LinearGradient(
                          //         begin: Alignment.topLeft,
                          //         end: Alignment.bottomRight,
                          //         colors: [primaryColor, secondaryColor],
                          //       ),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: primaryColor.withOpacity(0.15),
                          //           blurRadius: 25,
                          //           spreadRadius: 3,
                          //           offset: const Offset(0, 5),
                          //         ),
                          //       ],
                          //     ),
                          //     child: const Icon(
                          //       Icons.medical_services_rounded,
                          //       size: 70,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(height: 32),

                          // App Name "صحتي"
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [primaryColor, secondaryColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              'صحتي',
                              style: GoogleFonts.cairo(
                                fontSize: 44,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 2.0,
                                shadows: [
                                  Shadow(
                                    color: primaryColor.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Slogan
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'slogan'.tr(),
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textLightColor,
                                height: 1.5,
                                letterSpacing: 0.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Form Container
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: secondaryColor.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: -1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'login'.tr(),
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: textDarkColor,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 28),

                                // Email Field
                                Text(
                                  'email'.tr(),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: textDarkColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  onChanged: (value) =>
                                      bloc.add(LoginEmailChanged(value)),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email_required'.tr();
                                    }
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'email_invalid'.tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                    hintText: 'email_hint'.tr(),
                                    hintStyle: TextStyle(
                                      color: textLightColor.withOpacity(0.7),
                                      fontFamily: 'OpenSans',
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Password Field
                                Text(
                                  'password'.tr(),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: textDarkColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _passwordController,
                                  onChanged: (value) =>
                                      bloc.add(LoginPasswordChanged(value)),
                                  obscureText: _obscurePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'password_required'.tr();
                                    }
                                    if (value.length < 6) {
                                      return 'password_short'.tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: primaryColor,
                                      size: 22,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: primaryColor,
                                        size: 22,
                                      ),
                                      onPressed: () => setState(() =>
                                          _obscurePassword = !_obscurePassword),
                                    ),
                                    hintText: 'password_hint'.tr(),
                                    hintStyle: TextStyle(
                                      color: textLightColor.withOpacity(0.7),
                                      fontFamily: 'OpenSans',
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                      horizontal: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, animation, __) =>
                                              FadeTransition(
                                            opacity: animation,
                                            child: const ForgotPasswordScreen(),
                                          ),
                                          transitionDuration:
                                              const Duration(milliseconds: 600),
                                        ),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: secondaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                    child: Text(
                                      'forgot_password'.tr(),
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Login Button
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: state.isLoading ? 0.95 : 1.0,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: state.isLoading
                                              ? null
                                              : () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    bloc.add(LoginSubmitted());
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            elevation: 5,
                                            shadowColor:
                                                primaryColor.withOpacity(0.3),
                                          ),
                                          child: state.isLoading
                                              ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 3,
                                                  ),
                                                )
                                              : Text(
                                                  'login'.tr(),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Or Divider
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: textLightColor.withOpacity(0.5),
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 10,
                                ),
                              ),
                              Text(
                                'or_login_with'.tr(),
                                style: GoogleFonts.openSans(
                                  color: textLightColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: textLightColor.withOpacity(0.5),
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Google Sign-In
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: state.isLoading ? 0.95 : 1.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: secondaryColor.withOpacity(0.1),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: state.isLoading
                                        ? null
                                        : () => bloc.add(LoginWithGoogle()),
                                    borderRadius: BorderRadius.circular(50),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset(
                                        'assets/imges/google (2).png',
                                        width: 32,
                                        height: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),

                          // Register Prompt
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.05),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'no_account'.tr(),
                                  style: GoogleFonts.openSans(
                                    color: textLightColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, animation, __) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: const RegisterScreen(),
                                        ),
                                        transitionDuration:
                                            const Duration(milliseconds: 600),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: secondaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'register'.tr(),
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
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
