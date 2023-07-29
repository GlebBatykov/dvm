import 'package:args/command_runner.dart';

import '../constants/commands.dart';

final class DartCommand extends Command<void> {
  @override
  String get name => dartCommand;

  @override
  String get description => '';
}
