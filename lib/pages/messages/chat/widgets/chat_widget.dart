import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/entities.dart';
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

Widget chatWidget(Msgcontent item) {
  return Container(
    padding: EdgeInsets.only(
      top: 10.w,
      bottom: 10.w,
      left: 10.w,
      right: 10.w,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 250.w,
            minHeight: 40.w,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 0.w, top: 0.w),
                padding: EdgeInsets.only(
                  top: 10.w,
                  bottom: 10.w,
                  left: 10.w,
                  right: 10.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      0.w,
                    ),
                    topLeft: Radius.circular(20.w),
                    bottomLeft: Radius.circular(20.w),
                    bottomRight: Radius.circular(20.w),
                  ),
                ),
                child: Text("${item.content}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primaryElementText,
                    )),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
