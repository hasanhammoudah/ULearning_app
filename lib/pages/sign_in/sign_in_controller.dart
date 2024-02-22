import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/widgets/flutter_toast.dart';
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
          if (!credentail.user!.emailVerified) {
            print('user does not verified');
          }
          var user = credentail.user;
          if (user != null) {
            print('user exist');
          } else {
            print('no user');
          }
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          //   if (e.code == 'user-not-found') {
          //     print('No user found for that email.');
          //   } else if (e.code == 'wrong-password') {
          //     print('Wrong password provided for that user.');
          //   } else if (e.code == 'invalid-email') {
          //     print('Your email format is wrong.');
          //   }
          // }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
