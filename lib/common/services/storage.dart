import 'package:get_storage/get_storage.dart';

class Storage{
  static void clear(){
    GetStorage().erase();
  }

  static void setString(String key, String value){
    GetStorage().write(key, value);
  }

  static String? getString(String key){
    return GetStorage().read(key);
  }

  static void setBool(String key, bool value){
    GetStorage().write(key, value);
  }

  static bool? getBool(String key){
    return GetStorage().read(key);
  }

  static Future<void> removeKey(String key){
    return GetStorage().remove(key);
  }
}