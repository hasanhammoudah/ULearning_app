import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/pages/course/course_detail/bloc/course_detail_state.dart';

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: reusableText2('Course detail'),
  );
}

Widget thumbNail(String thumbnail) {
  return Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fitWidth,
        image: NetworkImage("${AppConstants.SERVER_UPLOADS}$thumbnail"),
      ),
    ),
  );
}

Widget menuView(BuildContext context, CourseDetailStates state) {
  return SizedBox(
    width: 325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.CONTRIBUTOR,
                arguments: {"token": state.courseItem!.user_token});
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(
                color: AppColors.primaryElement,
              ),
            ),
            child: reusableText2(
              'Author Page',
              color: AppColors.primaryElementText,
              fontWeight: FontWeight.normal,
              fontSize: 10.sp,
            ),
          ),
        ),
        _iconAndNum('assets/icons/people.png', 0),
        _iconAndNum('assets/icons/star.png', 0),
      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(
            iconPath,
          ),
          width: 20.w,
          height: 20.h,
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

Widget descriptionText(String description) {
  return reusableText2(
    color: AppColors.primaryThirdElementText,
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    description,
  );
}

Widget courseSummaryTitle() {
  return reusableText2(
    'The Course Includes',
    fontSize: 16.sp,
  );
}

Widget courseSummaryView(BuildContext context, CourseDetailStates state) {
  var imagesInfo = <String, String>{
    '${state.courseItem!.video_length ?? 0} Hours Video': 'video_detail.png',
    'Total ${state.courseItem!.lesson_num ?? 0} lessons': 'file_detail.png',
    '${state.courseItem!.down_num ?? 0} Downloadable Resources':
        'download_detail.png',
  };
  return Column(
    children: [
      ...List.generate(
        imagesInfo.length,
        (index) => GestureDetector(
          onTap: () => Null,
          child: Container(
            margin: EdgeInsets.only(
              top: 15.h,
            ),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.all(
                  //   7.0,
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.w,
                    ),
                    color: AppColors.primaryElement,
                  ),
                  child: Image.asset(
                    'assets/icons/${imagesInfo.values.elementAt(index)}',
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  imagesInfo.keys.elementAt(index),
                  style: TextStyle(
                    color: AppColors.primarySecondaryElementText,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Widget courseLessonList(CourseDetailStates state) {
  return SingleChildScrollView(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: state.lessonItem!.length,
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
              if (state.checkBuy == true) {
                Navigator.of(context).pushNamed(AppRoutes.Lesson_DETAIL,
                    arguments: {"id": state.lessonItem![index].id});
              } else {
                toastInfo(msg: 'Please buy this course before you watch');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.h,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image:
                              NetworkImage(state.lessonItem![index].thumbnail!),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        listContainer(state.lessonItem![index].name.toString()),
                        listContainer(
                          state.lessonItem![index].description.toString(),
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
