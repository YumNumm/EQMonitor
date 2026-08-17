// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_icon_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityIconData {

 IntensityIconJmaIntensity get jmaIntensity; IntensityIconJmaLpgmIntensity get lpgmIntensity;
/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityIconDataCopyWith<IntensityIconData> get copyWith => _$IntensityIconDataCopyWithImpl<IntensityIconData>(this as IntensityIconData, _$identity);

  /// Serializes this IntensityIconData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityIconData&&(identical(other.jmaIntensity, jmaIntensity) || other.jmaIntensity == jmaIntensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jmaIntensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityIconData(jmaIntensity: $jmaIntensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityIconDataCopyWith<$Res>  {
  factory $IntensityIconDataCopyWith(IntensityIconData value, $Res Function(IntensityIconData) _then) = _$IntensityIconDataCopyWithImpl;
@useResult
$Res call({
 IntensityIconJmaIntensity jmaIntensity, IntensityIconJmaLpgmIntensity lpgmIntensity
});


$IntensityIconJmaIntensityCopyWith<$Res> get jmaIntensity;$IntensityIconJmaLpgmIntensityCopyWith<$Res> get lpgmIntensity;

}
/// @nodoc
class _$IntensityIconDataCopyWithImpl<$Res>
    implements $IntensityIconDataCopyWith<$Res> {
  _$IntensityIconDataCopyWithImpl(this._self, this._then);

  final IntensityIconData _self;
  final $Res Function(IntensityIconData) _then;

/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jmaIntensity = null,Object? lpgmIntensity = null,}) {
  return _then(IntensityIconData(
jmaIntensity: null == jmaIntensity ? _self.jmaIntensity : jmaIntensity // ignore: cast_nullable_to_non_nullable
as IntensityIconJmaIntensity,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as IntensityIconJmaLpgmIntensity,
  ));
}
/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityIconJmaIntensityCopyWith<$Res> get jmaIntensity {
  
  return $IntensityIconJmaIntensityCopyWith<$Res>(_self.jmaIntensity, (value) {
    return _then(_self.copyWith(jmaIntensity: value));
  });
}/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityIconJmaLpgmIntensityCopyWith<$Res> get lpgmIntensity {
  
  return $IntensityIconJmaLpgmIntensityCopyWith<$Res>(_self.lpgmIntensity, (value) {
    return _then(_self.copyWith(lpgmIntensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityIconData].
extension IntensityIconDataPatterns on IntensityIconData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityIconData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityIconData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityIconData value)  $default,){
final _that = this;
switch (_that) {
case _IntensityIconData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityIconData value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityIconData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( IntensityIconJmaIntensity jmaIntensity,  IntensityIconJmaLpgmIntensity lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityIconData() when $default != null:
return $default(_that.jmaIntensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( IntensityIconJmaIntensity jmaIntensity,  IntensityIconJmaLpgmIntensity lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityIconData():
return $default(_that.jmaIntensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( IntensityIconJmaIntensity jmaIntensity,  IntensityIconJmaLpgmIntensity lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityIconData() when $default != null:
return $default(_that.jmaIntensity,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityIconData implements IntensityIconData {
  const _IntensityIconData({required this.jmaIntensity, required this.lpgmIntensity});
  factory _IntensityIconData.fromJson(Map<String, dynamic> json) => _$IntensityIconDataFromJson(json);

@override final  IntensityIconJmaIntensity jmaIntensity;
@override final  IntensityIconJmaLpgmIntensity lpgmIntensity;

/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityIconDataCopyWith<_IntensityIconData> get copyWith => __$IntensityIconDataCopyWithImpl<_IntensityIconData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityIconDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityIconData&&(identical(other.jmaIntensity, jmaIntensity) || other.jmaIntensity == jmaIntensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jmaIntensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityIconData(jmaIntensity: $jmaIntensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityIconDataCopyWith<$Res> implements $IntensityIconDataCopyWith<$Res> {
  factory _$IntensityIconDataCopyWith(_IntensityIconData value, $Res Function(_IntensityIconData) _then) = __$IntensityIconDataCopyWithImpl;
@override @useResult
$Res call({
 IntensityIconJmaIntensity jmaIntensity, IntensityIconJmaLpgmIntensity lpgmIntensity
});


@override $IntensityIconJmaIntensityCopyWith<$Res> get jmaIntensity;@override $IntensityIconJmaLpgmIntensityCopyWith<$Res> get lpgmIntensity;

}
/// @nodoc
class __$IntensityIconDataCopyWithImpl<$Res>
    implements _$IntensityIconDataCopyWith<$Res> {
  __$IntensityIconDataCopyWithImpl(this._self, this._then);

  final _IntensityIconData _self;
  final $Res Function(_IntensityIconData) _then;

/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jmaIntensity = null,Object? lpgmIntensity = null,}) {
  return _then(_IntensityIconData(
jmaIntensity: null == jmaIntensity ? _self.jmaIntensity : jmaIntensity // ignore: cast_nullable_to_non_nullable
as IntensityIconJmaIntensity,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as IntensityIconJmaLpgmIntensity,
  ));
}

/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityIconJmaIntensityCopyWith<$Res> get jmaIntensity {
  
  return $IntensityIconJmaIntensityCopyWith<$Res>(_self.jmaIntensity, (value) {
    return _then(_self.copyWith(jmaIntensity: value));
  });
}/// Create a copy of IntensityIconData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityIconJmaLpgmIntensityCopyWith<$Res> get lpgmIntensity {
  
  return $IntensityIconJmaLpgmIntensityCopyWith<$Res>(_self.lpgmIntensity, (value) {
    return _then(_self.copyWith(lpgmIntensity: value));
  });
}
}

// dart format on
