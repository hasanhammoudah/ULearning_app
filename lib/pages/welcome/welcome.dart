import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_bloc.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_event.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_state.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Container(
              width: 375.w,
              margin: EdgeInsets.only(top: 34.h),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                      //   print('index value is ${index}');
                    },
                    children: [
                      _page(
                        context: context,
                        imagePath: 'assets/images/reading.png',
                        index: 1,
                        buttonName: 'Next',
                        title: 'Firest See Learning',
                        subTitle:
                            'Forget about a for of paper all knowledge in one learning!',
                      ),
                      _page(
                        context: context,
                        imagePath: 'assets/images/boy.png',
                        index: 2,
                        buttonName: 'Next',
                        title: 'Connect With Everyone',
                        subTitle:
                            'Always keep in touch with your tutor & friend lets get connected!',
                      ),
                      _page(
                        context: context,
                        imagePath: 'assets/images/man.png',
                        index: 3,
                        buttonName: 'Get Started',
                        title: 'Always Fascinated Learning',
                        subTitle:
                            'Anywhere, anytime. The time is at your discretion so study whenever your want.',
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 100.h,
                    child: DotsIndicator(
                      position: state.page.toInt(),
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                        color: AppColors.primaryThirdElementText,
                        activeColor: AppColors.primaryElement,
                        size: const Size.square(
                          8.0,
                        ),
                        activeSize: const Size(
                          18.0,
                          8.0,
                        ),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _page({
    required BuildContext context,
    required String imagePath,
    required int index,
    required String buttonName,
    required String title,
    required String subTitle,
  }) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 24.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          width: 374.w,
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Text(
            subTitle,
            style: TextStyle(
              color: AppColors.primarySecondaryElementText,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            } else {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const MyHomePage()));
              Global.storageService
                  .setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);

              Navigator.pushNamedAndRemoveUntil(
                  context, '/signIn', (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 100.h,
              left: 25.w,
              right: 25.w,
            ),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(
                Radius.circular(15.w),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
