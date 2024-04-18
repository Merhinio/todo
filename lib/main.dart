import 'package:flutter/material.dart';
import 'package:todo/Presentation/home.dart';
import 'package:todo/Repository/repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => TodoProvider(), child: MaterialApp(home: MyHome(), debugShowCheckedModeBanner: false)));
}

