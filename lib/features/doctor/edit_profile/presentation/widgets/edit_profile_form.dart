import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'edit_profile_field.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'د. أحمد محمد');
  final _specialtyController = TextEditingController(text: 'أخصائي أمراض باطنية');
  final _phoneController = TextEditingController(text: '0123456789');
  final _emailController = TextEditingController(text: 'doctor@example.com');
  final _addressController = TextEditingController(text: 'القاهرة، مصر');
  final _workingHoursController = TextEditingController(text: '9 ص - 5 م');

  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _workingHoursController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('profile_saved'.tr()),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EditProfileField(
            controller: _nameController,
            label: 'full_name'.tr(),
            icon: Icons.person,
            validator: (v) => v == null || v.isEmpty ? 'enter_name'.tr() : null,
          ),
          EditProfileField(
            controller: _specialtyController,
            label: 'specialty'.tr(),
            icon: Icons.medical_services,
          ),
          EditProfileField(
            controller: _phoneController,
            label: 'phone'.tr(),
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          EditProfileField(
            controller: _emailController,
            label: 'email'.tr(),
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => (v == null || v.isEmpty || !v.contains('@')) ? 'invalid_email'.tr() : null,
          ),
          EditProfileField(
            controller: _addressController,
            label: 'address'.tr(),
            icon: Icons.location_on,
          ),
          EditProfileField(
            controller: _workingHoursController,
            label: 'working_hours'.tr(),
            icon: Icons.access_time,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('save_changes'.tr(), style: const TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
