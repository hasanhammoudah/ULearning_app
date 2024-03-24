import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_bloc.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_event.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_state.dart';
import 'package:ulearning_app/pages/profile/widgets/profile_widgets.dart';
import 'package:ulearning_app/common/widgets/base_text_widget.dart'
    as reusableText;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var userProfile = Global.storageService.getUserProfile();
    print('user profile is ${jsonEncode(userProfile)}');
    context.read<ProfileBloc>().add(TriggerProfileName(userProfile));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppbar(),
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  profileIconAndEditButton(),
                  SizedBox(
                    height: 30.h,
                  ),
                  buildProfileName(state),
                  buildRowView(context),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: buildListView(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
