import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mawaridii/routes/routes.dart';
import '../../../app/widgets/stylized_filled_button.dart';

// Scoped provider that auto-disposes when screen is removed
final _currentPageProvider = StateProvider.autoDispose<int>((ref) => 0);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final PageController _pageController = PageController();
  
  @override
  void initState() {
    super.initState();
    // Only update state when page settles
    _pageController.addListener(_onPageChange);
  }

  void _onPageChange() {
    if (!_pageController.position.isScrollingNotifier.value) {
      final index = _pageController.page?.round() ?? 0;
      if (index != ref.read(_currentPageProvider)) {
        ref.read(_currentPageProvider.notifier).state = index;
      }
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: _LoginAppBar(pageController: _pageController),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _PageIndicator(controller: _pageController),
          const SizedBox(height: 16),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 2,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                // Cache pages to prevent rebuilds
                return index == 0
                    ? PhoneInputPage(pageController: _pageController)
                    : const OtpPage();
              },
            )
          ),
        ],
      ),
    );
  }
}

// Split into separate widgets for better performance
class _LoginAppBar extends ConsumerWidget {
  final PageController pageController;
  
  const _LoginAppBar({required this.pageController});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(_currentPageProvider);
    
    return AppBar(
      title: const Text('تسجيل الدخول'),
      centerTitle: true,
      leading: currentPage == 1
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            )
          : null,
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final PageController controller;
  
  const _PageIndicator({required this.controller});
  
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 2,
      effect: WormEffect(
        dotHeight: 6,
        dotWidth: 24,
        radius: 2,
        spacing: 12,
        activeDotColor: Theme.of(context).primaryColor,
        dotColor: Colors.grey.shade300,
      ),
    );
  }
}

class PhoneInputPage extends StatelessWidget {
  final PageController pageController;
  
  const PhoneInputPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'مرحبا',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'يرجى ادخال رقم هاتفك المحمول',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 32),
          _PhoneInput(),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text('التالي'),
            ),
          ),
        ],
      ),
    );
  }
}

// Extracted phone input widget for better reusability and performance
class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '+966',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'رقم الهاتف',
                border: InputBorder.none,
              ),
              maxLength: 9,
              buildCounter: (_, {required currentLength,
                required isFocused,
                maxLength}) => null,
            ),
          ),
        ],
      ),
    );
  }
}

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(
            tr('auth.verify'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          _OtpInput(
            onCompleted: (value) {
              debugPrint("Entered OTP: $value");
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: StylizedButton(
              text: 'تحقق',
              buttonColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              function: () => context.goNamed(AppRoute.home.name),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(tr('auth.resend_otp')),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Extracted OTP input widget for better reusability
class _OtpInput extends StatelessWidget {
  final Function(String) onCompleted;

  const _OtpInput({required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 4,
      appContext: context,
      keyboardType: TextInputType.number,
      autoFocus: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 60,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey.shade300,
      ),
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (_) {},
      onCompleted: onCompleted,
    );
  }
}
