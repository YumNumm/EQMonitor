// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_v2_shake_detection_active_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetV2ShakeDetectionActiveResponse {

/// const: "shake_detection"
 String get type; int get revision; DateTime get responseAt; List<Events> get events;
/// Create a copy of GetV2ShakeDetectionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetV2ShakeDetectionActiveResponseCopyWith<GetV2ShakeDetectionActiveResponse> get copyWith => _$GetV2ShakeDetectionActiveResponseCopyWithImpl<GetV2ShakeDetectionActiveResponse>(this as GetV2ShakeDetectionActiveResponse, _$identity);

  /// Serializes this GetV2ShakeDetectionActiveResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetV2ShakeDetectionActiveResponse&&(identical(other.type, type) || other.type == type)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,revision,responseAt,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'GetV2ShakeDetectionActiveResponse(type: $type, revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class $GetV2ShakeDetectionActiveResponseCopyWith<$Res>  {
  factory $GetV2ShakeDetectionActiveResponseCopyWith(GetV2ShakeDetectionActiveResponse value, $Res Function(GetV2ShakeDetectionActiveResponse) _then) = _$GetV2ShakeDetectionActiveResponseCopyWithImpl;
@useResult
$Res call({
 String type, int revision, DateTime responseAt, List<Events> events
});




}
/// @nodoc
class _$GetV2ShakeDetectionActiveResponseCopyWithImpl<$Res>
    implements $GetV2ShakeDetectionActiveResponseCopyWith<$Res> {
  _$GetV2ShakeDetectionActiveResponseCopyWithImpl(this._self, this._then);

  final GetV2ShakeDetectionActiveResponse _self;
  final $Res Function(GetV2ShakeDetectionActiveResponse) _then;

/// Create a copy of GetV2ShakeDetectionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<Events>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetV2ShakeDetectionActiveResponse].
extension GetV2ShakeDetectionActiveResponsePatterns on GetV2ShakeDetectionActiveResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetV2ShakeDetectionActiveResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetV2ShakeDetectionActiveResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetV2ShakeDetectionActiveResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetV2ShakeDetectionActiveResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetV2ShakeDetectionActiveResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetV2ShakeDetectionActiveResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int revision,  DateTime responseAt,  List<Events> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetV2ShakeDetectionActiveResponse() when $default != null:
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int revision,  DateTime responseAt,  List<Events> events)  $default,) {final _that = this;
switch (_that) {
case _GetV2ShakeDetectionActiveResponse():
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int revision,  DateTime responseAt,  List<Events> events)?  $default,) {final _that = this;
switch (_that) {
case _GetV2ShakeDetectionActiveResponse() when $default != null:
return $default(_that.type,_that.revision,_that.responseAt,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetV2ShakeDetectionActiveResponse implements GetV2ShakeDetectionActiveResponse {
  const _GetV2ShakeDetectionActiveResponse({required this.type, required this.revision, required this.responseAt, required final  List<Events> events}): _events = events;
  factory _GetV2ShakeDetectionActiveResponse.fromJson(Map<String, dynamic> json) => _$GetV2ShakeDetectionActiveResponseFromJson(json);

/// const: "shake_detection"
@override final  String type;
@override final  int revision;
@override final  DateTime responseAt;
 final  List<Events> _events;
@override List<Events> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of GetV2ShakeDetectionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetV2ShakeDetectionActiveResponseCopyWith<_GetV2ShakeDetectionActiveResponse> get copyWith => __$GetV2ShakeDetectionActiveResponseCopyWithImpl<_GetV2ShakeDetectionActiveResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetV2ShakeDetectionActiveResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetV2ShakeDetectionActiveResponse&&(identical(other.type, type) || other.type == type)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.responseAt, responseAt) || other.responseAt == responseAt)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,revision,responseAt,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'GetV2ShakeDetectionActiveResponse(type: $type, revision: $revision, responseAt: $responseAt, events: $events)';
}


}

/// @nodoc
abstract mixin class _$GetV2ShakeDetectionActiveResponseCopyWith<$Res> implements $GetV2ShakeDetectionActiveResponseCopyWith<$Res> {
  factory _$GetV2ShakeDetectionActiveResponseCopyWith(_GetV2ShakeDetectionActiveResponse value, $Res Function(_GetV2ShakeDetectionActiveResponse) _then) = __$GetV2ShakeDetectionActiveResponseCopyWithImpl;
@override @useResult
$Res call({
 String type, int revision, DateTime responseAt, List<Events> events
});




}
/// @nodoc
class __$GetV2ShakeDetectionActiveResponseCopyWithImpl<$Res>
    implements _$GetV2ShakeDetectionActiveResponseCopyWith<$Res> {
  __$GetV2ShakeDetectionActiveResponseCopyWithImpl(this._self, this._then);

  final _GetV2ShakeDetectionActiveResponse _self;
  final $Res Function(_GetV2ShakeDetectionActiveResponse) _then;

/// Create a copy of GetV2ShakeDetectionActiveResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? revision = null,Object? responseAt = null,Object? events = null,}) {
  return _then(_GetV2ShakeDetectionActiveResponse(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,responseAt: null == responseAt ? _self.responseAt : responseAt // ignore: cast_nullable_to_non_nullable
as DateTime,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<Events>,
  ));
}


}

// dart format on
