import 'dart:io';

import 'package:args/command_runner.dart';

import '../../global/environment.dart';
import '../constants/commands.dart';
import '../constants/icons.dart';

const _detailsOptionName = 'details';
const _detailsOptionAbbr = 'd';

final class DoctorCommand extends Command<void> {
  @override
  String get name => doctorCommand;

  @override
  String get description => '';

  late bool _details;

  DoctorCommand() {
    _initializeParser();
  }

  void _initializeParser() {
    argParser.addFlag(
      _detailsOptionName,
      abbr: _detailsOptionAbbr,
      defaultsTo: false,
    );
  }

  @override
  void run() {
    final args = argResults;

    if (args == null) {
      return;
    }

    _details = args[_detailsOptionName];

    _printHomeInfo();
    _printXdgConfigHomeInfo();
    _printAppDataInfo();
    _printDvmHomeInfo();
    _printDvmCacheInfo();
  }

  void _printHomeInfo() {
    if (Platform.isWindows) {
      return;
    }

    final home = Environment.home;

    if (home != null) {
      print(
        '$successIcon \$HOME veriable specified${_details ? ' ($home)' : ''}.',
      );
    } else {
      print('$notSuccessIcon \$HOME veriable not specified.');
    }
  }

  void _printXdgConfigHomeInfo() {
    if (!Platform.isLinux) {
      return;
    }

    final xdgConfigHome = Environment.xdgConfigHome;

    if (xdgConfigHome != null) {
      print(
        '$successIcon \$XDG_CONFIG_HOME variable specified${_details ? ' ($xdgConfigHome)' : ''}.',
      );
    }
  }

  void _printAppDataInfo() {
    if (!Platform.isWindows) {
      return;
    }

    final appData = Environment.appData;

    if (appData != null) {
      print(
        '$successIcon %APPDATA% variable specified${_details ? ' ($appData)' : ''}.',
      );
    } else {
      print('$notSuccessIcon %APPDATA% variable not specified.');
    }
  }

  void _printDvmHomeInfo() {
    final dvmHome = Environment.dvmHome;

    if (dvmHome != null) {
      print(
        '$successIcon \$DVM_HOME veriable specified${_details ? ' ($dvmHome)' : ''}.',
      );
    } else {
      print('$warningIcon \$DVM_HOME veriable not specified.');
    }
  }

  void _printDvmCacheInfo() {
    final dvmCache = Environment.dvmCache;

    if (dvmCache != null) {
      print(
        '$successIcon \$DVM_CACHE variable specified${_details ? ' ($dvmCache)' : ''}.',
      );
    } else {
      print('$warningIcon \$DVM_CACHE variable not specified.');
    }
  }
}
