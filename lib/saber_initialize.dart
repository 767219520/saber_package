import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saber_package/saber_commonwidgets.dart';
import 'package:saber_package/saber_tools.dart';
import 'package:saber_package/saber_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Initialize<T> {
  static Initialize instance;
  ScreenUtils screenUtils = ScreenUtils.instance;
  Directory baseDir;
  String macId = "";
  bool loadMacId = true;
  SharedPreferences sharedPreferences;
  PackageInfo packageInfo;
  AndroidDeviceInfo _deviceInfo;
  IosDeviceInfo _iosDeviceInfo;
  static DeviceInfoPlugin _deviceInfoPlugin = new DeviceInfoPlugin();
  static FlutterSecureStorage _storage = new FlutterSecureStorage();
  double _designWidth;
  double _designHeight;
  bool _designAllowFontScaling;
  FutureInit _before;
  FutureInit _after;
  T loginUser;
  Function fromJsonAsT;
  bool firstInstall = false;

  setBeforeFutureInit(FutureInit _before) {
    this._before = _before;
  }

  setAfterFutureInit(FutureInit _after) {
    this._after = _after;
  }

  setLoginUser(T loginUser) {
    this.loginUser = loginUser;
    if (loginUser == null)
      sharedPreferences.remove("loginUser");
    else
      sharedPreferences.setString(
          "loginUser", JsonTool.toJsonString(loginUser));
  }

  T getLoginUser() {
    if (this.loginUser != null) {
      return this.loginUser;
    }
    String json = sharedPreferences.getString("loginUser");
    if (StringUtils.isEmpty(json)) return null;

    var json2 = JsonTool.toJson(json);
    this.loginUser = fromJsonAsT<T>(json2);
    return this.loginUser;
  }

  static Initialize<T> init<T>(
      {Function fromJsonAsT,
      FutureInit before,
      FutureInit after,
      double designWidth,
      double designHeight,
      bool designAllowFontScaling}) {
    Initialize<T> initialize = new Initialize<T>();
    initialize.fromJsonAsT = fromJsonAsT;
    initialize._before = before;
    initialize._after = after;
    initialize._designHeight = designHeight;
    initialize._designWidth = designWidth;
    initialize._designAllowFontScaling = designAllowFontScaling;
    instance = initialize;
    return initialize;
  }

  Future<String> _init(BuildContext context, Future init) async {
    macId = loadMacId ? await _getMacId() : "";
    if (_before != null) await _before(context);
    screenUtils.init(context,
        width: _designWidth,
        height: _designHeight,
        allowFontScaling: _designAllowFontScaling);
    sharedPreferences = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
    firstInstall =
        packageInfo.version != sharedPreferences.getString("versions");
    if (firstInstall) {
      sharedPreferences.setString("versions", packageInfo.version);
    }
    baseDir = await getApplicationDocumentsDirectory();
    if (_after != null) await _after(context);
    return Future.value("1");
  }

  static Future<String> storageRead(String key) async {
    return _storage.read(key: key);
  }

  static Future<void> storageWrite(String key, String value) async {
    return _storage.write(key: key, value: value);
  }

  Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
    if (_deviceInfo == null) {
      _deviceInfo = await _deviceInfoPlugin.androidInfo;
    }
    return _deviceInfo;
  }

  Future<IosDeviceInfo> getIosDeviceInfo() async {
    if (_iosDeviceInfo == null) {
      _iosDeviceInfo = await _deviceInfoPlugin.iosInfo;
    }
    return _iosDeviceInfo;
  }

  Future<String> _getMacId() async {
    if (StringUtils.isNotEmpty(macId)) return macId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await getAndroidDeviceInfo();
      macId = deviceInfo.androidId;
    } else {
      macId = await storageRead(packageInfo.packageName);
      if (StringUtils.isEmpty(macId)) {
        var deviceInfo = await _deviceInfoPlugin.iosInfo;
        macId = deviceInfo.identifierForVendor;
        storageWrite(packageInfo.packageName, macId);
      }
    }
    return macId;
  }
}

class InitializeApp extends StatelessWidget {
  WidgetBuilderResult widgetBuilder;
  Initialize _initialize;
  Future init;

  InitializeApp(this._initialize, this.widgetBuilder, this.init);

  FutureBuilderController _futureBuilderController = FutureBuilderController();

  Future _init(BuildContext context) {
    return _initialize._init(context, init);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWidget(widgetBuilder, _init, _futureBuilderController,
        key: Key("InitializeApp"));
  }
}
