// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeismicityManifest {

 List<SeismicityManifestLayer> get layers;
/// Create a copy of SeismicityManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityManifestCopyWith<SeismicityManifest> get copyWith => _$SeismicityManifestCopyWithImpl<SeismicityManifest>(this as SeismicityManifest, _$identity);

  /// Serializes this SeismicityManifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityManifest&&const DeepCollectionEquality().equals(other.layers, layers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(layers));

@override
String toString() {
  return 'SeismicityManifest(layers: $layers)';
}


}

/// @nodoc
abstract mixin class $SeismicityManifestCopyWith<$Res>  {
  factory $SeismicityManifestCopyWith(SeismicityManifest value, $Res Function(SeismicityManifest) _then) = _$SeismicityManifestCopyWithImpl;
@useResult
$Res call({
 List<SeismicityManifestLayer> layers
});




}
/// @nodoc
class _$SeismicityManifestCopyWithImpl<$Res>
    implements $SeismicityManifestCopyWith<$Res> {
  _$SeismicityManifestCopyWithImpl(this._self, this._then);

  final SeismicityManifest _self;
  final $Res Function(SeismicityManifest) _then;

/// Create a copy of SeismicityManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? layers = null,}) {
  return _then(SeismicityManifest(
layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as List<SeismicityManifestLayer>,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityManifest].
extension SeismicityManifestPatterns on SeismicityManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityManifest value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityManifest value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SeismicityManifestLayer> layers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityManifest() when $default != null:
return $default(_that.layers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SeismicityManifestLayer> layers)  $default,) {final _that = this;
switch (_that) {
case _SeismicityManifest():
return $default(_that.layers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SeismicityManifestLayer> layers)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityManifest() when $default != null:
return $default(_that.layers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeismicityManifest implements SeismicityManifest {
  const _SeismicityManifest({required  List<SeismicityManifestLayer> layers}): _layers = layers;
  factory _SeismicityManifest.fromJson(Map<String, dynamic> json) => _$SeismicityManifestFromJson(json);

 final  List<SeismicityManifestLayer> _layers;
@override List<SeismicityManifestLayer> get layers {
  if (_layers is EqualUnmodifiableListView) return _layers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layers);
}


/// Create a copy of SeismicityManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityManifestCopyWith<_SeismicityManifest> get copyWith => __$SeismicityManifestCopyWithImpl<_SeismicityManifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityManifestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityManifest&&const DeepCollectionEquality().equals(other._layers, _layers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_layers));

@override
String toString() {
  return 'SeismicityManifest(layers: $layers)';
}


}

/// @nodoc
abstract mixin class _$SeismicityManifestCopyWith<$Res> implements $SeismicityManifestCopyWith<$Res> {
  factory _$SeismicityManifestCopyWith(_SeismicityManifest value, $Res Function(_SeismicityManifest) _then) = __$SeismicityManifestCopyWithImpl;
@override @useResult
$Res call({
 List<SeismicityManifestLayer> layers
});




}
/// @nodoc
class __$SeismicityManifestCopyWithImpl<$Res>
    implements _$SeismicityManifestCopyWith<$Res> {
  __$SeismicityManifestCopyWithImpl(this._self, this._then);

  final _SeismicityManifest _self;
  final $Res Function(_SeismicityManifest) _then;

/// Create a copy of SeismicityManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? layers = null,}) {
  return _then(_SeismicityManifest(
layers: null == layers ? _self._layers : layers // ignore: cast_nullable_to_non_nullable
as List<SeismicityManifestLayer>,
  ));
}


}

// dart format on
