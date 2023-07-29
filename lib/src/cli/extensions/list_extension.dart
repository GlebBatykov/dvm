import 'dart:async';

extension ListExtension<T> on List<T> {
  Future<List<T>> asyncWhere(
    final FutureOr<bool> Function(T element) test,
  ) async {
    final result = <T>[];

    for (final element in this) {
      if (await test(element)) {
        result.add(element);
      }
    }

    return result;
  }
}
