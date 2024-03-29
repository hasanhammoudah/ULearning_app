import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/common/routes/names.dart';
import 'package:ulearning_app/global.dart';
import 'package:ulearning_app/pages/application/application_page.dart';
import 'package:ulearning_app/pages/application/bloc/application_bloc.dart';
import 'package:ulearning_app/pages/course/bloc/course_bloc.dart';
import 'package:ulearning_app/pages/course/contributor/contributor.dart';
import 'package:ulearning_app/pages/course/contributor/cubit/contributor_cubit.dart';
import 'package:ulearning_app/pages/course/course_detail/course_detail.dart';
import 'package:ulearning_app/pages/messages/chat/bloc/chat_bloc.dart';
import 'package:ulearning_app/pages/messages/chat/chat.dart';
import 'package:ulearning_app/pages/profile/buy_courses/bloc/buy_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/buy_courses/buy_courses.dart';
import 'package:ulearning_app/pages/profile/my_courses/bloc/my_courses_bloc.dart';
import 'package:ulearning_app/pages/profile/my_courses/my_courses.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_bloc.dart';
import 'package:ulearning_app/pages/course/paywebview/paywebview.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_bloc.dart';
import 'package:ulearning_app/pages/home/home_page.dart';
import 'package:ulearning_app/pages/lesson/bloc/lesson_bloc.dart';
import 'package:ulearning_app/pages/lesson/lesson_detail.dart';
import 'package:ulearning_app/pages/profile/bloc/profile_bloc.dart';
import 'package:ulearning_app/pages/profile/payment_details/cubit/payment_details_cubit.dart';
import 'package:ulearning_app/pages/profile/payment_details/payment_details.dart';
import 'package:ulearning_app/pages/profile/profile_page.dart';
import 'package:ulearning_app/pages/profile/settings/bloc/settings_bloc.dart';
import 'package:ulearning_app/pages/profile/settings/settings_page.dart';
import 'package:ulearning_app/pages/register/bloc/register_bloc.dart';
import 'package:ulearning_app/pages/register/register.dart';
import 'package:ulearning_app/pages/search/bloc/search_bloc.dart';
import 'package:ulearning_app/pages/search/search.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:ulearning_app/pages/sign_in/sign_in.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_bloc.dart';
import 'package:ulearning_app/pages/welcome/welcome.dart';

import '../../pages/course/course_detail/bloc/course_detail_bloc.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const Welcome(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(
          create: (_) => SignInBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: const Register(),
        bloc: BlocProvider(
          create: (_) => RegisterBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLACATION,
        page: const ApplicationPage(),
        bloc: BlocProvider(
          create: (_) => ApplicationBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: const HomePage(),
        bloc: BlocProvider(
          create: (_) => HomePageBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SETTINGS,
        page: const SettingsPage(),
        bloc: BlocProvider(
          create: (_) => SettingsBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.COURSE_DETAIL,
        page: const CourseDetail(),
        bloc: BlocProvider(
          create: (_) => CourseDetailBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Lesson_DETAIL,
        page: const LessonDetail(),
        bloc: BlocProvider(
          create: (_) => LessonBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PAY_WEB_VIEW,
        page: const PayWebView(),
        bloc: BlocProvider(
          create: (_) => PayviewBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PROFILE,
        page: const ProfilePage(),
        bloc: BlocProvider(
          create: (_) => ProfileBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.MY_COURSES,
        page: const MyCourses(),
        bloc: BlocProvider(
          create: (_) => MyCoursesBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.BUY_COURSES,
        page: const BuyCourses(),
        bloc: BlocProvider(
          create: (_) => BuyCoursesBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.PAYMENT_DETAILS,
        page: const PaymentDetails(),
        bloc: BlocProvider(
          create: (_) => PaymentDetailsCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.CONTRIBUTOR,
        page: const Contributor(),
        bloc: BlocProvider(
          create: (_) => ContributorCubit(),
        ),
      ),
      PageEntity(
        route: AppRoutes.CHAT,
        page: const ChatPage(),
        bloc: BlocProvider(
          create: (_) => ChatBloc(),
        ),
      ),
    ];
  }

// return all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  // a modal that covers entire screen as we click on navigator object
  static MaterialPageRoute GenarateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      // check for route name macthing when navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        print('first log');
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLoggedin = Global.storageService.getIsLoggedIn();
          if (isLoggedin) {
            return MaterialPageRoute(
              builder: (_) => const ApplicationPage(),
              settings: settings,
            );
          }
          return MaterialPageRoute(
            builder: (_) => const SignIn(),
            settings: settings,
          );
        }
        // print('valid route name ${settings.name}');
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(
        builder: (_) => const SignIn(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;
  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}
