import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_event.dart';
import '../bloc/edit_profile_state.dart';
import '../../../profile/data/models/user_model.dart'; // لو عندك موديل User

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

  String _selectedGender = 'male';
  String _selectedBloodType = 'A+';

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _birthDateController = TextEditingController(text: widget.user.dateOfBirth);
    _heightController = TextEditingController(text: '170');
    _weightController = TextEditingController(text: '70');
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
                _buildDropdownGender(),
                const SizedBox(height: 16),
                _buildDropdownBloodType(),
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

  Widget _buildDropdownGender() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      items: ['male', 'female'].map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender.tr()),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value ?? 'male';
        });
      },
      decoration: InputDecoration(
        labelText: 'gender'.tr(),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdownBloodType() {
    final bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    return DropdownButtonFormField<String>(
      value: _selectedBloodType,
      items: bloodTypes.map((blood) {
        return DropdownMenuItem(
          value: blood,
          child: Text(blood),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedBloodType = value ?? 'A+';
        });
      },
      decoration: InputDecoration(
        labelText: 'blood_type'.tr(),
        border: const OutlineInputBorder(),
      ),
    );
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

  Future<void> _onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final patientId = prefs.getInt('user_id'); // أو حسب مكان تخزين id

      if (patientId != null) {
        context.read<EditProfileBloc>().add(
          UpdateProfile(
            patientId: patientId,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            birthDate: _birthDateController.text.trim(),
            gender: _selectedGender,
            bloodType: _selectedBloodType,
            height: _heightController.text.trim(),
            weight: _weightController.text.trim(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error_loading_auth_data'.tr())),
        );
      }
    }
  }
}
