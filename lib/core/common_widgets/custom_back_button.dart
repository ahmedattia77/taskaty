import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  final String? pageNAme;
  const CustomBackButton({super.key, this.pageNAme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18.sp,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () => pageNAme != null
            ? Navigator.pushNamedAndRemoveUntil(
                context,
                pageNAme!,
                (e) => false,
              )
            : Navigator.pop(context),
      ),
    );
  }
}
