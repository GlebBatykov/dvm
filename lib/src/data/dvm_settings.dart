final class DvmSettings {
  final String? globalSdkPath;

  final Map<String, String>? localRules;

  const DvmSettings({
    required this.globalSdkPath,
    required this.localRules,
  });

  DvmSettings.fromJson(final Map<String, Object?> json)
      : globalSdkPath = json['globalSdkPath'] as String?,
        localRules = json['localRules'] as Map<String, String>?;

  Map<String, Object?> toJson() => {
        if (globalSdkPath != null) 'globalSdkPath': globalSdkPath,
        if (localRules != null) 'localRules': localRules,
      };
}
