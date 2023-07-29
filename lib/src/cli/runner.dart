import 'package:args/command_runner.dart';

import 'commands.dart';
import 'dart_command_proxy.dart';

final class Runner {
  Future<void> run(final List<String> args) async {
    if (_isProxyDartCommand(args)) {
      const DartCommandProxy().run(args);

      return;
    }

    await _runCommandRunner(args);
  }

  bool _isProxyDartCommand(final List<String> args) =>
      args.isNotEmpty && args.first == 'dart';

  Future<void> _runCommandRunner(final List<String> args) async {
    final runner = CommandRunner('dvm', 'Version manager of Dart.');

    runner.addCommand(AddCommand());
    runner.addCommand(ConfigCommand());
    runner.addCommand(DartCommand());
    runner.addCommand(DoctorCommand());
    runner.addCommand(GlobalCommand());
    runner.addCommand(InstallCommand());
    runner.addCommand(ListCommand());
    runner.addCommand(LocalCommand());
    runner.addCommand(RemoveCommand());

    try {
      await runner.run(args);
    } on Object catch (object) {
      if (object is UsageException) {
        print(object);
      }
    }
  }
}
