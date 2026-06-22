// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_station_observation_max_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiStationObservationMaxHeight {

/// 津波の最大波を観測した日時
@JsonKey(includeIfNull: false, name: 'date_time') DateTime? get dateTime;@JsonKey(includeIfNull: false) num? get value;/// 観測範囲より津波の高さが超過した場合に使用し、数値情報を補助する
@JsonKey(includeIfNull: false, name: 'is_over') dynamic get isOver;/// 数値情報に付加的情報が必要な場合に出現
@JsonKey(includeIfNull: false, name: 'is_rising') dynamic get isRising;@JsonKey(includeIfNull: false) ObservationMaxHeightCondition? get condition;/// 欠測によりデータが現在取得できていない場合に出現する
@JsonKey(includeIfNull: false, name: 'is_missing') dynamic get isMissing;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiStationObservationMaxHeightCopyWith<TsunamiStationObservationMaxHeight> get copyWith => _$TsunamiStationObservationMaxHeightCopyWithImpl<TsunamiStationObservationMaxHeight>(this as TsunamiStationObservationMaxHeight, _$identity);

  /// Serializes this TsunamiStationObservationMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiStationObservationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.isOver, isOver)&&const DeepCollectionEquality().equals(other.isRising, isRising)&&(identical(other.condition, condition) || other.condition == condition)&&const DeepCollectionEquality().equals(other.isMissing, isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,value,const DeepCollectionEquality().hash(isOver),const DeepCollectionEquality().hash(isRising),condition,const DeepCollectionEquality().hash(isMissing),revise);

@override
String toString() {
  return 'TsunamiStationObservationMaxHeight(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $TsunamiStationObservationMaxHeightCopyWith<$Res>  {
  factory $TsunamiStationObservationMaxHeightCopyWith(TsunamiStationObservationMaxHeight value, $Res Function(TsunamiStationObservationMaxHeight) _then) = _$TsunamiStationObservationMaxHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'date_time') DateTime? dateTime,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false, name: 'is_over') dynamic isOver,@JsonKey(includeIfNull: false, name: 'is_rising') dynamic isRising,@JsonKey(includeIfNull: false) ObservationMaxHeightCondition? condition,@JsonKey(includeIfNull: false, name: 'is_missing') dynamic isMissing,@JsonKey(includeIfNull: false) Revise? revise
});


$ObservationMaxHeightConditionCopyWith<$Res>? get condition;$ReviseCopyWith<$Res>? get revise;

}
/// @nodoc
class _$TsunamiStationObservationMaxHeightCopyWithImpl<$Res>
    implements $TsunamiStationObservationMaxHeightCopyWith<$Res> {
  _$TsunamiStationObservationMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiStationObservationMaxHeight _self;
  final $Res Function(TsunamiStationObservationMaxHeight) _then;

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as dynamic,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as dynamic,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as dynamic,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}
/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationMaxHeightConditionCopyWith<$Res>? get condition {
    if (_self.condition == null) {
    return null;
  }

  return $ObservationMaxHeightConditionCopyWith<$Res>(_self.condition!, (value) {
    return _then(_self.copyWith(condition: value));
  });
}/// Create a copy of TsunamiStationObservationMaxHeight
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


/// Adds pattern-matching-related methods to [TsunamiStationObservationMaxHeight].
extension TsunamiStationObservationMaxHeightPatterns on TsunamiStationObservationMaxHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiStationObservationMaxHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiStationObservationMaxHeight value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiStationObservationMaxHeight value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'date_time')  DateTime? dateTime, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  dynamic isOver, @JsonKey(includeIfNull: false, name: 'is_rising')  dynamic isRising, @JsonKey(includeIfNull: false)  ObservationMaxHeightCondition? condition, @JsonKey(includeIfNull: false, name: 'is_missing')  dynamic isMissing, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'date_time')  DateTime? dateTime, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  dynamic isOver, @JsonKey(includeIfNull: false, name: 'is_rising')  dynamic isRising, @JsonKey(includeIfNull: false)  ObservationMaxHeightCondition? condition, @JsonKey(includeIfNull: false, name: 'is_missing')  dynamic isMissing, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight():
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'date_time')  DateTime? dateTime, @JsonKey(includeIfNull: false)  num? value, @JsonKey(includeIfNull: false, name: 'is_over')  dynamic isOver, @JsonKey(includeIfNull: false, name: 'is_rising')  dynamic isRising, @JsonKey(includeIfNull: false)  ObservationMaxHeightCondition? condition, @JsonKey(includeIfNull: false, name: 'is_missing')  dynamic isMissing, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiStationObservationMaxHeight() when $default != null:
return $default(_that.dateTime,_that.value,_that.isOver,_that.isRising,_that.condition,_that.isMissing,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiStationObservationMaxHeight implements TsunamiStationObservationMaxHeight {
  const _TsunamiStationObservationMaxHeight({@JsonKey(includeIfNull: false, name: 'date_time') this.dateTime, @JsonKey(includeIfNull: false) this.value, @JsonKey(includeIfNull: false, name: 'is_over') this.isOver, @JsonKey(includeIfNull: false, name: 'is_rising') this.isRising, @JsonKey(includeIfNull: false) this.condition, @JsonKey(includeIfNull: false, name: 'is_missing') this.isMissing, @JsonKey(includeIfNull: false) this.revise});
  factory _TsunamiStationObservationMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiStationObservationMaxHeightFromJson(json);

/// 津波の最大波を観測した日時
@override@JsonKey(includeIfNull: false, name: 'date_time') final  DateTime? dateTime;
@override@JsonKey(includeIfNull: false) final  num? value;
/// 観測範囲より津波の高さが超過した場合に使用し、数値情報を補助する
@override@JsonKey(includeIfNull: false, name: 'is_over') final  dynamic isOver;
/// 数値情報に付加的情報が必要な場合に出現
@override@JsonKey(includeIfNull: false, name: 'is_rising') final  dynamic isRising;
@override@JsonKey(includeIfNull: false) final  ObservationMaxHeightCondition? condition;
/// 欠測によりデータが現在取得できていない場合に出現する
@override@JsonKey(includeIfNull: false, name: 'is_missing') final  dynamic isMissing;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiStationObservationMaxHeightCopyWith<_TsunamiStationObservationMaxHeight> get copyWith => __$TsunamiStationObservationMaxHeightCopyWithImpl<_TsunamiStationObservationMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiStationObservationMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiStationObservationMaxHeight&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.isOver, isOver)&&const DeepCollectionEquality().equals(other.isRising, isRising)&&(identical(other.condition, condition) || other.condition == condition)&&const DeepCollectionEquality().equals(other.isMissing, isMissing)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,value,const DeepCollectionEquality().hash(isOver),const DeepCollectionEquality().hash(isRising),condition,const DeepCollectionEquality().hash(isMissing),revise);

@override
String toString() {
  return 'TsunamiStationObservationMaxHeight(dateTime: $dateTime, value: $value, isOver: $isOver, isRising: $isRising, condition: $condition, isMissing: $isMissing, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$TsunamiStationObservationMaxHeightCopyWith<$Res> implements $TsunamiStationObservationMaxHeightCopyWith<$Res> {
  factory _$TsunamiStationObservationMaxHeightCopyWith(_TsunamiStationObservationMaxHeight value, $Res Function(_TsunamiStationObservationMaxHeight) _then) = __$TsunamiStationObservationMaxHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'date_time') DateTime? dateTime,@JsonKey(includeIfNull: false) num? value,@JsonKey(includeIfNull: false, name: 'is_over') dynamic isOver,@JsonKey(includeIfNull: false, name: 'is_rising') dynamic isRising,@JsonKey(includeIfNull: false) ObservationMaxHeightCondition? condition,@JsonKey(includeIfNull: false, name: 'is_missing') dynamic isMissing,@JsonKey(includeIfNull: false) Revise? revise
});


@override $ObservationMaxHeightConditionCopyWith<$Res>? get condition;@override $ReviseCopyWith<$Res>? get revise;

}
/// @nodoc
class __$TsunamiStationObservationMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiStationObservationMaxHeightCopyWith<$Res> {
  __$TsunamiStationObservationMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiStationObservationMaxHeight _self;
  final $Res Function(_TsunamiStationObservationMaxHeight) _then;

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = freezed,Object? value = freezed,Object? isOver = freezed,Object? isRising = freezed,Object? condition = freezed,Object? isMissing = freezed,Object? revise = freezed,}) {
  return _then(_TsunamiStationObservationMaxHeight(
dateTime: freezed == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as num?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as dynamic,isRising: freezed == isRising ? _self.isRising : isRising // ignore: cast_nullable_to_non_nullable
as dynamic,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as ObservationMaxHeightCondition?,isMissing: freezed == isMissing ? _self.isMissing : isMissing // ignore: cast_nullable_to_non_nullable
as dynamic,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

/// Create a copy of TsunamiStationObservationMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ObservationMaxHeightConditionCopyWith<$Res>? get condition {
    if (_self.condition == null) {
    return null;
  }

  return $ObservationMaxHeightConditionCopyWith<$Res>(_self.condition!, (value) {
    return _then(_self.copyWith(condition: value));
  });
}/// Create a copy of TsunamiStationObservationMaxHeight
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
