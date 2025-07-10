import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mawaridii/app/widgets/stylized_filled_button.dart';
import 'package:mawaridii/features/onboarding/logic/onboarding_providers.dart';
import 'package:mawaridii/routes/routes.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final controller = PageController();

  late final List<OnboardingPage> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      OnboardingPage(
        image: 'assets/images/onboarding-1.png',
        text: tr('onboarding.trusted_tools'),
      ),
      OnboardingPage(
        image: 'assets/images/onboarding-2.png',
        text: tr('onboarding.all_in_one'),
      ),
    ];
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        final page = controller.page ?? 0;
        ref.read(onboardingTextProvider.notifier).state = page < 0.5;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: controller,
              children: pages,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: WormEffect(
                    dotHeight: 6,
                    dotWidth: 24,
                    radius: 2,
                    spacing: 12,
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Consumer(
                  builder: (context, ref, _) {
                    return StylizedButton(
                      text: ref.watch(onboardingTextProvider)
                          ? tr('onboarding.continue')
                          : tr('onboarding.skip'),
                      textColor: Theme.of(context).primaryColor,
                      function: () {
                        print(tr('onboarding.continue'));
                        final currentPage = controller.page?.round() ?? 0;
                        if (currentPage == pages.length - 1) {
                          ref.read(isOnboardedProvider.notifier).completeOnboarding();
                          context.goNamed(AppRoute.welcome.name);
                        } else {
                          controller.animateToPage(
                            currentPage + 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String text;

  const OnboardingPage({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.5)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 140.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
