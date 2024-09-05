// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomFeedback _$CustomFeedbackFromJson(Map<String, dynamic> json) {
  return _CustomFeedback.fromJson(json);
}

/// @nodoc
mixin _$CustomFeedback {
  FeedbackType? get feedbackType => throw _privateConstructorUsedError;

  /// 返信を希望するかどうか
  bool? get isReplyRequested => throw _privateConstructorUsedError;

  /// スクリーンショットを添付するかどうか
  bool get isScreenshotAttached => throw _privateConstructorUsedError;

  /// Serializes this CustomFeedback to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFeedbackCopyWith<CustomFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFeedbackCopyWith<$Res> {
  factory $CustomFeedbackCopyWith(
          CustomFeedback value, $Res Function(CustomFeedback) then) =
      _$CustomFeedbackCopyWithImpl<$Res, CustomFeedback>;
  @useResult
  $Res call(
      {FeedbackType? feedbackType,
      bool? isReplyRequested,
      bool isScreenshotAttached});
}

/// @nodoc
class _$CustomFeedbackCopyWithImpl<$Res, $Val extends CustomFeedback>
    implements $CustomFeedbackCopyWith<$Res> {
  _$CustomFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedbackType = freezed,
    Object? isReplyRequested = freezed,
    Object? isScreenshotAttached = null,
  }) {
    return _then(_value.copyWith(
      feedbackType: freezed == feedbackType
          ? _value.feedbackType
          : feedbackType // ignore: cast_nullable_to_non_nullable
              as FeedbackType?,
      isReplyRequested: freezed == isReplyRequested
          ? _value.isReplyRequested
          : isReplyRequested // ignore: cast_nullable_to_non_nullable
              as bool?,
      isScreenshotAttached: null == isScreenshotAttached
          ? _value.isScreenshotAttached
          : isScreenshotAttached // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFeedbackImplCopyWith<$Res>
    implements $CustomFeedbackCopyWith<$Res> {
  factory _$$CustomFeedbackImplCopyWith(_$CustomFeedbackImpl value,
          $Res Function(_$CustomFeedbackImpl) then) =
      __$$CustomFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FeedbackType? feedbackType,
      bool? isReplyRequested,
      bool isScreenshotAttached});
}

/// @nodoc
class __$$CustomFeedbackImplCopyWithImpl<$Res>
    extends _$CustomFeedbackCopyWithImpl<$Res, _$CustomFeedbackImpl>
    implements _$$CustomFeedbackImplCopyWith<$Res> {
  __$$CustomFeedbackImplCopyWithImpl(
      _$CustomFeedbackImpl _value, $Res Function(_$CustomFeedbackImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? feedbackType = freezed,
    Object? isReplyRequested = freezed,
    Object? isScreenshotAttached = null,
  }) {
    return _then(_$CustomFeedbackImpl(
      feedbackType: freezed == feedbackType
          ? _value.feedbackType
          : feedbackType // ignore: cast_nullable_to_non_nullable
              as FeedbackType?,
      isReplyRequested: freezed == isReplyRequested
          ? _value.isReplyRequested
          : isReplyRequested // ignore: cast_nullable_to_non_nullable
              as bool?,
      isScreenshotAttached: null == isScreenshotAttached
          ? _value.isScreenshotAttached
          : isScreenshotAttached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomFeedbackImpl implements _CustomFeedback {
  const _$CustomFeedbackImpl(
      {this.feedbackType,
      this.isReplyRequested,
      this.isScreenshotAttached = true});

  factory _$CustomFeedbackImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomFeedbackImplFromJson(json);

  @override
  final FeedbackType? feedbackType;

  /// 返信を希望するかどうか
  @override
  final bool? isReplyRequested;

  /// スクリーンショットを添付するかどうか
  @override
  @JsonKey()
  final bool isScreenshotAttached;

  @override
  String toString() {
    return 'CustomFeedback(feedbackType: $feedbackType, isReplyRequested: $isReplyRequested, isScreenshotAttached: $isScreenshotAttached)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFeedbackImpl &&
            (identical(other.feedbackType, feedbackType) ||
                other.feedbackType == feedbackType) &&
            (identical(other.isReplyRequested, isReplyRequested) ||
                other.isReplyRequested == isReplyRequested) &&
            (identical(other.isScreenshotAttached, isScreenshotAttached) ||
                other.isScreenshotAttached == isScreenshotAttached));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, feedbackType, isReplyRequested, isScreenshotAttached);

  /// Create a copy of CustomFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFeedbackImplCopyWith<_$CustomFeedbackImpl> get copyWith =>
      __$$CustomFeedbackImplCopyWithImpl<_$CustomFeedbackImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomFeedbackImplToJson(
      this,
    );
  }
}

abstract class _CustomFeedback implements CustomFeedback {
  const factory _CustomFeedback(
      {final FeedbackType? feedbackType,
      final bool? isReplyRequested,
      final bool isScreenshotAttached}) = _$CustomFeedbackImpl;

  factory _CustomFeedback.fromJson(Map<String, dynamic> json) =
      _$CustomFeedbackImpl.fromJson;

  @override
  FeedbackType? get feedbackType;

  /// 返信を希望するかどうか
  @override
  bool? get isReplyRequested;

  /// スクリーンショットを添付するかどうか
  @override
  bool get isScreenshotAttached;

  /// Create a copy of CustomFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFeedbackImplCopyWith<_$CustomFeedbackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
