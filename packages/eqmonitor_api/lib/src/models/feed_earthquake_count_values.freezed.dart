// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_count_values.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeCountValues {

@JsonKey(includeIfNull: true) String? get all;@JsonKey(includeIfNull: true) String? get felt;
/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountValuesCopyWith<FeedEarthquakeCountValues> get copyWith => _$FeedEarthquakeCountValuesCopyWithImpl<FeedEarthquakeCountValues>(this as FeedEarthquakeCountValues, _$identity);

  /// Serializes this FeedEarthquakeCountValues to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCountValues&&(identical(other.all, all) || other.all == all)&&(identical(other.felt, felt) || other.felt == felt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,all,felt);

@override
String toString() {
  return 'FeedEarthquakeCountValues(all: $all, felt: $felt)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountValuesCopyWith<$Res>  {
  factory $FeedEarthquakeCountValuesCopyWith(FeedEarthquakeCountValues value, $Res Function(FeedEarthquakeCountValues) _then) = _$FeedEarthquakeCountValuesCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: true) String? all,@JsonKey(includeIfNull: true) String? felt
});




}
/// @nodoc
class _$FeedEarthquakeCountValuesCopyWithImpl<$Res>
    implements $FeedEarthquakeCountValuesCopyWith<$Res> {
  _$FeedEarthquakeCountValuesCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCountValues _self;
  final $Res Function(FeedEarthquakeCountValues) _then;

/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? all = freezed,Object? felt = freezed,}) {
  return _then(_self.copyWith(
all: freezed == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as String?,felt: freezed == felt ? _self.felt : felt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEarthquakeCountValues].
extension FeedEarthquakeCountValuesPatterns on FeedEarthquakeCountValues {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCountValues value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCountValues value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCountValues value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues() when $default != null:
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
case _FeedEarthquakeCountValues() when $default != null:
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
case _FeedEarthquakeCountValues():
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
case _FeedEarthquakeCountValues() when $default != null:
return $default(_that.all,_that.felt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeCountValues implements FeedEarthquakeCountValues {
  const _FeedEarthquakeCountValues({@JsonKey(includeIfNull: true) required this.all, @JsonKey(includeIfNull: true) required this.felt});
  factory _FeedEarthquakeCountValues.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeCountValuesFromJson(json);

@override@JsonKey(includeIfNull: true) final  String? all;
@override@JsonKey(includeIfNull: true) final  String? felt;

/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountValuesCopyWith<_FeedEarthquakeCountValues> get copyWith => __$FeedEarthquakeCountValuesCopyWithImpl<_FeedEarthquakeCountValues>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeCountValuesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCountValues&&(identical(other.all, all) || other.all == all)&&(identical(other.felt, felt) || other.felt == felt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,all,felt);

@override
String toString() {
  return 'FeedEarthquakeCountValues(all: $all, felt: $felt)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountValuesCopyWith<$Res> implements $FeedEarthquakeCountValuesCopyWith<$Res> {
  factory _$FeedEarthquakeCountValuesCopyWith(_FeedEarthquakeCountValues value, $Res Function(_FeedEarthquakeCountValues) _then) = __$FeedEarthquakeCountValuesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: true) String? all,@JsonKey(includeIfNull: true) String? felt
});




}
/// @nodoc
class __$FeedEarthquakeCountValuesCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountValuesCopyWith<$Res> {
  __$FeedEarthquakeCountValuesCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCountValues _self;
  final $Res Function(_FeedEarthquakeCountValues) _then;

/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? all = freezed,Object? felt = freezed,}) {
  return _then(_FeedEarthquakeCountValues(
all: freezed == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as String?,felt: freezed == felt ? _self.felt : felt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
