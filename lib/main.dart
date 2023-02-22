import 'package:flutter/material.dart';
import 'package:food_recipe_app/helper/dio_helper.dart';
import 'package:food_recipe_app/layout/home_screen.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(currentIndex: 0,),
    );
  }
}