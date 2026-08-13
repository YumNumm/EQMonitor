// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shindo_db_stations_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShindoDbStationsParameter {

 ShindoDbStationsParameterMetadata get metadata; List<ShindoDbStation> get stations;
/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShindoDbStationsParameterCopyWith<ShindoDbStationsParameter> get copyWith => _$ShindoDbStationsParameterCopyWithImpl<ShindoDbStationsParameter>(this as ShindoDbStationsParameter, _$identity);

  /// Serializes this ShindoDbStationsParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShindoDbStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'ShindoDbStationsParameter(metadata: $metadata, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $ShindoDbStationsParameterCopyWith<$Res>  {
  factory $ShindoDbStationsParameterCopyWith(ShindoDbStationsParameter value, $Res Function(ShindoDbStationsParameter) _then) = _$ShindoDbStationsParameterCopyWithImpl;
@useResult
$Res call({
 ShindoDbStationsParameterMetadata metadata, List<ShindoDbStation> stations
});


$ShindoDbStationsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ShindoDbStationsParameterCopyWithImpl<$Res>
    implements $ShindoDbStationsParameterCopyWith<$Res> {
  _$ShindoDbStationsParameterCopyWithImpl(this._self, this._then);

  final ShindoDbStationsParameter _self;
  final $Res Function(ShindoDbStationsParameter) _then;

/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? stations = null,}) {
  return _then(ShindoDbStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ShindoDbStationsParameterMetadata,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<ShindoDbStation>,
  ));
}
/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShindoDbStationsParameterMetadataCopyWith<$Res> get metadata {
  
  return $ShindoDbStationsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShindoDbStationsParameter].
extension ShindoDbStationsParameterPatterns on ShindoDbStationsParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShindoDbStationsParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShindoDbStationsParameter value)  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationsParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShindoDbStationsParameter value)?  $default,){
final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ShindoDbStationsParameterMetadata metadata,  List<ShindoDbStation> stations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
return $default(_that.metadata,_that.stations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ShindoDbStationsParameterMetadata metadata,  List<ShindoDbStation> stations)  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationsParameter():
return $default(_that.metadata,_that.stations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ShindoDbStationsParameterMetadata metadata,  List<ShindoDbStation> stations)?  $default,) {final _that = this;
switch (_that) {
case _ShindoDbStationsParameter() when $default != null:
return $default(_that.metadata,_that.stations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShindoDbStationsParameter implements ShindoDbStationsParameter {
  const _ShindoDbStationsParameter({required this.metadata, required  List<ShindoDbStation> stations}): _stations = stations;
  factory _ShindoDbStationsParameter.fromJson(Map<String, dynamic> json) => _$ShindoDbStationsParameterFromJson(json);

@override final  ShindoDbStationsParameterMetadata metadata;
 final  List<ShindoDbStation> _stations;
@override List<ShindoDbStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShindoDbStationsParameterCopyWith<_ShindoDbStationsParameter> get copyWith => __$ShindoDbStationsParameterCopyWithImpl<_ShindoDbStationsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShindoDbStationsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShindoDbStationsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'ShindoDbStationsParameter(metadata: $metadata, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$ShindoDbStationsParameterCopyWith<$Res> implements $ShindoDbStationsParameterCopyWith<$Res> {
  factory _$ShindoDbStationsParameterCopyWith(_ShindoDbStationsParameter value, $Res Function(_ShindoDbStationsParameter) _then) = __$ShindoDbStationsParameterCopyWithImpl;
@override @useResult
$Res call({
 ShindoDbStationsParameterMetadata metadata, List<ShindoDbStation> stations
});


@override $ShindoDbStationsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$ShindoDbStationsParameterCopyWithImpl<$Res>
    implements _$ShindoDbStationsParameterCopyWith<$Res> {
  __$ShindoDbStationsParameterCopyWithImpl(this._self, this._then);

  final _ShindoDbStationsParameter _self;
  final $Res Function(_ShindoDbStationsParameter) _then;

/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? stations = null,}) {
  return _then(_ShindoDbStationsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as ShindoDbStationsParameterMetadata,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<ShindoDbStation>,
  ));
}

/// Create a copy of ShindoDbStationsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShindoDbStationsParameterMetadataCopyWith<$Res> get metadata {
  
  return $ShindoDbStationsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
