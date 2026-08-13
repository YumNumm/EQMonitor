// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_manifest_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeismicityManifestResponse {

 List<SeismicityManifestLayer> get layers;
/// Create a copy of SeismicityManifestResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityManifestResponseCopyWith<SeismicityManifestResponse> get copyWith => _$SeismicityManifestResponseCopyWithImpl<SeismicityManifestResponse>(this as SeismicityManifestResponse, _$identity);

  /// Serializes this SeismicityManifestResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityManifestResponse&&const DeepCollectionEquality().equals(other.layers, layers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(layers));

@override
String toString() {
  return 'SeismicityManifestResponse(layers: $layers)';
}


}

/// @nodoc
abstract mixin class $SeismicityManifestResponseCopyWith<$Res>  {
  factory $SeismicityManifestResponseCopyWith(SeismicityManifestResponse value, $Res Function(SeismicityManifestResponse) _then) = _$SeismicityManifestResponseCopyWithImpl;
@useResult
$Res call({
 List<SeismicityManifestLayer> layers
});




}
/// @nodoc
class _$SeismicityManifestResponseCopyWithImpl<$Res>
    implements $SeismicityManifestResponseCopyWith<$Res> {
  _$SeismicityManifestResponseCopyWithImpl(this._self, this._then);

  final SeismicityManifestResponse _self;
  final $Res Function(SeismicityManifestResponse) _then;

/// Create a copy of SeismicityManifestResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? layers = null,}) {
  return _then(SeismicityManifestResponse(
layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as List<SeismicityManifestLayer>,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityManifestResponse].
extension SeismicityManifestResponsePatterns on SeismicityManifestResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityManifestResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityManifestResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityManifestResponse value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityManifestResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityManifestResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityManifestResponse() when $default != null:
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
case _SeismicityManifestResponse() when $default != null:
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
case _SeismicityManifestResponse():
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
case _SeismicityManifestResponse() when $default != null:
return $default(_that.layers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeismicityManifestResponse implements SeismicityManifestResponse {
  const _SeismicityManifestResponse({required  List<SeismicityManifestLayer> layers}): _layers = layers;
  factory _SeismicityManifestResponse.fromJson(Map<String, dynamic> json) => _$SeismicityManifestResponseFromJson(json);

 final  List<SeismicityManifestLayer> _layers;
@override List<SeismicityManifestLayer> get layers {
  if (_layers is EqualUnmodifiableListView) return _layers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layers);
}


/// Create a copy of SeismicityManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityManifestResponseCopyWith<_SeismicityManifestResponse> get copyWith => __$SeismicityManifestResponseCopyWithImpl<_SeismicityManifestResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityManifestResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityManifestResponse&&const DeepCollectionEquality().equals(other._layers, _layers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_layers));

@override
String toString() {
  return 'SeismicityManifestResponse(layers: $layers)';
}


}

/// @nodoc
abstract mixin class _$SeismicityManifestResponseCopyWith<$Res> implements $SeismicityManifestResponseCopyWith<$Res> {
  factory _$SeismicityManifestResponseCopyWith(_SeismicityManifestResponse value, $Res Function(_SeismicityManifestResponse) _then) = __$SeismicityManifestResponseCopyWithImpl;
@override @useResult
$Res call({
 List<SeismicityManifestLayer> layers
});




}
/// @nodoc
class __$SeismicityManifestResponseCopyWithImpl<$Res>
    implements _$SeismicityManifestResponseCopyWith<$Res> {
  __$SeismicityManifestResponseCopyWithImpl(this._self, this._then);

  final _SeismicityManifestResponse _self;
  final $Res Function(_SeismicityManifestResponse) _then;

/// Create a copy of SeismicityManifestResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? layers = null,}) {
  return _then(_SeismicityManifestResponse(
layers: null == layers ? _self._layers : layers // ignore: cast_nullable_to_non_nullable
as List<SeismicityManifestLayer>,
  ));
}


}

// dart format on
