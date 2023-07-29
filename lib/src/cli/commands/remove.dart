import 'package:args/command_runner.dart';

import '../constants/commands.dart';

final class RemoveCommand extends Command<void> {
  @override
  String get name => removeCommand;

  @override
  String get description => '';
}
