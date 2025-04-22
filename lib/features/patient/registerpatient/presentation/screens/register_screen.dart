import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late TextEditingController _dateController;
  String? _selectedDate;

  // List of blood types for dropdown
  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

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
                    const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
                  );
                  Navigator.pop(context);
                } else if (state.error != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error!)));
                }
              },
              builder: (context, state) {
                final bloc = context.read<RegisterBloc>();

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // الاسم الأول
                      const Text('الاسم الأول'),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (val) => bloc.add(FirstNameChanged(val)),
                        decoration: const InputDecoration(
                          hintText: 'أدخل الاسم الأول',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator:
                            (val) =>
                        val == null || val.isEmpty
                            ? 'يرجى إدخال الاسم الأول'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // الاسم الأخير
                      const Text('الاسم الأخير'),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (val) => bloc.add(LastNameChanged(val)),
                        decoration: const InputDecoration(
                          hintText: 'أدخل الاسم الأخير',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator:
                            (val) =>
                        val == null || val.isEmpty
                            ? 'يرجى إدخال الاسم الأخير'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // تاريخ الميلاد
                      const Text('تاريخ الميلاد'),
                      const SizedBox(height: 8),
                      TextFormField(
                        readOnly: true,
                        controller: _dateController,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000, 1, 1),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            helpText: 'اختر تاريخ الميلاد',
                            // locale: const Locale('ar'),
                          );

                          if (pickedDate != null) {
                            final formatted =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                            setState(() {
                              _selectedDate = formatted;
                              _dateController.text = formatted;
                            });

                            context.read<RegisterBloc>().add(
                              DateOfBirthChanged(formatted),
                            );
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'اختر تاريخ الميلاد',
                          prefixIcon: Icon(Icons.cake_outlined),
                        ),
                        validator:
                            (_) =>
                        _selectedDate == null
                            ? 'يرجى اختيار تاريخ الميلاد'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // الجنس
                      const Text('الجنس'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: state.gender,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'male', child: Text('ذكر')),
                          DropdownMenuItem(value: 'female', child: Text('أنثى')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(GenderChanged(value));
                          }
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'يرجى اختيار الجنس'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // فصيلة الدم
                      const Text('فصيلة الدم'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: state.bloodType,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.bloodtype),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: OutlineInputBorder(),
                        ),
                        items: _bloodTypes.map((String bloodType) {
                          return DropdownMenuItem<String>(
                            value: bloodType,
                            child: Text(bloodType),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(BloodTypeChanged(value));
                          }
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'يرجى اختيار فصيلة الدم'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // البريد الإلكتروني
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
                          if (val == null || val.isEmpty) {
                            return 'يرجى إدخال البريد';
                          }
                          final regex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          return regex.hasMatch(val) ? null : 'بريد غير صحيح';
                        },
                      ),
                      const SizedBox(height: 16),

                      // رقم الهاتف
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
                          if (val == null || val.isEmpty) {
                            return 'يرجى إدخال الهاتف';
                          }
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
                        ),
                        validator:
                            (val) =>
                        val != null && val.length < 6
                            ? 'يجب 6 أحرف على الأقل'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // تأكيد كلمة المرور
                      const Text('تأكيد كلمة المرور'),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: _obscureConfirmPassword,
                        onChanged:
                            (val) => bloc.add(ConfirmPasswordChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'أعد إدخال كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator:
                            (val) =>
                        val != state.password
                            ? 'كلمة المرور غير متطابقة'
                            : null,
                      ),
                      const SizedBox(height: 24),

                      // الموافقة على الشروط
                      Row(
                        children: [
                          Checkbox(
                            value: state.acceptTerms,
                            onChanged:
                                (val) =>
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
                      const SizedBox(height: 24),

                      // زر التسجيل
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed:
                          state.acceptTerms
                              ? () {
                            if (_formKey.currentState!.validate()) {
                              bloc.add(RegisterSubmitted());
                            }
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            state.acceptTerms
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                          ),
                          child:
                          state.isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
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

                      // تسجيل الدخول
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('لديك حساب بالفعل؟'),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'تسجيل الدخول',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
