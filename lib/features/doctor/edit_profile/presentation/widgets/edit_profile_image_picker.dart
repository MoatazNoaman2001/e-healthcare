import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileImagePicker extends StatelessWidget {
  const EditProfileImagePicker({super.key});

  void _changeProfileImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('change_profile_image'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: Text('take_photo'.tr()),
              onTap: () {
                Navigator.pop(context);
                // كود الكاميرا
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text('choose_from_gallery'.tr()),
              onTap: () {
                Navigator.pop(context);
                // كود المعرض
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/doctor.png'),
        ),
        FloatingActionButton.small(
          onPressed: () => _changeProfileImage(context),
          backgroundColor: Colors.teal,
          child: const Icon(Icons.camera_alt, color: Colors.white),
        ),
      ],
    );
  }
}
