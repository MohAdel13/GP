import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

import '../../../login/presentation/ui/login_screen.dart';

class GetStartScreen extends StatelessWidget
{
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
              action:(){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder:(context) => LoginScreen(),),
                );
                return Future(() => true);
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