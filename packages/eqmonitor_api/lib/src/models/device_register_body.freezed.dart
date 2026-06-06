// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_register_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceRegisterBody {

 dynamic get type;@JsonKey(includeIfNull: true) String? get locale;
/// Create a copy of DeviceRegisterBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceRegisterBodyCopyWith<DeviceRegisterBody> get copyWith => _$DeviceRegisterBodyCopyWithImpl<DeviceRegisterBody>(this as DeviceRegisterBody, _$identity);

  /// Serializes this DeviceRegisterBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceRegisterBody&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),locale);

@override
String toString() {
  return 'DeviceRegisterBody(type: $type, locale: $locale)';
}


}

/// @nodoc
abstract mixin class $DeviceRegisterBodyCopyWith<$Res>  {
  factory $DeviceRegisterBodyCopyWith(DeviceRegisterBody value, $Res Function(DeviceRegisterBody) _then) = _$DeviceRegisterBodyCopyWithImpl;
@useResult
$Res call({
 dynamic type,@JsonKey(includeIfNull: true) String? locale
});




}
/// @nodoc
class _$DeviceRegisterBodyCopyWithImpl<$Res>
    implements $DeviceRegisterBodyCopyWith<$Res> {
  _$DeviceRegisterBodyCopyWithImpl(this._self, this._then);

  final DeviceRegisterBody _self;
  final $Res Function(DeviceRegisterBody) _then;

/// Create a copy of DeviceRegisterBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? locale = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceRegisterBody].
extension DeviceRegisterBodyPatterns on DeviceRegisterBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceRegisterBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceRegisterBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceRegisterBody value)  $default,){
final _that = this;
switch (_that) {
case _DeviceRegisterBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceRegisterBody value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceRegisterBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic type, @JsonKey(includeIfNull: true)  String? locale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceRegisterBody() when $default != null:
return $default(_that.type,_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic type, @JsonKey(includeIfNull: true)  String? locale)  $default,) {final _that = this;
switch (_that) {
case _DeviceRegisterBody():
return $default(_that.type,_that.locale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic type, @JsonKey(includeIfNull: true)  String? locale)?  $default,) {final _that = this;
switch (_that) {
case _DeviceRegisterBody() when $default != null:
return $default(_that.type,_that.locale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceRegisterBody implements DeviceRegisterBody {
  const _DeviceRegisterBody({required this.type, @JsonKey(includeIfNull: true) this.locale = 'ja'});
  factory _DeviceRegisterBody.fromJson(Map<String, dynamic> json) => _$DeviceRegisterBodyFromJson(json);

@override final  dynamic type;
@override@JsonKey(includeIfNull: true) final  String? locale;

/// Create a copy of DeviceRegisterBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceRegisterBodyCopyWith<_DeviceRegisterBody> get copyWith => __$DeviceRegisterBodyCopyWithImpl<_DeviceRegisterBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceRegisterBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceRegisterBody&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),locale);

@override
String toString() {
  return 'DeviceRegisterBody(type: $type, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$DeviceRegisterBodyCopyWith<$Res> implements $DeviceRegisterBodyCopyWith<$Res> {
  factory _$DeviceRegisterBodyCopyWith(_DeviceRegisterBody value, $Res Function(_DeviceRegisterBody) _then) = __$DeviceRegisterBodyCopyWithImpl;
@override @useResult
$Res call({
 dynamic type,@JsonKey(includeIfNull: true) String? locale
});




}
/// @nodoc
class __$DeviceRegisterBodyCopyWithImpl<$Res>
    implements _$DeviceRegisterBodyCopyWith<$Res> {
  __$DeviceRegisterBodyCopyWithImpl(this._self, this._then);

  final _DeviceRegisterBody _self;
  final $Res Function(_DeviceRegisterBody) _then;

/// Create a copy of DeviceRegisterBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? locale = freezed,}) {
  return _then(_DeviceRegisterBody(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
