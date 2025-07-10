import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../routes/routes.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Widget buildIconContainer(IconData icon) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.settings'.tr()),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: buildIconContainer(Icons.person),
            title: Text('profile.profile'.tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              // TODO: Add your profile screen navigation here
              // context.goNamed(AppRoute.profile.name);
            },
          ),
          ListTile(
            leading: buildIconContainer(Icons.question_mark_outlined),
            title: Text('profile.faq'.tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              context.goNamed(AppRoute.commonQuestions.name);
            },
          ),
          ListTile(
            leading: buildIconContainer(Icons.timer_sharp),
            title: Text('profile.about_us'.tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              context.goNamed(AppRoute.whoAreWe.name);
            },
          ),
          ListTile(
            leading: buildIconContainer(Icons.card_giftcard_outlined),
            title: Text('profile.seller_account'.tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              // context.goNamed(AppRoute.sellerAccount.name);
            },
          ),
          ListTile(
            leading: buildIconContainer(Icons.mail),
            title: Text('profile.contact_us'.tr()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              context.goNamed(AppRoute.contactUs.name);
            },
          ),
          ListTile(
            leading: buildIconContainer(Icons.language),
            title: Text('profile.change_language'.tr()),
            onTap: () {
            //  final currentLocale = context.locale;
           //   if (currentLocale.languageCode == 'en') {
           //     context.setLocale(const Locale('ar'));
          //    } else {
            //    context.setLocale(const Locale('en'));
       //       }
            },
          ),
        ],
      ),
    );
  }

}
