import 'package:flutter/material.dart';
import 'package:gp_project/get_start_screen.dart';
import 'package:gp_project/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartScreen(),
    );
  }
}
