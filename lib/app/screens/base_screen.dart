
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/authentication/screens/welcome_screen.dart';
import 'package:mawaridii/features/onboarding/logic/onboarding_providers.dart';
import '../../features/onboarding/screen/onboarding_screen.dart';


class BaseScreen extends ConsumerWidget {
  const BaseScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnboarded = ref.watch(isOnboardedProvider);
   return  isOnboarded.when(
      data: (isOnboarded) {

        return isOnboarded ?
         WelcomeScreen() :
        OnboardingScreen();
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text
          ('Error: $err')),
      ),
    );
  }
}
