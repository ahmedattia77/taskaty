import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/common_widgets/custom_button.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/core/theme/app_colors.dart';

class WelcomeActionsWidget extends StatelessWidget {
  const WelcomeActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        CustomButtonWidget(
          text: 'Login',
          backgroundColor: Theme.of(context).primaryColor,
          textColor: AppColors.white,
          onPressed: () {
            Navigator.pushNamed(context, Routes.loginScreenRoute);
          },
        ),
        SizedBox(height: 15.h),

        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isDark
                    ? const Color(0xFF2C2C2C)
                    : const Color(0xFFE8ECF4),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              backgroundColor: Theme.of(context).cardColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.registerScreenRoute);
            },
            child: Text(
              'Register',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 15.sp),
            ),
          ),
        ),
      ],
    );
  }
}
