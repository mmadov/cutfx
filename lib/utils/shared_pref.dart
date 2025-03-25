import 'dart:convert';
import 'dart:io';

import 'package:cutfx/model/setting/setting.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  SharedPreferences? _sharedPreferences;
  static String selectedLanguage = Platform.localeName.split('_')[0];

  Future<SharePref> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future saveString(String key, String? value) async {
    await _sharedPreferences?.setString(key, value ?? "");
  }

  String? getString(String key) {
    return _sharedPreferences?.getString(key);
  }

  Future saveDouble(String key, double? value) async {
    await _sharedPreferences?.setDouble(key, value ?? 0);
  }

  double? getDouble(String key) {
    return _sharedPreferences?.getDouble(key);
  }

  bool getLogin(String key) {
    return _sharedPreferences?.getBool(key) == null
        ? false
        : _sharedPreferences!.getBool(key)!;
  }

  Future setLogin(String key, bool value) async {
    await _sharedPreferences?.setBool(key, value);
  }

  SalonUser? getSalonUser() {
    if (getString(AppRes.user) == null) return null;
    return SalonUser.fromJson(
        jsonDecode(_sharedPreferences!.getString(AppRes.user)!));
  }

  Setting? getSettings() {
    if (getString(AppRes.settings) == null) return null;
    return Setting.fromJson(
        jsonDecode(_sharedPreferences!.getString(AppRes.settings)!));
  }

  Future<dynamic>? clear() {
    return _sharedPreferences?.clear();
  }

  static setLatLong(String lat, String long) async {
    SharePref sharePref = await SharePref().init();
    sharePref.saveString(ConstRes.salonLat, lat);
    sharePref.saveString(ConstRes.salonLong, long);
  }
}
