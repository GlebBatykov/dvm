import 'dart:io';

import 'package:path/path.dart';

extension DirectoryExtension on Directory {
  String get name => basename(path);
}
