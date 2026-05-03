// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Intensity {

@JsonKey(name: 'max_intensity') JmaIntensity get maxIntensity;/// API が詳細未取得などで省略または null を返す場合がある
@JsonKey(name: 'intensity_tree') List<IntensityTree>? get intensityTree;@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? get maxLpgmIntensity;@JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree') List<LpgmIntensityTree>? get lpgmIntensityTree;
/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCopyWith<Intensity> get copyWith => _$IntensityCopyWithImpl<Intensity>(this as Intensity, _$identity);

  /// Serializes this Intensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Intensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other.intensityTree, intensityTree)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other.lpgmIntensityTree, lpgmIntensityTree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,const DeepCollectionEquality().hash(intensityTree),maxLpgmIntensity,const DeepCollectionEquality().hash(lpgmIntensityTree));

@override
String toString() {
  return 'Intensity(maxIntensity: $maxIntensity, intensityTree: $intensityTree, maxLpgmIntensity: $maxLpgmIntensity, lpgmIntensityTree: $lpgmIntensityTree)';
}


}

/// @nodoc
abstract mixin class $IntensityCopyWith<$Res>  {
  factory $IntensityCopyWith(Intensity value, $Res Function(Intensity) _then) = _$IntensityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'max_intensity') JmaIntensity maxIntensity,@JsonKey(name: 'intensity_tree') List<IntensityTree>? intensityTree,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity,@JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree') List<LpgmIntensityTree>? lpgmIntensityTree
});




}
/// @nodoc
class _$IntensityCopyWithImpl<$Res>
    implements $IntensityCopyWith<$Res> {
  _$IntensityCopyWithImpl(this._self, this._then);

  final Intensity _self;
  final $Res Function(Intensity) _then;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxIntensity = null,Object? intensityTree = freezed,Object? maxLpgmIntensity = freezed,Object? lpgmIntensityTree = freezed,}) {
  return _then(_self.copyWith(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,intensityTree: freezed == intensityTree ? _self.intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as List<IntensityTree>?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,lpgmIntensityTree: freezed == lpgmIntensityTree ? _self.lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as List<LpgmIntensityTree>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Intensity].
extension IntensityPatterns on Intensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Intensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Intensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Intensity value)  $default,){
final _that = this;
switch (_that) {
case _Intensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Intensity value)?  $default,){
final _that = this;
switch (_that) {
case _Intensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity, @JsonKey(name: 'intensity_tree')  List<IntensityTree>? intensityTree, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity, @JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree')  List<LpgmIntensityTree>? lpgmIntensityTree)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Intensity() when $default != null:
return $default(_that.maxIntensity,_that.intensityTree,_that.maxLpgmIntensity,_that.lpgmIntensityTree);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity, @JsonKey(name: 'intensity_tree')  List<IntensityTree>? intensityTree, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity, @JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree')  List<LpgmIntensityTree>? lpgmIntensityTree)  $default,) {final _that = this;
switch (_that) {
case _Intensity():
return $default(_that.maxIntensity,_that.intensityTree,_that.maxLpgmIntensity,_that.lpgmIntensityTree);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'max_intensity')  JmaIntensity maxIntensity, @JsonKey(name: 'intensity_tree')  List<IntensityTree>? intensityTree, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  JmaLpgmIntensity? maxLpgmIntensity, @JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree')  List<LpgmIntensityTree>? lpgmIntensityTree)?  $default,) {final _that = this;
switch (_that) {
case _Intensity() when $default != null:
return $default(_that.maxIntensity,_that.intensityTree,_that.maxLpgmIntensity,_that.lpgmIntensityTree);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Intensity implements Intensity {
  const _Intensity({@JsonKey(name: 'max_intensity') required this.maxIntensity, @JsonKey(name: 'intensity_tree') final  List<IntensityTree>? intensityTree, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') this.maxLpgmIntensity, @JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree') final  List<LpgmIntensityTree>? lpgmIntensityTree}): _intensityTree = intensityTree,_lpgmIntensityTree = lpgmIntensityTree;
  factory _Intensity.fromJson(Map<String, dynamic> json) => _$IntensityFromJson(json);

@override@JsonKey(name: 'max_intensity') final  JmaIntensity maxIntensity;
/// API が詳細未取得などで省略または null を返す場合がある
 final  List<IntensityTree>? _intensityTree;
/// API が詳細未取得などで省略または null を返す場合がある
@override@JsonKey(name: 'intensity_tree') List<IntensityTree>? get intensityTree {
  final value = _intensityTree;
  if (value == null) return null;
  if (_intensityTree is EqualUnmodifiableListView) return _intensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') final  JmaLpgmIntensity? maxLpgmIntensity;
 final  List<LpgmIntensityTree>? _lpgmIntensityTree;
@override@JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree') List<LpgmIntensityTree>? get lpgmIntensityTree {
  final value = _lpgmIntensityTree;
  if (value == null) return null;
  if (_lpgmIntensityTree is EqualUnmodifiableListView) return _lpgmIntensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCopyWith<_Intensity> get copyWith => __$IntensityCopyWithImpl<_Intensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Intensity&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._intensityTree, _intensityTree)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._lpgmIntensityTree, _lpgmIntensityTree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxIntensity,const DeepCollectionEquality().hash(_intensityTree),maxLpgmIntensity,const DeepCollectionEquality().hash(_lpgmIntensityTree));

@override
String toString() {
  return 'Intensity(maxIntensity: $maxIntensity, intensityTree: $intensityTree, maxLpgmIntensity: $maxLpgmIntensity, lpgmIntensityTree: $lpgmIntensityTree)';
}


}

/// @nodoc
abstract mixin class _$IntensityCopyWith<$Res> implements $IntensityCopyWith<$Res> {
  factory _$IntensityCopyWith(_Intensity value, $Res Function(_Intensity) _then) = __$IntensityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'max_intensity') JmaIntensity maxIntensity,@JsonKey(name: 'intensity_tree') List<IntensityTree>? intensityTree,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity,@JsonKey(includeIfNull: false, name: 'lpgm_intensity_tree') List<LpgmIntensityTree>? lpgmIntensityTree
});




}
/// @nodoc
class __$IntensityCopyWithImpl<$Res>
    implements _$IntensityCopyWith<$Res> {
  __$IntensityCopyWithImpl(this._self, this._then);

  final _Intensity _self;
  final $Res Function(_Intensity) _then;

/// Create a copy of Intensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxIntensity = null,Object? intensityTree = freezed,Object? maxLpgmIntensity = freezed,Object? lpgmIntensityTree = freezed,}) {
  return _then(_Intensity(
maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,intensityTree: freezed == intensityTree ? _self._intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as List<IntensityTree>?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity?,lpgmIntensityTree: freezed == lpgmIntensityTree ? _self._lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as List<LpgmIntensityTree>?,
  ));
}


}

// dart format on
