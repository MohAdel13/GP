import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/features/result/presentation/ui/result_screen.dart';
import 'package:gp_project/features/upload/bloc/upload_states.dart';

class UploadCubit extends Cubit<UploadStates>{
  UploadCubit(): super(UploadInitState());

  TextEditingController controller = TextEditingController();
  static UploadCubit get(BuildContext context) => BlocProvider.of(context);

  bool filePicked = false;
  File? file;

  void pick()async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav'],
      allowMultiple: false
    );
    if (result != null) {
      file = File(result.files.single.path!);
      controller.text = result.files.single.path!;
      emit(UploadSuccessState());
    }
    else{
      filePicked = false;
    }
  }

  void proceed(BuildContext context) async {
    final bytes = await File(file!.path).readAsBytes();
    String audio64 = base64Encode(bytes);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(audio64: audio64))
    );
  }
}