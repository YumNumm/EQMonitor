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

 String get id; String? get subRegionId; String? get subRegionName; ShakeDetectionLevel get minLevel; bool get isCurrentLocation; String? get prefectureCode; String? get cityCode;
/// Create a copy of ShakeDetectionEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionEntryCopyWith<ShakeDetectionEntry> get copyWith => _$ShakeDetectionEntryCopyWithImpl<ShakeDetectionEntry>(this as ShakeDetectionEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.subRegionId, subRegionId) || other.subRegionId == subRegionId)&&(identical(other.subRegionName, subRegionName) || other.subRegionName == subRegionName)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode));
}


@override
int get hashCode => Object.hash(runtimeType,id,subRegionId,subRegionName,minLevel,isCurrentLocation,prefectureCode,cityCode);

@override
String toString() {
  return 'ShakeDetectionEntry(id: $id, subRegionId: $subRegionId, subRegionName: $subRegionName, minLevel: $minLevel, isCurrentLocation: $isCurrentLocation, prefectureCode: $prefectureCode, cityCode: $cityCode)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionEntryCopyWith<$Res>  {
  factory $ShakeDetectionEntryCopyWith(ShakeDetectionEntry value, $Res Function(ShakeDetectionEntry) _then) = _$ShakeDetectionEntryCopyWithImpl;
@useResult
$Res call({
 String id, String? subRegionId, String? subRegionName, ShakeDetectionLevel minLevel, bool isCurrentLocation, String? prefectureCode, String? cityCode
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subRegionId = freezed,Object? subRegionName = freezed,Object? minLevel = null,Object? isCurrentLocation = null,Object? prefectureCode = freezed,Object? cityCode = freezed,}) {
  return _then(ShakeDetectionEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subRegionId: freezed == subRegionId ? _self.subRegionId : subRegionId // ignore: cast_nullable_to_non_nullable
as String?,subRegionName: freezed == subRegionName ? _self.subRegionName : subRegionName // ignore: cast_nullable_to_non_nullable
as String?,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? subRegionId,  String? subRegionName,  ShakeDetectionLevel minLevel,  bool isCurrentLocation,  String? prefectureCode,  String? cityCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionEntry() when $default != null:
return $default(_that.id,_that.subRegionId,_that.subRegionName,_that.minLevel,_that.isCurrentLocation,_that.prefectureCode,_that.cityCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? subRegionId,  String? subRegionName,  ShakeDetectionLevel minLevel,  bool isCurrentLocation,  String? prefectureCode,  String? cityCode)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEntry():
return $default(_that.id,_that.subRegionId,_that.subRegionName,_that.minLevel,_that.isCurrentLocation,_that.prefectureCode,_that.cityCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? subRegionId,  String? subRegionName,  ShakeDetectionLevel minLevel,  bool isCurrentLocation,  String? prefectureCode,  String? cityCode)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionEntry() when $default != null:
return $default(_that.id,_that.subRegionId,_that.subRegionName,_that.minLevel,_that.isCurrentLocation,_that.prefectureCode,_that.cityCode);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionEntry implements ShakeDetectionEntry {
  const _ShakeDetectionEntry({required this.id, required this.subRegionId, required this.subRegionName, required this.minLevel, required this.isCurrentLocation, this.prefectureCode, this.cityCode});
  

@override final  String id;
@override final  String? subRegionId;
@override final  String? subRegionName;
@override final  ShakeDetectionLevel minLevel;
@override final  bool isCurrentLocation;
@override final  String? prefectureCode;
@override final  String? cityCode;

/// Create a copy of ShakeDetectionEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionEntryCopyWith<_ShakeDetectionEntry> get copyWith => __$ShakeDetectionEntryCopyWithImpl<_ShakeDetectionEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.subRegionId, subRegionId) || other.subRegionId == subRegionId)&&(identical(other.subRegionName, subRegionName) || other.subRegionName == subRegionName)&&(identical(other.minLevel, minLevel) || other.minLevel == minLevel)&&(identical(other.isCurrentLocation, isCurrentLocation) || other.isCurrentLocation == isCurrentLocation)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode)&&(identical(other.cityCode, cityCode) || other.cityCode == cityCode));
}


@override
int get hashCode => Object.hash(runtimeType,id,subRegionId,subRegionName,minLevel,isCurrentLocation,prefectureCode,cityCode);

@override
String toString() {
  return 'ShakeDetectionEntry(id: $id, subRegionId: $subRegionId, subRegionName: $subRegionName, minLevel: $minLevel, isCurrentLocation: $isCurrentLocation, prefectureCode: $prefectureCode, cityCode: $cityCode)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionEntryCopyWith<$Res> implements $ShakeDetectionEntryCopyWith<$Res> {
  factory _$ShakeDetectionEntryCopyWith(_ShakeDetectionEntry value, $Res Function(_ShakeDetectionEntry) _then) = __$ShakeDetectionEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String? subRegionId, String? subRegionName, ShakeDetectionLevel minLevel, bool isCurrentLocation, String? prefectureCode, String? cityCode
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subRegionId = freezed,Object? subRegionName = freezed,Object? minLevel = null,Object? isCurrentLocation = null,Object? prefectureCode = freezed,Object? cityCode = freezed,}) {
  return _then(_ShakeDetectionEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subRegionId: freezed == subRegionId ? _self.subRegionId : subRegionId // ignore: cast_nullable_to_non_nullable
as String?,subRegionName: freezed == subRegionName ? _self.subRegionName : subRegionName // ignore: cast_nullable_to_non_nullable
as String?,minLevel: null == minLevel ? _self.minLevel : minLevel // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,isCurrentLocation: null == isCurrentLocation ? _self.isCurrentLocation : isCurrentLocation // ignore: cast_nullable_to_non_nullable
as bool,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,cityCode: freezed == cityCode ? _self.cityCode : cityCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ShakeDetectionSubRegion {

 String get id; String get code; String get name;
/// Create a copy of ShakeDetectionSubRegion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShakeDetectionSubRegionCopyWith<ShakeDetectionSubRegion> get copyWith => _$ShakeDetectionSubRegionCopyWithImpl<ShakeDetectionSubRegion>(this as ShakeDetectionSubRegion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShakeDetectionSubRegion&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'ShakeDetectionSubRegion(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $ShakeDetectionSubRegionCopyWith<$Res>  {
  factory $ShakeDetectionSubRegionCopyWith(ShakeDetectionSubRegion value, $Res Function(ShakeDetectionSubRegion) _then) = _$ShakeDetectionSubRegionCopyWithImpl;
@useResult
$Res call({
 String id, String code, String name
});




}
/// @nodoc
class _$ShakeDetectionSubRegionCopyWithImpl<$Res>
    implements $ShakeDetectionSubRegionCopyWith<$Res> {
  _$ShakeDetectionSubRegionCopyWithImpl(this._self, this._then);

  final ShakeDetectionSubRegion _self;
  final $Res Function(ShakeDetectionSubRegion) _then;

/// Create a copy of ShakeDetectionSubRegion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? name = null,}) {
  return _then(ShakeDetectionSubRegion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ShakeDetectionSubRegion].
extension ShakeDetectionSubRegionPatterns on ShakeDetectionSubRegion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShakeDetectionSubRegion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShakeDetectionSubRegion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShakeDetectionSubRegion value)  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSubRegion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShakeDetectionSubRegion value)?  $default,){
final _that = this;
switch (_that) {
case _ShakeDetectionSubRegion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShakeDetectionSubRegion() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String code,  String name)  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSubRegion():
return $default(_that.id,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _ShakeDetectionSubRegion() when $default != null:
return $default(_that.id,_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _ShakeDetectionSubRegion implements ShakeDetectionSubRegion {
  const _ShakeDetectionSubRegion({required this.id, required this.code, required this.name});
  

@override final  String id;
@override final  String code;
@override final  String name;

/// Create a copy of ShakeDetectionSubRegion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShakeDetectionSubRegionCopyWith<_ShakeDetectionSubRegion> get copyWith => __$ShakeDetectionSubRegionCopyWithImpl<_ShakeDetectionSubRegion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShakeDetectionSubRegion&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,name);

@override
String toString() {
  return 'ShakeDetectionSubRegion(id: $id, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ShakeDetectionSubRegionCopyWith<$Res> implements $ShakeDetectionSubRegionCopyWith<$Res> {
  factory _$ShakeDetectionSubRegionCopyWith(_ShakeDetectionSubRegion value, $Res Function(_ShakeDetectionSubRegion) _then) = __$ShakeDetectionSubRegionCopyWithImpl;
@override @useResult
$Res call({
 String id, String code, String name
});




}
/// @nodoc
class __$ShakeDetectionSubRegionCopyWithImpl<$Res>
    implements _$ShakeDetectionSubRegionCopyWith<$Res> {
  __$ShakeDetectionSubRegionCopyWithImpl(this._self, this._then);

  final _ShakeDetectionSubRegion _self;
  final $Res Function(_ShakeDetectionSubRegion) _then;

/// Create a copy of ShakeDetectionSubRegion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? name = null,}) {
  return _then(_ShakeDetectionSubRegion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
