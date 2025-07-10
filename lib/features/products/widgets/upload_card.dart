import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
class UploadCard extends StatelessWidget {
  const UploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
          color: const Color(0xFFFBF8F6),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'product.upload_file'.tr(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "و سنقدم لك كل ما تحتاجه بافضل الاسعار!",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: Size(32, 32),
                    shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
                ),
                onPressed: () {
                  context.goNamed(AppRoute.uploadFile.name);

                },
                child: const Text("رفع الملف"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
