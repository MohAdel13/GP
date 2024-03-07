import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'login.dart';


class RecScreen extends StatefulWidget {
  @override
  _RecScreenState createState() => _RecScreenState();
}

class _RecScreenState extends State<RecScreen> {
  bool isRecord = false;
  final record = AudioRecorder();
  final player = AudioPlayer();
  late String path;
  bool analysis = false;
  bool showResult = false;

  List<String> emotions =[
    'Angry', 'Happy', 'Sad', 'Disgust', 'Fearful', 'Surprised', 'Neutral', 'Calm'
  ];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    record.dispose();
    player.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if(showResult){
      final Random random = Random();
      int rand = random.nextInt(7);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => AwesomeDialog (
          customHeader: null,
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          titleTextStyle: const TextStyle(color: Colors.black),
          descTextStyle: const TextStyle(color: Colors.green),
          body: Column(
            children: [
              const Text('Analysis Done..', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image(
                    image: AssetImage('assets/images/${emotions[rand].toLowerCase()}.png'),
                    fit: BoxFit.scaleDown,
                    alignment: FractionalOffset.center
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(emotions[rand], style: const TextStyle(color: Colors.black)),
              ),
            ],
          )
      ).show());

      showResult = false;
      analysis = false;
      isRecord = false;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));

          },
            icon: const Row(
              children: [
                Text('Sign out ', style: TextStyle(color: Colors.white, fontSize: 18.0),),
                Icon(Icons.exit_to_app, size: 40.0,)
              ],
            ),
            color: Colors.white,)
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
          color: Colors.black,
          child: Stack(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: isRecord || analysis,
                    child: Text(
                      analysis ? 'Processing..': 'Listening...',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 70.0,
                          fontFamily: 'Italiano'),
                    ),
                  ),
                  Visibility(
                      visible: !(isRecord||analysis),
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
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Visibility(
                    visible: isRecord || analysis,
                    child: analysis ? LoadingAnimationWidget.flickr(
                      leftDotColor: Colors.white,
                      rightDotColor: Colors.blue,
                      size: 50,
                    ) : SiriWaveform.ios9(
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

            Visibility(
              visible: !analysis,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 70.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: const Color(0xFF35374B),
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
                        record.pause();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of AlertDialog
                            return AlertDialog(
                              title: const Text('Audio is recorded'),
                              content: const Text('Proceed for analysis?'),
                              actions: [
                                // Define two buttons - Save and Cancel
                                TextButton(
                                  onPressed: () {
                                    record.stop();
                                   // player.play(UrlSource(path));
                                    setState(() {
                                      analysis = true;
                                      isRecord = false;
                                    });
                                    Future.delayed(const Duration(seconds: 8), () {
                                      setState(() {
                                        showResult = true;
                                      });
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: ()async {
                                    record.stop();
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
      path = '${(await getApplicationDocumentsDirectory()).path}/recording.wav';
      await record.start(const RecordConfig(), path: path);
    }
    return null;
  }

}
