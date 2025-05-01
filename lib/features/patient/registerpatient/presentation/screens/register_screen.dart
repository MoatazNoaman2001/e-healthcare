// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:doctorapp/features/patient/registerpatient/data/auth_repository.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(authRepository: AuthRepository()),
      child: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late TextEditingController _dateController;
  String? _selectedDate;

  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Define colors at class level
   Color primaryColor = Color.fromARGB(255, 19, 165, 184); // Deep blue
    Color secondaryColor = Color.fromARGB(255, 35, 107, 216); // Cyan
     Color textDarkColor = Color(0xFF212121);
     Color textLightColor = Color(0xFF757575);
  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
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
    _dateController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hint, IconData icon, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.openSans(
        color: textLightColor.withOpacity(0.7),
      ),
      prefixIcon: Icon(icon, color: primaryColor, size: 22),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: primaryColor.withOpacity(0.05),
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
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 19, 165, 184).withOpacity(0.1),
              primaryColor.withOpacity(0.15),
              Colors.white,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('register_success'.tr()),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                  Navigator.pop(context);
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
                final bloc = context.read<RegisterBloc>();
                return FadeTransition(
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
                                  BoxShadow(
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

                          // Title
                          Text(
                            'register_title'.tr(),
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: textDarkColor,
                              letterSpacing: 0.8,
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
                                  color: primaryColor.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: -1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First Name
                                _buildTextField(
                                  label: 'first_name'.tr(),
                                  hint: 'enter_first_name'.tr(),
                                  icon: Icons.person,
                                  validatorMsg: 'first_name_required'.tr(),
                                  onChanged: (val) => bloc.add(FirstNameChanged(val)),
                                ),

                                // Last Name
                                _buildTextField(
                                  label: 'last_name'.tr(),
                                  hint: 'enter_last_name'.tr(),
                                  icon: Icons.person_outline,
                                  validatorMsg: 'last_name_required'.tr(),
                                  onChanged: (val) => bloc.add(LastNameChanged(val)),
                                ),

                                // Date of Birth
                                _buildDatePickerField(context, bloc),

                                // Gender
                                _buildDropdown(
                                  label: 'gender'.tr(),
                                  value: state.gender,
                                  items: ['male', 'female'],
                                  itemLabels: ['male'.tr(), 'female'.tr()],
                                  icon: Icons.person,
                                  onChanged: (val) => bloc.add(GenderChanged(val!)),
                                  validator: 'gender_required'.tr(),
                                ),

                                // Blood Type
                                _buildDropdown(
                                  label: 'blood_type'.tr(),
                                  value: state.bloodType,
                                  items: _bloodTypes,
                                  itemLabels: _bloodTypes,
                                  icon: Icons.bloodtype,
                                  onChanged: (val) => bloc.add(BloodTypeChanged(val!)),
                                  validator: 'blood_required'.tr(),
                                ),

                                // Email
                                _buildTextField(
                                  label: 'email'.tr(),
                                  hint: 'enter_email'.tr(),
                                  icon: Icons.email_outlined,
                                  validatorMsg: 'email_required'.tr(),
                                  onChanged: (val) => bloc.add(EmailChanged(val)),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'email_required'.tr();
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                                      return 'email_invalid'.tr();
                                    }
                                    return null;
                                  },
                                ),

                                // Phone
                                _buildTextField(
                                  label: 'phone'.tr(),
                                  hint: 'enter_phone'.tr(),
                                  icon: Icons.phone_android,
                                  validatorMsg: 'phone_required'.tr(),
                                  onChanged: (val) => bloc.add(PhoneChanged(val)),
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'phone_required'.tr();
                                    }
                                    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(val)) {
                                      return 'phone_invalid'.tr();
                                    }
                                    return null;
                                  },
                                ),

                                // Password
                                _buildPasswordField(
                                  label: 'password'.tr(),
                                  hint: 'enter_password'.tr(),
                                  obscure: _obscurePassword,
                                  toggle: () => setState(() => _obscurePassword = !_obscurePassword),
                                  onChanged: (val) => bloc.add(PasswordChanged(val)),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'password_required'.tr();
                                    }
                                    if (val.length < 6) {
                                      return 'password_too_short'.tr();
                                    }
                                    return null;
                                  },
                                ),

                                // Confirm Password
                                _buildPasswordField(
                                  label: 'confirm_password'.tr(),
                                  hint: 'reenter_password'.tr(),
                                  obscure: _obscureConfirmPassword,
                                  toggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                                  onChanged: (val) => bloc.add(ConfirmPasswordChanged(val)),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'confirm_password_required'.tr();
                                    }
                                    if (val != state.password) {
                                      return 'password_mismatch'.tr();
                                    }
                                    return null;
                                  },
                                ),

                                // Terms Checkbox
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: state.acceptTerms,
                                        onChanged: (val) => bloc.add(AcceptTermsChanged(val!)),
                                        activeColor: primaryColor,
                                        checkColor: Colors.white,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'terms_accept'.tr(),
                                          style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            color: textDarkColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Register Button
                                AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: state.isLoading ? 0.95 : 1.0,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 56,
                                        child: ElevatedButton(
                                          onPressed: state.acceptTerms && !state.isLoading
                                              ? () {
                                                  if (_formKey.currentState!.validate()) {
                                                    bloc.add(RegisterSubmitted());
                                                  }
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: state.acceptTerms ? primaryColor : Colors.grey.shade300,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            elevation: 5,
                                            shadowColor: primaryColor.withOpacity(0.3),
                                            disabledBackgroundColor: Colors.grey.shade300,
                                          ),
                                          child: state.isLoading
                                              ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 3,
                                                  ),
                                                )
                                              : Text(
                                                  'register'.tr(),
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
                          const SizedBox(height: 24),

                          // Back to Login
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
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
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                foregroundColor: primaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              child: Text(
                                'already_have_account'.tr(),
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
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

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required String validatorMsg,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textDarkColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator ?? (val) => val == null || val.isEmpty ? validatorMsg : null,
          decoration: _inputDecoration(hint, icon),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textDarkColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: obscure,
          onChanged: onChanged,
          validator: validator,
          decoration: _inputDecoration(hint, Icons.lock_outline, suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
              size: 22,
            ),
            onPressed: toggle,
          )),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required List<String> itemLabels,
    required IconData icon,
    required void Function(String?) onChanged,
    required String validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textDarkColor,
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: value,
          decoration: _inputDecoration(label, icon),
          items: List.generate(
            items.length,
            (index) => DropdownMenuItem(
              value: items[index],
              child: Text(
                itemLabels[index],
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  color: textDarkColor,
                ),
              ),
            ),
          ),
          onChanged: onChanged,
          validator: (val) => val == null ? validator : null,
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down, color: primaryColor, size: 24),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDatePickerField(BuildContext context, RegisterBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'birthdate'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textDarkColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000, 1, 1),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme:  ColorScheme.light(
                      primary: primaryColor,
                      onPrimary: Colors.white,
                      onSurface: textDarkColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              final formatted =
                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
              setState(() {
                _selectedDate = formatted;
                _dateController.text = formatted;
              });
              bloc.add(DateOfBirthChanged(formatted));
            }
          },
          validator: (_) => _selectedDate == null ? 'birthdate_required'.tr() : null,
          decoration: _inputDecoration('select_birthdate'.tr(), Icons.cake_outlined),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}