// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shake_detection_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShakeDetectionEntry {

 String get id; ShakeDetectionTargetType get targetType; String? get regionCode; bool get enabled; ShakeDetectionLevel get minLevel;
/// Create a copy of ShakeDetectionEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionEntryCopyWith<ShakeDetectionEntry> get copyWith => _$ShakeDetectionEntryCopyWithImpl<ShakeDetectionEntry>(this as ShakeDetectionEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel));
}


@override
int get hashCode => Object.hash(runtimeType,id,targetType,regionCode,enabled,minLevel);

@override
String toString() {
  return 'ShakeDetectionEntry(id: $id, targetType: $targetType, regionCode: $regionCode, enabled: $enabled, minLevel: $minLevel)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionEntryCopyWith<$Res>  {
  factory $ShakeDetectionEntryCopyWith(ShakeDetectionEntry value, $Res Function(ShakeDetectionEntry) _then) = _$ShakeDetectionEntryCopyWithImpl;
@useResult
$Res call({
 String id, ShakeDetectionTargetType targetType, String? regionCode, bool enabled, ShakeDetectionLevel minLevel
});




}
/// @nodoc
class _$ShakeDetectionEntryCopyWithImpl<$Res>
    implements $ShakeDetectionEntryCopyWith<$Res> {
  _$ShakeDetectionEntryCopyWithImpl(this._self, this._then);

  final ShakeDetectionEntry _self;
  final $Res Function(ShakeDetectionEntry) _then;

/// Create a copy of ShakeDetectionEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? targetType = null,Object? regionCode = freezed,Object? enabled = null,Object? minLevel = null,}) {
  return _then(ShakeDetectionEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as ShakeDetectionTargetType,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionEntry].
extension ShakeDetectionEntryPatterns on ShakeDetectionEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionEntry value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ShakeDetectionTargetType targetType,  String? regionCode,  bool enabled,  ShakeDetectionLevel minLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionEntry() when $default != null:
return $default(_that.id,_that.targetType,_that.regionCode,_that.enabled,_that.minLevel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ShakeDetectionTargetType targetType,  String? regionCode,  bool enabled,  ShakeDetectionLevel minLevel)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEntry():
return $default(_that.id,_that.targetType,_that.regionCode,_that.enabled,_that.minLevel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ShakeDetectionTargetType targetType,  String? regionCode,  bool enabled,  ShakeDetectionLevel minLevel)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEntry() when $default != null:
return $default(_that.id,_that.targetType,_that.regionCode,_that.enabled,_that.minLevel);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionEntry implements ShakeDetectionEntry {
  const _ShakeDetectionEntry({required this.id, required this.targetType, required this.regionCode, required this.enabled, required this.minLevel});
  

@override final  String id;
@override final  ShakeDetectionTargetType targetType;
@override final  String? regionCode;
@override final  bool enabled;
@override final  ShakeDetectionLevel minLevel;

/// Create a copy of ShakeDetectionEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionEntryCopyWith<_ShakeDetectionEntry> get copyWith => __$ShakeDetectionEntryCopyWithImpl<_ShakeDetectionEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&(identical(other.regionCode, regionCode) || other.regionCode == regionCode)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel));
}


@override
int get hashCode => Object.hash(runtimeType,id,targetType,regionCode,enabled,minLevel);

@override
String toString() {
  return 'ShakeDetectionEntry(id: $id, targetType: $targetType, regionCode: $regionCode, enabled: $enabled, minLevel: $minLevel)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionEntryCopyWith<$Res> implements $ShakeDetectionEntryCopyWith<$Res> {
  factory _$ShakeDetectionEntryCopyWith(_ShakeDetectionEntry value, $Res Function(_ShakeDetectionEntry) _then) = __$ShakeDetectionEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, ShakeDetectionTargetType targetType, String? regionCode, bool enabled, ShakeDetectionLevel minLevel
});




}
/// @nodoc
class __$ShakeDetectionEntryCopyWithImpl<$Res>
    implements _$ShakeDetectionEntryCopyWith<$Res> {
  __$ShakeDetectionEntryCopyWithImpl(this._self, this._then);

  final _ShakeDetectionEntry _self;
  final $Res Function(_ShakeDetectionEntry) _then;

/// Create a copy of ShakeDetectionEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? targetType = null,Object? regionCode = freezed,Object? enabled = null,Object? minLevel = null,}) {
  return _then(_ShakeDetectionEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,targetType: null == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as ShakeDetectionTargetType,regionCode: freezed == regionCode ? _self.regionCode : regionCode // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,
  ));
}


}

// dart format on
