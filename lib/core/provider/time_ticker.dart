import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_ticker.g.dart';

@riverpod
Stream<DateTime> timeTicker(TimeTickerRef ref) =>
    Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
