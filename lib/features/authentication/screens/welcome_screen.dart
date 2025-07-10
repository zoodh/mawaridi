import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/routes/routes.dart';
import '../../../app/widgets/stylized_filled_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Solid color fallback
          Container(color: Colors.black),

          // Background image
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome-image.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black45,
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Center(
                  child: Image.asset(
                    "assets/images/white-logo.png",
                    width: 200,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    StylizedButton(
                      text: tr('auth.register'),
                      buttonColor: Colors.white,
                      function: () {
                        context.goNamed(AppRoute.register.name);
                      },
                    ),
                    const SizedBox(height: 12),
                    StylizedButton(
                      text: tr('auth.login'),
                      buttonColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      function: () {
                        context.goNamed(AppRoute.login.name);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}