import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'د. أحمد محمد');
  final TextEditingController _specialtyController = TextEditingController(text: 'أخصائي أمراض باطنية');
  final TextEditingController _phoneController = TextEditingController(text: '0123456789');
  final TextEditingController _emailController = TextEditingController(text: 'doctor@example.com');
  final TextEditingController _addressController = TextEditingController(text: 'القاهرة، مصر');
  final TextEditingController _workingHoursController = TextEditingController(text: '9 ص - 5 م');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي'),
        backgroundColor: Colors.teal.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // صورة الطبيب مع زر تغيير الصورة
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/doctor.png'),
                  ),
                  FloatingActionButton.small(
                    onPressed: _changeProfileImage,
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // حقل الاسم
              _buildTextField(
                controller: _nameController,
                label: 'الاسم بالكامل',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              
              // حقل التخصص
              _buildTextField(
                controller: _specialtyController,
                label: 'التخصص',
                icon: Icons.medical_services,
              ),
              
              // حقل الهاتف
              _buildTextField(
                controller: _phoneController,
                label: 'رقم الهاتف',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              
              // حقل البريد الإلكتروني
              _buildTextField(
                controller: _emailController,
                label: 'البريد الإلكتروني',
                icon: Icons.email,
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
              
              // حقل العنوان
              _buildTextField(
                controller: _addressController,
                label: 'العنوان',
                icon: Icons.location_on,
              ),
              
              // حقل ساعات العمل
              _buildTextField(
                controller: _workingHoursController,
                label: 'ساعات العمل',
                icon: Icons.access_time,
              ),
              
              const SizedBox(height: 20),
              
              // زر الحفظ
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'حفظ التعديلات',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  void _changeProfileImage() {
    // هنا يمكنك إضافة كود لاختيار صورة من المعرض أو الكاميرا
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تغيير صورة الملف الشخصي'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('التقاط صورة'),
              onTap: () {
                Navigator.pop(context);
                // كود فتح الكاميرا
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('اختيار من المعرض'),
              onTap: () {
                Navigator.pop(context);
                // كود فتح المعرض
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // هنا يمكنك إضافة كود لحفظ البيانات في قاعدة البيانات
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ التعديلات بنجاح'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // العودة إلى صفحة الملف الشخصي
    }
  }
}