// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/register_bloc.dart';
// import '../widgets/register_form.dart';

// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => RegisterBloc(),
//       child: const Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: RegisterForm(),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إنشاء حساب'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
                  );
                  Navigator.pop(context);
                } else if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!)),
                  );
                }
              },
              builder: (context, state) {
                final bloc = context.read<RegisterBloc>();

                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'مرحباً بك!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'أنشئ حسابك للوصول لخدمات صحتي',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 32),

                      // الاسم
                      const Text('الاسم بالكامل'),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (val) => bloc.add(NameChanged(val)),
                        decoration: const InputDecoration(
                          hintText: 'أدخل اسمك الكامل',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (val) =>
                            val == null || val.isEmpty ? 'يرجى إدخال الاسم' : null,
                      ),
                      const SizedBox(height: 16),

                      // الإيميل
                      const Text('البريد الإلكتروني'),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) => bloc.add(EmailChanged(val)),
                        decoration: const InputDecoration(
                          hintText: 'أدخل بريدك الإلكتروني',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'يرجى إدخال البريد';
                          final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          return regex.hasMatch(val) ? null : 'بريد غير صحيح';
                        },
                      ),
                      const SizedBox(height: 16),

                      // الهاتف
                      const Text('رقم الهاتف'),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => bloc.add(PhoneChanged(val)),
                        decoration: const InputDecoration(
                          hintText: 'أدخل رقم هاتفك',
                          prefixIcon: Icon(Icons.phone_android),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) return 'يرجى إدخال الهاتف';
                          return val.length < 11 ? 'رقم غير صحيح' : null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // كلمة المرور
                      const Text('كلمة المرور'),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: _obscurePassword,
                        onChanged: (val) => bloc.add(PasswordChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'أدخل كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (val) =>
                            val != null && val.length < 6 ? 'يجب 6 أحرف على الأقل' : null,
                      ),
                      const SizedBox(height: 16),

                      // تأكيد كلمة المرور
                      const Text('تأكيد كلمة المرور'),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: _obscureConfirmPassword,
                        onChanged: (val) =>
                            bloc.add(ConfirmPasswordChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'أعد إدخال كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (val) => val != state.password
                            ? 'كلمة المرور غير متطابقة'
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // الموافقة على الشروط
                      Row(
                        children: [
                          Checkbox(
                            value: state.acceptTerms,
                            onChanged: (val) =>
                                bloc.add(AcceptTermsChanged(val ?? false)),
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'أوافق على ',
                                children: [
                                  TextSpan(
                                    text: 'الشروط والأحكام',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(text: ' و'),
                                  TextSpan(
                                    text: 'سياسة الخصوصية',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // زر التسجيل
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: state.acceptTerms
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    bloc.add(RegisterSubmitted());
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.acceptTerms
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'إنشاء حساب',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // تسجيل دخول
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'لديك حساب بالفعل؟',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
