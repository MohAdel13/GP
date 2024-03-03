import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RecScreen extends StatefulWidget {
  @override
  _RecScreenState createState() => _RecScreenState();
}

class _RecScreenState extends State<RecScreen> {
  bool isRecord = false;
  final record = AudioRecorder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Stack(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isRecord,
                    child: const Text(
                      'Listening...',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 70.0,
                          fontFamily: 'Italiano'),
                    ),
                  ),
                  Visibility(
                      visible: !isRecord,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Hi there!',
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 70.0,
                                fontFamily: 'Italiano'),
                            speed: const Duration(milliseconds: 250),
                          ),
                        ],
                        totalRepeatCount: 1,
                      )
                    //const Text(
                    //   'Hi',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 70.0,
                    //       fontFamily: 'Italiano'),
                    // ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Visibility(
                    visible: isRecord,
                    child: SiriWaveform.ios9(
                        controller: IOS9SiriWaveformController(
                          amplitude: 1,
                          speed: 0.1,
                        ),
                        options: const IOS9SiriWaveformOptions(
                          height: 180,
                          width: 360,
                        )),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Color(0xFF35374B),
                      borderRadius: BorderRadius.circular(60.0)
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        isRecord = !isRecord;
                        RecordFunc();
                      });
                    },
                    onLongPressEnd: (details) {
                      setState(() {
                        isRecord = !isRecord;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of AlertDialog
                          return AlertDialog(
                            title: const Text('Alert Dialog Title'),
                            content: const Text('This is the content of the dialog'),
                            actions: [
                              // Define two buttons - Save and Cancel
                              TextButton(
                                onPressed: () {
                                  // Handle Save action
                                  Navigator.of(context).pop();
                                  // Implement your save functionality here
                                },
                                child: const Text('Save'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle Cancel action
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.mic,
                      color: isRecord ? Colors.blue : Colors.white,
                      size: 65.0,
                    ),
                  ),
                ),
              ),
            )
          ],
          )
      ),
    );
  }

  Future<Stream?> RecordFunc() async {
    bool hasPermission = await Permission.microphone.status.isGranted;
    if (!hasPermission) {
      PermissionStatus status = await Permission.microphone.request();
      hasPermission = status == PermissionStatus.granted;
    }
    if (await record.hasPermission()) {
      // Start recording to file
      await record.start(const RecordConfig(), path: 'Records/test.m4a');
      // ... or to stream
      final stream = await record
          .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
      return stream;
    }
    return null;
  }
}
