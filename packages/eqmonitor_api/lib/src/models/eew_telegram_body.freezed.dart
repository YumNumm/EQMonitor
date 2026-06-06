// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_telegram_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewTelegramBody {

 dynamic get type; dynamic get eew;@JsonKey(includeIfNull: false) dynamic get eewIntensityRegions;@JsonKey(includeIfNull: false) dynamic get eewWarningZones;@JsonKey(includeIfNull: false) dynamic get eewWarningPrefectures;@JsonKey(includeIfNull: false) dynamic get eewWarningRegions;
/// Create a copy of EewTelegramBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewTelegramBodyCopyWith<EewTelegramBody> get copyWith => _$EewTelegramBodyCopyWithImpl<EewTelegramBody>(this as EewTelegramBody, _$identity);

  /// Serializes this EewTelegramBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewTelegramBody&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.eew, eew)&&const DeepCollectionEquality().equals(other.eewIntensityRegions, eewIntensityRegions)&&const DeepCollectionEquality().equals(other.eewWarningZones, eewWarningZones)&&const DeepCollectionEquality().equals(other.eewWarningPrefectures, eewWarningPrefectures)&&const DeepCollectionEquality().equals(other.eewWarningRegions, eewWarningRegions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(eew),const DeepCollectionEquality().hash(eewIntensityRegions),const DeepCollectionEquality().hash(eewWarningZones),const DeepCollectionEquality().hash(eewWarningPrefectures),const DeepCollectionEquality().hash(eewWarningRegions));

@override
String toString() {
  return 'EewTelegramBody(type: $type, eew: $eew, eewIntensityRegions: $eewIntensityRegions, eewWarningZones: $eewWarningZones, eewWarningPrefectures: $eewWarningPrefectures, eewWarningRegions: $eewWarningRegions)';
}


}

/// @nodoc
abstract mixin class $EewTelegramBodyCopyWith<$Res>  {
  factory $EewTelegramBodyCopyWith(EewTelegramBody value, $Res Function(EewTelegramBody) _then) = _$EewTelegramBodyCopyWithImpl;
@useResult
$Res call({
 dynamic type, dynamic eew,@JsonKey(includeIfNull: false) dynamic eewIntensityRegions,@JsonKey(includeIfNull: false) dynamic eewWarningZones,@JsonKey(includeIfNull: false) dynamic eewWarningPrefectures,@JsonKey(includeIfNull: false) dynamic eewWarningRegions
});




}
/// @nodoc
class _$EewTelegramBodyCopyWithImpl<$Res>
    implements $EewTelegramBodyCopyWith<$Res> {
  _$EewTelegramBodyCopyWithImpl(this._self, this._then);

  final EewTelegramBody _self;
  final $Res Function(EewTelegramBody) _then;

/// Create a copy of EewTelegramBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? eew = freezed,Object? eewIntensityRegions = freezed,Object? eewWarningZones = freezed,Object? eewWarningPrefectures = freezed,Object? eewWarningRegions = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,eew: freezed == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as dynamic,eewIntensityRegions: freezed == eewIntensityRegions ? _self.eewIntensityRegions : eewIntensityRegions // ignore: cast_nullable_to_non_nullable
as dynamic,eewWarningZones: freezed == eewWarningZones ? _self.eewWarningZones : eewWarningZones // ignore: cast_nullable_to_non_nullable
as dynamic,eewWarningPrefectures: freezed == eewWarningPrefectures ? _self.eewWarningPrefectures : eewWarningPrefectures // ignore: cast_nullable_to_non_nullable
as dynamic,eewWarningRegions: freezed == eewWarningRegions ? _self.eewWarningRegions : eewWarningRegions // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [EewTelegramBody].
extension EewTelegramBodyPatterns on EewTelegramBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewTelegramBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewTelegramBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewTelegramBody value)  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewTelegramBody value)?  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic type,  dynamic eew, @JsonKey(includeIfNull: false)  dynamic eewIntensityRegions, @JsonKey(includeIfNull: false)  dynamic eewWarningZones, @JsonKey(includeIfNull: false)  dynamic eewWarningPrefectures, @JsonKey(includeIfNull: false)  dynamic eewWarningRegions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewTelegramBody() when $default != null:
return $default(_that.type,_that.eew,_that.eewIntensityRegions,_that.eewWarningZones,_that.eewWarningPrefectures,_that.eewWarningRegions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic type,  dynamic eew, @JsonKey(includeIfNull: false)  dynamic eewIntensityRegions, @JsonKey(includeIfNull: false)  dynamic eewWarningZones, @JsonKey(includeIfNull: false)  dynamic eewWarningPrefectures, @JsonKey(includeIfNull: false)  dynamic eewWarningRegions)  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBody():
return $default(_that.type,_that.eew,_that.eewIntensityRegions,_that.eewWarningZones,_that.eewWarningPrefectures,_that.eewWarningRegions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic type,  dynamic eew, @JsonKey(includeIfNull: false)  dynamic eewIntensityRegions, @JsonKey(includeIfNull: false)  dynamic eewWarningZones, @JsonKey(includeIfNull: false)  dynamic eewWarningPrefectures, @JsonKey(includeIfNull: false)  dynamic eewWarningRegions)?  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBody() when $default != null:
return $default(_that.type,_that.eew,_that.eewIntensityRegions,_that.eewWarningZones,_that.eewWarningPrefectures,_that.eewWarningRegions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewTelegramBody implements EewTelegramBody {
  const _EewTelegramBody({required this.type, required this.eew, @JsonKey(includeIfNull: false) this.eewIntensityRegions, @JsonKey(includeIfNull: false) this.eewWarningZones, @JsonKey(includeIfNull: false) this.eewWarningPrefectures, @JsonKey(includeIfNull: false) this.eewWarningRegions});
  factory _EewTelegramBody.fromJson(Map<String, dynamic> json) => _$EewTelegramBodyFromJson(json);

@override final  dynamic type;
@override final  dynamic eew;
@override@JsonKey(includeIfNull: false) final  dynamic eewIntensityRegions;
@override@JsonKey(includeIfNull: false) final  dynamic eewWarningZones;
@override@JsonKey(includeIfNull: false) final  dynamic eewWarningPrefectures;
@override@JsonKey(includeIfNull: false) final  dynamic eewWarningRegions;

/// Create a copy of EewTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewTelegramBodyCopyWith<_EewTelegramBody> get copyWith => __$EewTelegramBodyCopyWithImpl<_EewTelegramBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewTelegramBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewTelegramBody&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.eew, eew)&&const DeepCollectionEquality().equals(other.eewIntensityRegions, eewIntensityRegions)&&const DeepCollectionEquality().equals(other.eewWarningZones, eewWarningZones)&&const DeepCollectionEquality().equals(other.eewWarningPrefectures, eewWarningPrefectures)&&const DeepCollectionEquality().equals(other.eewWarningRegions, eewWarningRegions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(eew),const DeepCollectionEquality().hash(eewIntensityRegions),const DeepCollectionEquality().hash(eewWarningZones),const DeepCollectionEquality().hash(eewWarningPrefectures),const DeepCollectionEquality().hash(eewWarningRegions));

@override
String toString() {
  return 'EewTelegramBody(type: $type, eew: $eew, eewIntensityRegions: $eewIntensityRegions, eewWarningZones: $eewWarningZones, eewWarningPrefectures: $eewWarningPrefectures, eewWarningRegions: $eewWarningRegions)';
}


}

/// @nodoc
abstract mixin class _$EewTelegramBodyCopyWith<$Res> implements $EewTelegramBodyCopyWith<$Res> {
  factory _$EewTelegramBodyCopyWith(_EewTelegramBody value, $Res Function(_EewTelegramBody) _then) = __$EewTelegramBodyCopyWithImpl;
@override @useResult
$Res call({
 dynamic type, dynamic eew,@JsonKey(includeIfNull: false) dynamic eewIntensityRegions,@JsonKey(includeIfNull: false) dynamic eewWarningZones,@JsonKey(includeIfNull: false) dynamic eewWarningPrefectures,@JsonKey(includeIfNull: false) dynamic eewWarningRegions
});




}
/// @nodoc
class __$EewTelegramBodyCopyWithImpl<$Res>
    implements _$EewTelegramBodyCopyWith<$Res> {
  __$EewTelegramBodyCopyWithImpl(this._self, this._then);

  final _EewTelegramBody _self;
  final $Res Function(_EewTelegramBody) _then;

/// Create a copy of EewTelegramBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? eew = freezed,Object? eewIntensityRegions = freezed,Object? eewWarningZones = freezed,Object? eewWarningPrefectures = freezed,Object? eewWarningRegions = freezed,}) {
  return _then(_EewTelegramBody(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,eew: freezed == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as dynamic,eewIntensityRegions: freezed == eewIntensityRegions ? _self.eewIntensityRegions : eewIntensityRegions // ignore: cast_nullable_to_non_nullable
as dynamic,eewWarningZones: freezed == eewWarningZones ? _self.eewWarningZones : eewWarningZones // ignore: cast_nullable_to_non_nullable
as dynamic,eewWarningPrefectures: freezed == eewWarningPrefectures ? _self.eewWarningPrefectures : eewWarningPrefectures // ignore: cast_nullable_to_non_nullable
as dynamic,eewWarningRegions: freezed == eewWarningRegions ? _self.eewWarningRegions : eewWarningRegions // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
