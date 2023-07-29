base class DvmException implements Exception {
  final String? message;

  DvmException([this.message]);

  @override
  String toString() {
    if (message != null) {
      return '$runtimeType: $message';
    } else {
      return super.toString();
    }
  }
}
