
import 'package:flutter/material.dart';
class StylizedButton extends StatelessWidget {
  final bool isBottomSheet;
  const StylizedButton({
    super.key,
    this.buttonColor,
    required this.text,
    this.textColor,
    required this.function,
    this.outlineColor,
    this.icon,
    this.isBottomSheet = false
  });
  final IconData? icon;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final void Function() function;
  final Color? outlineColor;


  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor:
      isBottomSheet?
      1: 0.9,
      child: FilledButton(
        onPressed: function,
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor ?? Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
            isBottomSheet ? 0 : 5
            ),
            side: BorderSide(
              color: outlineColor ?? Colors.transparent,
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor ?? const Color(0xFF604651),
                fontWeight: FontWeight.bold
              ),
            ),
            if(icon != null)
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
