import 'dart:convert';
import 'package:oauth2example/model/config_model.dart';
import 'package:oauth2example/model/user_profile_model.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  static const String _currentUser = "CURRENT_USER";
  static const String _savedConfigs = "CONFIGS";

//+++ USER Login Preference Data - {Key, Value}
  static void addCurrentUser({required UserProfileModel user}) =>
      GetStorage().write(_currentUser, json.encode(user.toJson()));

  static UserProfileModel? getCurrentUser() {
    String? profileJson = GetStorage().read(_currentUser);

    if (profileJson != null) {
      return UserProfileModel.fromJson(jsonDecode(profileJson));
    }
    return null;
  }

  static void removeCurrentUser() {
    GetStorage().remove(_currentUser);
  }

  static String? getToken() {
    var _tokenData = getCurrentUser()?.token;

    if (_tokenData == null) {
      removeCurrentUser();
      return null;
    }

    return _tokenData;
  }

  static String? getUserEmail() {
    return getCurrentUser()?.email;
  }

  static String? getUserFullName() {
    var curUser = getCurrentUser();
    return curUser?.name;
  }

  static bool isValidLogin() {
    bool login = false;
    try {
      var _user = getCurrentUser();

      if (_user != null && _user.name != null) {
        login = true;
      }
    } catch (_) {}

    return login;
  }

  ///  Guardar e Recuperar OAuth 2.0 COnfigs
  static void addConfiguration({required ConfigModel configuration}) =>
      GetStorage().write(_savedConfigs, json.encode(configuration.toJson()));

  static ConfigModel? getConfiguration() {
    String? configuration = GetStorage().read(_savedConfigs);
    if (configuration != null) {
      return ConfigModel.fromJson(jsonDecode(configuration));
    }
    return null;
  }

  static void removeConfiguration() {
    GetStorage().remove(_savedConfigs);
  }
}
