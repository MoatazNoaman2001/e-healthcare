import 'package:doctorapp/screens/patient/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreenDoctor extends StatefulWidget {
  const LoginScreenDoctor({super.key});

  @override
  State<LoginScreenDoctor> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenDoctor> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = false; // إضافة متغير لإخفاء/إظهار كلمة المرور

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  'تسجيل الدخول للطبيب',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
                const SizedBox(height: 30),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // حقل البريد الإلكتروني مع محاذاة للنص
                      Directionality(
                        textDirection: TextDirection.rtl, // للنص العربي
                        child: TextFormField(
                          controller: _emailController,
                          textAlign: TextAlign.right, // محاذاة النص لليمين
                          decoration: InputDecoration(
                            labelText: 'البريد الإلكتروني',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(
                              Icons.email,
                            ), // أيقونة على اليسار
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

                      // حقل كلمة المرور مع أيقونة العين
                      Directionality(
                        textDirection: TextDirection.rtl, // للنص العربي
                        child: TextFormField(
                          controller: _passwordController,
                          textAlign: TextAlign.right, // محاذاة النص لليمين
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            prefixIcon: const Icon(
                              Icons.lock,
                            ), // أيقونة القفل على اليسار
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
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
                      const SizedBox(height: 10),

                      // باقي الكود كما هو...
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                              ),
                              const Text('تذكرني'),
                            ],
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              ' نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: Colors.teal.shade700,
                                
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:
                              _isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(fontSize: 18),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ليس لديك حساب؟'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'سجل الآن',
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    }
  }
}
