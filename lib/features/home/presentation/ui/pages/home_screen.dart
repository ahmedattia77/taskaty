import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/common_widgets/offline_banner_widget.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/core/services/internet_connection/cubit/network_status_cubit.dart';
import 'package:taskaty/core/theme/app_colors.dart';
import 'package:taskaty/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:taskaty/features/home/presentation/ui/widgets/filter_bottom_sheet.dart';
import 'package:taskaty/features/home/presentation/ui/widgets/home_header_widget.dart';
import 'package:taskaty/features/home/presentation/ui/widgets/task_summary_card.dart';
import 'package:taskaty/features/home/presentation/ui/widgets/tasks_list_view_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkStatusCubit, NetworkStatusState>(
      listenWhen: (previous, current) {
        return previous is NetworkStatusDisConnected &&
            current is NetworkStatusConnected;
      },
      listener: (context, state) {
        final homeState = context.read<HomeCubit>().state;
        if (homeState is HomeTaskFialer) {
          context.read<HomeCubit>().fetchTasks();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.addTaskScreenRoute,
              (route) => false,
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add_rounded, color: AppColors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OfflineBannerWidget(),
                const HomeHeaderWidget(),
                SizedBox(height: 20.h),
                const TaskSummaryCard(),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text(
                      'Tasks',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontSize: 18.sp),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list_rounded),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                          builder: (bottomSheetContext) {
                            return BlocProvider.value(
                              value: context.read<HomeCubit>(),
                              child: FilterBottomSheet(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Expanded(child: TasksListViewBuilder()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
