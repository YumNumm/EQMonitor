import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'periodic_timer.g.dart';

@riverpod
Stream<DateTime> periodicTimer(Ref ref, Duration interval) async* {
  final streamController = StreamController<DateTime>();
  final timer = Timer.periodic(interval, (_) {
    streamController.add(DateTime.now());
  });
  ref.onDispose(() {
    timer.cancel();
    unawaited(streamController.close());
  });
  yield* streamController.stream;
}
