import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskaty/core/theme/app_colors.dart';
import 'package:taskaty/features/home/presentation/cubit/home/home_cubit.dart';

enum Priority { low, medium, high }

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Set<Priority> _selectedPriority = {};
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();

    if (cubit.currentPriority != null) {
      _selectedPriority = {
        Priority.values.firstWhere(
          (e) => e.name == cubit.currentPriority,
          orElse: () => Priority.low,
        ),
      };
    }

    if (cubit.currentStartDate != null && cubit.currentEndDate != null) {
      _selectedDateRange = DateTimeRange(
        start: DateTime.parse(cubit.currentStartDate!),
        end: DateTime.parse(cubit.currentEndDate!),
      );
    }
  }

  Future<void> _pickDateRange() async {
    final currentTheme = Theme.of(context);
    final isDarkMode = currentTheme.brightness == Brightness.dark;
    final ColorScheme colorScheme = isDarkMode
        ? ColorScheme.dark(primary: Theme.of(context).primaryColor)
        : ColorScheme.light(primary: Theme.of(context).primaryColor);

    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: colorScheme,
            scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final startDateStr = _selectedDateRange != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDateRange!.start)
        : null;
    final endDateStr = _selectedDateRange != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDateRange!.end)
        : null;

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Tasks',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  context.read<HomeCubit>().clearFilter();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Reset',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(height: 12.h),

          Text(
            'Priority',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<Priority>(
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: AppColors.primary,
              ),
              segments: const <ButtonSegment<Priority>>[
                ButtonSegment<Priority>(
                  value: Priority.low,
                  label: Text('Low'),
                ),
                ButtonSegment<Priority>(
                  value: Priority.medium,
                  label: Text('Medium'),
                ),
                ButtonSegment<Priority>(
                  value: Priority.high,
                  label: Text('High'),
                ),
              ],
              selected: _selectedPriority,
              emptySelectionAllowed: true,
              multiSelectionEnabled: false,
              onSelectionChanged: (Set<Priority> newSelection) {
                setState(() {
                  _selectedPriority = newSelection;
                });
              },
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(),
          SizedBox(height: 10.h),

          Text(
            'Date Range',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12.h),
          InkWell(
            onTap: _pickDateRange,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDateRange == null
                        ? 'Select Start & End Date'
                        : '$startDateStr  ➔  $endDateStr',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: _selectedDateRange == null
                          ? Theme.of(context).hintColor
                          : AppColors.primary,
                    ),
                  ),
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 28.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().fetchTasks(
                  startDate: startDateStr,
                  endDate: endDateStr,
                  priority: _selectedPriority.isNotEmpty
                      ? _selectedPriority.first.name
                      : null,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.primary,
                shadowColor: Theme.of(context).shadowColor,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Apply Filter',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
