// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'eew_warning_zone_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EewWarningZoneItem {

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
 String get code; String get name;/// 前回の情報において、警報だったかどうか
@JsonKey(name: 'had_warning') bool get hadWarning;
/// Create a copy of EewWarningZoneItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EewWarningZoneItemCopyWith<EewWarningZoneItem> get copyWith => _$EewWarningZoneItemCopyWithImpl<EewWarningZoneItem>(this as EewWarningZoneItem, _$identity);

  /// Serializes this EewWarningZoneItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EewWarningZoneItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hadWarning, hadWarning) || other.hadWarning == hadWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,hadWarning);

@override
String toString() {
  return 'EewWarningZoneItem(code: $code, name: $name, hadWarning: $hadWarning)';
}


}

/// @nodoc
abstract mixin class $EewWarningZoneItemCopyWith<$Res>  {
  factory $EewWarningZoneItemCopyWith(EewWarningZoneItem value, $Res Function(EewWarningZoneItem) _then) = _$EewWarningZoneItemCopyWithImpl;
@useResult
$Res call({
 String code, String name,@JsonKey(name: 'had_warning') bool hadWarning
});




}
/// @nodoc
class _$EewWarningZoneItemCopyWithImpl<$Res>
    implements $EewWarningZoneItemCopyWith<$Res> {
  _$EewWarningZoneItemCopyWithImpl(this._self, this._then);

  final EewWarningZoneItem _self;
  final $Res Function(EewWarningZoneItem) _then;

/// Create a copy of EewWarningZoneItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? hadWarning = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hadWarning: null == hadWarning ? _self.hadWarning : hadWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EewWarningZoneItem].
extension EewWarningZoneItemPatterns on EewWarningZoneItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EewWarningZoneItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EewWarningZoneItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EewWarningZoneItem value)  $default,){
final _that = this;
switch (_that) {
case _EewWarningZoneItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EewWarningZoneItem value)?  $default,){
final _that = this;
switch (_that) {
case _EewWarningZoneItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'had_warning')  bool hadWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EewWarningZoneItem() when $default != null:
return $default(_that.code,_that.name,_that.hadWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name, @JsonKey(name: 'had_warning')  bool hadWarning)  $default,) {final _that = this;
switch (_that) {
case _EewWarningZoneItem():
return $default(_that.code,_that.name,_that.hadWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name, @JsonKey(name: 'had_warning')  bool hadWarning)?  $default,) {final _that = this;
switch (_that) {
case _EewWarningZoneItem() when $default != null:
return $default(_that.code,_that.name,_that.hadWarning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EewWarningZoneItem implements EewWarningZoneItem {
  const _EewWarningZoneItem({required this.code, required this.name, @JsonKey(name: 'had_warning') required this.hadWarning});
  factory _EewWarningZoneItem.fromJson(Map<String, dynamic> json) => _$EewWarningZoneItemFromJson(json);

/// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
@override final  String code;
@override final  String name;
/// 前回の情報において、警報だったかどうか
@override@JsonKey(name: 'had_warning') final  bool hadWarning;

/// Create a copy of EewWarningZoneItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EewWarningZoneItemCopyWith<_EewWarningZoneItem> get copyWith => __$EewWarningZoneItemCopyWithImpl<_EewWarningZoneItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EewWarningZoneItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EewWarningZoneItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.hadWarning, hadWarning) || other.hadWarning == hadWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,hadWarning);

@override
String toString() {
  return 'EewWarningZoneItem(code: $code, name: $name, hadWarning: $hadWarning)';
}


}

/// @nodoc
abstract mixin class _$EewWarningZoneItemCopyWith<$Res> implements $EewWarningZoneItemCopyWith<$Res> {
  factory _$EewWarningZoneItemCopyWith(_EewWarningZoneItem value, $Res Function(_EewWarningZoneItem) _then) = __$EewWarningZoneItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String name,@JsonKey(name: 'had_warning') bool hadWarning
});




}
/// @nodoc
class __$EewWarningZoneItemCopyWithImpl<$Res>
    implements _$EewWarningZoneItemCopyWith<$Res> {
  __$EewWarningZoneItemCopyWithImpl(this._self, this._then);

  final _EewWarningZoneItem _self;
  final $Res Function(_EewWarningZoneItem) _then;

/// Create a copy of EewWarningZoneItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? hadWarning = null,}) {
  return _then(_EewWarningZoneItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hadWarning: null == hadWarning ? _self.hadWarning : hadWarning // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
