import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/common/widgets/image_widgets.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_state.dart';

Widget backgroundImage() {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        20.h,
      ),
      image: const DecorationImage(
        image: AssetImage(
          'assets/icons/background.png',
        ),
      ),
    ),
  );
}

Widget authorView(BuildContext context, ContributorStates state) {
  return Container(
    width: 325,
    margin: EdgeInsets.only(
      left: 20.w,
      bottom: 5.w,
    ),
    child: state.authorItem == null
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cachedNetworkImage(state.authorItem!.avatar ?? "",
                  height: 80.h,
                  width: 80.w,
                  defaultImage: "assets/icons/person(1).png"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 6.w,
                      bottom: 8.h,
                    ),
                    child: reusableText2(
                      state.authorItem?.name ?? "Unknown",
                      color: AppColors.primaryText,
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 6.w,
                      bottom: 8.h,
                    ),
                    child: reusableText2(
                      state.authorItem?.job ?? "Instructor",
                      color: AppColors.primarySecondaryElementText,
                      fontSize: 9,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  _authorPopularity(),
                ],
              ),
            ],
          ),
  );
}

Widget _authorPopularity() {
  return Row(
    children: [
      _iconAndNum('assets/icons/people.png', 121),
      SizedBox(
        width: 5.w,
      ),
      _iconAndNum('assets/icons/star.png', 12),
      SizedBox(
        width: 5.w,
      ),
      _iconAndNum('assets/icons/download.png', 12),
    ],
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    //margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(
            iconPath,
          ),
          width: 16.w,
          height: 16.h,
        ),
        reusableText2(
          num.toString(),
          color: AppColors.primaryThirdElementText,
          fontWeight: FontWeight.normal,
        ),
      ],
    ),
  );
}

Widget authorDescription(ContributorStates state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      reusableText2(
        "About me",
        color: AppColors.primaryText,
      ),
      state.authorItem == null
          ? Container()
          : reusableText2(
              state.authorItem?.description ?? "No description found",
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 11.sp,
            ),
    ],
  );
}

Widget authorCourseList(ContributorStates state) {
  return SingleChildScrollView(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: state.courseItem.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: 10.h),
          width: 325.w,
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.COURSE_DETAIL,
                  arguments: {"id": state.courseItem[index].id});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    cachedNetworkImage(
                      '${AppConstants.SERVER_UPLOADS}${state.courseItem[index].thumbnail!}',
                      width: 60.w,
                      height: 60.h,
                      defaultImage: "assets/icons/image(1).png",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        listContainer(state.courseItem[index].name.toString()),
                        listContainer(
                          state.courseItem[index].price.toString(),
                          fontSize: 10,
                          color: AppColors.primaryThirdElementText,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
                Image(
                  height: 24.h,
                  width: 24.h,
                  image: const AssetImage("assets/icons/arrow_right.png"),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
