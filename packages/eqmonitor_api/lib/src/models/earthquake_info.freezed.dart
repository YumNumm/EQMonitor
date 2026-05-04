// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeInfo {

 String get text;@JsonKey(includeIfNull: false) Kind? get kind;@JsonKey(includeIfNull: false) String? get appendix;
/// Create a copy of EarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeInfoCopyWith<EarthquakeInfo> get copyWith => _$EarthquakeInfoCopyWithImpl<EarthquakeInfo>(this as EarthquakeInfo, _$identity);

  /// Serializes this EarthquakeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.appendix, appendix) || other.appendix == appendix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,kind,appendix);

@override
String toString() {
  return 'EarthquakeInfo(text: $text, kind: $kind, appendix: $appendix)';
}


}

/// @nodoc
abstract mixin class $EarthquakeInfoCopyWith<$Res>  {
  factory $EarthquakeInfoCopyWith(EarthquakeInfo value, $Res Function(EarthquakeInfo) _then) = _$EarthquakeInfoCopyWithImpl;
@useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) Kind? kind,@JsonKey(includeIfNull: false) String? appendix
});


$KindCopyWith<$Res>? get kind;

}
/// @nodoc
class _$EarthquakeInfoCopyWithImpl<$Res>
    implements $EarthquakeInfoCopyWith<$Res> {
  _$EarthquakeInfoCopyWithImpl(this._self, this._then);

  final EarthquakeInfo _self;
  final $Res Function(EarthquakeInfo) _then;

/// Create a copy of EarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? kind = freezed,Object? appendix = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as Kind?,appendix: freezed == appendix ? _self.appendix : appendix // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KindCopyWith<$Res>? get kind {
    if (_self.kind == null) {
    return null;
  }

  return $KindCopyWith<$Res>(_self.kind!, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeInfo].
extension EarthquakeInfoPatterns on EarthquakeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeInfo value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text, @JsonKey(includeIfNull: false)  Kind? kind, @JsonKey(includeIfNull: false)  String? appendix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeInfo() when $default != null:
return $default(_that.text,_that.kind,_that.appendix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text, @JsonKey(includeIfNull: false)  Kind? kind, @JsonKey(includeIfNull: false)  String? appendix)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeInfo():
return $default(_that.text,_that.kind,_that.appendix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text, @JsonKey(includeIfNull: false)  Kind? kind, @JsonKey(includeIfNull: false)  String? appendix)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeInfo() when $default != null:
return $default(_that.text,_that.kind,_that.appendix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeInfo implements EarthquakeInfo {
  const _EarthquakeInfo({required this.text, @JsonKey(includeIfNull: false) this.kind, @JsonKey(includeIfNull: false) this.appendix});
  factory _EarthquakeInfo.fromJson(Map<String, dynamic> json) => _$EarthquakeInfoFromJson(json);

@override final  String text;
@override@JsonKey(includeIfNull: false) final  Kind? kind;
@override@JsonKey(includeIfNull: false) final  String? appendix;

/// Create a copy of EarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeInfoCopyWith<_EarthquakeInfo> get copyWith => __$EarthquakeInfoCopyWithImpl<_EarthquakeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.appendix, appendix) || other.appendix == appendix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,kind,appendix);

@override
String toString() {
  return 'EarthquakeInfo(text: $text, kind: $kind, appendix: $appendix)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeInfoCopyWith<$Res> implements $EarthquakeInfoCopyWith<$Res> {
  factory _$EarthquakeInfoCopyWith(_EarthquakeInfo value, $Res Function(_EarthquakeInfo) _then) = __$EarthquakeInfoCopyWithImpl;
@override @useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) Kind? kind,@JsonKey(includeIfNull: false) String? appendix
});


@override $KindCopyWith<$Res>? get kind;

}
/// @nodoc
class __$EarthquakeInfoCopyWithImpl<$Res>
    implements _$EarthquakeInfoCopyWith<$Res> {
  __$EarthquakeInfoCopyWithImpl(this._self, this._then);

  final _EarthquakeInfo _self;
  final $Res Function(_EarthquakeInfo) _then;

/// Create a copy of EarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? kind = freezed,Object? appendix = freezed,}) {
  return _then(_EarthquakeInfo(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as Kind?,appendix: freezed == appendix ? _self.appendix : appendix // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KindCopyWith<$Res>? get kind {
    if (_self.kind == null) {
    return null;
  }

  return $KindCopyWith<$Res>(_self.kind!, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}

// dart format on
