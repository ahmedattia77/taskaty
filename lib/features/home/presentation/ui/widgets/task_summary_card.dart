import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/theme/app_colors.dart';

class TaskSummaryCard extends StatelessWidget {
  const TaskSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Progress',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Keep it up! You are almost done.',
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.8),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
