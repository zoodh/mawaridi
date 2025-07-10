import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mawaridii/app/logic/bottom_navigation_provider.dart';
import 'package:mawaridii/features/cart/logic/next_step_provider.dart';
import 'package:mawaridii/routes/routes.dart';

import '../../../app/widgets/stylized_filled_button.dart';
class CheckOutScreen extends ConsumerWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme
        .of(context)
        .primaryColor;

    final bool isNextStep = ref.watch(nextStepProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('cart.shipping_info'.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "الشحن",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Container(
                  width: 40,
                  height: 2,
                  color: Colors.grey.shade400,
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: isNextStep ? primaryColor : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "الدفع",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            !isNextStep ?

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(_formFields.length, (index) {
                    final field = _formFields[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildLabeledTextField(field['label']!, field['hint']!),
                    );
                  }),
                ),
              )
            : Column(
              children: [
                PaymentOptionsWidget()
              ],
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: StylizedButton(
                text: isNextStep ? "الدفع" : "التالي",
                function: () {
                  if (!isNextStep) {
                    ref
                        .read(nextStepProvider.notifier)
                        .state = true;
                  } else {
                    context.goNamed(AppRoute.home.name);
                  }
                },
                buttonColor: primaryColor,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Helper to build labeled text fields
  Widget _buildLabeledTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}


      final List<Map<String, String>> _formFields = [
{"label": "الاسم الأول", "hint": "أدخل اسمك الأول"},
{"label": "البريد الإلكتروني", "hint": "أدخل بريدك الإلكتروني"},
{"label": "عنوان الشارع", "hint": "اسم الشارع، رقم المبنى..."},
{"label": "المحافظة", "hint": "مثلاً: الجيزة، الرياض"},
{"label": "المنطقة", "hint": "مثلاً: الدقي، النخيل"},
{"label": "رقم الهاتف", "hint": "أدخل رقم الهاتف"},
];


class PaymentOptionsWidget extends StatefulWidget {
  const PaymentOptionsWidget({super.key});

  @override
  State<PaymentOptionsWidget> createState() => _PaymentOptionsWidgetState();
}

class _PaymentOptionsWidgetState extends State<PaymentOptionsWidget> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentOptionTile(
          index: 0,
          isSelected: selectedOption == 0,
          iconPath: 'assets/images/cash-on-delivery 1.png',
          label: 'cart.payment.cash_on_delivery'.tr(),
          iconSize: 50,
          onChanged: (value) => setState(() => selectedOption = value!),
        ),
        SizedBox(height: 20,),
        PaymentOptionTile(
          index: 1,
          isSelected: selectedOption == 1,
          iconPath: 'assets/images/payment-method-3.png',
          label: 'cart.payment.electronic'.tr(),
          iconSize: 50,
          onChanged: (value) => setState(() => selectedOption = value!),
        ),
        PaymentOptionTile(
          index: 2,
          isSelected: selectedOption == 2,
          iconPath: 'assets/images/payment-method-2.png',
          label: 'cart.payment.tabby'.tr(),
          iconSize: 90,
          onChanged: (value) => setState(() => selectedOption = value!),
        ),
        PaymentOptionTile(
          index: 3,
          isSelected: selectedOption == 3,
          iconPath: 'assets/images/payment-method-1.png',
          label: 'cart.payment.tamara'.tr(),
          iconSize: 90,
          onChanged: (value) => setState(() => selectedOption = value!),
        ),
      ],
    );
  }
}class PaymentOptionTile extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String iconPath;
  final String label;
  final double iconSize;
  final ValueChanged<int?> onChanged;

  const PaymentOptionTile({
    super.key,
    required this.index,
    required this.isSelected,
    required this.iconPath,
    required this.label,
    this.iconSize = 64,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4), // consistent spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // fix alignment
        children: [
          Radio<int>(
            value: index,
            groupValue: isSelected ? index : null,
            onChanged: onChanged,
          ),
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
