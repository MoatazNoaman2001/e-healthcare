import 'package:doctorapp/features/doctor/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/doctor_profile_bloc.dart';
import '../bloc/doctor_profile_event.dart';
import '../bloc/doctor_profile_state.dart';
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
      body: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorProfileLoaded) {
            final doctor = state.doctor;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  DoctorInfoHeader(doctor: doctor),
                  const SizedBox(height: 20),
                  ContactInfoCard(doctor: doctor),
                  const SizedBox(height: 20),
                  QualificationCard(doctor: doctor),
                  const SizedBox(height: 20),
                  EditProfileButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is DoctorProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
