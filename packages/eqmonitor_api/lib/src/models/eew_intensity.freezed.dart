// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewIntensity {

 List<EewIntensityItem> get regions;@JsonKey(includeIfNull: false, name: 'max_intensity') EewIntensityValue? get maxIntensity;@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') EewIntensityLpgmValue? get maxLpgmIntensity;
/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityCopyWith<EewIntensity> get copyWith => _$EewIntensityCopyWithImpl<EewIntensity>(this as EewIntensity, _$identity);

  /// Serializes this EewIntensity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensity&&const DeepCollectionEquality().equals(other.regions, regions)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(regions),maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'EewIntensity(regions: $regions, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $EewIntensityCopyWith<$Res>  {
  factory $EewIntensityCopyWith(EewIntensity value, $Res Function(EewIntensity) _then) = _$EewIntensityCopyWithImpl;
@useResult
$Res call({
 List<EewIntensityItem> regions,@JsonKey(includeIfNull: false, name: 'max_intensity') EewIntensityValue? maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') EewIntensityLpgmValue? maxLpgmIntensity
});


$EewIntensityValueCopyWith<$Res>? get maxIntensity;$EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity;

}
/// @nodoc
class _$EewIntensityCopyWithImpl<$Res>
    implements $EewIntensityCopyWith<$Res> {
  _$EewIntensityCopyWithImpl(this._self, this._then);

  final EewIntensity _self;
  final $Res Function(EewIntensity) _then;

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? regions = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(EewIntensity(
regions: null == regions ? _self.regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewIntensityItem>,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,
  ));
}
/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res>? get maxIntensity {
    if (_self.maxIntensity == null) {
    return null;
  }

  return $EewIntensityValueCopyWith<$Res>(_self.maxIntensity!, (value) {
    return _then(_self.copyWith(maxIntensity: value));
  });
}/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity {
    if (_self.maxLpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.maxLpgmIntensity!, (value) {
    return _then(_self.copyWith(maxLpgmIntensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewIntensity].
extension EewIntensityPatterns on EewIntensity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensity value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensity value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EewIntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_intensity')  EewIntensityValue? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  EewIntensityLpgmValue? maxLpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
return $default(_that.regions,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EewIntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_intensity')  EewIntensityValue? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  EewIntensityLpgmValue? maxLpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _EewIntensity():
return $default(_that.regions,_that.maxIntensity,_that.maxLpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EewIntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_intensity')  EewIntensityValue? maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity')  EewIntensityLpgmValue? maxLpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensity() when $default != null:
return $default(_that.regions,_that.maxIntensity,_that.maxLpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensity implements EewIntensity {
  const _EewIntensity({required  List<EewIntensityItem> regions, @JsonKey(includeIfNull: false, name: 'max_intensity') this.maxIntensity, @JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') this.maxLpgmIntensity}): _regions = regions;
  factory _EewIntensity.fromJson(Map<String, dynamic> json) => _$EewIntensityFromJson(json);

 final  List<EewIntensityItem> _regions;
@override List<EewIntensityItem> get regions {
  if (_regions is EqualUnmodifiableListView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_regions);
}

@override@JsonKey(includeIfNull: false, name: 'max_intensity') final  EewIntensityValue? maxIntensity;
@override@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') final  EewIntensityLpgmValue? maxLpgmIntensity;

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityCopyWith<_EewIntensity> get copyWith => __$EewIntensityCopyWithImpl<_EewIntensity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensity&&const DeepCollectionEquality().equals(other._regions, _regions)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_regions),maxIntensity,maxLpgmIntensity);

@override
String toString() {
  return 'EewIntensity(regions: $regions, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityCopyWith<$Res> implements $EewIntensityCopyWith<$Res> {
  factory _$EewIntensityCopyWith(_EewIntensity value, $Res Function(_EewIntensity) _then) = __$EewIntensityCopyWithImpl;
@override @useResult
$Res call({
 List<EewIntensityItem> regions,@JsonKey(includeIfNull: false, name: 'max_intensity') EewIntensityValue? maxIntensity,@JsonKey(includeIfNull: false, name: 'max_lpgm_intensity') EewIntensityLpgmValue? maxLpgmIntensity
});


@override $EewIntensityValueCopyWith<$Res>? get maxIntensity;@override $EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity;

}
/// @nodoc
class __$EewIntensityCopyWithImpl<$Res>
    implements _$EewIntensityCopyWith<$Res> {
  __$EewIntensityCopyWithImpl(this._self, this._then);

  final _EewIntensity _self;
  final $Res Function(_EewIntensity) _then;

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? regions = null,Object? maxIntensity = freezed,Object? maxLpgmIntensity = freezed,}) {
  return _then(_EewIntensity(
regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as List<EewIntensityItem>,maxIntensity: freezed == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue?,maxLpgmIntensity: freezed == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,
  ));
}

/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res>? get maxIntensity {
    if (_self.maxIntensity == null) {
    return null;
  }

  return $EewIntensityValueCopyWith<$Res>(_self.maxIntensity!, (value) {
    return _then(_self.copyWith(maxIntensity: value));
  });
}/// Create a copy of EewIntensity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get maxLpgmIntensity {
    if (_self.maxLpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.maxLpgmIntensity!, (value) {
    return _then(_self.copyWith(maxLpgmIntensity: value));
  });
}
}

// dart format on
