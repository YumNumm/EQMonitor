// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegionOption {

 RegionKind get kind; String get code; String get name; String? get kana; String? get englishName; RegionKind? get parentKind; String? get parentCode; String? get parentName; String? get prefectureCode;
/// Create a copy of RegionOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionOptionCopyWith<RegionOption> get copyWith => _$RegionOptionCopyWithImpl<RegionOption>(this as RegionOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionOption&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.parentKind, parentKind) || other.parentKind == parentKind)&&(identical(other.parentCode, parentCode) || other.parentCode == parentCode)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode));
}


@override
int get hashCode => Object.hash(runtimeType,kind,code,name,kana,englishName,parentKind,parentCode,parentName,prefectureCode);

@override
String toString() {
  return 'RegionOption(kind: $kind, code: $code, name: $name, kana: $kana, englishName: $englishName, parentKind: $parentKind, parentCode: $parentCode, parentName: $parentName, prefectureCode: $prefectureCode)';
}


}

/// @nodoc
abstract mixin class $RegionOptionCopyWith<$Res>  {
  factory $RegionOptionCopyWith(RegionOption value, $Res Function(RegionOption) _then) = _$RegionOptionCopyWithImpl;
@useResult
$Res call({
 RegionKind kind, String code, String name, String? kana, String? englishName, RegionKind? parentKind, String? parentCode, String? parentName, String? prefectureCode
});




}
/// @nodoc
class _$RegionOptionCopyWithImpl<$Res>
    implements $RegionOptionCopyWith<$Res> {
  _$RegionOptionCopyWithImpl(this._self, this._then);

  final RegionOption _self;
  final $Res Function(RegionOption) _then;

/// Create a copy of RegionOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? code = null,Object? name = null,Object? kana = freezed,Object? englishName = freezed,Object? parentKind = freezed,Object? parentCode = freezed,Object? parentName = freezed,Object? prefectureCode = freezed,}) {
  return _then(RegionOption(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RegionKind,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,englishName: freezed == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String?,parentKind: freezed == parentKind ? _self.parentKind : parentKind // ignore: cast_nullable_to_non_nullable
as RegionKind?,parentCode: freezed == parentCode ? _self.parentCode : parentCode // ignore: cast_nullable_to_non_nullable
as String?,parentName: freezed == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionOption].
extension RegionOptionPatterns on RegionOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionOption value)  $default,){
final _that = this;
switch (_that) {
case _RegionOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionOption value)?  $default,){
final _that = this;
switch (_that) {
case _RegionOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RegionKind kind,  String code,  String name,  String? kana,  String? englishName,  RegionKind? parentKind,  String? parentCode,  String? parentName,  String? prefectureCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionOption() when $default != null:
return $default(_that.kind,_that.code,_that.name,_that.kana,_that.englishName,_that.parentKind,_that.parentCode,_that.parentName,_that.prefectureCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RegionKind kind,  String code,  String name,  String? kana,  String? englishName,  RegionKind? parentKind,  String? parentCode,  String? parentName,  String? prefectureCode)  $default,) {final _that = this;
switch (_that) {
case _RegionOption():
return $default(_that.kind,_that.code,_that.name,_that.kana,_that.englishName,_that.parentKind,_that.parentCode,_that.parentName,_that.prefectureCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RegionKind kind,  String code,  String name,  String? kana,  String? englishName,  RegionKind? parentKind,  String? parentCode,  String? parentName,  String? prefectureCode)?  $default,) {final _that = this;
switch (_that) {
case _RegionOption() when $default != null:
return $default(_that.kind,_that.code,_that.name,_that.kana,_that.englishName,_that.parentKind,_that.parentCode,_that.parentName,_that.prefectureCode);case _:
  return null;

}
}

}

/// @nodoc


class _RegionOption extends RegionOption {
  const _RegionOption({required this.kind, required this.code, required this.name, this.kana, this.englishName, this.parentKind, this.parentCode, this.parentName, this.prefectureCode}): super._();
  

@override final  RegionKind kind;
@override final  String code;
@override final  String name;
@override final  String? kana;
@override final  String? englishName;
@override final  RegionKind? parentKind;
@override final  String? parentCode;
@override final  String? parentName;
@override final  String? prefectureCode;

/// Create a copy of RegionOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionOptionCopyWith<_RegionOption> get copyWith => __$RegionOptionCopyWithImpl<_RegionOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionOption&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.englishName, englishName) || other.englishName == englishName)&&(identical(other.parentKind, parentKind) || other.parentKind == parentKind)&&(identical(other.parentCode, parentCode) || other.parentCode == parentCode)&&(identical(other.parentName, parentName) || other.parentName == parentName)&&(identical(other.prefectureCode, prefectureCode) || other.prefectureCode == prefectureCode));
}


@override
int get hashCode => Object.hash(runtimeType,kind,code,name,kana,englishName,parentKind,parentCode,parentName,prefectureCode);

@override
String toString() {
  return 'RegionOption(kind: $kind, code: $code, name: $name, kana: $kana, englishName: $englishName, parentKind: $parentKind, parentCode: $parentCode, parentName: $parentName, prefectureCode: $prefectureCode)';
}


}

/// @nodoc
abstract mixin class _$RegionOptionCopyWith<$Res> implements $RegionOptionCopyWith<$Res> {
  factory _$RegionOptionCopyWith(_RegionOption value, $Res Function(_RegionOption) _then) = __$RegionOptionCopyWithImpl;
@override @useResult
$Res call({
 RegionKind kind, String code, String name, String? kana, String? englishName, RegionKind? parentKind, String? parentCode, String? parentName, String? prefectureCode
});




}
/// @nodoc
class __$RegionOptionCopyWithImpl<$Res>
    implements _$RegionOptionCopyWith<$Res> {
  __$RegionOptionCopyWithImpl(this._self, this._then);

  final _RegionOption _self;
  final $Res Function(_RegionOption) _then;

/// Create a copy of RegionOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? code = null,Object? name = null,Object? kana = freezed,Object? englishName = freezed,Object? parentKind = freezed,Object? parentCode = freezed,Object? parentName = freezed,Object? prefectureCode = freezed,}) {
  return _then(_RegionOption(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as RegionKind,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,englishName: freezed == englishName ? _self.englishName : englishName // ignore: cast_nullable_to_non_nullable
as String?,parentKind: freezed == parentKind ? _self.parentKind : parentKind // ignore: cast_nullable_to_non_nullable
as RegionKind?,parentCode: freezed == parentCode ? _self.parentCode : parentCode // ignore: cast_nullable_to_non_nullable
as String?,parentName: freezed == parentName ? _self.parentName : parentName // ignore: cast_nullable_to_non_nullable
as String?,prefectureCode: freezed == prefectureCode ? _self.prefectureCode : prefectureCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
