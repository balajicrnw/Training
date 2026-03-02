import 'package:flutter/foundation.dart';

mixin ExceptionHandlerMixin {

  Future<bool> handleAsync(
    Future<void> Function() action, {
    String? errorMessage,
    void Function(Object error)? onError,
  }) async {
    try {
      await action();
      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('${errorMessage ?? "Exception caught in mixin"}: $e');
        print(stackTrace);
      }
      if (onError != null) {
        onError(e);
      }
      return false;
    }
  }


  bool handleSync(
    void Function() action, {
    String? errorMessage,
    void Function(Object error)? onError,
  }) {
    try {
      action();
      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('${errorMessage ?? "Exception caught in mixin"}: $e');
        print(stackTrace);
      }
      if (onError != null) {
        onError(e);
      }
      return false;
    }
  }
}
