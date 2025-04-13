import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        final bloc = context.read<RegisterBloc>();

        return Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'الاسم بالكامل',
                ),
                onChanged: (value) => bloc.add(NameChanged(value)),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال الاسم' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                ),
                onChanged: (value) => bloc.add(EmailChanged(value)),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال البريد' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                ),
                onChanged: (value) => bloc.add(PhoneChanged(value)),
                validator: (value) => value!.isEmpty ? 'يرجى إدخال الهاتف' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: state.obscurePassword,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  suffixIcon: IconButton(
                    icon: Icon(state.obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => bloc.add(TogglePasswordVisibility()),
                  ),
                ),
                onChanged: (value) => bloc.add(PasswordChanged(value)),
                validator: (value) => value!.length < 6 ? 'كلمة المرور قصيرة' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: state.obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'تأكيد كلمة المرور',
                  suffixIcon: IconButton(
                    icon: Icon(state.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => bloc.add(ToggleConfirmPasswordVisibility()),
                  ),
                ),
                onChanged: (value) => bloc.add(ConfirmPasswordChanged(value)),
                validator: (value) => value != state.password ? 'كلمة المرور غير متطابقة' : null,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: state.acceptTerms,
                    onChanged: (_) => bloc.add(ToggleAcceptTerms()),
                  ),
                  const Expanded(child: Text('أوافق على الشروط والأحكام')),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: state.acceptTerms
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          bloc.add(SubmitForm());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم إنشاء الحساب')),
                          );
                        }
                      }
                    : null,
                child: const Text('إنشاء حساب'),
              ),
            ],
          ),
        );
      },
    );
  }
}
