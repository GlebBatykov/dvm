import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:file_copy/file_copy.dart';
import 'package:cli_progress_bar/cli_progress_bar.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';

import '../../global/sdk_analyzer.dart';
import '../constants/commands.dart';
import '../constants/icons.dart';
import '../paths.dart';

const _pathOptionName = 'path';
const _pathOptionAbbr = 'p';

final class AddCommand extends Command<void> {
  @override
  String get name => addCommand;

  @override
  String get description => '''
    -$_pathOptionName - 
''';

  late final SdkAnalyzer _analyzer = SdkAnalyzer();

  AddCommand() {
    _initializeParser();
  }

  void _initializeParser() {
    argParser.addOption(
      _pathOptionName,
      abbr: _pathOptionAbbr,
      defaultsTo: Directory.current.path,
    );
  }

  @override
  Future<void> run() async {
    final cacheFolderPath = getCacheFolderPath();

    if (cacheFolderPath == null) {
      print(
        'DVM cache folder not found. Use \'dvm doctor\' command for see more details.',
      );

      return;
    }

    final args = argResults;

    if (args == null) {
      return;
    }

    final path = _getPath(args);

    final directory = _getDirectory(path);

    if (!await directory.exists()) {
      print('Folder not exist by path: $path.');

      return;
    }

    if (!await _analyzer.isSdkFolder(path)) {
      print('Folder not contains Dart SDK.');

      return;
    }

    final copyPath = _getCopyPath(directory, cacheFolderPath);

    await _copyDirectory(directory, copyPath);
  }

  String _getPath(final ArgResults args) {
    final path = args[_pathOptionName];

    if (path != Directory.current.path) {
      return '${Directory.current.path}/$path';
    }

    return path;
  }

  Directory _getDirectory(final String path) =>
      Directory.fromUri(Uri.directory(path));

  String _getCopyPath(
    final Directory directory,
    final String cacheFolderPath,
  ) =>
      '$cacheFolderPath/${basename(directory.path)}';

  Future<void> _copyDirectory(
    final Directory directory,
    final String copyPath,
  ) async {
    final size = await directory.length();

    final bar = _createProgressBar(size);

    print('Copy files...');

    bar.update();

    final copy = FileCopy.watchCopyDirectory(directory, copyPath);

    final progressStream = _getProgressStream(copy);

    await for (final copyProgress in progressStream) {
      final progress = copyProgress.total - copyProgress.remains;

      bar.setProgress(progress);
      bar.setAfter(_getAfter(progress, size));

      bar.update();
    }

    stdout.writeln();

    print('$successIcon Copying completed successfully.');
  }

  Stream<CopyProgress> _getProgressStream(final ObservableCopy copy) =>
      copy.progressStream.debounceTime(
        const Duration(milliseconds: 50),
      );

  ProgressBar _createProgressBar(final int fileSize) => ProgressBar(
        schema: '#before [#bar] #after',
        before: 'Copy',
        after: _getAfter(0, fileSize),
        settings: ProgressBarSettings(
          max: fileSize,
          size: 20,
        ),
      );

  String _getAfter(final int progress, final int fileSize) =>
      '$progress/$fileSize bytes';
}
