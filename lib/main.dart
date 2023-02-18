import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:qstart_admin_web/Screens/login/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyBXTLp--6nbat-UUDb090KTdZj0Pp9okWM",
              appId: "1:880080785905:web:575e8dee932c2025d27450",
              messagingSenderId: "880080785905",
              projectId: "qstart-ec938",
              storageBucket: "qstart-ec938.appspot.com")
          : null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,

      // home: LoginPage(),
      //
      home: LoginScreen(),
    );
  }
}
