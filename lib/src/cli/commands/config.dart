import 'package:args/command_runner.dart';

import '../constants/commands.dart';

final class ConfigCommand extends Command<void> {
  @override
  String get name => configCommand;

  @override
  String get description => '';
}
