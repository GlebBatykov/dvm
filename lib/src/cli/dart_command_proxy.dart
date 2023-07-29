import 'dart:io';

import 'package:dvm/src/cli/paths.dart';

import '../global/platform_specific_variables.dart';

final class DartCommandProxy {
  const DartCommandProxy();

  Future<void> run(final List<String> args) async {
    final currentLinkPath = getCurrentLinkPath();

    if (currentLinkPath == null) {
      print(
        'DVM home folder not found. Use dvm doctor command for see more details.',
      );

      return;
    }

    final link = Link.fromUri(Uri.file(currentLinkPath));

    if (!await link.exists()) {
      print('Dart SDK not selected.');

      return;
    }

    final target = await link.target();

    await _executeCommand(args, target);
  }

  Future<void> _executeCommand(
    final List<String> args,
    final String target,
  ) async {
    final executablePath = '$target/bin/$dartExecutableFileName';

    final commandArgs = args.getRange(1, args.length);

    final process = await Process.start(
      executablePath,
      [...commandArgs],
      runInShell: true,
    );

    process.stdout.listen(stdout.add);
    process.stderr.listen(stderr.add);

    await process.exitCode;
  }
}
