import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'services_provider.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => ServicesProvider(),
  ));
}
