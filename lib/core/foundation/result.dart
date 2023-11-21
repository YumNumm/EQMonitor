import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T, R> with _$Result<T, R> {
  const Result._();
  const factory Result.success(T value) = Success<T, R>;
  const factory Result.failure(R error) = Failure<T, R>;

  T? get valueOrNull => when(
        success: (value) => value,
        failure: (_) => null,
      );

  R? get errorOrNull => when(
        success: (_) => null,
        failure: (error) => error,
      );
}
