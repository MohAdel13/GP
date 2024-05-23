import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPreferences;

  static Future<void> init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Object? getData(String key) async{
    Object? value = sharedPreferences.get(key);
    return value;
  }

  static Future<bool> setData(String key, dynamic value)async{
    if(value is String) {
      return await sharedPreferences.setString(key, value);
    }
    else if(value is double)
    {
      return await sharedPreferences.setDouble(key, value);
    }
    else if(value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    else if(value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    else {
      return false;
    }
  }

  static Future<bool> removeData(String key){
    return sharedPreferences.remove(key);
  }
}