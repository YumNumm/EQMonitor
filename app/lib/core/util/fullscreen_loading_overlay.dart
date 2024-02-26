import 'dart:async';

import 'package:flutter/material.dart';

Future<T> showFullScreenLoadingOverlay<T>(
  BuildContext context,
  Future<T> future,
) async {
  // loading dialog
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    ),
  );

  // wait for future with try/catch
  try {
    return await future;
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    rethrow;
  } finally {
    if (context.mounted && Navigator.of(context).canPop()) {
      // current screen is dialog
      Navigator.of(context).pop();
    }
  }
}
