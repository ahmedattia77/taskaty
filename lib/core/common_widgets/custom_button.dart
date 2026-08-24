import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor,
    required this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 1.5.w)
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textColor != null
              ? TextStyle(
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                )
              : Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
