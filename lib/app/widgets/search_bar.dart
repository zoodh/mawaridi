
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'search.label'.tr(),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(Icons.search),
          ),
          filled: true,
          fillColor: const Color(0xFFFBF8F6),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
