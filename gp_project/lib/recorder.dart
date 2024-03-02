import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:siri_wave/siri_wave.dart';
import 'dart:async';

class RecScreen extends StatefulWidget
{
  @override
  _RecScreenState createState() => _RecScreenState();
}

class _RecScreenState extends State<RecScreen>
{
  bool isRecord = false;
  Stopwatch _stopwatch = Stopwatch();
  Duration _elapsedTime = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hi', style: TextStyle(color: Colors.white,
                  fontSize: 80.0,
                  fontFamily: 'Italiano'),),
              SizedBox(height: 30.0,),
              
              Visibility(
                visible: isRecord,
                child: SiriWaveform.ios7(
                  controller: IOS7SiriWaveformController(
                    amplitude: 0.5,
                    color: Colors.blue,
                    frequency: 4,
                    speed: 0.15,),
                  options: IOS7SiriWaveformOptions(height: 180,width: 360,)),
              ),
              SizedBox(height: 30.0,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60.0)
                ),
                child: IconButton(
                onPressed: (){
                  setState(() {
                    isRecord = !isRecord;
                  });
                }, 
                icon: Icon(Icons.mic,
                color: isRecord ? Colors.green : Colors.grey,
                size: 85.0,
                ),
                ),
              )
            ],
          )
        ),
      ),
      );
  }
}