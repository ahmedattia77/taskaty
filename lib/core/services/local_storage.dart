import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences preferencesInstance;

  static Future<void> initSharedPref() async {
    preferencesInstance = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData<T>({
    required String key,
    required T value,
  }) async {
    switch (value) {
      case String s:
        return await preferencesInstance.setString(key, s);
      case int i:
        return await preferencesInstance.setInt(key, i);
      case bool b:
        return await preferencesInstance.setBool(key, b);
      case double d:
        return await preferencesInstance.setDouble(key, d);
      case List<String> l:
        return await preferencesInstance.setStringList(key, l);
      default:
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }

  static Object? getData({required String key}) {
    try {
      return preferencesInstance.get(key);
    } catch (e) {
      return null;
    }
  }
}
