
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mawaridii/features/cart/logic/cart_provider.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isGrandTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.isGrandTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: isGrandTotal ?22
            :16,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: isGrandTotal ? Theme.of(context).primaryColor : Colors.black

    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}

class CartSummary extends ConsumerWidget {
  final double itemsTotal;
  final double tax;
  final double deliveryFee;
  final double grandTotal;

  const CartSummary({
    super.key,
    required this.itemsTotal,
    required this.tax,
    required this.deliveryFee,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  isEmpty = ref.read(cartProvider).isEmpty;
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SummaryRow(label: 'cart.summary.subtotal'.tr(), value: itemsTotal.toStringAsFixed(2)),
          const SizedBox(height: 4),
          SummaryRow(label:
          'cart.summary.delivery'.tr(),

              value:
              isEmpty ? "0" :
              deliveryFee.toStringAsFixed(2)),
          const SizedBox(height: 4),
          SummaryRow(label:
          'cart.summary.tax'.tr(),
              value:
              isEmpty ? "0" :
              tax.toStringAsFixed(2)),
          const SizedBox(height: 4),

          SummaryRow(
            label: 'cart.summary.total'.tr(),
            value:
            isEmpty ? "0" :
            grandTotal.toStringAsFixed(2),
            isBold: true,
            isGrandTotal: true,
          ),
        ],
      ),
    );
  }
}

