// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_telegram_body_warning_area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewTelegramBodyWarningArea {

 String get eventId; num get serialNo; String get code; String get name; bool get hadWarning;
/// Create a copy of EewTelegramBodyWarningArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewTelegramBodyWarningAreaCopyWith<EewTelegramBodyWarningArea> get copyWith => _$EewTelegramBodyWarningAreaCopyWithImpl<EewTelegramBodyWarningArea>(this as EewTelegramBodyWarningArea, _$identity);

  /// Serializes this EewTelegramBodyWarningArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewTelegramBodyWarningArea&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hadWarning, hadWarning) || other.hadWarning == hadWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,code,name,hadWarning);

@override
String toString() {
  return 'EewTelegramBodyWarningArea(eventId: $eventId, serialNo: $serialNo, code: $code, name: $name, hadWarning: $hadWarning)';
}


}

/// @nodoc
abstract mixin class $EewTelegramBodyWarningAreaCopyWith<$Res>  {
  factory $EewTelegramBodyWarningAreaCopyWith(EewTelegramBodyWarningArea value, $Res Function(EewTelegramBodyWarningArea) _then) = _$EewTelegramBodyWarningAreaCopyWithImpl;
@useResult
$Res call({
 String eventId, num serialNo, String code, String name, bool hadWarning
});




}
/// @nodoc
class _$EewTelegramBodyWarningAreaCopyWithImpl<$Res>
    implements $EewTelegramBodyWarningAreaCopyWith<$Res> {
  _$EewTelegramBodyWarningAreaCopyWithImpl(this._self, this._then);

  final EewTelegramBodyWarningArea _self;
  final $Res Function(EewTelegramBodyWarningArea) _then;

/// Create a copy of EewTelegramBodyWarningArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? serialNo = null,Object? code = null,Object? name = null,Object? hadWarning = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hadWarning: null == hadWarning ? _self.hadWarning : hadWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewTelegramBodyWarningArea].
extension EewTelegramBodyWarningAreaPatterns on EewTelegramBodyWarningArea {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewTelegramBodyWarningArea value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewTelegramBodyWarningArea() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewTelegramBodyWarningArea value)  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBodyWarningArea():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewTelegramBodyWarningArea value)?  $default,){
final _that = this;
switch (_that) {
case _EewTelegramBodyWarningArea() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  num serialNo,  String code,  String name,  bool hadWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewTelegramBodyWarningArea() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.code,_that.name,_that.hadWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  num serialNo,  String code,  String name,  bool hadWarning)  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBodyWarningArea():
return $default(_that.eventId,_that.serialNo,_that.code,_that.name,_that.hadWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  num serialNo,  String code,  String name,  bool hadWarning)?  $default,) {final _that = this;
switch (_that) {
case _EewTelegramBodyWarningArea() when $default != null:
return $default(_that.eventId,_that.serialNo,_that.code,_that.name,_that.hadWarning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewTelegramBodyWarningArea implements EewTelegramBodyWarningArea {
  const _EewTelegramBodyWarningArea({required this.eventId, required this.serialNo, required this.code, required this.name, required this.hadWarning});
  factory _EewTelegramBodyWarningArea.fromJson(Map<String, dynamic> json) => _$EewTelegramBodyWarningAreaFromJson(json);

@override final  String eventId;
@override final  num serialNo;
@override final  String code;
@override final  String name;
@override final  bool hadWarning;

/// Create a copy of EewTelegramBodyWarningArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewTelegramBodyWarningAreaCopyWith<_EewTelegramBodyWarningArea> get copyWith => __$EewTelegramBodyWarningAreaCopyWithImpl<_EewTelegramBodyWarningArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewTelegramBodyWarningAreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewTelegramBodyWarningArea&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hadWarning, hadWarning) || other.hadWarning == hadWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,serialNo,code,name,hadWarning);

@override
String toString() {
  return 'EewTelegramBodyWarningArea(eventId: $eventId, serialNo: $serialNo, code: $code, name: $name, hadWarning: $hadWarning)';
}


}

/// @nodoc
abstract mixin class _$EewTelegramBodyWarningAreaCopyWith<$Res> implements $EewTelegramBodyWarningAreaCopyWith<$Res> {
  factory _$EewTelegramBodyWarningAreaCopyWith(_EewTelegramBodyWarningArea value, $Res Function(_EewTelegramBodyWarningArea) _then) = __$EewTelegramBodyWarningAreaCopyWithImpl;
@override @useResult
$Res call({
 String eventId, num serialNo, String code, String name, bool hadWarning
});




}
/// @nodoc
class __$EewTelegramBodyWarningAreaCopyWithImpl<$Res>
    implements _$EewTelegramBodyWarningAreaCopyWith<$Res> {
  __$EewTelegramBodyWarningAreaCopyWithImpl(this._self, this._then);

  final _EewTelegramBodyWarningArea _self;
  final $Res Function(_EewTelegramBodyWarningArea) _then;

/// Create a copy of EewTelegramBodyWarningArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? serialNo = null,Object? code = null,Object? name = null,Object? hadWarning = null,}) {
  return _then(_EewTelegramBodyWarningArea(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: null == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hadWarning: null == hadWarning ? _self.hadWarning : hadWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
