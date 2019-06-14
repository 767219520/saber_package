
import 'dart:io';
import 'package:orientation/orientation.dart';
import 'package:flutter/services.dart';

class Orientation_Utils{
  static void setPreferredOrientations(List<DeviceOrientation> orientations) {
    if (orientations == null || orientations.isEmpty) return;
    if (Platform.isIOS) {
      OrientationPlugin.forceOrientation(orientations[0]);
    }
    OrientationPlugin.setPreferredOrientations(orientations);
  }
}