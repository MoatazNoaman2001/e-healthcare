import 'package:flutter/material.dart';
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
        const SnackBar(
          content: Text('تم حفظ التعديلات بنجاح'),
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
            label: 'الاسم بالكامل',
            icon: Icons.person,
            validator: (v) => v == null || v.isEmpty ? 'الرجاء إدخال الاسم' : null,
          ),
          EditProfileField(
            controller: _specialtyController,
            label: 'التخصص',
            icon: Icons.medical_services,
          ),
          EditProfileField(
            controller: _phoneController,
            label: 'رقم الهاتف',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          EditProfileField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => (v == null || v.isEmpty || !v.contains('@')) ? 'بريد غير صالح' : null,
          ),
          EditProfileField(
            controller: _addressController,
            label: 'العنوان',
            icon: Icons.location_on,
          ),
          EditProfileField(
            controller: _workingHoursController,
            label: 'ساعات العمل',
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
              child: const Text('حفظ التعديلات', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
