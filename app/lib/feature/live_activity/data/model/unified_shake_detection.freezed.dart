// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unified_shake_detection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnifiedShakeDetectionLocation {

 String get name; ShakeDetectionLevel get level;
/// Create a copy of UnifiedShakeDetectionLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedShakeDetectionLocationCopyWith<UnifiedShakeDetectionLocation> get copyWith => _$UnifiedShakeDetectionLocationCopyWithImpl<UnifiedShakeDetectionLocation>(this as UnifiedShakeDetectionLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedShakeDetectionLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level));
}


@override
int get hashCode => Object.hash(runtimeType,name,level);

@override
String toString() {
  return 'UnifiedShakeDetectionLocation(name: $name, level: $level)';
}


}

/// @nodoc
abstract mixin class $UnifiedShakeDetectionLocationCopyWith<$Res>  {
  factory $UnifiedShakeDetectionLocationCopyWith(UnifiedShakeDetectionLocation value, $Res Function(UnifiedShakeDetectionLocation) _then) = _$UnifiedShakeDetectionLocationCopyWithImpl;
@useResult
$Res call({
 String name, ShakeDetectionLevel level
});




}
/// @nodoc
class _$UnifiedShakeDetectionLocationCopyWithImpl<$Res>
    implements $UnifiedShakeDetectionLocationCopyWith<$Res> {
  _$UnifiedShakeDetectionLocationCopyWithImpl(this._self, this._then);

  final UnifiedShakeDetectionLocation _self;
  final $Res Function(UnifiedShakeDetectionLocation) _then;

/// Create a copy of UnifiedShakeDetectionLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? level = null,}) {
  return _then(UnifiedShakeDetectionLocation(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [UnifiedShakeDetectionLocation].
extension UnifiedShakeDetectionLocationPatterns on UnifiedShakeDetectionLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedShakeDetectionLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedShakeDetectionLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedShakeDetectionLocation value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedShakeDetectionLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedShakeDetectionLocation value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedShakeDetectionLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  ShakeDetectionLevel level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedShakeDetectionLocation() when $default != null:
return $default(_that.name,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  ShakeDetectionLevel level)  $default,) {final _that = this;
switch (_that) {
case _UnifiedShakeDetectionLocation():
return $default(_that.name,_that.level);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  ShakeDetectionLevel level)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedShakeDetectionLocation() when $default != null:
return $default(_that.name,_that.level);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedShakeDetectionLocation extends UnifiedShakeDetectionLocation {
  const _UnifiedShakeDetectionLocation({required this.name, required this.level}): super._();
  

@override final  String name;
@override final  ShakeDetectionLevel level;

/// Create a copy of UnifiedShakeDetectionLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedShakeDetectionLocationCopyWith<_UnifiedShakeDetectionLocation> get copyWith => __$UnifiedShakeDetectionLocationCopyWithImpl<_UnifiedShakeDetectionLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedShakeDetectionLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level));
}


@override
int get hashCode => Object.hash(runtimeType,name,level);

@override
String toString() {
  return 'UnifiedShakeDetectionLocation(name: $name, level: $level)';
}


}

/// @nodoc
abstract mixin class _$UnifiedShakeDetectionLocationCopyWith<$Res> implements $UnifiedShakeDetectionLocationCopyWith<$Res> {
  factory _$UnifiedShakeDetectionLocationCopyWith(_UnifiedShakeDetectionLocation value, $Res Function(_UnifiedShakeDetectionLocation) _then) = __$UnifiedShakeDetectionLocationCopyWithImpl;
@override @useResult
$Res call({
 String name, ShakeDetectionLevel level
});




}
/// @nodoc
class __$UnifiedShakeDetectionLocationCopyWithImpl<$Res>
    implements _$UnifiedShakeDetectionLocationCopyWith<$Res> {
  __$UnifiedShakeDetectionLocationCopyWithImpl(this._self, this._then);

  final _UnifiedShakeDetectionLocation _self;
  final $Res Function(_UnifiedShakeDetectionLocation) _then;

/// Create a copy of UnifiedShakeDetectionLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? level = null,}) {
  return _then(_UnifiedShakeDetectionLocation(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,
  ));
}


}

/// @nodoc
mixin _$UnifiedShakeDetection {

 String get headline; DateTime get detectedAt; DateTime get updatedAt; ShakeDetectionLevel get level; UnifiedShakeDetectionStatus get status; UnifiedShakeDetectionLocation? get location;
/// Create a copy of UnifiedShakeDetection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedShakeDetectionCopyWith<UnifiedShakeDetection> get copyWith => _$UnifiedShakeDetectionCopyWithImpl<UnifiedShakeDetection>(this as UnifiedShakeDetection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedShakeDetection&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,headline,detectedAt,updatedAt,level,status,location);

@override
String toString() {
  return 'UnifiedShakeDetection(headline: $headline, detectedAt: $detectedAt, updatedAt: $updatedAt, level: $level, status: $status, location: $location)';
}


}

/// @nodoc
abstract mixin class $UnifiedShakeDetectionCopyWith<$Res>  {
  factory $UnifiedShakeDetectionCopyWith(UnifiedShakeDetection value, $Res Function(UnifiedShakeDetection) _then) = _$UnifiedShakeDetectionCopyWithImpl;
@useResult
$Res call({
 String headline, DateTime detectedAt, DateTime updatedAt, ShakeDetectionLevel level, UnifiedShakeDetectionStatus status, UnifiedShakeDetectionLocation? location
});


$UnifiedShakeDetectionLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$UnifiedShakeDetectionCopyWithImpl<$Res>
    implements $UnifiedShakeDetectionCopyWith<$Res> {
  _$UnifiedShakeDetectionCopyWithImpl(this._self, this._then);

  final UnifiedShakeDetection _self;
  final $Res Function(UnifiedShakeDetection) _then;

/// Create a copy of UnifiedShakeDetection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headline = null,Object? detectedAt = null,Object? updatedAt = null,Object? level = null,Object? status = null,Object? location = freezed,}) {
  return _then(UnifiedShakeDetection(
headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UnifiedShakeDetectionStatus,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as UnifiedShakeDetectionLocation?,
  ));
}
/// Create a copy of UnifiedShakeDetection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedShakeDetectionLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $UnifiedShakeDetectionLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [UnifiedShakeDetection].
extension UnifiedShakeDetectionPatterns on UnifiedShakeDetection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedShakeDetection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedShakeDetection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedShakeDetection value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedShakeDetection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedShakeDetection value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedShakeDetection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String headline,  DateTime detectedAt,  DateTime updatedAt,  ShakeDetectionLevel level,  UnifiedShakeDetectionStatus status,  UnifiedShakeDetectionLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedShakeDetection() when $default != null:
return $default(_that.headline,_that.detectedAt,_that.updatedAt,_that.level,_that.status,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String headline,  DateTime detectedAt,  DateTime updatedAt,  ShakeDetectionLevel level,  UnifiedShakeDetectionStatus status,  UnifiedShakeDetectionLocation? location)  $default,) {final _that = this;
switch (_that) {
case _UnifiedShakeDetection():
return $default(_that.headline,_that.detectedAt,_that.updatedAt,_that.level,_that.status,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String headline,  DateTime detectedAt,  DateTime updatedAt,  ShakeDetectionLevel level,  UnifiedShakeDetectionStatus status,  UnifiedShakeDetectionLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedShakeDetection() when $default != null:
return $default(_that.headline,_that.detectedAt,_that.updatedAt,_that.level,_that.status,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedShakeDetection extends UnifiedShakeDetection {
  const _UnifiedShakeDetection({required this.headline, required this.detectedAt, required this.updatedAt, required this.level, required this.status, required this.location}): super._();
  

@override final  String headline;
@override final  DateTime detectedAt;
@override final  DateTime updatedAt;
@override final  ShakeDetectionLevel level;
@override final  UnifiedShakeDetectionStatus status;
@override final  UnifiedShakeDetectionLocation? location;

/// Create a copy of UnifiedShakeDetection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedShakeDetectionCopyWith<_UnifiedShakeDetection> get copyWith => __$UnifiedShakeDetectionCopyWithImpl<_UnifiedShakeDetection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedShakeDetection&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.detectedAt, detectedAt) || other.detectedAt == detectedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,headline,detectedAt,updatedAt,level,status,location);

@override
String toString() {
  return 'UnifiedShakeDetection(headline: $headline, detectedAt: $detectedAt, updatedAt: $updatedAt, level: $level, status: $status, location: $location)';
}


}

/// @nodoc
abstract mixin class _$UnifiedShakeDetectionCopyWith<$Res> implements $UnifiedShakeDetectionCopyWith<$Res> {
  factory _$UnifiedShakeDetectionCopyWith(_UnifiedShakeDetection value, $Res Function(_UnifiedShakeDetection) _then) = __$UnifiedShakeDetectionCopyWithImpl;
@override @useResult
$Res call({
 String headline, DateTime detectedAt, DateTime updatedAt, ShakeDetectionLevel level, UnifiedShakeDetectionStatus status, UnifiedShakeDetectionLocation? location
});


@override $UnifiedShakeDetectionLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$UnifiedShakeDetectionCopyWithImpl<$Res>
    implements _$UnifiedShakeDetectionCopyWith<$Res> {
  __$UnifiedShakeDetectionCopyWithImpl(this._self, this._then);

  final _UnifiedShakeDetection _self;
  final $Res Function(_UnifiedShakeDetection) _then;

/// Create a copy of UnifiedShakeDetection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headline = null,Object? detectedAt = null,Object? updatedAt = null,Object? level = null,Object? status = null,Object? location = freezed,}) {
  return _then(_UnifiedShakeDetection(
headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,detectedAt: null == detectedAt ? _self.detectedAt : detectedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as ShakeDetectionLevel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UnifiedShakeDetectionStatus,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as UnifiedShakeDetectionLocation?,
  ));
}

/// Create a copy of UnifiedShakeDetection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedShakeDetectionLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $UnifiedShakeDetectionLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
