import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/theme/app_colors.dart';
import 'package:taskaty/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:taskaty/features/home/presentation/ui/widgets/task_item_widget.dart';

class TasksListViewBuilder extends StatelessWidget {
  const TasksListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeTaskFialer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMassage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeTaskLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (state is HomeTaskSuccess) {
          if (state.taskResponseModel.tasks.isEmpty) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => context.read<HomeCubit>().fetchTasks(),
              child: const Center(child: Text('empty no Tasks ... add a task')),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () => context.read<HomeCubit>().fetchTasks(),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: state.taskResponseModel.tasks.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return TaskItemWidget(
                  task: state.taskResponseModel.tasks[index],
                );
              },
            ),
          );
        }

        if (state is HomeTaskFialer) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  size: 64.sp,
                  color: Theme.of(context).focusColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  state.errorMassage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(height: 16.h),
                ElevatedButton.icon(
                  onPressed: () => context.read<HomeCubit>().fetchTasks(),
                  label: Text("try a agian"),
                  icon: Icon(Icons.refresh_outlined),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
