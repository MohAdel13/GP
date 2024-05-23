import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/bloc_observer.dart';
import 'package:gp_project/core/network/local/cache_helper.dart';
import 'package:gp_project/features/get%20start/presentation/ui/get_start_screen.dart';
import 'package:gp_project/features/home%20layout/presentation/ui/home_layout_screen.dart';

import 'core/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB6N0T07gFuPKnstXama7md2cVpPI1OnBc",
      appId: "1:723155374403:android:87e6b335b0e407d40b9ff6",
      messagingSenderId: "723155374403",
      projectId: "speech-emotion-recogniti-9cc7c",
    ),
  );
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: !CacheHelper.sharedPreferences.containsKey('userId') ? GetStartScreen():HomeLayoutScreen(),
    );
  }
}
