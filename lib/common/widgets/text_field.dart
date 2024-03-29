import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';

Widget appTextField(String hintText, String textType,
    void Function(String value)? func,{int? maxLines=1}) {
  return TextField(
    maxLines: maxLines,
    onChanged: (value) => func!(value),
    keyboardType: TextInputType.multiline,
    decoration: InputDecoration(
      hintText: hintText,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      hintStyle: const TextStyle(
        color: AppColors.primarySecondaryElementText,
      ),
    ),
    style: TextStyle(
      fontFamily: 'Avenir',
      color: AppColors.primaryText,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
    ),
    autocorrect: false,
    obscureText: textType == 'password' ? true : false,
  );
}
