// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hypocenter_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HypocenterManifest {

 List<HypocenterArchive> get archives; String get datasetRevision; DateTime get dataUpdatedAt;
/// Create a copy of HypocenterManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterManifestCopyWith<HypocenterManifest> get copyWith => _$HypocenterManifestCopyWithImpl<HypocenterManifest>(this as HypocenterManifest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterManifest&&const DeepCollectionEquality().equals(other.archives, archives)&&(identical(other.datasetRevision, datasetRevision) || other.datasetRevision == datasetRevision)&&(identical(other.dataUpdatedAt, dataUpdatedAt) || other.dataUpdatedAt == dataUpdatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(archives),datasetRevision,dataUpdatedAt);

@override
String toString() {
  return 'HypocenterManifest(archives: $archives, datasetRevision: $datasetRevision, dataUpdatedAt: $dataUpdatedAt)';
}


}

/// @nodoc
abstract mixin class $HypocenterManifestCopyWith<$Res>  {
  factory $HypocenterManifestCopyWith(HypocenterManifest value, $Res Function(HypocenterManifest) _then) = _$HypocenterManifestCopyWithImpl;
@useResult
$Res call({
 List<HypocenterArchive> archives, String datasetRevision, DateTime dataUpdatedAt
});




}
/// @nodoc
class _$HypocenterManifestCopyWithImpl<$Res>
    implements $HypocenterManifestCopyWith<$Res> {
  _$HypocenterManifestCopyWithImpl(this._self, this._then);

  final HypocenterManifest _self;
  final $Res Function(HypocenterManifest) _then;

/// Create a copy of HypocenterManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? archives = null,Object? datasetRevision = null,Object? dataUpdatedAt = null,}) {
  return _then(_self.copyWith(
archives: null == archives ? _self.archives : archives // ignore: cast_nullable_to_non_nullable
as List<HypocenterArchive>,datasetRevision: null == datasetRevision ? _self.datasetRevision : datasetRevision // ignore: cast_nullable_to_non_nullable
as String,dataUpdatedAt: null == dataUpdatedAt ? _self.dataUpdatedAt : dataUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterManifest].
extension HypocenterManifestPatterns on HypocenterManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterManifest value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterManifest value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HypocenterArchive> archives,  String datasetRevision,  DateTime dataUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterManifest() when $default != null:
return $default(_that.archives,_that.datasetRevision,_that.dataUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HypocenterArchive> archives,  String datasetRevision,  DateTime dataUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _HypocenterManifest():
return $default(_that.archives,_that.datasetRevision,_that.dataUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HypocenterArchive> archives,  String datasetRevision,  DateTime dataUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterManifest() when $default != null:
return $default(_that.archives,_that.datasetRevision,_that.dataUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _HypocenterManifest implements HypocenterManifest {
  const _HypocenterManifest({required final  List<HypocenterArchive> archives, required this.datasetRevision, required this.dataUpdatedAt}): _archives = archives;
  

 final  List<HypocenterArchive> _archives;
@override List<HypocenterArchive> get archives {
  if (_archives is EqualUnmodifiableListView) return _archives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_archives);
}

@override final  String datasetRevision;
@override final  DateTime dataUpdatedAt;

/// Create a copy of HypocenterManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterManifestCopyWith<_HypocenterManifest> get copyWith => __$HypocenterManifestCopyWithImpl<_HypocenterManifest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterManifest&&const DeepCollectionEquality().equals(other._archives, _archives)&&(identical(other.datasetRevision, datasetRevision) || other.datasetRevision == datasetRevision)&&(identical(other.dataUpdatedAt, dataUpdatedAt) || other.dataUpdatedAt == dataUpdatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_archives),datasetRevision,dataUpdatedAt);

@override
String toString() {
  return 'HypocenterManifest(archives: $archives, datasetRevision: $datasetRevision, dataUpdatedAt: $dataUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$HypocenterManifestCopyWith<$Res> implements $HypocenterManifestCopyWith<$Res> {
  factory _$HypocenterManifestCopyWith(_HypocenterManifest value, $Res Function(_HypocenterManifest) _then) = __$HypocenterManifestCopyWithImpl;
@override @useResult
$Res call({
 List<HypocenterArchive> archives, String datasetRevision, DateTime dataUpdatedAt
});




}
/// @nodoc
class __$HypocenterManifestCopyWithImpl<$Res>
    implements _$HypocenterManifestCopyWith<$Res> {
  __$HypocenterManifestCopyWithImpl(this._self, this._then);

  final _HypocenterManifest _self;
  final $Res Function(_HypocenterManifest) _then;

/// Create a copy of HypocenterManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? archives = null,Object? datasetRevision = null,Object? dataUpdatedAt = null,}) {
  return _then(_HypocenterManifest(
archives: null == archives ? _self._archives : archives // ignore: cast_nullable_to_non_nullable
as List<HypocenterArchive>,datasetRevision: null == datasetRevision ? _self.datasetRevision : datasetRevision // ignore: cast_nullable_to_non_nullable
as String,dataUpdatedAt: null == dataUpdatedAt ? _self.dataUpdatedAt : dataUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
