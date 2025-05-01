import 'package:doctorapp/core/localization/bloc/language_bloc.dart';
import 'package:doctorapp/core/localization/bloc/language_event.dart';
import 'package:doctorapp/core/di/dependancy_injection.dart';
import 'package:doctorapp/features/patient/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:doctorapp/features/patient/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:doctorapp/features/patient/login/presentation/screens/login_screen.dart';
import 'package:doctorapp/features/patient/profile/data/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _fadeAnimation;

  final Color _primaryColor = const Color(0xFF006272);
  final Color _accentColor = const Color(0xFFE0F7FA);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(LoadUserProfile()),
      child: Scaffold(
        backgroundColor: _accentColor.withOpacity(0.2),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            Widget content = _buildContent(context, state);

            if (_fadeAnimation != null) {
              content = FadeTransition(opacity: _fadeAnimation!, child: content);
            }

            return content;
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
          backgroundColor: _accentColor.withOpacity(0.3),
        ),
      );
    } else if (state is ProfileLoaded) {
      final user = state.user;
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_primaryColor, _accentColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildProfilePhoto(context, user.name ?? 'unknown_user'.tr()),
                      const SizedBox(height: 12),
                      Text(
                        user.name ?? 'unknown_user'.tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user.email ?? 'unknown_email'.tr(),
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: _primaryColor,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              _buildSection(
                context,
                title: 'personal_info'.tr(),
                icon: Icons.person_outline,
                items: [
                  _buildInfoTile('name'.tr(), user.name ?? 'unknown_user'.tr(), Icons.person_outline),
                  _buildInfoTile('phone'.tr(), user.phone ?? 'unknown_phone'.tr(), Icons.phone_outlined),
                  _buildInfoTile('email'.tr(), user.email ?? 'unknown_email'.tr(), Icons.email_outlined),
                  _buildInfoTile('birthdate'.tr(), user.birthDate ?? 'unknown_birthdate'.tr(), Icons.calendar_today_outlined),
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                context,
                title: 'medical_summary'.tr(),
                icon: Icons.medical_services_outlined,
                items: [
                  _buildInfoTile('blood_type'.tr(), user.bloodType ?? 'unknown_blood_type'.tr(), Icons.bloodtype_outlined),
                  _buildInfoTile('height'.tr(), user.height ?? 'unknown_height'.tr(), Icons.height_outlined),
                  _buildInfoTile('weight'.tr(), user.weight ?? 'unknown_weight'.tr(), Icons.monitor_weight_outlined),
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                context,
                title: 'insurance_info'.tr(),
                icon: Icons.verified_user_outlined,
                items: [
                  _buildInfoTile('insurance_company'.tr(), user.insuranceCompany ?? 'unknown_insurance_company'.tr(), Icons.business_outlined),
                  _buildInfoTile('insurance_number'.tr(), user.insuranceNumber ?? 'unknown_insurance_number'.tr(), Icons.confirmation_number_outlined),
                  _buildInfoTile('insurance_expiry'.tr(), user.insuranceExpiry ?? 'unknown_insurance_expiry'.tr(), Icons.date_range_outlined),
                ],
              ),
              const SizedBox(height: 20),
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
                                firstName: user.name != null && user.name!.isNotEmpty ? user.name!.split(' ').first : '',
                                lastName: user.name != null && user.name!.isNotEmpty && user.name!.split(' ').length > 1 ? user.name!.split(' ').sublist(1).join(' ') : '',
                                email: user.email ?? '',
                                phoneNumber: user.phone != null && user.phone != 'لا يوجد' ? user.phone! : '',
                                dateOfBirth: user.birthDate ?? '',
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
                    iconColor: Colors.red.shade700,
                    textColor: Colors.red.shade700,
                    onTap: () => _showLogoutConfirmationDialog(context),
                  ),
                  _buildActionTile(
                    context,
                    title: context.locale.languageCode == 'ar' ? 'English' : 'العربية',
                    icon: Icons.language,
                    onTap: () {
                      final newLocale = context.locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
                      context.read<LanguageBloc>().add(ChangeLanguage(newLocale));
                      context.setLocale(newLocale);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ]),
          ),
        ],
      );
    } else if (state is ProfileError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade700),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: GoogleFonts.openSans(fontSize: 16, color: _primaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                context.read<ProfileBloc>().add(LoadUserProfile());
              },
              child: Text(
                'retry'.tr(),
                style: GoogleFonts.cairo(fontSize: 14, color: Colors.white),
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
            Icon(Icons.warning_amber_outlined, size: 48, color: Colors.orange.shade700),
            const SizedBox(height: 16),
            Text(
              'unexpected_error'.tr(),
              style: GoogleFonts.openSans(fontSize: 16, color: _primaryColor),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProfilePhoto(BuildContext context, String name) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          color: _accentColor.withOpacity(0.3),
          child: Icon(
            Icons.person,
            size: 60,
            color: Colors.white.withOpacity(0.9),
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
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primaryColor.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
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
                Icon(icon, size: 20, color: _primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: _primaryColor),
        ),
        title: Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 13,
            color: _primaryColor.withOpacity(0.7),
          ),
        ),
        subtitle: Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: _primaryColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (iconColor ?? _primaryColor).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? _primaryColor,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: textColor ?? _primaryColor,
          ),
        ),
        trailing: Icon(
          context.locale.languageCode == 'ar' ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
          size: 16,
          color: _primaryColor.withOpacity(0.6),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
        backgroundColor: Colors.white.withOpacity(0.95),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                size: 48,
                color: Colors.red.shade700,
              ),
              const SizedBox(height: 16),
              Text(
                'logout'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'confirm_logout'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: _primaryColor.withOpacity(0.7),
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
                        side: BorderSide(color: _primaryColor.withOpacity(0.3)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'cancel'.tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: _primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Future.microtask(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('logged_out_successfully'.tr()),
                              backgroundColor: _primaryColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        });
                      },
                      child: Text(
                        'logout'.tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.white,
                        ),
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