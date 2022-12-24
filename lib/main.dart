import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theummah/UI/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
     theme: ThemeData(
       primaryColor:const Color(0x37218B15),
       primarySwatch: Colors.green,

     ),

      home: const SplashScreen(),
    );
  }
}
