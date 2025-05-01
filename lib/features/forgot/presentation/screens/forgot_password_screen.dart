import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/forgot_password_bloc.dart';
import '../bloc/forgot_password_event.dart';
import '../bloc/forgot_password_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Define colors at class level
   Color primaryColor = Color(0xFF00BCD4); // Cyan (primary)
     Color secondaryColor = Color(0xFF3949AB); // Deep blue (secondary)
    Color textDarkColor = Color(0xFF212121);
  Color textLightColor = Color(0xFF757575);
    Color primaryColorOpacity10 = Color.fromRGBO(0, 188, 212, 0.1);
   Color primaryColorOpacity15 = Color.fromRGBO(0, 188, 212, 0.15);
  Color primaryColorOpacity05 = Color.fromRGBO(0, 188, 212, 0.05);
    Color primaryColorOpacity30 = Color.fromRGBO(0, 188, 212, 0.3);

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
    _animationController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.openSans(
        color: textLightColor.withOpacity(0.7),
      ),
      prefixIcon: Icon(Icons.email_outlined, color: primaryColor, size: 22),
      filled: true,
      fillColor: primaryColorOpacity05,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forgot_password_title'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textDarkColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColorOpacity10,
              primaryColorOpacity15,
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('reset_link_sent'.tr()),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is ForgotPasswordError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
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
                final bloc = context.read<ForgotPasswordBloc>();
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Logo
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient:  LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [primaryColor, secondaryColor],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColorOpacity15,
                                    blurRadius: 25,
                                    spreadRadius: 3,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.medical_services_rounded,
                                size: 70,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

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
                                  BoxShadow(
                                    color: primaryColorOpacity30,
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Instruction
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'forgot_password_instruction'.tr(),
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: textLightColor,
                                height: 1.5,
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
                                  color: primaryColorOpacity10,
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: primaryColorOpacity05,
                                  blurRadius: 10,
                                  spreadRadius: -1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email Field
                                Text(
                                  'email'.tr(),
                                  style: GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: textDarkColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  // onChanged: (value) => bloc.add(EmailChangedEvent(value)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'email_required'.tr();
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                      return 'email_invalid'.tr();
                                    }
                                    return null;
                                  },
                                  decoration: _inputDecoration('email_hint'.tr()),
                                ),
                                const SizedBox(height: 24),

                                // Submit Button
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: state is ForgotPasswordLoading ? 0.95 : 1.0,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: state is ForgotPasswordLoading
                                              ? null
                                              : () {
                                                  if (_formKey.currentState!.validate()) {
                                                    final email = _emailController.text.trim();
                                                    bloc.add(SendResetLinkEvent(email));
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            elevation: 5,
                                            shadowColor: primaryColorOpacity30,
                                            disabledBackgroundColor: Colors.grey.shade300,
                                          ),
                                          child: state is ForgotPasswordLoading
                                              ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 3,
                                                  ),
                                                )
                                              : Text(
                                                  'send_reset'.tr(),
                                                  style: GoogleFonts.cairo(
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
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context, ForgotPasswordBloc bloc) {
    return Container(); // Placeholder to avoid errors if referenced elsewhere
  }
}