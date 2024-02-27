import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/pages.dart';
import 'package:ulearning_app/common/values/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDV6jENlNzylFosbiIoKUnN2Hcu4vBJvkY',
      appId: '1:800081806428:android:67404905833efbee865299',
      messagingSenderId: 'fsdf',
      projectId: 'ulearning-5e7cd',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: AppColors.primaryText),
                elevation: 0,
                backgroundColor: Colors.white,
              ),
            ),
            title: 'Flutter Demo',
            onGenerateRoute: AppPages.GenarateRouteSettings,
          );
        },
      ),
    );
  }
}

