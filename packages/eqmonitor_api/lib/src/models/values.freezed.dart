// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'values.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Values {

@JsonKey(includeIfNull: true) String? get all;@JsonKey(includeIfNull: true) String? get felt;
/// Create a copy of Values
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValuesCopyWith<Values> get copyWith => _$ValuesCopyWithImpl<Values>(this as Values, _$identity);

  /// Serializes this Values to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Values&&(identical(other.all, all) || other.all == all)&&(identical(other.felt, felt) || other.felt == felt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,all,felt);

@override
String toString() {
  return 'Values(all: $all, felt: $felt)';
}


}

/// @nodoc
abstract mixin class $ValuesCopyWith<$Res>  {
  factory $ValuesCopyWith(Values value, $Res Function(Values) _then) = _$ValuesCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: true) String? all,@JsonKey(includeIfNull: true) String? felt
});




}
/// @nodoc
class _$ValuesCopyWithImpl<$Res>
    implements $ValuesCopyWith<$Res> {
  _$ValuesCopyWithImpl(this._self, this._then);

  final Values _self;
  final $Res Function(Values) _then;

/// Create a copy of Values
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? all = freezed,Object? felt = freezed,}) {
  return _then(_self.copyWith(
all: freezed == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as String?,felt: freezed == felt ? _self.felt : felt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Values].
extension ValuesPatterns on Values {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Values value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Values() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Values value)  $default,){
final _that = this;
switch (_that) {
case _Values():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Values value)?  $default,){
final _that = this;
switch (_that) {
case _Values() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true)  String? all, @JsonKey(includeIfNull: true)  String? felt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Values() when $default != null:
return $default(_that.all,_that.felt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: true)  String? all, @JsonKey(includeIfNull: true)  String? felt)  $default,) {final _that = this;
switch (_that) {
case _Values():
return $default(_that.all,_that.felt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: true)  String? all, @JsonKey(includeIfNull: true)  String? felt)?  $default,) {final _that = this;
switch (_that) {
case _Values() when $default != null:
return $default(_that.all,_that.felt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Values implements Values {
  const _Values({@JsonKey(includeIfNull: true) required this.all, @JsonKey(includeIfNull: true) required this.felt});
  factory _Values.fromJson(Map<String, dynamic> json) => _$ValuesFromJson(json);

@override@JsonKey(includeIfNull: true) final  String? all;
@override@JsonKey(includeIfNull: true) final  String? felt;

/// Create a copy of Values
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValuesCopyWith<_Values> get copyWith => __$ValuesCopyWithImpl<_Values>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValuesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Values&&(identical(other.all, all) || other.all == all)&&(identical(other.felt, felt) || other.felt == felt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,all,felt);

@override
String toString() {
  return 'Values(all: $all, felt: $felt)';
}


}

/// @nodoc
abstract mixin class _$ValuesCopyWith<$Res> implements $ValuesCopyWith<$Res> {
  factory _$ValuesCopyWith(_Values value, $Res Function(_Values) _then) = __$ValuesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: true) String? all,@JsonKey(includeIfNull: true) String? felt
});




}
/// @nodoc
class __$ValuesCopyWithImpl<$Res>
    implements _$ValuesCopyWith<$Res> {
  __$ValuesCopyWithImpl(this._self, this._then);

  final _Values _self;
  final $Res Function(_Values) _then;

/// Create a copy of Values
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? all = freezed,Object? felt = freezed,}) {
  return _then(_Values(
all: freezed == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as String?,felt: freezed == felt ? _self.felt : felt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
