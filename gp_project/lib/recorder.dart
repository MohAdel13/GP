import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

class RecScreen extends StatefulWidget
{
  @override
  _RecScreenState createState() => _RecScreenState();
}

class _RecScreenState extends State<RecScreen>
{
  bool isRecord = false;
  final record = AudioRecorder();

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
              Visibility(
                visible: isRecord,
                child: Text('Listening...', style: TextStyle(color: Colors.white,
                    fontSize: 70.0,
                    fontFamily: 'Italiano'),),
              ),
              Visibility(
                visible: !isRecord,
                child: Text('Hi', style: TextStyle(color: Colors.white,
                    fontSize: 70.0,
                    fontFamily: 'Italiano'),),),
              SizedBox(height: 30.0,),
              
              Visibility(
                visible: isRecord,
                child: SiriWaveform.ios9(
                  controller: IOS9SiriWaveformController(
                    amplitude: 1,
                    speed: 0.1,),
                  options: IOS9SiriWaveformOptions(height: 180,width: 360,)),
              ),
              SizedBox(height: 30.0,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                          title: Text('Alert Dialog Title'),
                          content: Text('This is the content of the dialog'),
                          actions: [
                            // Define two buttons - Save and Cancel
                            TextButton(
                              onPressed: () {
                                // Handle Save action
                                Navigator.of(context).pop();
                                // Implement your save functionality here
                              },
                              child: Text('Save'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle Cancel action
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                  Icons.mic,
                  color: isRecord ? Colors.blue : Colors.grey,
                  size: 85.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      );
  }

  
  Future<Stream?> RecordFunc() async
  {
    bool hasPermission = await Permission.microphone.status.isGranted;
    if (!hasPermission) {
    PermissionStatus status = await Permission.microphone.request();
    hasPermission = status == PermissionStatus.granted;
    }
    if (await record.hasPermission()) {
    // Start recording to file
    await record.start(const RecordConfig(), path: 'Records/test.m4a');
    // ... or to stream
    final stream = await record.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    return stream;
    }
    return null;
  }
}