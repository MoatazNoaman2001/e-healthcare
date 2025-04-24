import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late TextEditingController _dateController;
  String? _selectedDate;

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
    return  Scaffold(
        appBar: AppBar(
          title: Text('register_title'.tr()),
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
                    SnackBar(content: Text('register_success'.tr())),
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
                    children: [
                      const SizedBox(height: 16),
                      Text('first_name'.tr()),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (val) => bloc.add(FirstNameChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'enter_first_name'.tr(),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (val) =>
                            val == null || val.isEmpty ? 'first_name_required'.tr() : null,
                      ),
                      const SizedBox(height: 16),
                      Text('last_name'.tr()),
                      const SizedBox(height: 8),
                      TextFormField(
                        onChanged: (val) => bloc.add(LastNameChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'enter_last_name'.tr(),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: (val) =>
                            val == null || val.isEmpty ? 'last_name_required'.tr() : null,
                      ),
                      const SizedBox(height: 16),
                      Text('birthdate'.tr()),
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
                            helpText: 'select_birthdate'.tr(),
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
                        decoration: InputDecoration(
                          hintText: 'select_birthdate'.tr(),
                          prefixIcon: const Icon(Icons.cake_outlined),
                        ),
                        validator: (_) =>
                            _selectedDate == null ? 'birthdate_required'.tr() : null,
                      ),
                      const SizedBox(height: 16),
                      Text('gender'.tr()),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: state.gender,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'male', child: Text('male'.tr())),
                          DropdownMenuItem(value: 'female', child: Text('female'.tr())),
                        ],
                        onChanged: (value) {
                          if (value != null) bloc.add(GenderChanged(value));
                        },
                        validator: (value) =>
                            value == null || value.isEmpty ? 'gender_required'.tr() : null,
                      ),
                      const SizedBox(height: 16),
                      Text('blood_type'.tr()),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: state.bloodType,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.bloodtype),
                          border: OutlineInputBorder(),
                        ),
                        items: _bloodTypes.map((String bloodType) {
                          return DropdownMenuItem<String>(
                            value: bloodType,
                            child: Text(bloodType),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) bloc.add(BloodTypeChanged(value));
                        },
                        validator: (value) =>
                            value == null || value.isEmpty ? 'blood_required'.tr() : null,
                      ),
                      const SizedBox(height: 16),
                      Text('email'.tr()),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) => bloc.add(EmailChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'enter_email'.tr(),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'email_required'.tr();
                          }
                          final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          return regex.hasMatch(val) ? null : 'invalid_email'.tr();
                        },
                      ),
                      const SizedBox(height: 16),
                      Text('phone'.tr()),
                      const SizedBox(height: 8),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onChanged: (val) => bloc.add(PhoneChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'enter_phone'.tr(),
                          prefixIcon: const Icon(Icons.phone_android),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'phone_required'.tr();
                          }
                          return val.length < 11 ? 'invalid_phone'.tr() : null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text('password'.tr()),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: _obscurePassword,
                        onChanged: (val) => bloc.add(PasswordChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'enter_password'.tr(),
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
                            val != null && val.length < 6 ? 'password_too_short'.tr() : null,
                      ),
                      const SizedBox(height: 16),
                      Text('confirm_password'.tr()),
                      const SizedBox(height: 8),
                      TextFormField(
                        obscureText: _obscureConfirmPassword,
                        onChanged: (val) => bloc.add(ConfirmPasswordChanged(val)),
                        decoration: InputDecoration(
                          hintText: 'reenter_password'.tr(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (val) =>
                            val != state.password ? 'password_mismatch'.tr() : null,
                      ),
                      const SizedBox(height: 24),
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
                                text: 'terms_accept'.tr(),
                                children: [
                                  TextSpan(
                                    text: 'terms'.tr(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: 'and'.tr()),
                                  TextSpan(
                                    text: 'privacy'.tr(),
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
                              : Text('register'.tr(),
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('already_have_account'.tr()),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('login'.tr(),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
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
      );
  }
}
