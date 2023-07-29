import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';

import '../extensions/directory_extension.dart';
import '../../global/cache_analyzer.dart';
import '../constants/commands.dart';
import '../paths.dart';

final class GlobalCommand extends Command<void> {
  @override
  String get name => globalCommand;

  @override
  String get description => '';

  late final Console _console = Console();

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

    print('List:');
    stdout.writeln();

    _printInfo(directories);

    stdout.writeln();
    print('Select sdk:');

    final index = _selectSdkIndex(directories.length);

    if (index == null) {
      print('No versions selected.');

      return;
    }

    final currentLinkPath = getCurrentLinkPath();

    if (currentLinkPath == null) {
      print(
        'DVM home folder not found. Use dvm doctor command for see more details.',
      );

      return;
    }

    final selectedDirectory = directories[index - 1];

    await _createLink(selectedDirectory, currentLinkPath);

    stdout.writeln();
    print('Sdk ${selectedDirectory.name} is globally selected.');
  }

  void _printInfo(final List<Directory> directories) {
    for (var i = 0; i < directories.length; i++) {
      print('[${i + 1}]: ${directories[i].name}');
    }
  }

  int? _selectSdkIndex(final int length) {
    int? index;

    do {
      final input = _console.readLine(
        cancelOnBreak: true,
        cancelOnEscape: true,
        cancelOnEOF: true,
      );

      if (input == null) {
        return null;
      }

      final number = int.tryParse(input);

      if (number != null && number > 0 && number <= length) {
        index = number;
      } else {
        print('Incorrect input.');
      }
    } while (index == null);

    return index;
  }

  Future<void> _createLink(
    final Directory directory,
    final String dvmFolderPath,
  ) async {
    final link = Link.fromUri(Uri.file(dvmFolderPath));

    if (await link.exists()) {
      await link.delete();
    }

    await link.create(directory.path, recursive: true);
  }
}
