// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_live_activity_start_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TestLiveActivityStartRequest {

@JsonKey(name: 'start_trigger') LiveActivityStartTrigger get startTrigger;@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? get contentState;@JsonKey(includeIfNull: false) Alert? get alert;
/// Create a copy of TestLiveActivityStartRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestLiveActivityStartRequestCopyWith<TestLiveActivityStartRequest> get copyWith => _$TestLiveActivityStartRequestCopyWithImpl<TestLiveActivityStartRequest>(this as TestLiveActivityStartRequest, _$identity);

  /// Serializes this TestLiveActivityStartRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestLiveActivityStartRequest&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger)&&const DeepCollectionEquality().equals(other.contentState, contentState)&&(identical(other.alert, alert) || other.alert == alert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTrigger,const DeepCollectionEquality().hash(contentState),alert);

@override
String toString() {
  return 'TestLiveActivityStartRequest(startTrigger: $startTrigger, contentState: $contentState, alert: $alert)';
}


}

/// @nodoc
abstract mixin class $TestLiveActivityStartRequestCopyWith<$Res>  {
  factory $TestLiveActivityStartRequestCopyWith(TestLiveActivityStartRequest value, $Res Function(TestLiveActivityStartRequest) _then) = _$TestLiveActivityStartRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'start_trigger') LiveActivityStartTrigger startTrigger,@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? contentState,@JsonKey(includeIfNull: false) Alert? alert
});


$AlertCopyWith<$Res>? get alert;

}
/// @nodoc
class _$TestLiveActivityStartRequestCopyWithImpl<$Res>
    implements $TestLiveActivityStartRequestCopyWith<$Res> {
  _$TestLiveActivityStartRequestCopyWithImpl(this._self, this._then);

  final TestLiveActivityStartRequest _self;
  final $Res Function(TestLiveActivityStartRequest) _then;

/// Create a copy of TestLiveActivityStartRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTrigger = null,Object? contentState = freezed,Object? alert = freezed,}) {
  return _then(_self.copyWith(
startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,contentState: freezed == contentState ? _self.contentState : contentState // ignore: cast_nullable_to_non_nullable
as LiveActivityContentState?,alert: freezed == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as Alert?,
  ));
}
/// Create a copy of TestLiveActivityStartRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertCopyWith<$Res>? get alert {
    if (_self.alert == null) {
    return null;
  }

  return $AlertCopyWith<$Res>(_self.alert!, (value) {
    return _then(_self.copyWith(alert: value));
  });
}
}


/// Adds pattern-matching-related methods to [TestLiveActivityStartRequest].
extension TestLiveActivityStartRequestPatterns on TestLiveActivityStartRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestLiveActivityStartRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestLiveActivityStartRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestLiveActivityStartRequest value)  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityStartRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestLiveActivityStartRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TestLiveActivityStartRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger, @JsonKey(includeIfNull: false, name: 'content_state')  LiveActivityContentState? contentState, @JsonKey(includeIfNull: false)  Alert? alert)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestLiveActivityStartRequest() when $default != null:
return $default(_that.startTrigger,_that.contentState,_that.alert);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger, @JsonKey(includeIfNull: false, name: 'content_state')  LiveActivityContentState? contentState, @JsonKey(includeIfNull: false)  Alert? alert)  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityStartRequest():
return $default(_that.startTrigger,_that.contentState,_that.alert);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'start_trigger')  LiveActivityStartTrigger startTrigger, @JsonKey(includeIfNull: false, name: 'content_state')  LiveActivityContentState? contentState, @JsonKey(includeIfNull: false)  Alert? alert)?  $default,) {final _that = this;
switch (_that) {
case _TestLiveActivityStartRequest() when $default != null:
return $default(_that.startTrigger,_that.contentState,_that.alert);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TestLiveActivityStartRequest implements TestLiveActivityStartRequest {
  const _TestLiveActivityStartRequest({@JsonKey(name: 'start_trigger') required this.startTrigger, @JsonKey(includeIfNull: false, name: 'content_state') final  LiveActivityContentState? contentState, @JsonKey(includeIfNull: false) this.alert}): _contentState = contentState;
  factory _TestLiveActivityStartRequest.fromJson(Map<String, dynamic> json) => _$TestLiveActivityStartRequestFromJson(json);

@override@JsonKey(name: 'start_trigger') final  LiveActivityStartTrigger startTrigger;
 final  LiveActivityContentState? _contentState;
@override@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? get contentState {
  final value = _contentState;
  if (value == null) return null;
  if (_contentState is EqualUnmodifiableMapView) return _contentState;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(includeIfNull: false) final  Alert? alert;

/// Create a copy of TestLiveActivityStartRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestLiveActivityStartRequestCopyWith<_TestLiveActivityStartRequest> get copyWith => __$TestLiveActivityStartRequestCopyWithImpl<_TestLiveActivityStartRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TestLiveActivityStartRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestLiveActivityStartRequest&&(identical(other.startTrigger, startTrigger) || other.startTrigger == startTrigger)&&const DeepCollectionEquality().equals(other._contentState, _contentState)&&(identical(other.alert, alert) || other.alert == alert));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTrigger,const DeepCollectionEquality().hash(_contentState),alert);

@override
String toString() {
  return 'TestLiveActivityStartRequest(startTrigger: $startTrigger, contentState: $contentState, alert: $alert)';
}


}

/// @nodoc
abstract mixin class _$TestLiveActivityStartRequestCopyWith<$Res> implements $TestLiveActivityStartRequestCopyWith<$Res> {
  factory _$TestLiveActivityStartRequestCopyWith(_TestLiveActivityStartRequest value, $Res Function(_TestLiveActivityStartRequest) _then) = __$TestLiveActivityStartRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'start_trigger') LiveActivityStartTrigger startTrigger,@JsonKey(includeIfNull: false, name: 'content_state') LiveActivityContentState? contentState,@JsonKey(includeIfNull: false) Alert? alert
});


@override $AlertCopyWith<$Res>? get alert;

}
/// @nodoc
class __$TestLiveActivityStartRequestCopyWithImpl<$Res>
    implements _$TestLiveActivityStartRequestCopyWith<$Res> {
  __$TestLiveActivityStartRequestCopyWithImpl(this._self, this._then);

  final _TestLiveActivityStartRequest _self;
  final $Res Function(_TestLiveActivityStartRequest) _then;

/// Create a copy of TestLiveActivityStartRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTrigger = null,Object? contentState = freezed,Object? alert = freezed,}) {
  return _then(_TestLiveActivityStartRequest(
startTrigger: null == startTrigger ? _self.startTrigger : startTrigger // ignore: cast_nullable_to_non_nullable
as LiveActivityStartTrigger,contentState: freezed == contentState ? _self._contentState : contentState // ignore: cast_nullable_to_non_nullable
as LiveActivityContentState?,alert: freezed == alert ? _self.alert : alert // ignore: cast_nullable_to_non_nullable
as Alert?,
  ));
}

/// Create a copy of TestLiveActivityStartRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertCopyWith<$Res>? get alert {
    if (_self.alert == null) {
    return null;
  }

  return $AlertCopyWith<$Res>(_self.alert!, (value) {
    return _then(_self.copyWith(alert: value));
  });
}
}

// dart format on
