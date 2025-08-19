import 'package:flutter/material.dart';
import 'package:fruitty/utils/string_app.dart';
import 'package:get/get.dart';
import 'package:fruitty/screens/intro_screen.dart';
import 'package:fruitty/controllers/favorite_controller.dart';

void main() {

  Get.put(FavoriteController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      home: const IntroScreen(),
      debugShowCheckedModeBanner: false,
      title: StringApp.appName,
    );
  }
}