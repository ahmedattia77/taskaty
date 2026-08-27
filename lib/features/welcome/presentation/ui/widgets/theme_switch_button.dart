import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/theme/app_theme.dart';
import 'package:taskaty/core/theme/cubit/theme_cubit.dart';

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final themeCubit = context.read<ThemeCubit>();
        final isDark = themeCubit.themeData == AppTheme.darkMode;

        return IconButton(
          onPressed: () {
            themeCubit.changeMode();
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: anim,
              child: RotationTransition(turns: anim, child: child),
            ),
            child: Icon(
              isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
              key: ValueKey(isDark),
              color: isDark ? Colors.amber : Colors.orangeAccent,
              size: 24.sp,
            ),
          ),
        );
      },
    );
  }
}
