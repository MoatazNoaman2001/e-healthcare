import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'search_hint'.tr(),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
