import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saber_package/saber_commonwidgets.dart';
import 'package:saber_package/saber_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Initialize {
  static Initialize instance = new Initialize();

  Directory baseDir;
  String macId = "";
  bool loadMacId = true;
  SharedPreferences sharedPreferences;
  PackageInfo packageInfo;
  AndroidDeviceInfo _deviceInfo;
  IosDeviceInfo _iosDeviceInfo;
  static DeviceInfoPlugin _deviceInfoPlugin = new DeviceInfoPlugin();
  static FlutterSecureStorage _storage = new FlutterSecureStorage();

  FutureInit _before;
  FutureInit _after;

  setBeforeFutureInit(FutureInit _before) {
    this._before = _before;
  }

  setAfterFutureInit(FutureInit _after) {
    this._after = _after;
  }

  Future<String> _init(BuildContext context) async {
    Common.printLog('初始化');
    macId = loadMacId ? await _getMacId() : "";
    if (_before != null) await _before(context);
    sharedPreferences = await SharedPreferences.getInstance();
    baseDir = await getApplicationDocumentsDirectory();
    packageInfo = await PackageInfo.fromPlatform();
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

  InitializeApp(this._initialize, this.widgetBuilder);

  FutureBuilderController _futureBuilderController = FutureBuilderController();

  Future _init(BuildContext context) {
    return _initialize._init(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWidget(widgetBuilder, _init, _futureBuilderController);
  }
}
