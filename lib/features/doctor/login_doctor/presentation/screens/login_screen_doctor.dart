import 'package:flutter/material.dart';
import '../widgets/login_title.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/remember_and_forgot_row.dart';
import '../widgets/login_button.dart';
import '../widgets/register_prompt.dart';

class LoginScreenDoctor extends StatefulWidget {
  const LoginScreenDoctor({super.key});

  @override
  State<LoginScreenDoctor> createState() => _LoginScreenDoctorState();
}

class _LoginScreenDoctorState extends State<LoginScreenDoctor> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const LoginTitle(),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EmailField(controller: _emailController),
                    const SizedBox(height: 20),
                    PasswordField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    const SizedBox(height: 10),
                    RememberAndForgotRow(
                      remember: _rememberMe,
                      onChanged: (val) => setState(() => _rememberMe = val),
                    ),
                    const SizedBox(height: 30),
                    LoginButton(
                      isLoading: _isLoading,
                      onPressed: _login,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const RegisterPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
