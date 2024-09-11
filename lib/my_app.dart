import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '/splash/splash.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(home: SplashScreen());
  }
}
