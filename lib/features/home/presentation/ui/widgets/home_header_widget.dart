import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/features/welcome/presentation/ui/widgets/theme_switch_button.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, User 👋',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              'Have a nice day!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const ThemeSwitchButton(),
      ],
    );
  }
}
