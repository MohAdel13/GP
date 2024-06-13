import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/network/local/cache_helper.dart';
import 'package:gp_project/core/network/remote/dio_helper.dart';
import 'package:gp_project/features/result/bloc/result_states.dart';
import 'package:gp_project/features/result/models/result_model.dart';

class ResultCubit extends Cubit<ResultStates>{
  ResultCubit({required this.audio}): super(ResultInitState());

  String? resultEmotion;

  final File audio;

  List<String> emotions = [
    'Angry', 'Happy', 'Sad', 'Disgust', 'Fearful', 'Surprised', 'Neutral', 'Calm'
  ];

  static ResultCubit get(BuildContext context) => BlocProvider.of(context);

  void getResult()async{
    emit(ResultLoadingState());

    final bytes = await audio.readAsBytes();
    String audio64 = base64Encode(bytes);

    Response response = await DioHelper.postData({'audio': '$audio64'}).catchError((error){

      return Response(requestOptions: RequestOptions(), statusCode: 400, data: {'error': error.toString()});
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      resultEmotion = emotions[response.data['emotion']];
      print(resultEmotion);
      emit(ResultSuccessState());
    }

    else{
      //print("error:..............." + response.data['error']);
      emit(ResultErrorState());
    }
  }

  Future<void> saveHistory({required BuildContext context}) async {
    emit(ResultSaveLoadingState());

    final String? userId = CacheHelper.getData('userId') as String?;

    final firestoreInstance = FirebaseFirestore.instance;

    DateTime dateTime = DateTime.now();

    ResultModel model = await uploadAudio(userId, dateTime);

    await firestoreInstance.collection('users').doc(userId)
      .collection('history').doc('$dateTime'.split('.')[0]).set(model.toJson()).then((value){
        emit(ResultSaveSuccessState());
        Navigator.pop(context);
    }).catchError((error){
      print(error);
      emit(ResultSaveErrorState());
    });
  }

  Future<ResultModel> uploadAudio(String? userId,DateTime dateTime)async{
    late final ResultModel model;
    final Reference reference = FirebaseStorage.instance.ref();
    String ref = '';
    await reference.child('audios/${userId}_${"${dateTime}".split('.')[0]}.wav')
        .putFile(audio).then((value)async{
      await value.storage.ref().child('audios/${userId}_${"${dateTime}".split('.')[0]}.wav')
          .getDownloadURL().then((v){
        ref = v;
        model = ResultModel(emotion: resultEmotion!, dateTime: dateTime, audio: ref);
      });
    });
    return model;
  }
}