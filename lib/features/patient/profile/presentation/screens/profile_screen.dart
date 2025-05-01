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
        backgroundColor: Colors.grey[50],
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
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
                        title: 'personal_info'.tr(),
                        icon: Icons.person_outline,
                        items: [
                          _buildInfoTile(
                              'name'.tr(), user.name, Icons.person_outline),
                          _buildInfoTile(
                              'phone'.tr(), user.phone, Icons.phone_outlined),
                          _buildInfoTile(
                              'email'.tr(), user.email, Icons.email_outlined),
                          _buildInfoTile('birthdate'.tr(), user.birthDate,
                              Icons.calendar_today_outlined),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSection(
                        context,
                        title: 'medical_summary'.tr(),
                        icon: Icons.medical_services_outlined,
                        items: [
                          _buildInfoTile('blood_type'.tr(), user.bloodType,
                              Icons.bloodtype_outlined),
                          _buildInfoTile('height'.tr(), user.height,
                              Icons.height_outlined),
                          _buildInfoTile('weight'.tr(), user.weight,
                              Icons.monitor_weight_outlined),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSection(
                        context,
                        title: 'insurance_info'.tr(),
                        icon: Icons.verified_user_outlined,
                        items: [
                          _buildInfoTile('insurance_company'.tr(),
                              user.insuranceCompany, Icons.business_outlined),
                          _buildInfoTile(
                              'insurance_number'.tr(),
                              user.insuranceNumber,
                              Icons.confirmation_number_outlined),
                          _buildInfoTile('insurance_expiry'.tr(),
                              user.insuranceExpiry, Icons.date_range_outlined),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSection(
                        context,
                        title: 'settings'.tr(),
                        icon: Icons.settings_outlined,
                        items: [
                          _buildActionTile(
                            context,
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
                              );

                              if (result == true) {
                                context
                                    .read<ProfileBloc>()
                                    .add(LoadUserProfile());
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
                                ? 'English'
                                : 'العربية',
                            icon: Icons.language,
                            onTap: () {
                              final newLocale =
                                  context.locale.languageCode == 'ar'
                                      ? const Locale('en')
                                      : const Locale('ar');
                              context
                                  .read<LanguageBloc>()
                                  .add(ChangeLanguage(newLocale));
                              context.setLocale(newLocale);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ]),
                  ),
                ],
              );
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {
                        context.read<ProfileBloc>().add(LoadUserProfile());
                      },
                      child: Text(
                        'retry'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_outlined,
                        size: 48, color: Colors.orange[400]),
                    const SizedBox(height: 16),
                    Text(
                      'unexpected_error'.tr(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context, String name) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Row(
              children: [
                Icon(icon,
                    size: 20, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ...items,
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF006272).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF006272)),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        minLeadingWidth: 0,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (iconColor ?? Colors.grey).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? Colors.grey,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: textColor ?? Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        minLeadingWidth: 0,
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                size: 48,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'logout'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'confirm_logout'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'cancel'.tr(),
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Future.microtask(() {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        });
                      },
                      child: Text(
                        'logout'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
