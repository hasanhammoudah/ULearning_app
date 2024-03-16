import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

// AppBar buildAppBar(String url) {
//   return AppBar(
//     title: reusableText(url),
//   );
// }

Widget reusableText2(
  String text, {
  Color color = AppColors.primaryText,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.bold,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize.sp,
    ),
  );
}
