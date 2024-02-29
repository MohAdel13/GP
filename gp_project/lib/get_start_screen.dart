import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';

// Create the MyHomePage widget for the main screen
class GetStartScreen extends StatelessWidget {
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

                  Image.asset('assets/images/background.gif'),

                ],
              ),
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(50.0),
            child: SliderButton(
              action:()async{print('done');},
              baseColor: Colors.blue,
              label: const Text(
                'Get Started',
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