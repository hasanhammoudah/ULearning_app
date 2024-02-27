import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ulearning_app/common/service/storage_service.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDV6jENlNzylFosbiIoKUnN2Hcu4vBJvkY',
        appId: '1:800081806428:android:67404905833efbee865299',
        messagingSenderId: 'fsdf',
        projectId: 'ulearning-5e7cd',
      ),
    );
    storageService = await StorageService().init();
  }
}
