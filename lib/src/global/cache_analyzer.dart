import 'dart:io';

import 'package:dvm/src/cli/extensions/list_extension.dart';

import 'sdk_analyzer.dart';

final class CacheAnalyzer {
  final String _path;

  late final SdkAnalyzer _sdkAnalyzer = SdkAnalyzer();

  CacheAnalyzer(String path) : _path = path;

  Future<List<Directory>?> getDirectories() async {
    final directory = Directory.fromUri(Uri.directory(_path));

    if (!await directory.exists()) {
      return null;
    }

    final directories = await directory
        .list()
        .where((entry) => entry is Directory)
        .cast<Directory>()
        .toList();

    return directories.asyncWhere(
      (directory) async => _sdkAnalyzer.isSdkFolder(directory.path),
    );
  }
}
