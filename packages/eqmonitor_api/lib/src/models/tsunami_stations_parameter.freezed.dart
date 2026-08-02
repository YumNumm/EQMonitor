// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_stations_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationsParameter {

 TsunamiStationsParameterMetadata get metadata; List<TsunamiStationPrefecture> get prefectures;
/// Create a copy of TsunamiStationsParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationsParameterCopyWith<TsunamiStationsParameter> get copyWith => _$TsunamiStationsParameterCopyWithImpl<TsunamiStationsParameter>(this as TsunamiStationsParameter, _$identity);

  /// Serializes this TsunamiStationsParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.prefectures, prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(prefectures));

@override
String toString() {
  return 'TsunamiStationsParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationsParameterCopyWith<$Res>  {
  factory $TsunamiStationsParameterCopyWith(TsunamiStationsParameter value, $Res Function(TsunamiStationsParameter) _then) = _$TsunamiStationsParameterCopyWithImpl;
@useResult
$Res call({
 TsunamiStationsParameterMetadata metadata, List<TsunamiStationPrefecture> prefectures
});


$TsunamiStationsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$TsunamiStationsParameterCopyWithImpl<$Res>
    implements $TsunamiStationsParameterCopyWith<$Res> {
  _$TsunamiStationsParameterCopyWithImpl(this._self, this._then);

  final TsunamiStationsParameter _self;
  final $Res Function(TsunamiStationsParameter) _then;

/// Create a copy of TsunamiStationsParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as TsunamiStationsParameterMetadata,prefectures: null == prefectures ? _self.prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<TsunamiStationPrefecture>,
  ));
}
/// Create a copy of TsunamiStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationsParameterMetadataCopyWith<$Res> get metadata {

  return $TsunamiStationsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiStationsParameter].
extension TsunamiStationsParameterPatterns on TsunamiStationsParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationsParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationsParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationsParameter value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationsParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationsParameter value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationsParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiStationsParameterMetadata metadata,  List<TsunamiStationPrefecture> prefectures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationsParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiStationsParameterMetadata metadata,  List<TsunamiStationPrefecture> prefectures)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationsParameter():
return $default(_that.metadata,_that.prefectures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiStationsParameterMetadata metadata,  List<TsunamiStationPrefecture> prefectures)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationsParameter() when $default != null:
return $default(_that.metadata,_that.prefectures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationsParameter implements TsunamiStationsParameter {
  const _TsunamiStationsParameter({required this.metadata, required final  List<TsunamiStationPrefecture> prefectures}): _prefectures = prefectures;
  factory _TsunamiStationsParameter.fromJson(Map<String, dynamic> json) => _$TsunamiStationsParameterFromJson(json);

@override final  TsunamiStationsParameterMetadata metadata;
 final  List<TsunamiStationPrefecture> _prefectures;
@override List<TsunamiStationPrefecture> get prefectures {
  if (_prefectures is EqualUnmodifiableListView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prefectures);
}


/// Create a copy of TsunamiStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationsParameterCopyWith<_TsunamiStationsParameter> get copyWith => __$TsunamiStationsParameterCopyWithImpl<_TsunamiStationsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_prefectures));

@override
String toString() {
  return 'TsunamiStationsParameter(metadata: $metadata, prefectures: $prefectures)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationsParameterCopyWith<$Res> implements $TsunamiStationsParameterCopyWith<$Res> {
  factory _$TsunamiStationsParameterCopyWith(_TsunamiStationsParameter value, $Res Function(_TsunamiStationsParameter) _then) = __$TsunamiStationsParameterCopyWithImpl;
@override @useResult
$Res call({
 TsunamiStationsParameterMetadata metadata, List<TsunamiStationPrefecture> prefectures
});


@override $TsunamiStationsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$TsunamiStationsParameterCopyWithImpl<$Res>
    implements _$TsunamiStationsParameterCopyWith<$Res> {
  __$TsunamiStationsParameterCopyWithImpl(this._self, this._then);

  final _TsunamiStationsParameter _self;
  final $Res Function(_TsunamiStationsParameter) _then;

/// Create a copy of TsunamiStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? prefectures = null,}) {
  return _then(_TsunamiStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as TsunamiStationsParameterMetadata,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as List<TsunamiStationPrefecture>,
  ));
}

/// Create a copy of TsunamiStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiStationsParameterMetadataCopyWith<$Res> get metadata {

  return $TsunamiStationsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
