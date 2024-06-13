import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/features/record/bloc/record_states.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../result/presentation/ui/result_screen.dart';

class RecordCubit extends Cubit<RecordStates> {
  RecordCubit() : super(RecordInitState());
  AudioRecorder record = AudioRecorder();

  String path = "";

  static RecordCubit get(BuildContext context) => BlocProvider.of(context);

  void startRecord() async {
    bool hasPermission = await Permission.microphone.status.isGranted;
    if (!hasPermission) {
      PermissionStatus status = await Permission.microphone.request();
      hasPermission = (status == PermissionStatus.granted);
    }
    if (await record.hasPermission()) {
      path = '${(await getApplicationDocumentsDirectory())
          .path}/recording.wav';
      await record.start(const RecordConfig(), path: path);
      emit(RecordStartState());
    }
  }

  Future<void> stopRecord(BuildContext context)async{
    await record.stop();
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
              onPressed: () async {
                final File audio = File(path);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultScreen(audio: audio))
                );
                close();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
    emit(RecordFinishedState());
  }

}