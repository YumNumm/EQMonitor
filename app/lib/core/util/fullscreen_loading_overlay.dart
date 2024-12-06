import 'dart:async';
import 'dart:developer';

import 'package:eqmonitor/app.dart';
import 'package:flutter/material.dart';

class FullScreenCircularProgressIndicator extends StatelessWidget {
  const FullScreenCircularProgressIndicator({super.key});

  static Future<T> showUntil<T>(
    BuildContext context,
    Future<T> Function() function, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => const FullScreenCircularProgressIndicator(),
        barrierDismissible: false,
      ),
    );
    final T result;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      result = await function().timeout(timeout);
    } on TimeoutException catch (e) {
      log(
        'タイムアウト',
        error: e,
        name: 'FullScreenCircularProgressIndicator.showUntil',
      );
      rethrow;
    } finally {
      final navigator = App.navigatorKey.currentState;
      if (navigator != null && navigator.canPop()) {
        navigator.pop();
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
