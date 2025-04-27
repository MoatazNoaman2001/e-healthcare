import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_event.dart';
import '../bloc/edit_profile_state.dart';
import '../../../profile/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDateController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String? _selectedGender;
  String? _selectedBloodType;

  final List<String> _genders = ['male', 'female'];
  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _birthDateController = TextEditingController(text: widget.user.dateOfBirth);
    _heightController = TextEditingController(); 
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit_profile'.tr()),
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('profile_updated_successfully'.tr())),
            );
            Navigator.pop(context, true);
          } else if (state is EditProfileFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(_firstNameController, 'first_name'.tr()),
                const SizedBox(height: 16),
                _buildTextField(_lastNameController, 'last_name'.tr()),
                const SizedBox(height: 16),
                _buildTextField(_emailController, 'email'.tr(), keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                _buildTextField(_phoneController, 'phone'.tr(), keyboardType: TextInputType.phone),
                const SizedBox(height: 16),
                _buildTextField(_birthDateController, 'birthdate'.tr(), readOnly: true, onTap: _selectBirthDate),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'gender'.tr(),
                  value: _selectedGender,
                  items: _genders,
                  onChanged: (val) => setState(() => _selectedGender = val),
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'blood_type'.tr(),
                  value: _selectedBloodType,
                  items: _bloodTypes,
                  onChanged: (val) => setState(() => _selectedBloodType = val),
                ),
                const SizedBox(height: 16),
                _buildTextField(_heightController, 'height'.tr(), keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(_weightController, 'weight'.tr(), keyboardType: TextInputType.number),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onSavePressed,
                  child: Text('save'.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field_required'.tr();
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field_required'.tr();
        }
        return null;
      },
    );
  }

  Future<void> _onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');
        final patientId = prefs.getInt('user_id');

        if (token == null || patientId == null) {
          throw Exception('بيانات تسجيل الدخول غير موجودة');
        }

        context.read<EditProfileBloc>().add(
          UpdateProfile(
            patientId: patientId,
            token: token,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            birthDate: _birthDateController.text.trim(),
            gender: _selectedGender ?? 'male',
            bloodType: _selectedBloodType ?? 'A+',
            height: _heightController.text.isNotEmpty ? _heightController.text : '170',
            weight: _weightController.text.isNotEmpty ? _weightController.text : '70',
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error_loading_auth_data'.tr())),
        );
      }
    }
  }

  Future<void> _selectBirthDate() async {
    DateTime initialDate = DateTime.tryParse(_birthDateController.text) ?? DateTime(2000);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      _birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }
}
