import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadUserProfile()),
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final user = state.user;
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildProfilePhoto(context, user.name, user.email),
                    const SizedBox(height: 24),
                    _buildSection(
                      context,
                      title: 'المعلومات الشخصية',
                      items: [
                        _buildInfoTile('الاسم', user.name, Icons.person_outline),
                        _buildInfoTile('رقم الهاتف', user.phone, Icons.phone_outlined),
                        _buildInfoTile('البريد الإلكتروني', user.email, Icons.email_outlined),
                        _buildInfoTile('تاريخ الميلاد', user.birthDate, Icons.calendar_today_outlined),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      context,
                      title: 'ملخص المعلومات الطبية',
                      items: [
                        _buildInfoTile('فصيلة الدم', user.bloodType, Icons.bloodtype_outlined),
                        _buildInfoTile('الطول', user.height, Icons.height_outlined),
                        _buildInfoTile('الوزن', user.weight, Icons.monitor_weight_outlined),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      context,
                      title: 'معلومات التأمين',
                      items: [
                        _buildInfoTile('شركة التأمين', user.insuranceCompany, Icons.business_outlined),
                        _buildInfoTile('رقم الوثيقة', user.insuranceNumber, Icons.confirmation_number_outlined),
                        _buildInfoTile('تاريخ الانتهاء', user.insuranceExpiry, Icons.date_range_outlined),
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
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('حدث خطأ غير متوقع'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context, String name, String email) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(email, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> items}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                Text(title, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap, Color? iconColor, Color? textColor}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: iconColor ?? Colors.grey.shade600),
      title: Text(title, style: TextStyle(color: textColor ?? Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
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
