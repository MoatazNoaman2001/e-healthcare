import 'package:doctorapp/features/doctor/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../widgets/doctor_info_header.dart';
import '../widgets/contact_info_card.dart';
import '../widgets/qualification_card.dart';
import '../widgets/edit_profile_button.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const DoctorInfoHeader(),
            const SizedBox(height: 20),
            const ContactInfoCard(),
            const SizedBox(height: 20),
            const QualificationCard(),
            const SizedBox(height: 20),
            EditProfileButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
