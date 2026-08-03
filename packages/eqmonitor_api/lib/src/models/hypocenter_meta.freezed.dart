// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HypocenterMeta {

@JsonKey(name: 'dataset_revision') String get datasetRevision;@JsonKey(name: 'data_updated_at') DateTime get dataUpdatedAt; HypocenterCoverage get coverage;
/// Create a copy of HypocenterMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterMetaCopyWith<HypocenterMeta> get copyWith => _$HypocenterMetaCopyWithImpl<HypocenterMeta>(this as HypocenterMeta, _$identity);

  /// Serializes this HypocenterMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterMeta&&(identical(other.datasetRevision, datasetRevision) || other.datasetRevision == datasetRevision)&&(identical(other.dataUpdatedAt, dataUpdatedAt) || other.dataUpdatedAt == dataUpdatedAt)&&(identical(other.coverage, coverage) || other.coverage == coverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datasetRevision,dataUpdatedAt,coverage);

@override
String toString() {
  return 'HypocenterMeta(datasetRevision: $datasetRevision, dataUpdatedAt: $dataUpdatedAt, coverage: $coverage)';
}


}

/// @nodoc
abstract mixin class $HypocenterMetaCopyWith<$Res>  {
  factory $HypocenterMetaCopyWith(HypocenterMeta value, $Res Function(HypocenterMeta) _then) = _$HypocenterMetaCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'dataset_revision') String datasetRevision,@JsonKey(name: 'data_updated_at') DateTime dataUpdatedAt, HypocenterCoverage coverage
});


$HypocenterCoverageCopyWith<$Res> get coverage;

}
/// @nodoc
class _$HypocenterMetaCopyWithImpl<$Res>
    implements $HypocenterMetaCopyWith<$Res> {
  _$HypocenterMetaCopyWithImpl(this._self, this._then);

  final HypocenterMeta _self;
  final $Res Function(HypocenterMeta) _then;

/// Create a copy of HypocenterMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? datasetRevision = null,Object? dataUpdatedAt = null,Object? coverage = null,}) {
  return _then(_self.copyWith(
datasetRevision: null == datasetRevision ? _self.datasetRevision : datasetRevision // ignore: cast_nullable_to_non_nullable
as String,dataUpdatedAt: null == dataUpdatedAt ? _self.dataUpdatedAt : dataUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,coverage: null == coverage ? _self.coverage : coverage // ignore: cast_nullable_to_non_nullable
as HypocenterCoverage,
  ));
}
/// Create a copy of HypocenterMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCoverageCopyWith<$Res> get coverage {

  return $HypocenterCoverageCopyWith<$Res>(_self.coverage, (value) {
    return _then(_self.copyWith(coverage: value));
  });
}
}


/// Adds pattern-matching-related methods to [HypocenterMeta].
extension HypocenterMetaPatterns on HypocenterMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterMeta value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterMeta value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'dataset_revision')  String datasetRevision, @JsonKey(name: 'data_updated_at')  DateTime dataUpdatedAt,  HypocenterCoverage coverage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterMeta() when $default != null:
return $default(_that.datasetRevision,_that.dataUpdatedAt,_that.coverage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'dataset_revision')  String datasetRevision, @JsonKey(name: 'data_updated_at')  DateTime dataUpdatedAt,  HypocenterCoverage coverage)  $default,) {final _that = this;
switch (_that) {
case _HypocenterMeta():
return $default(_that.datasetRevision,_that.dataUpdatedAt,_that.coverage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'dataset_revision')  String datasetRevision, @JsonKey(name: 'data_updated_at')  DateTime dataUpdatedAt,  HypocenterCoverage coverage)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterMeta() when $default != null:
return $default(_that.datasetRevision,_that.dataUpdatedAt,_that.coverage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterMeta implements HypocenterMeta {
  const _HypocenterMeta({@JsonKey(name: 'dataset_revision') required this.datasetRevision, @JsonKey(name: 'data_updated_at') required this.dataUpdatedAt, required this.coverage});
  factory _HypocenterMeta.fromJson(Map<String, dynamic> json) => _$HypocenterMetaFromJson(json);

@override@JsonKey(name: 'dataset_revision') final  String datasetRevision;
@override@JsonKey(name: 'data_updated_at') final  DateTime dataUpdatedAt;
@override final  HypocenterCoverage coverage;

/// Create a copy of HypocenterMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterMetaCopyWith<_HypocenterMeta> get copyWith => __$HypocenterMetaCopyWithImpl<_HypocenterMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterMeta&&(identical(other.datasetRevision, datasetRevision) || other.datasetRevision == datasetRevision)&&(identical(other.dataUpdatedAt, dataUpdatedAt) || other.dataUpdatedAt == dataUpdatedAt)&&(identical(other.coverage, coverage) || other.coverage == coverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datasetRevision,dataUpdatedAt,coverage);

@override
String toString() {
  return 'HypocenterMeta(datasetRevision: $datasetRevision, dataUpdatedAt: $dataUpdatedAt, coverage: $coverage)';
}


}

/// @nodoc
abstract mixin class _$HypocenterMetaCopyWith<$Res> implements $HypocenterMetaCopyWith<$Res> {
  factory _$HypocenterMetaCopyWith(_HypocenterMeta value, $Res Function(_HypocenterMeta) _then) = __$HypocenterMetaCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'dataset_revision') String datasetRevision,@JsonKey(name: 'data_updated_at') DateTime dataUpdatedAt, HypocenterCoverage coverage
});


@override $HypocenterCoverageCopyWith<$Res> get coverage;

}
/// @nodoc
class __$HypocenterMetaCopyWithImpl<$Res>
    implements _$HypocenterMetaCopyWith<$Res> {
  __$HypocenterMetaCopyWithImpl(this._self, this._then);

  final _HypocenterMeta _self;
  final $Res Function(_HypocenterMeta) _then;

/// Create a copy of HypocenterMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? datasetRevision = null,Object? dataUpdatedAt = null,Object? coverage = null,}) {
  return _then(_HypocenterMeta(
datasetRevision: null == datasetRevision ? _self.datasetRevision : datasetRevision // ignore: cast_nullable_to_non_nullable
as String,dataUpdatedAt: null == dataUpdatedAt ? _self.dataUpdatedAt : dataUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,coverage: null == coverage ? _self.coverage : coverage // ignore: cast_nullable_to_non_nullable
as HypocenterCoverage,
  ));
}

/// Create a copy of HypocenterMeta
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCoverageCopyWith<$Res> get coverage {

  return $HypocenterCoverageCopyWith<$Res>(_self.coverage, (value) {
    return _then(_self.copyWith(coverage: value));
  });
}
}

// dart format on
