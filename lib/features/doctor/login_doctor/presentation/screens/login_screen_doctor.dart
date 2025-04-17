import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_repository.dart';
import '../bloc/doctor_login_bloc.dart';
import '../widgets/login_title.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/remember_and_forgot_row.dart';
import '../widgets/login_button.dart';
import '../widgets/register_prompt.dart';

class LoginScreenDoctor extends StatelessWidget {
  const LoginScreenDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorLoginBloc(authRepository: AuthRepository()),
      child: const _LoginScreenDoctorView(),
    );
  }
}

class _LoginScreenDoctorView extends StatefulWidget {
  const _LoginScreenDoctorView();

  @override
  State<_LoginScreenDoctorView> createState() => _LoginScreenDoctorViewState();
}

class _LoginScreenDoctorViewState extends State<_LoginScreenDoctorView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<DoctorLoginBloc, DoctorLoginState>(
          listener: (context, state) {
            if (state.isSuccess && state.token != null) {
              // عرض رسالة نجاح
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تسجيل الدخول بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );

              // الانتقال إلى الصفحة الرئيسية
              Navigator.pushReplacementNamed(context, '/HomeScreen');

            } else if (state.error != null) {
              // عرض رسالة الخطأ
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
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
                        EmailField(
                          controller: _emailController,
                          onChanged: (value) {
                            context.read<DoctorLoginBloc>().add(
                              DoctorLoginEmailChanged(value),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          onToggleVisibility: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                          onChanged: (value) {
                            context.read<DoctorLoginBloc>().add(
                              DoctorLoginPasswordChanged(value),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        RememberAndForgotRow(
                          remember: state.rememberMe,
                          onChanged: (val) {
                            context.read<DoctorLoginBloc>().add(
                              DoctorLoginRememberMeChanged(val!),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        LoginButton(
                          isLoading: state.isLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<DoctorLoginBloc>().add(
                                DoctorLoginSubmitted(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // const RegisterPrompt(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}