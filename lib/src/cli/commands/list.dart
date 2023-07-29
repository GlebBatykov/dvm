import 'dart:io';

import 'package:args/command_runner.dart';

import '../../global/cache_analyzer.dart';
import '../constants/commands.dart';
import '../extensions/directory_extension.dart';
import '../paths.dart';

final class ListCommand extends Command<void> {
  @override
  String get name => listCommand;

  @override
  String get description => '';

  @override
  Future<void> run() async {
    final path = getCacheFolderPath();

    if (path == null) {
      print(
        'DVM cache folder not found. Use dvm doctor command for see more details.',
      );

      return;
    }

    final cacheAnalyzer = CacheAnalyzer(path);

    final directories = await cacheAnalyzer.getDirectories();

    if (directories == null || directories.isEmpty) {
      print('No versions have been installed yet.');

      return;
    }

    _printList(directories);
  }

  void _printList(final List<Directory> directories) async {
    for (final directory in directories) {
      print(directory.name);
    }
  }
}
