import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/pages/course/contributor/contributor_controller.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_cubit.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_state.dart';
import 'package:ulearning_app/pages/course/contributor/widgets/contributor_widgets.dart';

class Contributor extends StatefulWidget {
  const Contributor({super.key});

  @override
  State<Contributor> createState() => _ContributorState();
}

class _ContributorState extends State<Contributor> {
  late ContributorController _contributorController;
  @override
  void didChangeDependencies() {
    _contributorController = ContributorController(context: context);
    _contributorController.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContributorCubit, ContributorStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: const Text(
            'Contributor',
          )),
          body: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 325.w,
                    height: 220.h,
                    child: Stack(
                      children: [
                        backgroundImage(),
                        if (state.authorItem != null)
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: authorView(context, state),
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  authorDescription(state),
                  SizedBox(
                    height: 20.h,
                  ),
                  appPrimaryButton('Go chat'),
                  SizedBox(
                    height: 20.h,
                  ),
                  reusableText2(
                    "Author course lisr",
                    color: AppColors.primaryText,
                  ),
                  authorCourseList(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
