import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildProfilePhoto(context),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'المعلومات الشخصية',
              items: [
                _buildInfoTile('الاسم', 'محمد أحمد', Icons.person_outline),
                _buildInfoTile(
                  'رقم الهاتف',
                  '01012345678',
                  Icons.phone_outlined,
                ),
                _buildInfoTile(
                  'البريد الإلكتروني',
                  'mohammed@example.com',
                  Icons.email_outlined,
                ),
                _buildInfoTile(
                  'تاريخ الميلاد',
                  '١٥ يناير ١٩٩٠',
                  Icons.calendar_today_outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'ملخص المعلومات الطبية',
              items: [
                _buildInfoTile('فصيلة الدم', 'O+', Icons.bloodtype_outlined),
                _buildInfoTile('الطول', '175 سم', Icons.height_outlined),
                _buildInfoTile(
                  'الوزن',
                  '75 كجم',
                  Icons.monitor_weight_outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'معلومات التأمين',
              items: [
                _buildInfoTile(
                  'شركة التأمين',
                  'شركة التأمين العربية',
                  Icons.business_outlined,
                ),
                _buildInfoTile(
                  'رقم الوثيقة',
                  '123456789',
                  Icons.confirmation_number_outlined,
                ),
                _buildInfoTile(
                  'تاريخ الانتهاء',
                  '٣٠ ديسمبر ٢٠٢٣',
                  Icons.date_range_outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              context,
              title: 'الإعدادات',
              items: [
                _buildActionTile(
                  context,
                  title: 'تعديل الملف الشخصي',
                  icon: Icons.edit_outlined,
                  onTap: () {},
                ),
                _buildActionTile(
                  context,
                  title: 'تسجيل الخروج',
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => _showLogoutConfirmationDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _showPhotoOptions(context),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'محمد أحمد',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'mohammed@example.com',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  void _showPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined),
                  title: const Text('التقاط صورة جديدة'),
                  onTap: () {
                    // Add functionality to capture a new photo
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('اختيار من المعرض'),
                  onTap: () {
                    // Add functionality to pick a photo from the gallery
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('إزالة الصورة الحالية'),
                  onTap: () {
                    // Add functionality to remove the current photo
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.grey.shade600),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor ?? Colors.grey.shade600),
      title: Text(title, style: TextStyle(color: textColor ?? Colors.black87)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('تسجيل الخروج'),
            content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('تسجيل الخروج'),
              ),
            ],
          ),
    );
  }
}
