import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.menu_book_rounded,
            size: 50.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 32.h),

        Text(
          'Welcome to Bookia',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),

        Text(
          'Order your favorite books easily and explore a huge collection in one place.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
