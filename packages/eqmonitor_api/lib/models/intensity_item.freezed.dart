// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityItem {

 CodeName get value;@JsonKey(includeIfNull: false, name: 'max_intensity') Intensity? get maxIntensity;@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') LpgmIntensity? get maxLpgmIntensity;
/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityItemCopyWith<IntensityItem> get copyWith => _$IntensityItemCopyWithImpl<IntensityItem>(this as IntensityItem, _$identity);

  /// Serializes this IntensityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityItem(value: $value, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityItemCopyWith<$Res>  {
  factory $IntensityItemCopyWith(IntensityItem value, $Res Function(IntensityItem) _then) = _$IntensityItemCopyWithImpl;
@useResult
$Res call({
 CodeName value,@JsonKey(includeIfNull: false, name: 'max_intensity') Intensity? maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') LpgmIntensity? maxLpgmIntensity
});


$CodeNameCopyWith<$Res> get value;$IntensityCopyWith<$Res>? get maxIntensity;

}
/// @nodoc
class _$IntensityItemCopyWithImpl<$Res>
    implements $IntensityItemCopyWith<$Res> {
  _$IntensityItemCopyWithImpl(this._self, this._then);

  final IntensityItem _self;
  final $Res Function(IntensityItem) _then;

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as Intensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensity?,
  ));
}
/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get maxIntensity {
    if (_self.maxIntensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.maxIntensity!, (value) {
    return _then(_self.copyWith(maxIntensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityItem].
extension IntensityItemPatterns on IntensityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value, @JsonKey(includeIfNull: false, name: 'max_intensity')  Intensity? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  LpgmIntensity? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value, @JsonKey(includeIfNull: false, name: 'max_intensity')  Intensity? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  LpgmIntensity? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityItem():
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value, @JsonKey(includeIfNull: false, name: 'max_intensity')  Intensity? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  LpgmIntensity? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityItem() when $default != null:
return $default(_that.value,_that.maxIntensity,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityItem implements IntensityItem {
  const _IntensityItem({required this.value, @JsonKey(includeIfNull: false, name: 'max_intensity') this.maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') this.maxLpgmIntensity});
  factory _IntensityItem.fromJson(Map<String, dynamic> json) => _$IntensityItemFromJson(json);

@override final  CodeName value;
@override@JsonKey(includeIfNull: false, name: 'max_intensity') final  Intensity? maxIntensity;
@override@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') final  LpgmIntensity? maxLpgmIntensity;

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityItemCopyWith<_IntensityItem> get copyWith => __$IntensityItemCopyWithImpl<_IntensityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'IntensityItem(value: $value, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityItemCopyWith<$Res> implements $IntensityItemCopyWith<$Res> {
  factory _$IntensityItemCopyWith(_IntensityItem value, $Res Function(_IntensityItem) _then) = __$IntensityItemCopyWithImpl;
@override @useResult
$Res call({
 CodeName value,@JsonKey(includeIfNull: false, name: 'max_intensity') Intensity? maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') LpgmIntensity? maxLpgmIntensity
});


@override $CodeNameCopyWith<$Res> get value;@override $IntensityCopyWith<$Res>? get maxIntensity;

}
/// @nodoc
class __$IntensityItemCopyWithImpl<$Res>
    implements _$IntensityItemCopyWith<$Res> {
  __$IntensityItemCopyWithImpl(this._self, this._then);

  final _IntensityItem _self;
  final $Res Function(_IntensityItem) _then;

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_IntensityItem(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as Intensity?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensity?,
  ));
}

/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of IntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityCopyWith<$Res>? get maxIntensity {
    if (_self.maxIntensity == null) {
    return null;
  }

  return $IntensityCopyWith<$Res>(_self.maxIntensity!, (value) {
    return _then(_self.copyWith(maxIntensity: value));
  });
}
}

// dart format on
