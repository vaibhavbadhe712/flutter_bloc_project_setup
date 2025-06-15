import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

abstract class LocalStorage {
  Future<void> saveUserData(Map<String, dynamic> userData);
  Future<Map<String, dynamic>?> getUserData();
  Future<void> clearUserData();
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> clear();
}

@LazySingleton(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  final SharedPreferences sharedPreferences;
  
  LocalStorageImpl(this.sharedPreferences);
  
  @override
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await sharedPreferences.setString(
      AppConstants.userDataKey,
      json.encode(userData),
    );
  }
  
  @override
  Future<Map<String, dynamic>?> getUserData() async {
    final userData = sharedPreferences.getString(AppConstants.userDataKey);
    if (userData != null) {
      return json.decode(userData) as Map<String, dynamic>;
    }
    return null;
  }
  
  @override
  Future<void> clearUserData() async {
    await sharedPreferences.remove(AppConstants.userDataKey);
  }
  
  @override
  Future<void> saveString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }
  
  @override
  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }
  
  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }
}

@module
abstract class StorageModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

