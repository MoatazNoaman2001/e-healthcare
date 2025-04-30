// تم تعديل الكود لدعم easy_localization بالكامل
import 'package:doctorapp/core/localization/bloc/language_bloc.dart';
import 'package:doctorapp/core/localization/bloc/language_event.dart';
import 'package:doctorapp/features/patient/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:doctorapp/features/patient/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:doctorapp/features/patient/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/di/dependancy_injection.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(LoadUserProfile()),
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
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
                    title: 'personal_info'.tr(),
                    items: [
                      _buildInfoTile('name'.tr(), user.name, Icons.person_outline),
                      _buildInfoTile('phone'.tr(), user.phone, Icons.phone_outlined),
                      _buildInfoTile('email'.tr(), user.email, Icons.email_outlined),
                      _buildInfoTile('birthdate'.tr(), user.birthDate, Icons.calendar_today_outlined),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    context,
                    title: 'medical_summary'.tr(),
                    items: [
                      _buildInfoTile('blood_type'.tr(), user.bloodType, Icons.bloodtype_outlined),
                      _buildInfoTile('height'.tr(), user.height, Icons.height_outlined),
                      _buildInfoTile('weight'.tr(), user.weight, Icons.monitor_weight_outlined),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    context,
                    title: 'insurance_info'.tr(),
                    items: [
                      _buildInfoTile('insurance_company'.tr(), user.insuranceCompany, Icons.business_outlined),
                      _buildInfoTile('insurance_number'.tr(), user.insuranceNumber, Icons.confirmation_number_outlined),
                      _buildInfoTile('insurance_expiry'.tr(), user.insuranceExpiry, Icons.date_range_outlined),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    context,
                    title: 'settings'.tr(),
                    items: [
                      _buildActionTile(

              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF006272)),
                ),
              );
            } else if (state is ProfileLoaded) {
              final user = state.user;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // image: DecorationImage(
                          //   image: AssetImage("assets/images/profile_background.png"), // صورة خلفية اختيارية
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildProfilePhoto(context, user.name),
                              const SizedBox(height: 8),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    backgroundColor:
                        Colors.white, // لون خلفية AppBar عند التقلص
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 16),
                      _buildSection(

                        context,
                        title: 'edit_profile'.tr(),
                        icon: Icons.edit_outlined,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) => sl<EditProfileBloc>(),
                                child: EditProfileScreen(
                                  user: User(
                                    id: 0,
                                    firstName: user.name.isNotEmpty ? user.name.split(' ').first : '',
                                    lastName: user.name.isNotEmpty && user.name.split(' ').length > 1
                                        ? user.name.split(' ').sublist(1).join(' ')
                                        : '',
                                    email: user.email,
                                    phoneNumber: user.phone == 'لا يوجد' ? '' : user.phone,
                                    dateOfBirth: user.birthDate,

                            title: 'edit_profile'.tr(),
                            icon: Icons.edit_outlined,
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (_) => sl<EditProfileBloc>(),
                                    child: EditProfileScreen(
                                      user: User(
                                        id: 0,
                                        firstName: user.name.isNotEmpty
                                            ? user.name.split(' ').first
                                            : '',
                                        lastName: user.name.isNotEmpty &&
                                                user.name.split(' ').length > 1
                                            ? user.name
                                                .split(' ')
                                                .sublist(1)
                                                .join(' ')
                                            : '',
                                        email: user.email,
                                        phoneNumber: user.phone == 'لا يوجد'
                                            ? ''
                                            : user.phone,
                                        dateOfBirth: user.birthDate,
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ),
                          );

                          if (result == true) {
                            context.read<ProfileBloc>().add(LoadUserProfile());
                          }
                        },
                      ),
                      _buildActionTile(
                        context,
                        title: 'logout'.tr(),
                        icon: Icons.logout,
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        onTap: () => _showLogoutConfirmationDialog(context),
                      ),
                      _buildActionTile(
                        context,
                        title: context.locale.languageCode == 'ar'
                            ? 'language_switch'.tr()
                            : 'العربية'.tr(),
                        icon: Icons.language,
                        onTap: () {
                          final newLocale = context.locale.languageCode == 'ar'
                              ? const Locale('en')
                              : const Locale('ar');
                          context.read<LanguageBloc>().add(ChangeLanguage(newLocale));
                          context.setLocale(newLocale);
                        },
                      ),
                    ],
                  ),
                ],
              );
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileBloc>().add(LoadUserProfile());
                      },
                      child: Text('retry'.tr()),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('unexpected_error'.tr()));
            }
          },
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

  Widget _buildActionTile(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap, Color? iconColor, Color? textColor}) {
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
        title: Text('logout'.tr()),
        content: Text('confirm_logout'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Future.microtask(() {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('logout'.tr()),
          ),
        ],
      ),
    );
  }
}
