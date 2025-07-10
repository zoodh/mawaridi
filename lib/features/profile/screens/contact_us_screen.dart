import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plumColor = const Color(0xFF5C3B42); // dark plum color

    final InputDecoration inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF4F4F4),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('contact.start_project'.tr()),
        centerTitle: true,
        backgroundColor: plumColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "تواصل معنا",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('contact.address'.tr()),
            const SizedBox(height: 15,),
            const Divider(),
            Text('contact.working_hours'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            Text('contact.working_days'.tr()),
            Text('contact.phone'.tr()),
            const SizedBox(height: 15,),
            const Divider(),
            Text('contact.license'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Text('contact.leave_message'.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(
              "نضمن لعملائنا الحصول على أفضل جودة وسعر وخدمة. نفخر بكل ما نقوم به في مصنعنا.",
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: inputDecoration.copyWith(hintText: "الاسم"),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: inputDecoration.copyWith(hintText: "الايميل"),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: inputDecoration.copyWith(hintText: "الموضوع"),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: inputDecoration.copyWith(hintText: "تليفون"),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: inputDecoration.copyWith(hintText: "الرسالة"),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: plumColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  // TODO: handle form submission
                },
                child: const Text(
                  "راسلنا",
                  style: TextStyle(color: Colors.white),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}
