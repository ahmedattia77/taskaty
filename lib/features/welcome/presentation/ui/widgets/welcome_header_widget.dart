import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110.h,
          width: 110.w,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.edit_note_rounded,
            size: 60.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 32.h),

        Text(
          'Capture Your Thoughts',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),

        Text(
          'Organize your notes, manage daily tasks, and keep your ideas saved safely in one place.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
