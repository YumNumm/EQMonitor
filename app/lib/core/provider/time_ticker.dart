import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_ticker.g.dart';

@Riverpod(keepAlive: true)
Stream<DateTime> timeTicker(
  Ref ref, [
  Duration duration = const Duration(seconds: 1),
]) => Stream.periodic(duration, (_) => DateTime.now());
