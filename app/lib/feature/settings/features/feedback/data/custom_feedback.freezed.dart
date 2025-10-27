// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomFeedback {

 FeedbackType? get feedbackType;/// 返信を希望するかどうか
 bool? get isReplyRequested;/// スクリーンショットを添付するかどうか
 bool get isScreenshotAttached;
/// Create a copy of CustomFeedback
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomFeedbackCopyWith<CustomFeedback> get copyWith => _$CustomFeedbackCopyWithImpl<CustomFeedback>(this as CustomFeedback, _$identity);

  /// Serializes this CustomFeedback to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomFeedback&&(identical(other.feedbackType, feedbackType) || other.feedbackType == feedbackType)&&(identical(other.isReplyRequested, isReplyRequested) || other.isReplyRequested == isReplyRequested)&&(identical(other.isScreenshotAttached, isScreenshotAttached) || other.isScreenshotAttached == isScreenshotAttached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedbackType,isReplyRequested,isScreenshotAttached);

@override
String toString() {
  return 'CustomFeedback(feedbackType: $feedbackType, isReplyRequested: $isReplyRequested, isScreenshotAttached: $isScreenshotAttached)';
}


}

/// @nodoc
abstract mixin class $CustomFeedbackCopyWith<$Res>  {
  factory $CustomFeedbackCopyWith(CustomFeedback value, $Res Function(CustomFeedback) _then) = _$CustomFeedbackCopyWithImpl;
@useResult
$Res call({
 FeedbackType? feedbackType, bool? isReplyRequested, bool isScreenshotAttached
});




}
/// @nodoc
class _$CustomFeedbackCopyWithImpl<$Res>
    implements $CustomFeedbackCopyWith<$Res> {
  _$CustomFeedbackCopyWithImpl(this._self, this._then);

  final CustomFeedback _self;
  final $Res Function(CustomFeedback) _then;

/// Create a copy of CustomFeedback
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feedbackType = freezed,Object? isReplyRequested = freezed,Object? isScreenshotAttached = null,}) {
  return _then(_self.copyWith(
feedbackType: freezed == feedbackType ? _self.feedbackType : feedbackType // ignore: cast_nullable_to_non_nullable
as FeedbackType?,isReplyRequested: freezed == isReplyRequested ? _self.isReplyRequested : isReplyRequested // ignore: cast_nullable_to_non_nullable
as bool?,isScreenshotAttached: null == isScreenshotAttached ? _self.isScreenshotAttached : isScreenshotAttached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomFeedback].
extension CustomFeedbackPatterns on CustomFeedback {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomFeedback value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomFeedback() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomFeedback value)  $default,){
final _that = this;
switch (_that) {
case _CustomFeedback():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomFeedback value)?  $default,){
final _that = this;
switch (_that) {
case _CustomFeedback() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeedbackType? feedbackType,  bool? isReplyRequested,  bool isScreenshotAttached)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomFeedback() when $default != null:
return $default(_that.feedbackType,_that.isReplyRequested,_that.isScreenshotAttached);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeedbackType? feedbackType,  bool? isReplyRequested,  bool isScreenshotAttached)  $default,) {final _that = this;
switch (_that) {
case _CustomFeedback():
return $default(_that.feedbackType,_that.isReplyRequested,_that.isScreenshotAttached);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeedbackType? feedbackType,  bool? isReplyRequested,  bool isScreenshotAttached)?  $default,) {final _that = this;
switch (_that) {
case _CustomFeedback() when $default != null:
return $default(_that.feedbackType,_that.isReplyRequested,_that.isScreenshotAttached);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomFeedback implements CustomFeedback {
  const _CustomFeedback({this.feedbackType, this.isReplyRequested, this.isScreenshotAttached = true});
  factory _CustomFeedback.fromJson(Map<String, dynamic> json) => _$CustomFeedbackFromJson(json);

@override final  FeedbackType? feedbackType;
/// 返信を希望するかどうか
@override final  bool? isReplyRequested;
/// スクリーンショットを添付するかどうか
@override@JsonKey() final  bool isScreenshotAttached;

/// Create a copy of CustomFeedback
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomFeedbackCopyWith<_CustomFeedback> get copyWith => __$CustomFeedbackCopyWithImpl<_CustomFeedback>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomFeedbackToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomFeedback&&(identical(other.feedbackType, feedbackType) || other.feedbackType == feedbackType)&&(identical(other.isReplyRequested, isReplyRequested) || other.isReplyRequested == isReplyRequested)&&(identical(other.isScreenshotAttached, isScreenshotAttached) || other.isScreenshotAttached == isScreenshotAttached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedbackType,isReplyRequested,isScreenshotAttached);

@override
String toString() {
  return 'CustomFeedback(feedbackType: $feedbackType, isReplyRequested: $isReplyRequested, isScreenshotAttached: $isScreenshotAttached)';
}


}

/// @nodoc
abstract mixin class _$CustomFeedbackCopyWith<$Res> implements $CustomFeedbackCopyWith<$Res> {
  factory _$CustomFeedbackCopyWith(_CustomFeedback value, $Res Function(_CustomFeedback) _then) = __$CustomFeedbackCopyWithImpl;
@override @useResult
$Res call({
 FeedbackType? feedbackType, bool? isReplyRequested, bool isScreenshotAttached
});




}
/// @nodoc
class __$CustomFeedbackCopyWithImpl<$Res>
    implements _$CustomFeedbackCopyWith<$Res> {
  __$CustomFeedbackCopyWithImpl(this._self, this._then);

  final _CustomFeedback _self;
  final $Res Function(_CustomFeedback) _then;

/// Create a copy of CustomFeedback
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feedbackType = freezed,Object? isReplyRequested = freezed,Object? isScreenshotAttached = null,}) {
  return _then(_CustomFeedback(
feedbackType: freezed == feedbackType ? _self.feedbackType : feedbackType // ignore: cast_nullable_to_non_nullable
as FeedbackType?,isReplyRequested: freezed == isReplyRequested ? _self.isReplyRequested : isReplyRequested // ignore: cast_nullable_to_non_nullable
as bool?,isScreenshotAttached: null == isScreenshotAttached ? _self.isScreenshotAttached : isScreenshotAttached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
