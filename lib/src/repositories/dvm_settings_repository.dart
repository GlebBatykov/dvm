import 'dart:convert';
import 'dart:io';

import '../data/dvm_settings.dart';
import '../global/constants.dart';
import '../global/environment.dart';

final class DvmSettingsRepository {
  Future<DvmSettings?> get() async {
    final file = _getFile();

    if (!await file.exists()) {
      return null;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      return null;
    }

    final json = jsonDecode(data);

    return DvmSettings.fromJson(json);
  }

  Future<void> save(final DvmSettings settings) async {
    final file = _getFile();

    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    final json = settings.toJson();

    final data = jsonEncode(json);

    await file.writeAsString(data);
  }

  Future<void> remove() async {
    final file = _getFile();

    if (await file.exists()) {
      await file.delete();
    }
  }

  File _getFile() {
    final home = Environment.home;

    if (home == null) {
      throw Exception('\$HOME environment variable must be specified.');
    }

    final path = '$home/$dvmFolderName/$settingsFileName';

    return File.fromUri(Uri.file(path));
  }
}
