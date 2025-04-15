import 'package:doctorapp/features/doctor/login_doctor/presentation/screens/login_screen_doctor.dart';
import 'package:flutter/material.dart';

import '../widgets/register_title.dart';
import '../widgets/name_field.dart';
import '../widgets/email_field.dart';
import '../widgets/phone_field.dart';
import '../widgets/password_field.dart';
import '../widgets/confirm_password_field.dart';
import '../widgets/register_button.dart';
import '../widgets/login_prompt.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إنشاء الحساب بنجاح'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreenDoctor()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تسجيل حساب جديد'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade700,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const RegisterTitle(),
                const SizedBox(height: 30),
                NameField(controller: _nameController),
                const SizedBox(height: 20),
                EmailField(controller: _emailController),
                const SizedBox(height: 20),
                PhoneField(controller: _phoneController),
                const SizedBox(height: 20),
                PasswordField(
                  controller: _passwordController,
                  showPassword: _showPassword,
                  onToggle: () => setState(() => _showPassword = !_showPassword),
                ),
                const SizedBox(height: 20),
                ConfirmPasswordField(
                  controller: _confirmPasswordController,
                  passwordController: _passwordController,
                  showPassword: _showConfirmPassword,
                  onToggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
                ),
                const SizedBox(height: 30),
                RegisterButton(
                  isLoading: _isLoading,
                  onPressed: _register,
                ),
                const SizedBox(height: 20),
                const LoginPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
