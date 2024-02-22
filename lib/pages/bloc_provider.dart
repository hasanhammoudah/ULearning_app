import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/app_bloc.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_bloc.dart';

class AppBlocProviders {
  static get allBlocProviders => [
     BlocProvider(
          lazy: false,
          create: (context) => WelcomeBloc(),
        ),
        // BlocProvider(
        //   lazy: false,
        //   create: (context) => AppBlocs(),
        // ),
        BlocProvider(
          // lazy: false,
          create: (context) => SignInBloc(),
        ),
          BlocProvider(
          // lazy: false,
          create: (context) => RegisterBloc(),
        ),
  ];
}
