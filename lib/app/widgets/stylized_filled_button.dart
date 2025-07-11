import 'package:flutter/material.dart';

class StylizedButton extends StatelessWidget {
  final bool isBottomSheet;
  final bool wrapWithFraction;

  const StylizedButton({
    super.key,
    this.buttonColor,
    required this.text,
    this.textColor,
    required this.function,
    this.outlineColor,
    this.icon,
    this.isBottomSheet = false,
    this.wrapWithFraction = true, // ✅ Defaults to true for existing usage
  });

  final IconData? icon;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final void Function() function;
  final Color? outlineColor;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      onPressed: function,
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.white,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isBottomSheet ? 0 : 5),
          side: BorderSide(
            color: outlineColor ?? Colors.transparent,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor ?? const Color(0xFF604651),
              fontWeight: FontWeight.bold,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 8),
            Icon(icon, size: 18),
          ],
        ],
      ),
    );

    return wrapWithFraction
        ? FractionallySizedBox(
      widthFactor: isBottomSheet ? 1 : 0.9,
      child: button,
    )
        : button;
  }
}
