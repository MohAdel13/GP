import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gp_project/Shared/constants.dart';
import 'package:gp_project/get_start_screen.dart';
import 'package:gp_project/login.dart';
import 'package:gp_project/recorder.dart';
import 'package:gp_project/history.dart';
import 'package:gp_project/register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB6N0T07gFuPKnstXama7md2cVpPI1OnBc",  //Replace with API key from google-services.json
      appId: "1:723155374403:android:87e6b335b0e407d40b9ff6",    // Replace with App ID from google-services.json`enter code here`
      messagingSenderId: "723155374403",  // Replace with Messaging Sender ID from google-services.json
      projectId: "speech-emotion-recogniti-9cc7c",  // Replace with Project ID from google-services.json
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser==null?GetStartScreen():RecScreen(),
    );
  }
}
