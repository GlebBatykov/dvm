import 'dart:io';

String get dartExecutableFileName {
  if (Platform.isWindows) {
    return 'dart.exe';
  }

  return 'dart';
}
