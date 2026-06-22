// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'first_height.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FirstHeight {

/// 1観測地点以上で第1波の時刻を明瞭に観測した場合
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? get arrivalTime;/// 早いところでは既に津波到達と推定
@JsonKey(includeIfNull: false, name: 'is_already_arrived') dynamic get isAlreadyArrived;@JsonKey(includeIfNull: false) Revise? get revise;
/// Create a copy of FirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirstHeightCopyWith<FirstHeight> get copyWith => _$FirstHeightCopyWithImpl<FirstHeight>(this as FirstHeight, _$identity);

  /// Serializes this FirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&const DeepCollectionEquality().equals(other.isAlreadyArrived, isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,const DeepCollectionEquality().hash(isAlreadyArrived),revise);

@override
String toString() {
  return 'FirstHeight(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise)';
}


}

/// @nodoc
abstract mixin class $FirstHeightCopyWith<$Res>  {
  factory $FirstHeightCopyWith(FirstHeight value, $Res Function(FirstHeight) _then) = _$FirstHeightCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false, name: 'is_already_arrived') dynamic isAlreadyArrived,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class _$FirstHeightCopyWithImpl<$Res>
    implements $FirstHeightCopyWith<$Res> {
  _$FirstHeightCopyWithImpl(this._self, this._then);

  final FirstHeight _self;
  final $Res Function(FirstHeight) _then;

/// Create a copy of FirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as dynamic,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}

}


/// Adds pattern-matching-related methods to [FirstHeight].
extension FirstHeightPatterns on FirstHeight {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirstHeight value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirstHeight() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirstHeight value)  $default,){
final _that = this;
switch (_that) {
case _FirstHeight():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirstHeight value)?  $default,){
final _that = this;
switch (_that) {
case _FirstHeight() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived')  dynamic isAlreadyArrived, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived')  dynamic isAlreadyArrived, @JsonKey(includeIfNull: false)  Revise? revise)  $default,) {final _that = this;
switch (_that) {
case _FirstHeight():
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false, name: 'arrival_time')  DateTime? arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived')  dynamic isAlreadyArrived, @JsonKey(includeIfNull: false)  Revise? revise)?  $default,) {final _that = this;
switch (_that) {
case _FirstHeight() when $default != null:
return $default(_that.arrivalTime,_that.isAlreadyArrived,_that.revise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FirstHeight implements FirstHeight {
  const _FirstHeight({@JsonKey(includeIfNull: false, name: 'arrival_time') this.arrivalTime, @JsonKey(includeIfNull: false, name: 'is_already_arrived') this.isAlreadyArrived, @JsonKey(includeIfNull: false) this.revise});
  factory _FirstHeight.fromJson(Map<String, dynamic> json) => _$FirstHeightFromJson(json);

/// 1観測地点以上で第1波の時刻を明瞭に観測した場合
@override@JsonKey(includeIfNull: false, name: 'arrival_time') final  DateTime? arrivalTime;
/// 早いところでは既に津波到達と推定
@override@JsonKey(includeIfNull: false, name: 'is_already_arrived') final  dynamic isAlreadyArrived;
@override@JsonKey(includeIfNull: false) final  Revise? revise;

/// Create a copy of FirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirstHeightCopyWith<_FirstHeight> get copyWith => __$FirstHeightCopyWithImpl<_FirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&const DeepCollectionEquality().equals(other.isAlreadyArrived, isAlreadyArrived)&&(identical(other.revise, revise) || other.revise == revise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,const DeepCollectionEquality().hash(isAlreadyArrived),revise);

@override
String toString() {
  return 'FirstHeight(arrivalTime: $arrivalTime, isAlreadyArrived: $isAlreadyArrived, revise: $revise)';
}


}

/// @nodoc
abstract mixin class _$FirstHeightCopyWith<$Res> implements $FirstHeightCopyWith<$Res> {
  factory _$FirstHeightCopyWith(_FirstHeight value, $Res Function(_FirstHeight) _then) = __$FirstHeightCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false, name: 'arrival_time') DateTime? arrivalTime,@JsonKey(includeIfNull: false, name: 'is_already_arrived') dynamic isAlreadyArrived,@JsonKey(includeIfNull: false) Revise? revise
});




}
/// @nodoc
class __$FirstHeightCopyWithImpl<$Res>
    implements _$FirstHeightCopyWith<$Res> {
  __$FirstHeightCopyWithImpl(this._self, this._then);

  final _FirstHeight _self;
  final $Res Function(_FirstHeight) _then;

/// Create a copy of FirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? isAlreadyArrived = freezed,Object? revise = freezed,}) {
  return _then(_FirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isAlreadyArrived: freezed == isAlreadyArrived ? _self.isAlreadyArrived : isAlreadyArrived // ignore: cast_nullable_to_non_nullable
as dynamic,revise: freezed == revise ? _self.revise : revise // ignore: cast_nullable_to_non_nullable
as Revise?,
  ));
}


}

// dart format on
