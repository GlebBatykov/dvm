import 'package:args/command_runner.dart';

import '../constants/commands.dart';

final class LocalCommand extends Command<void> {
  @override
  String get name => localCommand;

  @override
  String get description => '';
}
