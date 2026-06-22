// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'first_height2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FirstHeight2 {

/// まだ津波が到達していない場合、到達していないと推測される場合に出現する
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;@JsonKey(includeIfNull: false) FirstHeightCondition? get condition;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of FirstHeight2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirstHeight2CopyWith<FirstHeight2> get copyWith => _$FirstHeight2CopyWithImpl<FirstHeight2>(this as FirstHeight2, _$identity);

  /// Serializes this FirstHeight2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirstHeight2&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition,revise);

@override
String toString() {
  return 'FirstHeight2(arrivalTime: $arrivalTime, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $FirstHeight2CopyWith<$Res>  {
  factory $FirstHeight2CopyWith(FirstHeight2 value, $Res Function(FirstHeight2) _then) = _$FirstHeight2CopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) FirstHeightCondition? condition,@JsonKey(includeIfNull: false) Revise? revise
});


$FirstHeightConditionCopyWith<$Res>? get condition;$ReviseCopyWith<$Res>? get revise;

}
/// @nodoc
class _$FirstHeight2CopyWithImpl<$Res>
    implements $FirstHeight2CopyWith<$Res> {
  _$FirstHeight2CopyWithImpl(this._self, this._then);

  final FirstHeight2 _self;
  final $Res Function(FirstHeight2) _then;

/// Create a copy of FirstHeight2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}
/// Create a copy of FirstHeight2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FirstHeightConditionCopyWith<$Res>? get condition {
    if (_self.condition == null) {
    return null;
  }

  return $FirstHeightConditionCopyWith<$Res>(_self.condition!, (value) {
    return _then(_self.copyWith(condition: value));
  });
}/// Create a copy of FirstHeight2
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


/// Adds pattern-matching-related methods to [FirstHeight2].
extension FirstHeight2Patterns on FirstHeight2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirstHeight2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirstHeight2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirstHeight2 value)  $default,){
final _that = this;
switch (_that) {
case _FirstHeight2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirstHeight2 value)?  $default,){
final _that = this;
switch (_that) {
case _FirstHeight2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  FirstHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirstHeight2() when $default != null:
return $default(_that.arrivalTime,_that.condition,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  FirstHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _FirstHeight2():
return $default(_that.arrivalTime,_that.condition,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false)  FirstHeightCondition? condition, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _FirstHeight2() when $default != null:
return $default(_that.arrivalTime,_that.condition,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FirstHeight2 implements FirstHeight2 {
  const _FirstHeight2({@JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false) this.condition, @JsonKey(includeIfNull: false) this.revise});
  factory _FirstHeight2.fromJson(Map<String, dynamic> json) => _$FirstHeight2FromJson(json);

/// まだ津波が到達していない場合、到達していないと推測される場合に出現する
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
@override@JsonKey(includeIfNull: false) final  FirstHeightCondition? condition;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of FirstHeight2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirstHeight2CopyWith<_FirstHeight2> get copyWith => __$FirstHeight2CopyWithImpl<_FirstHeight2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FirstHeight2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirstHeight2&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition,revise);

@override
String toString() {
  return 'FirstHeight2(arrivalTime: $arrivalTime, condition: $condition, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$FirstHeight2CopyWith<$Res> implements $FirstHeight2CopyWith<$Res> {
  factory _$FirstHeight2CopyWith(_FirstHeight2 value, $Res Function(_FirstHeight2) _then) = __$FirstHeight2CopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false) FirstHeightCondition? condition,@JsonKey(includeIfNull: false) Revise? revise
});


@override $FirstHeightConditionCopyWith<$Res>? get condition;@override $ReviseCopyWith<$Res>? get revise;

}
/// @nodoc
class __$FirstHeight2CopyWithImpl<$Res>
    implements _$FirstHeight2CopyWith<$Res> {
  __$FirstHeight2CopyWithImpl(this._self, this._then);

  final _FirstHeight2 _self;
  final $Res Function(_FirstHeight2) _then;

/// Create a copy of FirstHeight2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? condition = freezed,Object? revise = freezed,}) {
  return _then(_FirstHeight2(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as FirstHeightCondition?,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

/// Create a copy of FirstHeight2
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FirstHeightConditionCopyWith<$Res>? get condition {
    if (_self.condition == null) {
    return null;
  }

  return $FirstHeightConditionCopyWith<$Res>(_self.condition!, (value) {
    return _then(_self.copyWith(condition: value));
  });
}/// Create a copy of FirstHeight2
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
