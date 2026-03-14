// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_intensity_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewIntensityItem {

 CodeName get value;@JsonKey(name: 'is_plum') bool get isPlum;@JsonKey(name: 'is_warning') bool get isWarning; EewIntensityValue get intensity;@JsonKey(name: 'arrival_time') EewIntensityItemArrivalTimeUnion get arrivalTime;@JsonKey(includeIfNull: false, name: 'lpgm_intensity') EewIntensityLpgmValue? get lpgmIntensity;
/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewIntensityItemCopyWith<EewIntensityItem> get copyWith => _$EewIntensityItemCopyWithImpl<EewIntensityItem>(this as EewIntensityItem, _$identity);

  /// Serializes this EewIntensityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewIntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isPlum,isWarning,intensity,arrivalTime,lpgmIntensity);

@override
String toString() {
  return 'EewIntensityItem(value: $value, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, arrivalTime: $arrivalTime, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $EewIntensityItemCopyWith<$Res>  {
  factory $EewIntensityItemCopyWith(EewIntensityItem value, $Res Function(EewIntensityItem) _then) = _$EewIntensityItemCopyWithImpl;
@useResult
$Res call({
 CodeName value,@JsonKey(name: 'is_plum') bool isPlum,@JsonKey(name: 'is_warning') bool isWarning, EewIntensityValue intensity,@JsonKey(name: 'arrival_time') EewIntensityItemArrivalTimeUnion arrivalTime,@JsonKey(includeIfNull: false, name: 'lpgm_intensity') EewIntensityLpgmValue? lpgmIntensity
});


$CodeNameCopyWith<$Res> get value;$EewIntensityValueCopyWith<$Res> get intensity;$EewIntensityItemArrivalTimeUnionCopyWith<$Res> get arrivalTime;$EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity;

}
/// @nodoc
class _$EewIntensityItemCopyWithImpl<$Res>
    implements $EewIntensityItemCopyWith<$Res> {
  _$EewIntensityItemCopyWithImpl(this._self, this._then);

  final EewIntensityItem _self;
  final $Res Function(EewIntensityItem) _then;

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? arrivalTime = null,Object? lpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as EewIntensityItemArrivalTimeUnion,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,
  ));
}
/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res> get intensity {
  
  return $EewIntensityValueCopyWith<$Res>(_self.intensity, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionCopyWith<$Res> get arrivalTime {
  
  return $EewIntensityItemArrivalTimeUnionCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity {
    if (_self.lpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.lpgmIntensity!, (value) {
    return _then(_self.copyWith(lpgmIntensity: value));
  });
}
}


/// Adds pattern-matching-related methods to [EewIntensityItem].
extension EewIntensityItemPatterns on EewIntensityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewIntensityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewIntensityItem value)  $default,){
final _that = this;
switch (_that) {
case _EewIntensityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewIntensityItem value)?  $default,){
final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CodeName value, @JsonKey(name: 'is_plum')  bool isPlum, @JsonKey(name: 'is_warning')  bool isWarning,  EewIntensityValue intensity, @JsonKey(name: 'arrival_time')  EewIntensityItemArrivalTimeUnion arrivalTime, @JsonKey(includeIfNull: false, name: 'lpgm_intensity')  EewIntensityLpgmValue? lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
return $default(_that.value,_that.isPlum,_that.isWarning,_that.intensity,_that.arrivalTime,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CodeName value, @JsonKey(name: 'is_plum')  bool isPlum, @JsonKey(name: 'is_warning')  bool isWarning,  EewIntensityValue intensity, @JsonKey(name: 'arrival_time')  EewIntensityItemArrivalTimeUnion arrivalTime, @JsonKey(includeIfNull: false, name: 'lpgm_intensity')  EewIntensityLpgmValue? lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _EewIntensityItem():
return $default(_that.value,_that.isPlum,_that.isWarning,_that.intensity,_that.arrivalTime,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CodeName value, @JsonKey(name: 'is_plum')  bool isPlum, @JsonKey(name: 'is_warning')  bool isWarning,  EewIntensityValue intensity, @JsonKey(name: 'arrival_time')  EewIntensityItemArrivalTimeUnion arrivalTime, @JsonKey(includeIfNull: false, name: 'lpgm_intensity')  EewIntensityLpgmValue? lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _EewIntensityItem() when $default != null:
return $default(_that.value,_that.isPlum,_that.isWarning,_that.intensity,_that.arrivalTime,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewIntensityItem implements EewIntensityItem {
  const _EewIntensityItem({required this.value, @JsonKey(name: 'is_plum') required this.isPlum, @JsonKey(name: 'is_warning') required this.isWarning, required this.intensity, @JsonKey(name: 'arrival_time') required this.arrivalTime, @JsonKey(includeIfNull: false, name: 'lpgm_intensity') this.lpgmIntensity});
  factory _EewIntensityItem.fromJson(Map<String, dynamic> json) => _$EewIntensityItemFromJson(json);

@override final  CodeName value;
@override@JsonKey(name: 'is_plum') final  bool isPlum;
@override@JsonKey(name: 'is_warning') final  bool isWarning;
@override final  EewIntensityValue intensity;
@override@JsonKey(name: 'arrival_time') final  EewIntensityItemArrivalTimeUnion arrivalTime;
@override@JsonKey(includeIfNull: false, name: 'lpgm_intensity') final  EewIntensityLpgmValue? lpgmIntensity;

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewIntensityItemCopyWith<_EewIntensityItem> get copyWith => __$EewIntensityItemCopyWithImpl<_EewIntensityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewIntensityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewIntensityItem&&(identical(other.value, value) || other.value == value)&&(identical(other.isPlum, isPlum) || other.isPlum == isPlum)&&(identical(other.isWarning, isWarning) || other.isWarning == isWarning)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isPlum,isWarning,intensity,arrivalTime,lpgmIntensity);

@override
String toString() {
  return 'EewIntensityItem(value: $value, isPlum: $isPlum, isWarning: $isWarning, intensity: $intensity, arrivalTime: $arrivalTime, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$EewIntensityItemCopyWith<$Res> implements $EewIntensityItemCopyWith<$Res> {
  factory _$EewIntensityItemCopyWith(_EewIntensityItem value, $Res Function(_EewIntensityItem) _then) = __$EewIntensityItemCopyWithImpl;
@override @useResult
$Res call({
 CodeName value,@JsonKey(name: 'is_plum') bool isPlum,@JsonKey(name: 'is_warning') bool isWarning, EewIntensityValue intensity,@JsonKey(name: 'arrival_time') EewIntensityItemArrivalTimeUnion arrivalTime,@JsonKey(includeIfNull: false, name: 'lpgm_intensity') EewIntensityLpgmValue? lpgmIntensity
});


@override $CodeNameCopyWith<$Res> get value;@override $EewIntensityValueCopyWith<$Res> get intensity;@override $EewIntensityItemArrivalTimeUnionCopyWith<$Res> get arrivalTime;@override $EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity;

}
/// @nodoc
class __$EewIntensityItemCopyWithImpl<$Res>
    implements _$EewIntensityItemCopyWith<$Res> {
  __$EewIntensityItemCopyWithImpl(this._self, this._then);

  final _EewIntensityItem _self;
  final $Res Function(_EewIntensityItem) _then;

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? isPlum = null,Object? isWarning = null,Object? intensity = null,Object? arrivalTime = null,Object? lpgmIntensity = freezed,}) {
  return _then(_EewIntensityItem(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as CodeName,isPlum: null == isPlum ? _self.isPlum : isPlum // ignore: cast_nullable_to_non_nullable
as bool,isWarning: null == isWarning ? _self.isWarning : isWarning // ignore: cast_nullable_to_non_nullable
as bool,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as EewIntensityValue,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as EewIntensityItemArrivalTimeUnion,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as EewIntensityLpgmValue?,
  ));
}

/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CodeNameCopyWith<$Res> get value {
  
  return $CodeNameCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityValueCopyWith<$Res> get intensity {
  
  return $EewIntensityValueCopyWith<$Res>(_self.intensity, (value) {
    return _then(_self.copyWith(intensity: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityItemArrivalTimeUnionCopyWith<$Res> get arrivalTime {
  
  return $EewIntensityItemArrivalTimeUnionCopyWith<$Res>(_self.arrivalTime, (value) {
    return _then(_self.copyWith(arrivalTime: value));
  });
}/// Create a copy of EewIntensityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EewIntensityLpgmValueCopyWith<$Res>? get lpgmIntensity {
    if (_self.lpgmIntensity == null) {
    return null;
  }

  return $EewIntensityLpgmValueCopyWith<$Res>(_self.lpgmIntensity!, (value) {
    return _then(_self.copyWith(lpgmIntensity: value));
  });
}
}

// dart format on
