import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskaty/core/common_widgets/custom_button.dart';
import 'package:taskaty/core/routing/routs.dart';
import 'package:taskaty/core/theme/app_colors.dart';
import 'package:taskaty/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:taskaty/features/auth/login/presentation/ui/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: MediaQuery.heightOf(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  CustomTextFormField(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    textHint: 'Enter Email',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'PLS Enter Email';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15.h),

                  CustomTextFormField(
                    controller: _passwordController,
                    textInputType: TextInputType.text,
                    textHint: 'Enter Password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'PLS Enter Password';
                      }
                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'forgget password',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  BlocListener<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        // Navigator.of(context, rootNavigator: true).pop();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.homeScreenRoute,
                          (route) => false,
                        );
                      } else if (state is LoginLoading) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      } else if (state is LoginError) {
                        // Navigator.of(context, rootNavigator: true).pop();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errro),
                            backgroundColor: AppColors.red,
                          ),
                        );
                      }
                    },
                    child: CustomButtonWidget(
                      text: 'Login',
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'register now',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'register',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
