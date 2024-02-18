import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/sign_in/widgets/sign_in_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static String routeName = "/signIn";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildThirdPartyLogin(context),
                Center(
                  child: reusableText('Or use your email account to login'),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 36.h,
                  ),
                  padding: EdgeInsets.only(left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText('Email'),
                      SizedBox(
                        height: 5.h,
                      ),
                      buildTextField(
                          'Enter your email address', 'email', 'user'),
                      SizedBox(
                        height: 5.h,
                      ),
                      reusableText('Password'),
                      buildTextField('Enter your password', 'password', 'lock'),
                      forgotPassword(),
                      buildLogInAndRegButton('Log in', 'login'),
                      buildLogInAndRegButton('Register', 'register'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
