
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo/Presentation/home.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(), 
    );
  }
}
