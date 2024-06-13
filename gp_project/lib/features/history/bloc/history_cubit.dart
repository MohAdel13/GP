import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/network/local/cache_helper.dart';
import 'package:gp_project/features/history/bloc/history_states.dart';
import 'package:gp_project/features/result/models/result_model.dart';
import 'package:path_provider/path_provider.dart';

class HistoryCubit extends Cubit<HistoryStates>{
  HistoryCubit(): super(HistoryInitState());

  List<ResultModel> history = [];

  List<String> resultState = [];

  late final AudioPlayer player;

  static HistoryCubit get(BuildContext context) => BlocProvider.of(context);

  void initPlayer(){
    player = AudioPlayer();
    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        allOff(-1);
        emit(HistoryAudioEndState());
      }
    });
  }

  void getHistory() async{
    emit(HistoryLoadingState());

    String? userId = CacheHelper.getData('userId') as String?;

    final firestoreInstance = FirebaseFirestore.instance;

    await firestoreInstance.collection('users')
        .doc(userId).collection('history').get().then((value){
          for(var result in value.docs){
            history.add(ResultModel.fromJson(data: result.data()));
            resultState.add('off');
          }
          print(history);
          emit(HistorySuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HistoryErrorState());
    });
  }

  Future<void> allOff(int index)async{
    await player.stop().then((value){
      for(int i = 0; i< resultState.length; i++){
        if(i != index){
          resultState[i] = 'off';
        }
      }
    });
  }

  void startAudio(int index)async{
    resultState[index] = 'loading';
    emit(HistoryAudioLoadingState());

    await allOff(index);

    resultState[index] = 'on';
    emit(HistoryAudioStartState());

    await player.play(UrlSource(history[index].audio));
  }

  void stopAudio(int index)async{
    await player.stop();
    resultState[index] = 'off';
    emit(HistoryAudioEndState());
  }
  
  void deleteHistory(int index)async{
    if(resultState[index] != 'off'){
      stopAudio(index);
    }
    
    final firestoreInstance = FirebaseFirestore.instance;
    
    final String? userId = CacheHelper.getData('userId') as String?;

    final Reference reference = FirebaseStorage.instance.ref();

    await reference.child('audios/${userId}_${"${history[index].dateTime}".split('.')[0]}.wav')
        .delete();
    
    await firestoreInstance.collection('users')
        .doc(userId)
        .collection('history')
        .doc('${history[index].dateTime}'.split('.')[0])
        .delete().then((value){
          print('${history[index].dateTime}'.split('.')[0]);
          history.removeAt(index);
          emit(HistoryDeleteSuccessState());
    }).catchError((error){
      emit(HistoryDeleteErrorState());
    });
  }
}