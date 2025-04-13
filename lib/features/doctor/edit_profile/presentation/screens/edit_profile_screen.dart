import 'package:flutter/material.dart';
import '../widgets/edit_profile_image_picker.dart';
import '../widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              EditProfileImagePicker(),
              SizedBox(height: 20),
              EditProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
