import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/theme/app_colors.dart';
import 'package:taskaty/features/home/data/model/task_response_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback? onTap;

  const TaskItemWidget({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Icon(
          task.isCompleted
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          color: task.isCompleted
              ? Theme.of(context).primaryColor
              : AppColors.grey,
          size: 24.sp,
        ),
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              SizedBox(height: 4.h),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 14.sp,
                  color: Theme.of(context).hintColor,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatDate(task.deliveryDate),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 11.sp),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: _getPriorityColor(task.priority).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            task.priority.toUpperCase(),
            style: TextStyle(
              color: _getPriorityColor(task.priority),
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.high;
      case 'medium':
        return AppColors.medium;
      case 'low':
      default:
        return Colors.blueAccent;
    }
  }

  String _formatDate(String rawDate) {
    if (rawDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(rawDate);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return rawDate.split(' ').first;
    }
  }
}
