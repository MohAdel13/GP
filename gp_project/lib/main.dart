import 'package:flutter/material.dart';
import 'package:gp_project/Shared/database.dart';
import 'package:gp_project/get_start_screen.dart';
import 'package:gp_project/login.dart';
import 'package:gp_project/recorder.dart';
import 'package:gp_project/history.dart';
import 'package:gp_project/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegiScreen(),
    );
  }
}
