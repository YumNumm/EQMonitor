import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueExt<T> on AsyncValue<T> {
  Future<AsyncValue<T>> guardPlus(
    Future<T> Function() future,
  ) async {
    try {
      return AsyncValue<T>.data(await future());
      // ignore: avoid_catches_without_on_clauses
    } catch (e, st) {
      return AsyncValue<T>.error(e, st).copyWithPrevious(this);
    }
  }
}
