// ignore_for_file: prefer_const_constructors

import 'package:flapy_bird/karekter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hiko Baba Uçuyor",
      debugShowCheckedModeBanner: false,
      //Karekteri Seçeceğimiz kısma yönlendir
      home: Karekter(),
    );
  }
}
/*
   FURKAN CAN 
   Github: https://github.com/furkancan2107
   Linkedin: https://www.linkedin.com/in/furkan-can-45182b236/
 */
