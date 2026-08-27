import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/services/internet_connection/cubit/network_status_cubit.dart';
import 'package:taskaty/core/theme/app_colors.dart';

class OfflineBannerWidget extends StatelessWidget {
  const OfflineBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkStatusCubit, NetworkStatusState>(
      listener: (context, status) {
        if (status is NetworkStatusDisConnected) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: AppColors.red,
              statusBarIconBrightness: Theme.of(context).brightness,
            ),
          );
        } else {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;

          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDarkMode
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
            ),
          );
        }
      },
      builder: (context, status) {
        if (status is NetworkStatusConnected) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            width: double.infinity,
            color: AppColors.red,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  color: AppColors.white,
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'no internet connection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
