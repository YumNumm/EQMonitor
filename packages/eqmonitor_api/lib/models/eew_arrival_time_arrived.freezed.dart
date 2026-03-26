// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_arrival_time_arrived.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewArrivalTimeArrived {

 dynamic get type;
/// Create a copy of EewArrivalTimeArrived
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewArrivalTimeArrivedCopyWith<EewArrivalTimeArrived> get copyWith => _$EewArrivalTimeArrivedCopyWithImpl<EewArrivalTimeArrived>(this as EewArrivalTimeArrived, _$identity);

  /// Serializes this EewArrivalTimeArrived to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewArrivalTimeArrived&&const DeepCollectionEquality().equals(other.type, type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type));

@override
String toString() {
  return 'EewArrivalTimeArrived(type: $type)';
}


}

/// @nodoc
abstract mixin class $EewArrivalTimeArrivedCopyWith<$Res>  {
  factory $EewArrivalTimeArrivedCopyWith(EewArrivalTimeArrived value, $Res Function(EewArrivalTimeArrived) _then) = _$EewArrivalTimeArrivedCopyWithImpl;
@useResult
$Res call({
 dynamic type
});




}
/// @nodoc
class _$EewArrivalTimeArrivedCopyWithImpl<$Res>
    implements $EewArrivalTimeArrivedCopyWith<$Res> {
  _$EewArrivalTimeArrivedCopyWithImpl(this._self, this._then);

  final EewArrivalTimeArrived _self;
  final $Res Function(EewArrivalTimeArrived) _then;

/// Create a copy of EewArrivalTimeArrived
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [EewArrivalTimeArrived].
extension EewArrivalTimeArrivedPatterns on EewArrivalTimeArrived {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewArrivalTimeArrived value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewArrivalTimeArrived() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewArrivalTimeArrived value)  $default,){
final _that = this;
switch (_that) {
case _EewArrivalTimeArrived():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewArrivalTimeArrived value)?  $default,){
final _that = this;
switch (_that) {
case _EewArrivalTimeArrived() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewArrivalTimeArrived() when $default != null:
return $default(_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic type)  $default,) {final _that = this;
switch (_that) {
case _EewArrivalTimeArrived():
return $default(_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic type)?  $default,) {final _that = this;
switch (_that) {
case _EewArrivalTimeArrived() when $default != null:
return $default(_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewArrivalTimeArrived implements EewArrivalTimeArrived {
  const _EewArrivalTimeArrived({required this.type});
  factory _EewArrivalTimeArrived.fromJson(Map<String, dynamic> json) => _$EewArrivalTimeArrivedFromJson(json);

@override final  dynamic type;

/// Create a copy of EewArrivalTimeArrived
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewArrivalTimeArrivedCopyWith<_EewArrivalTimeArrived> get copyWith => __$EewArrivalTimeArrivedCopyWithImpl<_EewArrivalTimeArrived>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewArrivalTimeArrivedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewArrivalTimeArrived&&const DeepCollectionEquality().equals(other.type, type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type));

@override
String toString() {
  return 'EewArrivalTimeArrived(type: $type)';
}


}

/// @nodoc
abstract mixin class _$EewArrivalTimeArrivedCopyWith<$Res> implements $EewArrivalTimeArrivedCopyWith<$Res> {
  factory _$EewArrivalTimeArrivedCopyWith(_EewArrivalTimeArrived value, $Res Function(_EewArrivalTimeArrived) _then) = __$EewArrivalTimeArrivedCopyWithImpl;
@override @useResult
$Res call({
 dynamic type
});




}
/// @nodoc
class __$EewArrivalTimeArrivedCopyWithImpl<$Res>
    implements _$EewArrivalTimeArrivedCopyWith<$Res> {
  __$EewArrivalTimeArrivedCopyWithImpl(this._self, this._then);

  final _EewArrivalTimeArrived _self;
  final $Res Function(_EewArrivalTimeArrived) _then;

/// Create a copy of EewArrivalTimeArrived
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,}) {
  return _then(_EewArrivalTimeArrived(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
