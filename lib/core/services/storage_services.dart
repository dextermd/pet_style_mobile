import 'dart:convert';

import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  static late SharedPreferences _sharedPreferences;

  StorageServices(){
    _init();
  }

  static Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> setObject(String key, dynamic value) async {
    return await _sharedPreferences.setString(key, json.encode(value));
  }

  Future<dynamic> getObject(String key) async {
    if (_sharedPreferences.getString(key) == null) return null;
    return json.decode(_sharedPreferences.getString(key)!);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  bool getDeviceOnboardingOpen() {
    return _sharedPreferences.getBool(AppConstants.STORAGE_SHOW_ONBOARDING) ?? true;
  }

  bool getIsLoggedIn() {
    return _sharedPreferences.getString(AppConstants.STORAGE_ACCESS_TOKEN) == null
        ? false
        : true;
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }
}