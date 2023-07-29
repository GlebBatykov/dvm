import '../global/constants.dart';
import '../global/environment.dart';

String? getCacheFolderPath() {
  final dvmCache = Environment.dvmCache;

  if (dvmCache != null) {
    return dvmCache;
  }

  final home = Environment.dvmHome ?? Environment.applicationConfigHome;

  if (home == null) {
    return null;
  }

  return '$home/$cacheFolderName';
}

String? getCurrentLinkPath() {
  final dvmHome = Environment.dvmHome;

  if (dvmHome != null) {
    return '$dvmHome/$currentLinkName';
  }

  final applicationConfigHome = Environment.applicationConfigHome;

  if (applicationConfigHome != null) {
    return '$applicationConfigHome/$dvmFolderName/$currentLinkName';
  }

  return null;
}
