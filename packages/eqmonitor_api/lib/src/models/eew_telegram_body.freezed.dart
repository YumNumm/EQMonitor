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

 dynamic get type; dynamic get eew; List<dynamic> get eewIntensityRegions; List<dynamic> get eewWarningZones; List<dynamic> get eewWarningPrefectures; List<dynamic> get eewWarningRegions;
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
 dynamic type, dynamic eew, List<dynamic> eewIntensityRegions, List<dynamic> eewWarningZones, List<dynamic> eewWarningPrefectures, List<dynamic> eewWarningRegions
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
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? eew = freezed,Object? eewIntensityRegions = null,Object? eewWarningZones = null,Object? eewWarningPrefectures = null,Object? eewWarningRegions = null,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,eew: freezed == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as dynamic,eewIntensityRegions: null == eewIntensityRegions ? _self.eewIntensityRegions : eewIntensityRegions // ignore: cast_nullable_to_non_nullable
as List<dynamic>,eewWarningZones: null == eewWarningZones ? _self.eewWarningZones : eewWarningZones // ignore: cast_nullable_to_non_nullable
as List<dynamic>,eewWarningPrefectures: null == eewWarningPrefectures ? _self.eewWarningPrefectures : eewWarningPrefectures // ignore: cast_nullable_to_non_nullable
as List<dynamic>,eewWarningRegions: null == eewWarningRegions ? _self.eewWarningRegions : eewWarningRegions // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic type,  dynamic eew,  List<dynamic> eewIntensityRegions,  List<dynamic> eewWarningZones,  List<dynamic> eewWarningPrefectures,  List<dynamic> eewWarningRegions)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic type,  dynamic eew,  List<dynamic> eewIntensityRegions,  List<dynamic> eewWarningZones,  List<dynamic> eewWarningPrefectures,  List<dynamic> eewWarningRegions)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic type,  dynamic eew,  List<dynamic> eewIntensityRegions,  List<dynamic> eewWarningZones,  List<dynamic> eewWarningPrefectures,  List<dynamic> eewWarningRegions)?  $default,) {final _that = this;
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
  const _EewTelegramBody({required this.type, required this.eew, required final  List<dynamic> eewIntensityRegions, required final  List<dynamic> eewWarningZones, required final  List<dynamic> eewWarningPrefectures, required final  List<dynamic> eewWarningRegions}): _eewIntensityRegions = eewIntensityRegions,_eewWarningZones = eewWarningZones,_eewWarningPrefectures = eewWarningPrefectures,_eewWarningRegions = eewWarningRegions;
  factory _EewTelegramBody.fromJson(Map<String, dynamic> json) => _$EewTelegramBodyFromJson(json);

@override final  dynamic type;
@override final  dynamic eew;
 final  List<dynamic> _eewIntensityRegions;
@override List<dynamic> get eewIntensityRegions {
  if (_eewIntensityRegions is EqualUnmodifiableListView) return _eewIntensityRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewIntensityRegions);
}

 final  List<dynamic> _eewWarningZones;
@override List<dynamic> get eewWarningZones {
  if (_eewWarningZones is EqualUnmodifiableListView) return _eewWarningZones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewWarningZones);
}

 final  List<dynamic> _eewWarningPrefectures;
@override List<dynamic> get eewWarningPrefectures {
  if (_eewWarningPrefectures is EqualUnmodifiableListView) return _eewWarningPrefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewWarningPrefectures);
}

 final  List<dynamic> _eewWarningRegions;
@override List<dynamic> get eewWarningRegions {
  if (_eewWarningRegions is EqualUnmodifiableListView) return _eewWarningRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewWarningRegions);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewTelegramBody&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.eew, eew)&&const DeepCollectionEquality().equals(other._eewIntensityRegions, _eewIntensityRegions)&&const DeepCollectionEquality().equals(other._eewWarningZones, _eewWarningZones)&&const DeepCollectionEquality().equals(other._eewWarningPrefectures, _eewWarningPrefectures)&&const DeepCollectionEquality().equals(other._eewWarningRegions, _eewWarningRegions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(eew),const DeepCollectionEquality().hash(_eewIntensityRegions),const DeepCollectionEquality().hash(_eewWarningZones),const DeepCollectionEquality().hash(_eewWarningPrefectures),const DeepCollectionEquality().hash(_eewWarningRegions));

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
 dynamic type, dynamic eew, List<dynamic> eewIntensityRegions, List<dynamic> eewWarningZones, List<dynamic> eewWarningPrefectures, List<dynamic> eewWarningRegions
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
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? eew = freezed,Object? eewIntensityRegions = null,Object? eewWarningZones = null,Object? eewWarningPrefectures = null,Object? eewWarningRegions = null,}) {
  return _then(_EewTelegramBody(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,eew: freezed == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as dynamic,eewIntensityRegions: null == eewIntensityRegions ? _self._eewIntensityRegions : eewIntensityRegions // ignore: cast_nullable_to_non_nullable
as List<dynamic>,eewWarningZones: null == eewWarningZones ? _self._eewWarningZones : eewWarningZones // ignore: cast_nullable_to_non_nullable
as List<dynamic>,eewWarningPrefectures: null == eewWarningPrefectures ? _self._eewWarningPrefectures : eewWarningPrefectures // ignore: cast_nullable_to_non_nullable
as List<dynamic>,eewWarningRegions: null == eewWarningRegions ? _self._eewWarningRegions : eewWarningRegions // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
