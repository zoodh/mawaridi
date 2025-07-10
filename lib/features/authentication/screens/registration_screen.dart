import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/app/widgets/stylized_filled_button.dart';
import 'package:mawaridii/features/authentication/logic/authentication_provider.dart';
import 'package:mawaridii/features/authentication/models/registriation_request.dart';
import 'package:mawaridii/routes/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('auth.register')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),

            // Logo
            Center(
              child: Image.asset(
                'assets/images/splash-logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),

            // Form Fields (with padding)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('auth.phone_number'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixText: "🇸🇦 +966 ",
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    tr('auth.full_name'),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    tr('auth.email'),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Submit Button
            Center(
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return StylizedButton(
                    text: tr('auth.create_account'),
                    function: () {
                      ref.read(authProvider.notifier).register(RegistrationRequest(
                        mobileNumber: phoneController.text,
                        fullName: fullNameController.text,
                        email: emailController.text
                      ));
                      context.go('/welcome/login');
                    },
                    buttonColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  );
                },
              ),
            ),

            // Already have an account?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    context.goNamed(AppRoute.login.name);
                  },
                  child: Text(tr('auth.sign_in')),
                ),
                Text(tr('auth.already_have_account')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
