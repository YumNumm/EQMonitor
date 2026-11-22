// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_screenshot_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoreScreenshotSession {

 Map<String, dynamic> get preferences; List<StoreScreenshotScene> get scenes;
/// Create a copy of StoreScreenshotSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreScreenshotSessionCopyWith<StoreScreenshotSession> get copyWith => _$StoreScreenshotSessionCopyWithImpl<StoreScreenshotSession>(this as StoreScreenshotSession, _$identity);

  /// Serializes this StoreScreenshotSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreScreenshotSession&&const DeepCollectionEquality().equals(other.preferences, preferences)&&const DeepCollectionEquality().equals(other.scenes, scenes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(preferences),const DeepCollectionEquality().hash(scenes));

@override
String toString() {
  return 'StoreScreenshotSession(preferences: $preferences, scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class $StoreScreenshotSessionCopyWith<$Res>  {
  factory $StoreScreenshotSessionCopyWith(StoreScreenshotSession value, $Res Function(StoreScreenshotSession) _then) = _$StoreScreenshotSessionCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> preferences, List<StoreScreenshotScene> scenes
});




}
/// @nodoc
class _$StoreScreenshotSessionCopyWithImpl<$Res>
    implements $StoreScreenshotSessionCopyWith<$Res> {
  _$StoreScreenshotSessionCopyWithImpl(this._self, this._then);

  final StoreScreenshotSession _self;
  final $Res Function(StoreScreenshotSession) _then;

/// Create a copy of StoreScreenshotSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preferences = null,Object? scenes = null,}) {
  return _then(StoreScreenshotSession(
preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<StoreScreenshotScene>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreScreenshotSession].
extension StoreScreenshotSessionPatterns on StoreScreenshotSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoreScreenshotSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoreScreenshotSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoreScreenshotSession value)  $default,){
final _that = this;
switch (_that) {
case _StoreScreenshotSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoreScreenshotSession value)?  $default,){
final _that = this;
switch (_that) {
case _StoreScreenshotSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> preferences,  List<StoreScreenshotScene> scenes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoreScreenshotSession() when $default != null:
return $default(_that.preferences,_that.scenes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> preferences,  List<StoreScreenshotScene> scenes)  $default,) {final _that = this;
switch (_that) {
case _StoreScreenshotSession():
return $default(_that.preferences,_that.scenes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> preferences,  List<StoreScreenshotScene> scenes)?  $default,) {final _that = this;
switch (_that) {
case _StoreScreenshotSession() when $default != null:
return $default(_that.preferences,_that.scenes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoreScreenshotSession implements StoreScreenshotSession {
  const _StoreScreenshotSession({required  Map<String, dynamic> preferences, required  List<StoreScreenshotScene> scenes}): _preferences = preferences,_scenes = scenes;
  factory _StoreScreenshotSession.fromJson(Map<String, dynamic> json) => _$StoreScreenshotSessionFromJson(json);

 final  Map<String, dynamic> _preferences;
@override Map<String, dynamic> get preferences {
  if (_preferences is EqualUnmodifiableMapView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_preferences);
}

 final  List<StoreScreenshotScene> _scenes;
@override List<StoreScreenshotScene> get scenes {
  if (_scenes is EqualUnmodifiableListView) return _scenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scenes);
}


/// Create a copy of StoreScreenshotSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoreScreenshotSessionCopyWith<_StoreScreenshotSession> get copyWith => __$StoreScreenshotSessionCopyWithImpl<_StoreScreenshotSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreScreenshotSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoreScreenshotSession&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&const DeepCollectionEquality().equals(other._scenes, _scenes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_preferences),const DeepCollectionEquality().hash(_scenes));

@override
String toString() {
  return 'StoreScreenshotSession(preferences: $preferences, scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class _$StoreScreenshotSessionCopyWith<$Res> implements $StoreScreenshotSessionCopyWith<$Res> {
  factory _$StoreScreenshotSessionCopyWith(_StoreScreenshotSession value, $Res Function(_StoreScreenshotSession) _then) = __$StoreScreenshotSessionCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> preferences, List<StoreScreenshotScene> scenes
});




}
/// @nodoc
class __$StoreScreenshotSessionCopyWithImpl<$Res>
    implements _$StoreScreenshotSessionCopyWith<$Res> {
  __$StoreScreenshotSessionCopyWithImpl(this._self, this._then);

  final _StoreScreenshotSession _self;
  final $Res Function(_StoreScreenshotSession) _then;

/// Create a copy of StoreScreenshotSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preferences = null,Object? scenes = null,}) {
  return _then(_StoreScreenshotSession(
preferences: null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,scenes: null == scenes ? _self._scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<StoreScreenshotScene>,
  ));
}


}

// dart format on
