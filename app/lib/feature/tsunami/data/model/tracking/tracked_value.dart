import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_value.freezed.dart';

/// {value, telegramId}[] を表す追跡履歴
typedef Tracked<T> = List<TrackedValue<T>>;

@freezed
abstract class TrackedValue<T> with _$TrackedValue<T> {
  const factory({
    required T value,
    required String telegramId,
  }) = _TrackedValue<T>;
}
