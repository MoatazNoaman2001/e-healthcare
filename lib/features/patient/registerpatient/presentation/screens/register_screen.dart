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

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

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

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF006272)),
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 255, 255),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 214, 249, 247), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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
                      const SizedBox(height: 20),
                      const Icon(Icons.medical_services_rounded,
                          size: 60, color: Color(0xFF006272)),
                      const SizedBox(height: 10),
                      Text('register_title'.tr(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF006272),
                          )),
                      const SizedBox(height: 30),
                      _buildTextField(
                        label: 'first_name'.tr(),
                        hint: 'enter_first_name'.tr(),
                        icon: Icons.person,
                        validatorMsg: 'first_name_required'.tr(),
                        onChanged: (val) => bloc.add(FirstNameChanged(val)),
                      ),
                      _buildTextField(
                        label: 'last_name'.tr(),
                        hint: 'enter_last_name'.tr(),
                        icon: Icons.person_outline,
                        validatorMsg: 'last_name_required'.tr(),
                        onChanged: (val) => bloc.add(LastNameChanged(val)),
                      ),
                      _buildDatePickerField(context, bloc),
                      _buildDropdown(
                        label: 'gender'.tr(),
                        value: state.gender,
                        items: ['male', 'female'],
                        itemLabels: ['male'.tr(), 'female'.tr()],
                        icon: Icons.person,
                        onChanged: (val) => bloc.add(GenderChanged(val!)),
                        validator: 'gender_required'.tr(),
                      ),
                      _buildDropdown(
                        label: 'blood_type'.tr(),
                        value: state.bloodType,
                        items: _bloodTypes,
                        itemLabels: _bloodTypes,
                        icon: Icons.bloodtype,
                        onChanged: (val) => bloc.add(BloodTypeChanged(val!)),
                        validator: 'blood_required'.tr(),
                      ),
                      _buildTextField(
                        label: 'email'.tr(),
                        hint: 'enter_email'.tr(),
                        icon: Icons.email_outlined,
                        validatorMsg: 'email_required'.tr(),
                        onChanged: (val) => bloc.add(EmailChanged(val)),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildTextField(
                        label: 'phone'.tr(),
                        hint: 'enter_phone'.tr(),
                        icon: Icons.phone_android,
                        validatorMsg: 'phone_required'.tr(),
                        onChanged: (val) => bloc.add(PhoneChanged(val)),
                        keyboardType: TextInputType.phone,
                      ),
                      _buildPasswordField(
                        label: 'password'.tr(),
                        hint: 'enter_password'.tr(),
                        obscure: _obscurePassword,
                        toggle: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        onChanged: (val) => bloc.add(PasswordChanged(val)),
                        validator: (val) => val != null && val.length < 6
                            ? 'password_too_short'.tr()
                            : null,
                      ),
                      _buildPasswordField(
                        label: 'confirm_password'.tr(),
                        hint: 'reenter_password'.tr(),
                        obscure: _obscureConfirmPassword,
                        toggle: () => setState(() =>
                            _obscureConfirmPassword = !_obscureConfirmPassword),
                        onChanged: (val) =>
                            bloc.add(ConfirmPasswordChanged(val)),
                        validator: (val) => val != state.password
                            ? 'password_mismatch'.tr()
                            : null,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Checkbox(
                            value: state.acceptTerms,
                            onChanged: (val) =>
                                bloc.add(AcceptTermsChanged(val!)),
                          ),
                          Expanded(
                            child: Text('terms_accept'.tr(),
                                style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
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
                                ? const Color(0xFF006272)
                                : Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text('register'.tr(),
                                  style: const TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('already_have_account'.tr(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
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

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required String validatorMsg,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: (val) => val == null || val.isEmpty ? validatorMsg : null,
          decoration: _inputDecoration(hint, icon),
        ),
        const SizedBox(height: 16),
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
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscure,
          onChanged: onChanged,
          validator: validator,
          decoration: _inputDecoration(hint, Icons.lock_outline).copyWith(
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: toggle,
            ),
          ),
        ),
        const SizedBox(height: 16),
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
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: _inputDecoration(label, icon),
          items: List.generate(
            items.length,
            (index) => DropdownMenuItem(
              value: items[index],
              child: Text(itemLabels[index]),
            ),
          ),
          onChanged: onChanged,
          validator: (val) => val == null || val.isEmpty ? validator : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePickerField(BuildContext context, RegisterBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('birthdate'.tr(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: _dateController,
          readOnly: true,
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000, 1, 1),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
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
          validator: (_) =>
              _selectedDate == null ? 'birthdate_required'.tr() : null,
          decoration:
              _inputDecoration('select_birthdate'.tr(), Icons.cake_outlined),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
