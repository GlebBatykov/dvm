import 'dart:io';

import 'package:path/path.dart';

import 'constants.dart';

abstract final class Environment {
  static String? get applicationConfigHome {
    final configHome = Environment.configHome;

    if (configHome == null) {
      return null;
    }

    return join(configHome, dvmFolderName);
  }

  static String? get configHome {
    if (Platform.isWindows) {
      return appData;
    }

    if (Platform.isMacOS) {
      final home = Environment.home;

      if (home == null) {
        return null;
      }

      return join(home, 'Library', 'Application Support');
    }

    if (Platform.isLinux) {
      final xdgConfigHome = Environment.xdgConfigHome;

      if (xdgConfigHome != null) {
        return xdgConfigHome;
      }

      final home = Environment.home;

      if (home == null) {
        return null;
      }

      return join(home, '.config');
    }

    final home = Environment.home;

    if (home == null) {
      return null;
    }

    return join(home, '.config');
  }

  static String? get xdgConfigHome => _environment['XDG_CONFIG_COME'];

  static String? get appData => _environment['APPDATA'];

  static String? get home => _environment['HOME'];

  static String? get dvmHome => Platform.environment['DVM_HOME'];

  static String? get dvmCache => Platform.environment['DVM_CACHE'];

  static Map<String, String> get _environment => Platform.environment;
}
