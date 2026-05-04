// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kyoshin_observation_points_parameter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KyoshinObservationPointsParameter {

 KyoshinObservationPointsParameterMetadata get metadata; List<KyoshinObservationPoint> get points;
/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterCopyWith<KyoshinObservationPointsParameter> get copyWith => _$KyoshinObservationPointsParameterCopyWithImpl<KyoshinObservationPointsParameter>(this as KyoshinObservationPointsParameter, _$identity);

  /// Serializes this KyoshinObservationPointsParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KyoshinObservationPointsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.points, points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(points));

@override
String toString() {
  return 'KyoshinObservationPointsParameter(metadata: $metadata, points: $points)';
}


}

/// @nodoc
abstract mixin class $KyoshinObservationPointsParameterCopyWith<$Res>  {
  factory $KyoshinObservationPointsParameterCopyWith(KyoshinObservationPointsParameter value, $Res Function(KyoshinObservationPointsParameter) _then) = _$KyoshinObservationPointsParameterCopyWithImpl;
@useResult
$Res call({
 KyoshinObservationPointsParameterMetadata metadata, List<KyoshinObservationPoint> points
});


$KyoshinObservationPointsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$KyoshinObservationPointsParameterCopyWithImpl<$Res>
    implements $KyoshinObservationPointsParameterCopyWith<$Res> {
  _$KyoshinObservationPointsParameterCopyWithImpl(this._self, this._then);

  final KyoshinObservationPointsParameter _self;
  final $Res Function(KyoshinObservationPointsParameter) _then;

/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metadata = null,Object? points = null,}) {
  return _then(_self.copyWith(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointsParameterMetadata,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,
  ));
}
/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterMetadataCopyWith<$Res> get metadata {
  
  return $KyoshinObservationPointsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [KyoshinObservationPointsParameter].
extension KyoshinObservationPointsParameterPatterns on KyoshinObservationPointsParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KyoshinObservationPointsParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KyoshinObservationPointsParameter value)  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KyoshinObservationPointsParameter value)?  $default,){
final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( KyoshinObservationPointsParameterMetadata metadata,  List<KyoshinObservationPoint> points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
return $default(_that.metadata,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( KyoshinObservationPointsParameterMetadata metadata,  List<KyoshinObservationPoint> points)  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter():
return $default(_that.metadata,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( KyoshinObservationPointsParameterMetadata metadata,  List<KyoshinObservationPoint> points)?  $default,) {final _that = this;
switch (_that) {
case _KyoshinObservationPointsParameter() when $default != null:
return $default(_that.metadata,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KyoshinObservationPointsParameter implements KyoshinObservationPointsParameter {
  const _KyoshinObservationPointsParameter({required this.metadata, required final  List<KyoshinObservationPoint> points}): _points = points;
  factory _KyoshinObservationPointsParameter.fromJson(Map<String, dynamic> json) => _$KyoshinObservationPointsParameterFromJson(json);

@override final  KyoshinObservationPointsParameterMetadata metadata;
 final  List<KyoshinObservationPoint> _points;
@override List<KyoshinObservationPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}


/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KyoshinObservationPointsParameterCopyWith<_KyoshinObservationPointsParameter> get copyWith => __$KyoshinObservationPointsParameterCopyWithImpl<_KyoshinObservationPointsParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KyoshinObservationPointsParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KyoshinObservationPointsParameter&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._points, _points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metadata,const DeepCollectionEquality().hash(_points));

@override
String toString() {
  return 'KyoshinObservationPointsParameter(metadata: $metadata, points: $points)';
}


}

/// @nodoc
abstract mixin class _$KyoshinObservationPointsParameterCopyWith<$Res> implements $KyoshinObservationPointsParameterCopyWith<$Res> {
  factory _$KyoshinObservationPointsParameterCopyWith(_KyoshinObservationPointsParameter value, $Res Function(_KyoshinObservationPointsParameter) _then) = __$KyoshinObservationPointsParameterCopyWithImpl;
@override @useResult
$Res call({
 KyoshinObservationPointsParameterMetadata metadata, List<KyoshinObservationPoint> points
});


@override $KyoshinObservationPointsParameterMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$KyoshinObservationPointsParameterCopyWithImpl<$Res>
    implements _$KyoshinObservationPointsParameterCopyWith<$Res> {
  __$KyoshinObservationPointsParameterCopyWithImpl(this._self, this._then);

  final _KyoshinObservationPointsParameter _self;
  final $Res Function(_KyoshinObservationPointsParameter) _then;

/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metadata = null,Object? points = null,}) {
  return _then(_KyoshinObservationPointsParameter(
metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as KyoshinObservationPointsParameterMetadata,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<KyoshinObservationPoint>,
  ));
}

/// Create a copy of KyoshinObservationPointsParameter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KyoshinObservationPointsParameterMetadataCopyWith<$Res> get metadata {
  
  return $KyoshinObservationPointsParameterMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
