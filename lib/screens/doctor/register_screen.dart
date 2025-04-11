import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تسجيل حساب جديد'),
          backgroundColor: Colors.teal.shade700,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                Text(
                  'إنشاء حساب طبيب جديد',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // نموذج التسجيل
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // حقل الاسم
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _nameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            labelText: 'الاسم بالكامل',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال الاسم';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // حقل البريد الإلكتروني
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _emailController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال البريد الإلكتروني';
                            }
                            if (!value.contains('@')) {
                              return 'بريد إلكتروني غير صالح';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // حقل الهاتف
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _phoneController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            labelText: 'رقم الهاتف',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال رقم الهاتف';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // حقل كلمة المرور
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _passwordController,
                          textAlign: TextAlign.right,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال كلمة المرور';
                            }
                            if (value.length < 6) {
                              return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // تأكيد كلمة المرور
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          textAlign: TextAlign.right,
                          obscureText: !_showConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'تأكيد كلمة المرور',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showConfirmPassword = !_showConfirmPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء تأكيد كلمة المرور';
                            }
                            if (value != _passwordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),

                      // زر التسجيل
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child:
                              _isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'تسجيل الحساب',
                                    style: TextStyle(fontSize: 18),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // رابط الانتقال لتسجيل الدخول
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('لديك حساب بالفعل؟'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreenDoctor(),
                          ),
                        );
                      },
                      child: Text(
                        ' سجل الدخول',
                        style: TextStyle(
                          color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
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
        MaterialPageRoute(builder: (context) => const LoginScreenDoctor()),
      );
    }
  }
}
