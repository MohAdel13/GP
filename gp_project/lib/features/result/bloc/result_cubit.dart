import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp_project/core/network/remote/dio_helper.dart';
import 'package:gp_project/features/result/bloc/result_states.dart';

class ResultCubit extends Cubit<ResultStates>{
  ResultCubit({required this.audio64}): super(ResultInitState());

  String audio64;

  String? resultEmotion;

  List<String> emotions = [
    'Angry', 'Happy', 'Sad', 'Disgust', 'Fearful', 'Surprised', 'Neutral', 'Calm'
  ];

  static ResultCubit get(BuildContext context) => BlocProvider.of(context);

  void getResult()async{
    emit(ResultLoadingState());
    Response response = await DioHelper.postData({'audio': '$audio64'}).catchError((error){

      return Response(requestOptions: RequestOptions(), statusCode: 400, data: {'error': error.toString()});
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      resultEmotion = emotions[response.data['emotion']];
      print(resultEmotion);
      emit(ResultSuccessState());
    }

    else{
      print("error:..............." + response.data['error']);
      emit(ResultErrorState());
    }
  }
}