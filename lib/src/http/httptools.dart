import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:saber_package/saber_tools.dart';
import 'package:saber_package/saber_utils.dart';
import 'package:saber_package/src/utils/file_utils.dart';

import '../../saber_http.dart';

class Httptools {
  static Httptools instance = new Httptools();
  Client _client;

  init([int connectionTimeout, int idleTimeout]) {
    _client = _paypalClient();
  }

  static http.Client _paypalClient(
      [int connectionTimeout = 10, int idleTimeout = 10]) {
    var ioClient = new HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    ioClient.connectionTimeout = Duration(seconds: connectionTimeout);
    ioClient.idleTimeout = Duration(seconds: idleTimeout);
    var c = IOClient(ioClient);
    return c;
  }

  Future<HttpResponse> requestCall(@required String url,
      {Map<String, Object> queryParameters,
      Map<String, String> headers,
      String requestType = "post"}) async {
    HttpResponse httpResponse = new HttpResponse();
    var q = toMap(queryParameters);
    url = render(url, q);
    try {
      Response response = "post" == requestType
          ? await _client.post(url, body: q, headers: headers)
          : await _client.get(url, headers: headers);
      httpResponse.httpCode = response.statusCode;
      httpResponse.result = response.body;
    } catch (e) {
      httpResponse.httpCode = 0;
      httpResponse.result = e.toString();
    }
    return httpResponse;
  }

  Future<HttpResponse> uploadFile(@required String url, @required File file,
      {BuildContext loading}) async {
    FormData formData = FormData.from(
        {"file": new UploadFileInfo(file, FileUtils.getFileNameByPath(file))});
    var h = {
      'content-type':
          "multipart/form-data; boundary=${formData.boundary.substring(2)}"
    };

    HttpResponse httpResponse = new HttpResponse();
    try {
      Response response =
          await _client.post(url, body: formData.asBytes(), headers: h);
      httpResponse.httpCode = response.statusCode;
      httpResponse.result = response.body;
    } catch (e) {
      httpResponse.httpCode = 0;
      httpResponse.result = e.toString();
    }
  }

  static String render(String value, Map<String, String> map) {
    if (map == null || map.isEmpty) return value;
    map.forEach((k, v) {
      value = value.replaceAll("{${k}}", v);
    });
    return value;
  }

  static Map<String, String> toMap(Map<String, Object> map) {
    Map<String, String> m = Map();
    if (map == null) return m;
    map.forEach((k, v) {
      m.putIfAbsent(k, () {
        return v.toString();
      });
    });
    return m;
  }
}

class HttpResponse {
  int httpCode;
  String result;
}
