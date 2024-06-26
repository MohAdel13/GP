import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;

  static void init(){

    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.80.93:5000",
        headers: {
          "Content-Type": "application/json",
        },
        receiveDataWhenStatusError: true
      ),
    );
  }
  
  static Future<Response> postData(Map<String, dynamic> data){
    return dio.post('/emotion', data: data);
  }
}