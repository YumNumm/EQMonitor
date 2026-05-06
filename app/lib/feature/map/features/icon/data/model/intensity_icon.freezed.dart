// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_icon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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
  return _then(_self.copyWith(
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


/// @nodoc
mixin _$IntensityIconJmaIntensity {

@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> get filled;@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> get small;@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> get smallWithoutText;
/// Create a copy of IntensityIconJmaIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityIconJmaIntensityCopyWith<IntensityIconJmaIntensity> get copyWith => _$IntensityIconJmaIntensityCopyWithImpl<IntensityIconJmaIntensity>(this as IntensityIconJmaIntensity, _$identity);

  /// Serializes this IntensityIconJmaIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityIconJmaIntensity&&const DeepCollectionEquality().equals(other.filled, filled)&&const DeepCollectionEquality().equals(other.small, small)&&const DeepCollectionEquality().equals(other.smallWithoutText, smallWithoutText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(filled),const DeepCollectionEquality().hash(small),const DeepCollectionEquality().hash(smallWithoutText));

@override
String toString() {
  return 'IntensityIconJmaIntensity(filled: $filled, small: $small, smallWithoutText: $smallWithoutText)';
}


}

/// @nodoc
abstract mixin class $IntensityIconJmaIntensityCopyWith<$Res>  {
  factory $IntensityIconJmaIntensityCopyWith(IntensityIconJmaIntensity value, $Res Function(IntensityIconJmaIntensity) _then) = _$IntensityIconJmaIntensityCopyWithImpl;
@useResult
$Res call({
@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> filled,@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> small,@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> smallWithoutText
});




}
/// @nodoc
class _$IntensityIconJmaIntensityCopyWithImpl<$Res>
    implements $IntensityIconJmaIntensityCopyWith<$Res> {
  _$IntensityIconJmaIntensityCopyWithImpl(this._self, this._then);

  final IntensityIconJmaIntensity _self;
  final $Res Function(IntensityIconJmaIntensity) _then;

/// Create a copy of IntensityIconJmaIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filled = null,Object? small = null,Object? smallWithoutText = null,}) {
  return _then(_self.copyWith(
filled: null == filled ? _self.filled : filled // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, Uint8List>,small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, Uint8List>,smallWithoutText: null == smallWithoutText ? _self.smallWithoutText : smallWithoutText // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, Uint8List>,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityIconJmaIntensity].
extension IntensityIconJmaIntensityPatterns on IntensityIconJmaIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityIconJmaIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityIconJmaIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityIconJmaIntensity value)  $default,){
final _that = this;
switch (_that) {
case _IntensityIconJmaIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityIconJmaIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityIconJmaIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> filled, @MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> small, @MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> smallWithoutText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityIconJmaIntensity() when $default != null:
return $default(_that.filled,_that.small,_that.smallWithoutText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> filled, @MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> small, @MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> smallWithoutText)  $default,) {final _that = this;
switch (_that) {
case _IntensityIconJmaIntensity():
return $default(_that.filled,_that.small,_that.smallWithoutText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> filled, @MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> small, @MapJmaIntensityUint8ListJsonConverter()  Map<JmaIntensity, Uint8List> smallWithoutText)?  $default,) {final _that = this;
switch (_that) {
case _IntensityIconJmaIntensity() when $default != null:
return $default(_that.filled,_that.small,_that.smallWithoutText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityIconJmaIntensity implements IntensityIconJmaIntensity {
  const _IntensityIconJmaIntensity({@MapJmaIntensityUint8ListJsonConverter() required final  Map<JmaIntensity, Uint8List> filled, @MapJmaIntensityUint8ListJsonConverter() required final  Map<JmaIntensity, Uint8List> small, @MapJmaIntensityUint8ListJsonConverter() required final  Map<JmaIntensity, Uint8List> smallWithoutText}): _filled = filled,_small = small,_smallWithoutText = smallWithoutText;
  factory _IntensityIconJmaIntensity.fromJson(Map<String, dynamic> json) => _$IntensityIconJmaIntensityFromJson(json);

 final  Map<JmaIntensity, Uint8List> _filled;
@override@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> get filled {
  if (_filled is EqualUnmodifiableMapView) return _filled;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_filled);
}

 final  Map<JmaIntensity, Uint8List> _small;
@override@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> get small {
  if (_small is EqualUnmodifiableMapView) return _small;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_small);
}

 final  Map<JmaIntensity, Uint8List> _smallWithoutText;
@override@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> get smallWithoutText {
  if (_smallWithoutText is EqualUnmodifiableMapView) return _smallWithoutText;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_smallWithoutText);
}


/// Create a copy of IntensityIconJmaIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityIconJmaIntensityCopyWith<_IntensityIconJmaIntensity> get copyWith => __$IntensityIconJmaIntensityCopyWithImpl<_IntensityIconJmaIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityIconJmaIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityIconJmaIntensity&&const DeepCollectionEquality().equals(other._filled, _filled)&&const DeepCollectionEquality().equals(other._small, _small)&&const DeepCollectionEquality().equals(other._smallWithoutText, _smallWithoutText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filled),const DeepCollectionEquality().hash(_small),const DeepCollectionEquality().hash(_smallWithoutText));

@override
String toString() {
  return 'IntensityIconJmaIntensity(filled: $filled, small: $small, smallWithoutText: $smallWithoutText)';
}


}

/// @nodoc
abstract mixin class _$IntensityIconJmaIntensityCopyWith<$Res> implements $IntensityIconJmaIntensityCopyWith<$Res> {
  factory _$IntensityIconJmaIntensityCopyWith(_IntensityIconJmaIntensity value, $Res Function(_IntensityIconJmaIntensity) _then) = __$IntensityIconJmaIntensityCopyWithImpl;
@override @useResult
$Res call({
@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> filled,@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> small,@MapJmaIntensityUint8ListJsonConverter() Map<JmaIntensity, Uint8List> smallWithoutText
});




}
/// @nodoc
class __$IntensityIconJmaIntensityCopyWithImpl<$Res>
    implements _$IntensityIconJmaIntensityCopyWith<$Res> {
  __$IntensityIconJmaIntensityCopyWithImpl(this._self, this._then);

  final _IntensityIconJmaIntensity _self;
  final $Res Function(_IntensityIconJmaIntensity) _then;

/// Create a copy of IntensityIconJmaIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filled = null,Object? small = null,Object? smallWithoutText = null,}) {
  return _then(_IntensityIconJmaIntensity(
filled: null == filled ? _self._filled : filled // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, Uint8List>,small: null == small ? _self._small : small // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, Uint8List>,smallWithoutText: null == smallWithoutText ? _self._smallWithoutText : smallWithoutText // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, Uint8List>,
  ));
}


}


/// @nodoc
mixin _$IntensityIconJmaLpgmIntensity {

@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> get filled;@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> get small;@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> get smallWithoutText;
/// Create a copy of IntensityIconJmaLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityIconJmaLpgmIntensityCopyWith<IntensityIconJmaLpgmIntensity> get copyWith => _$IntensityIconJmaLpgmIntensityCopyWithImpl<IntensityIconJmaLpgmIntensity>(this as IntensityIconJmaLpgmIntensity, _$identity);

  /// Serializes this IntensityIconJmaLpgmIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityIconJmaLpgmIntensity&&const DeepCollectionEquality().equals(other.filled, filled)&&const DeepCollectionEquality().equals(other.small, small)&&const DeepCollectionEquality().equals(other.smallWithoutText, smallWithoutText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(filled),const DeepCollectionEquality().hash(small),const DeepCollectionEquality().hash(smallWithoutText));

@override
String toString() {
  return 'IntensityIconJmaLpgmIntensity(filled: $filled, small: $small, smallWithoutText: $smallWithoutText)';
}


}

/// @nodoc
abstract mixin class $IntensityIconJmaLpgmIntensityCopyWith<$Res>  {
  factory $IntensityIconJmaLpgmIntensityCopyWith(IntensityIconJmaLpgmIntensity value, $Res Function(IntensityIconJmaLpgmIntensity) _then) = _$IntensityIconJmaLpgmIntensityCopyWithImpl;
@useResult
$Res call({
@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> filled,@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> small,@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> smallWithoutText
});




}
/// @nodoc
class _$IntensityIconJmaLpgmIntensityCopyWithImpl<$Res>
    implements $IntensityIconJmaLpgmIntensityCopyWith<$Res> {
  _$IntensityIconJmaLpgmIntensityCopyWithImpl(this._self, this._then);

  final IntensityIconJmaLpgmIntensity _self;
  final $Res Function(IntensityIconJmaLpgmIntensity) _then;

/// Create a copy of IntensityIconJmaLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filled = null,Object? small = null,Object? smallWithoutText = null,}) {
  return _then(_self.copyWith(
filled: null == filled ? _self.filled : filled // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, Uint8List>,small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, Uint8List>,smallWithoutText: null == smallWithoutText ? _self.smallWithoutText : smallWithoutText // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, Uint8List>,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityIconJmaLpgmIntensity].
extension IntensityIconJmaLpgmIntensityPatterns on IntensityIconJmaLpgmIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityIconJmaLpgmIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityIconJmaLpgmIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityIconJmaLpgmIntensity value)  $default,){
final _that = this;
switch (_that) {
case _IntensityIconJmaLpgmIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityIconJmaLpgmIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityIconJmaLpgmIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> filled, @MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> small, @MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> smallWithoutText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityIconJmaLpgmIntensity() when $default != null:
return $default(_that.filled,_that.small,_that.smallWithoutText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> filled, @MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> small, @MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> smallWithoutText)  $default,) {final _that = this;
switch (_that) {
case _IntensityIconJmaLpgmIntensity():
return $default(_that.filled,_that.small,_that.smallWithoutText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> filled, @MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> small, @MapJmaLpgmIntensityUint8ListJsonConverter()  Map<JmaLpgmIntensity, Uint8List> smallWithoutText)?  $default,) {final _that = this;
switch (_that) {
case _IntensityIconJmaLpgmIntensity() when $default != null:
return $default(_that.filled,_that.small,_that.smallWithoutText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityIconJmaLpgmIntensity implements IntensityIconJmaLpgmIntensity {
  const _IntensityIconJmaLpgmIntensity({@MapJmaLpgmIntensityUint8ListJsonConverter() required final  Map<JmaLpgmIntensity, Uint8List> filled, @MapJmaLpgmIntensityUint8ListJsonConverter() required final  Map<JmaLpgmIntensity, Uint8List> small, @MapJmaLpgmIntensityUint8ListJsonConverter() required final  Map<JmaLpgmIntensity, Uint8List> smallWithoutText}): _filled = filled,_small = small,_smallWithoutText = smallWithoutText;
  factory _IntensityIconJmaLpgmIntensity.fromJson(Map<String, dynamic> json) => _$IntensityIconJmaLpgmIntensityFromJson(json);

 final  Map<JmaLpgmIntensity, Uint8List> _filled;
@override@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> get filled {
  if (_filled is EqualUnmodifiableMapView) return _filled;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_filled);
}

 final  Map<JmaLpgmIntensity, Uint8List> _small;
@override@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> get small {
  if (_small is EqualUnmodifiableMapView) return _small;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_small);
}

 final  Map<JmaLpgmIntensity, Uint8List> _smallWithoutText;
@override@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> get smallWithoutText {
  if (_smallWithoutText is EqualUnmodifiableMapView) return _smallWithoutText;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_smallWithoutText);
}


/// Create a copy of IntensityIconJmaLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityIconJmaLpgmIntensityCopyWith<_IntensityIconJmaLpgmIntensity> get copyWith => __$IntensityIconJmaLpgmIntensityCopyWithImpl<_IntensityIconJmaLpgmIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityIconJmaLpgmIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityIconJmaLpgmIntensity&&const DeepCollectionEquality().equals(other._filled, _filled)&&const DeepCollectionEquality().equals(other._small, _small)&&const DeepCollectionEquality().equals(other._smallWithoutText, _smallWithoutText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filled),const DeepCollectionEquality().hash(_small),const DeepCollectionEquality().hash(_smallWithoutText));

@override
String toString() {
  return 'IntensityIconJmaLpgmIntensity(filled: $filled, small: $small, smallWithoutText: $smallWithoutText)';
}


}

/// @nodoc
abstract mixin class _$IntensityIconJmaLpgmIntensityCopyWith<$Res> implements $IntensityIconJmaLpgmIntensityCopyWith<$Res> {
  factory _$IntensityIconJmaLpgmIntensityCopyWith(_IntensityIconJmaLpgmIntensity value, $Res Function(_IntensityIconJmaLpgmIntensity) _then) = __$IntensityIconJmaLpgmIntensityCopyWithImpl;
@override @useResult
$Res call({
@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> filled,@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> small,@MapJmaLpgmIntensityUint8ListJsonConverter() Map<JmaLpgmIntensity, Uint8List> smallWithoutText
});




}
/// @nodoc
class __$IntensityIconJmaLpgmIntensityCopyWithImpl<$Res>
    implements _$IntensityIconJmaLpgmIntensityCopyWith<$Res> {
  __$IntensityIconJmaLpgmIntensityCopyWithImpl(this._self, this._then);

  final _IntensityIconJmaLpgmIntensity _self;
  final $Res Function(_IntensityIconJmaLpgmIntensity) _then;

/// Create a copy of IntensityIconJmaLpgmIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filled = null,Object? small = null,Object? smallWithoutText = null,}) {
  return _then(_IntensityIconJmaLpgmIntensity(
filled: null == filled ? _self._filled : filled // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, Uint8List>,small: null == small ? _self._small : small // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, Uint8List>,smallWithoutText: null == smallWithoutText ? _self._smallWithoutText : smallWithoutText // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, Uint8List>,
  ));
}


}

// dart format on
