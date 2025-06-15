import 'package:injectable/injectable.dart';
import '../../../core/storage/local_storage.dart';
import '../../models/user_model.dart';
import 'dart:convert';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
  Future<UserModel?> getCachedUserById(int id);
  Future<void> cacheUser(UserModel user);
  Future<void> clearCache();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final LocalStorage localStorage;
  
  UserLocalDataSourceImpl(this.localStorage);
  
  static const String _usersKey = 'cached_users';
  static const String _userKey = 'cached_user_';
  
  @override
  Future<List<UserModel>> getCachedUsers() async {
    try {
      final userData = await localStorage.getUserData();
      if (userData != null && userData.containsKey(_usersKey)) {
        final List<dynamic> userList = userData[_usersKey];
        return userList.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    try {
      final userData = await localStorage.getUserData() ?? <String, dynamic>{};
      userData[_usersKey] = users.map((user) => user.toJson()).toList();
      await localStorage.saveUserData(userData);
    } catch (e) {
      // Handle caching error
    }
  }
  
  @override
  Future<UserModel?> getCachedUserById(int id) async {
    try {
      final userDataString = await localStorage.getString('$_userKey$id');
      if (userDataString != null) {
        final Map<String, dynamic> userJson = jsonDecode(userDataString);
        return UserModel.fromJson(userJson);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await localStorage.saveString(
        '$_userKey${user.id}',
        jsonEncode(user.toJson()),
      );
    } catch (e) {
      // Handle caching error
    }
  }
  
  @override
  Future<void> clearCache() async {
    try {
      await localStorage.clear();
    } catch (e) {
      // Handle clearing error
    }
  }
}