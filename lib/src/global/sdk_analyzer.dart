import 'dart:io';

import 'platform_specific_variables.dart';

final class SdkAnalyzer {
  Future<bool> isSdkFolder(final String path) async {
    return _isExecutableFileExists(path);
  }

  Future<bool> _isExecutableFileExists(final String path) async {
    final file = File.fromUri(Uri.file('$path/bin/$dartExecutableFileName'));

    return file.exists();
  }
}
