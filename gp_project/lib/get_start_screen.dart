import 'package:flutter/material.dart';
import 'package:gp_project/login.dart';
import 'package:slider_button/slider_button.dart';

class GetStartScreen extends StatefulWidget
{
  @override
  _GetStartScreen createState() => _GetStartScreen();
}

// Create the MyHomePage widget for the main screen
class _GetStartScreen extends State<GetStartScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center children
                children: [
                  const Text(
                    'SPEECH EMOTION RECOGNITION',
                    style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset('assets/images/wave.gif'),
                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: SliderButton(
              action:()async{
                Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen(),));
              },
              baseColor: Colors.blue,
              label: const Text(
                'Get started',
                style: TextStyle(fontSize:18.0),
                textAlign: TextAlign.center,
              ),
              alignLabel: Alignment.center,
              icon: const Icon(Icons.navigate_next, size: 30,),
            ),
          )
        ],
      ),
    );
  }
}