// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_region_forecast_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiRegionForecastMaxHeight {

/// 津波の予想される高さ 定性的表現をする場合は出現しない
@JsonKey(includeIfNull: false) num? get value;/// 10m超となるときに出現 数値情報より大きいことを示す場合に出現
@JsonKey(includeIfNull: false, name: 'is_over') dynamic get isOver;@JsonKey(includeIfNull: false) QualitativeHeight? get qualitative;@JsonKey(includeIfNull: false, name: 'is_important') dynamic get isImportant;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiRegionForecastMaxHeightCopyWith<TsunamiRegionForecastMaxHeight> get copyWith => _$TsunamiRegionForecastMaxHeightCopyWithImpl<TsunamiRegionForecastMaxHeight>(this as TsunamiRegionForecastMaxHeight, _$identity);

  /// Serializes this TsunamiRegionForecastMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiRegionForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.isOver, isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&const DeepCollectionEquality().equals(other.isImportant, isImportant)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,const DeepCollectionEquality().hash(isOver),qualitative,const DeepCollectionEquality().hash(isImportant),revise);

@override
String toString() {
  return 'TsunamiRegionForecastMaxHeight(value: $value, isOver: $isOver, qualitative: $qualitative, isImportant: $isImportant, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiRegionForecastMaxHeightCopyWith<$Res>  {
  factory $TsunamiRegionForecastMaxHeightCopyWith(TsunamiRegionForecastMaxHeight value, $Res Function(TsunamiRegionForecastMaxHeight) _then) = _$TsunamiRegionForecastMaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false, name: 'is_over') dynamic isOver,@JsonKey(includeIfNull: false) QualitativeHeight? qualitative,@JsonKey(includeIfNull: false, name: 'is_important') dynamic isImportant,@JsonKey(includeIfNull: false) Revise? revise
});


$QualitativeHeightCopyWith<$Res>? get qualitative;$ReviseCopyWith<$Res>? get revise;

}
/// @nodoc
class _$TsunamiRegionForecastMaxHeightCopyWithImpl<$Res>
    implements $TsunamiRegionForecastMaxHeightCopyWith<$Res> {
  _$TsunamiRegionForecastMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiRegionForecastMaxHeight _self;
  final $Res Function(TsunamiRegionForecastMaxHeight) _then;

/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isImportant = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as dynamic,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isImportant: freezed == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as dynamic,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}
/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QualitativeHeightCopyWith<$Res>? get qualitative {
    if (_self.qualitative == null) {
    return null;
  }

  return $QualitativeHeightCopyWith<$Res>(_self.qualitative!, (value) {
    return _then(_self.copyWith(qualitative: value));
  });
}/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviseCopyWith<$Res>? get revise {
    if (_self.revise == null) {
    return null;
  }

  return $ReviseCopyWith<$Res>(_self.revise!, (value) {
    return _then(_self.copyWith(revise: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiRegionForecastMaxHeight].
extension TsunamiRegionForecastMaxHeightPatterns on TsunamiRegionForecastMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiRegionForecastMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiRegionForecastMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiRegionForecastMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionForecastMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiRegionForecastMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiRegionForecastMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  dynamic isOver, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false, name: 'is_important')  dynamic isImportant, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiRegionForecastMaxHeight() when $default != null:
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  dynamic isOver, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false, name: 'is_important')  dynamic isImportant, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionForecastMaxHeight():
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  dynamic isOver, @JsonKey(includeIfNull: false)  QualitativeHeight? qualitative, @JsonKey(includeIfNull: false, name: 'is_important')  dynamic isImportant, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiRegionForecastMaxHeight() when $default != null:
return $default(_that.value,_that.isOver,_that.qualitative,_that.isImportant,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiRegionForecastMaxHeight implements TsunamiRegionForecastMaxHeight {
  const _TsunamiRegionForecastMaxHeight({@JsonKey(includeIfNull: false) this.value, @JsonKey(includeIfNull: false, name: 'is_over') this.isOver, @JsonKey(includeIfNull: false) this.qualitative, @JsonKey(includeIfNull: false, name: 'is_important') this.isImportant, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiRegionForecastMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiRegionForecastMaxHeightFromJson(json);

/// 津波の予想される高さ 定性的表現をする場合は出現しない
@override@JsonKey(includeIfNull: false) final  num? value;
/// 10m超となるときに出現 数値情報より大きいことを示す場合に出現
@override@JsonKey(includeIfNull: false, name: 'is_over') final  dynamic isOver;
@override@JsonKey(includeIfNull: false) final  QualitativeHeight? qualitative;
@override@JsonKey(includeIfNull: false, name: 'is_important') final  dynamic isImportant;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiRegionForecastMaxHeightCopyWith<_TsunamiRegionForecastMaxHeight> get copyWith => __$TsunamiRegionForecastMaxHeightCopyWithImpl<_TsunamiRegionForecastMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiRegionForecastMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiRegionForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.isOver, isOver)&&(identical(other.qualitative, qualitative) || other.qualitative == qualitative)&&const DeepCollectionEquality().equals(other.isImportant, isImportant)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,const DeepCollectionEquality().hash(isOver),qualitative,const DeepCollectionEquality().hash(isImportant),revise);

@override
String toString() {
  return 'TsunamiRegionForecastMaxHeight(value: $value, isOver: $isOver, qualitative: $qualitative, isImportant: $isImportant, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiRegionForecastMaxHeightCopyWith<$Res> implements $TsunamiRegionForecastMaxHeightCopyWith<$Res> {
  factory _$TsunamiRegionForecastMaxHeightCopyWith(_TsunamiRegionForecastMaxHeight value, $Res Function(_TsunamiRegionForecastMaxHeight) _then) = __$TsunamiRegionForecastMaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false, name: 'is_over') dynamic isOver,@JsonKey(includeIfNull: false) QualitativeHeight? qualitative,@JsonKey(includeIfNull: false, name: 'is_important') dynamic isImportant,@JsonKey(includeIfNull: false) Revise? revise
});


@override $QualitativeHeightCopyWith<$Res>? get qualitative;@override $ReviseCopyWith<$Res>? get revise;

}
/// @nodoc
class __$TsunamiRegionForecastMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiRegionForecastMaxHeightCopyWith<$Res> {
  __$TsunamiRegionForecastMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiRegionForecastMaxHeight _self;
  final $Res Function(_TsunamiRegionForecastMaxHeight) _then;

/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? isOver = freezed,Object? qualitative = freezed,Object? isImportant = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiRegionForecastMaxHeight(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as dynamic,qualitative: freezed == qualitative ? _self.qualitative : qualitative // ignore: cast_nullable_to_non_nullable
as QualitativeHeight?,isImportant: freezed == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as dynamic,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QualitativeHeightCopyWith<$Res>? get qualitative {
    if (_self.qualitative == null) {
    return null;
  }

  return $QualitativeHeightCopyWith<$Res>(_self.qualitative!, (value) {
    return _then(_self.copyWith(qualitative: value));
  });
}/// Create a copy of TsunamiRegionForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviseCopyWith<$Res>? get revise {
    if (_self.revise == null) {
    return null;
  }

  return $ReviseCopyWith<$Res>(_self.revise!, (value) {
    return _then(_self.copyWith(revise: value));
  });
}
}

// dart format on
