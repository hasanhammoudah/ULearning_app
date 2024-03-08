import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ulearning_app/common/apis/user_api.dart';
import 'package:ulearning_app/common/entities/user.dart';
import 'package:ulearning_app/common/values/constants.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_bloc.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  void handlesSignIn(String type) async {
    try {
      if (type == "email") {
        // BlocProvider.of<SignInBloc>(context).state;
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          print('email empty');
        } else {
          print('email is $emailAddress');
        }
        if (password.isEmpty) {
          print('password empty');
        }
        try {
          final credentail =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress.trim(),
            password: password.trim(),
          );
          if (credentail.user == null) {
            print('does not exist');
          }
          // if (!credentail.user!.emailVerified) {
          //   print('user does not verified');
          // }
          var user = credentail.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;
            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            loginRequestEntity.type = 1;
            await asyncPostAllData(loginRequestEntity);
            if (context.mounted) {
             await HomeController(context: context).init();
            }
          } else {
            toastInfo(msg: 'Currently you are not a user of this app');
          }
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          } else if (e.code == 'invalid-email') {
            print('Your email format is wrong.');
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    var result = await UserAPI.login(params: loginRequestEntity);

    try {
      Global.storageService.setString(
          AppConstants.STORAGE_USER_PROFILE_KEY, jsonEncode(result.data!));
      Global.storageService.setString(
          AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);
      EasyLoading.dismiss();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/application', (route) => false);
      }
    } catch (e) {
      print('saving local storage error ${e.toString()}');
    }
  }
}
