import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

Widget chatFileButtons(String iconPath) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(10.w),
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(
            40.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ]),
      child: Image.asset(iconPath),
    ),
  );
}
