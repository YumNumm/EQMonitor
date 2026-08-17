// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_telegram_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeTelegramMetadata {

 EarthquakeTelegramType get type; DateTime get reportedAt;
/// Create a copy of EarthquakeTelegramMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeTelegramMetadataCopyWith<EarthquakeTelegramMetadata> get copyWith => _$EarthquakeTelegramMetadataCopyWithImpl<EarthquakeTelegramMetadata>(this as EarthquakeTelegramMetadata, _$identity);

  /// Serializes this EarthquakeTelegramMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeTelegramMetadata&&(identical(other.type, type) || other.type == type)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,reportedAt);

@override
String toString() {
  return 'EarthquakeTelegramMetadata(type: $type, reportedAt: $reportedAt)';
}


}

/// @nodoc
abstract mixin class $EarthquakeTelegramMetadataCopyWith<$Res>  {
  factory $EarthquakeTelegramMetadataCopyWith(EarthquakeTelegramMetadata value, $Res Function(EarthquakeTelegramMetadata) _then) = _$EarthquakeTelegramMetadataCopyWithImpl;
@useResult
$Res call({
 EarthquakeTelegramType type, DateTime reportedAt
});




}
/// @nodoc
class _$EarthquakeTelegramMetadataCopyWithImpl<$Res>
    implements $EarthquakeTelegramMetadataCopyWith<$Res> {
  _$EarthquakeTelegramMetadataCopyWithImpl(this._self, this._then);

  final EarthquakeTelegramMetadata _self;
  final $Res Function(EarthquakeTelegramMetadata) _then;

/// Create a copy of EarthquakeTelegramMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? reportedAt = null,}) {
  return _then(EarthquakeTelegramMetadata(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramType,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeTelegramMetadata].
extension EarthquakeTelegramMetadataPatterns on EarthquakeTelegramMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeTelegramMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeTelegramMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeTelegramMetadata value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeTelegramMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeTelegramMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeTelegramType type,  DateTime reportedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeTelegramMetadata() when $default != null:
return $default(_that.type,_that.reportedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeTelegramType type,  DateTime reportedAt)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramMetadata():
return $default(_that.type,_that.reportedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeTelegramType type,  DateTime reportedAt)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeTelegramMetadata() when $default != null:
return $default(_that.type,_that.reportedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeTelegramMetadata implements EarthquakeTelegramMetadata {
  const _EarthquakeTelegramMetadata({required this.type, required this.reportedAt});
  factory _EarthquakeTelegramMetadata.fromJson(Map<String, dynamic> json) => _$EarthquakeTelegramMetadataFromJson(json);

@override final  EarthquakeTelegramType type;
@override final  DateTime reportedAt;

/// Create a copy of EarthquakeTelegramMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeTelegramMetadataCopyWith<_EarthquakeTelegramMetadata> get copyWith => __$EarthquakeTelegramMetadataCopyWithImpl<_EarthquakeTelegramMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeTelegramMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeTelegramMetadata&&(identical(other.type, type) || other.type == type)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,reportedAt);

@override
String toString() {
  return 'EarthquakeTelegramMetadata(type: $type, reportedAt: $reportedAt)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeTelegramMetadataCopyWith<$Res> implements $EarthquakeTelegramMetadataCopyWith<$Res> {
  factory _$EarthquakeTelegramMetadataCopyWith(_EarthquakeTelegramMetadata value, $Res Function(_EarthquakeTelegramMetadata) _then) = __$EarthquakeTelegramMetadataCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeTelegramType type, DateTime reportedAt
});




}
/// @nodoc
class __$EarthquakeTelegramMetadataCopyWithImpl<$Res>
    implements _$EarthquakeTelegramMetadataCopyWith<$Res> {
  __$EarthquakeTelegramMetadataCopyWithImpl(this._self, this._then);

  final _EarthquakeTelegramMetadata _self;
  final $Res Function(_EarthquakeTelegramMetadata) _then;

/// Create a copy of EarthquakeTelegramMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? reportedAt = null,}) {
  return _then(_EarthquakeTelegramMetadata(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramType,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
