import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/features/welcome/presentation/ui/widgets/theme_switch_button.dart';
import 'package:taskaty/features/welcome/presentation/ui/widgets/welcome_actions_widgetdart.dart';
import 'package:taskaty/features/welcome/presentation/ui/widgets/welcome_header_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              WelcomeHeaderWidget(),
              WelcomeActionsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
