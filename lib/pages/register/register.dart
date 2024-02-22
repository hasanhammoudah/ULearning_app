import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_event.dart';
import 'package:ulearning_app/pages/register/bloc/register_state.dart';
import 'package:ulearning_app/pages/register/register_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterStates>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar('Sign Up'),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: reusableText(
                          'Enter your details below and free sign up'),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 36.h,
                      ),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText('User name'),
                          SizedBox(
                            height: 5.h,
                          ),
                          buildTextField('Enter your user name', 'name', 'user',
                              (value) {
                            context
                                .read<RegisterBloc>()
                                .add(UserNameEvent(value));
                          }),
                          reusableText('Email'),
                          SizedBox(
                            height: 5.h,
                          ),
                          buildTextField(
                              'Enter your email address', 'email', 'user',
                              (value) {
                            context.read<RegisterBloc>().add(EmailEvent(value));
                          }),
                          reusableText('Password'),
                          buildTextField(
                              'Enter your password', 'password', 'lock',
                              (value) {
                            context
                                .read<RegisterBloc>()
                                .add(PasswordEvent(value));
                          }),
                          reusableText('Re-enter password'),
                          buildTextField('Re-enter your password to confirm',
                              'password', 'lock', (value) {
                            context
                                .read<RegisterBloc>()
                                .add(RePasswordEvent(value));
                          }),
                          Container(
                            margin: EdgeInsets.only(left: 25.w),
                            child: reusableText(
                                'Enter your details below and free sign up'),
                          ),
                          buildLogInAndRegButton(
                            'Sign Up',
                            'login',
                            () {
                              RegisterController(context: context)
                                  .handleEmailRegister();
                              // Navigator.pushNamed(context, Register.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
