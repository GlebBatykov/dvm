import 'package:args/command_runner.dart';

import '../constants/commands.dart';

final class InstallCommand extends Command<void> {
  @override
  String get name => installCommand;

  @override
  String get description => '';

  @override
  Future<void> run() async {}
}
