// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_nankai_earthquake_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedNankaiEarthquakeInfo {

 String get text;@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfoKind? get kind;@JsonKey(includeIfNull: false) String? get appendix;
/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoCopyWith<FeedNankaiEarthquakeInfo> get copyWith => _$FeedNankaiEarthquakeInfoCopyWithImpl<FeedNankaiEarthquakeInfo>(this as FeedNankaiEarthquakeInfo, _$identity);

  /// Serializes this FeedNankaiEarthquakeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedNankaiEarthquakeInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.appendix, appendix) || other.appendix == appendix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,kind,appendix);

@override
String toString() {
  return 'FeedNankaiEarthquakeInfo(text: $text, kind: $kind, appendix: $appendix)';
}


}

/// @nodoc
abstract mixin class $FeedNankaiEarthquakeInfoCopyWith<$Res>  {
  factory $FeedNankaiEarthquakeInfoCopyWith(FeedNankaiEarthquakeInfo value, $Res Function(FeedNankaiEarthquakeInfo) _then) = _$FeedNankaiEarthquakeInfoCopyWithImpl;
@useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfoKind? kind,@JsonKey(includeIfNull: false) String? appendix
});


$FeedNankaiEarthquakeInfoKindCopyWith<$Res>? get kind;

}
/// @nodoc
class _$FeedNankaiEarthquakeInfoCopyWithImpl<$Res>
    implements $FeedNankaiEarthquakeInfoCopyWith<$Res> {
  _$FeedNankaiEarthquakeInfoCopyWithImpl(this._self, this._then);

  final FeedNankaiEarthquakeInfo _self;
  final $Res Function(FeedNankaiEarthquakeInfo) _then;

/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? kind = freezed,Object? appendix = freezed,}) {
  return _then(FeedNankaiEarthquakeInfo(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FeedNankaiEarthquakeInfoKind?,appendix: freezed == appendix ? _self.appendix : appendix // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoKindCopyWith<$Res>? get kind {
    if (_self.kind == null) {
    return null;
  }

  return $FeedNankaiEarthquakeInfoKindCopyWith<$Res>(_self.kind!, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedNankaiEarthquakeInfo].
extension FeedNankaiEarthquakeInfoPatterns on FeedNankaiEarthquakeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedNankaiEarthquakeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedNankaiEarthquakeInfo value)  $default,){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedNankaiEarthquakeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfoKind? kind, @JsonKey(includeIfNull: false)  String? appendix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfoKind? kind, @JsonKey(includeIfNull: false)  String? appendix)  $default,) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfoKind? kind, @JsonKey(includeIfNull: false)  String? appendix)?  $default,) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo() when $default != null:
return $default(_that.text,_that.kind,_that.appendix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedNankaiEarthquakeInfo implements FeedNankaiEarthquakeInfo {
  const _FeedNankaiEarthquakeInfo({required this.text, @JsonKey(includeIfNull: false) this.kind, @JsonKey(includeIfNull: false) this.appendix});
  factory _FeedNankaiEarthquakeInfo.fromJson(Map<String, dynamic> json) => _$FeedNankaiEarthquakeInfoFromJson(json);

@override final  String text;
@override@JsonKey(includeIfNull: false) final  FeedNankaiEarthquakeInfoKind? kind;
@override@JsonKey(includeIfNull: false) final  String? appendix;

/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedNankaiEarthquakeInfoCopyWith<_FeedNankaiEarthquakeInfo> get copyWith => __$FeedNankaiEarthquakeInfoCopyWithImpl<_FeedNankaiEarthquakeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedNankaiEarthquakeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedNankaiEarthquakeInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.appendix, appendix) || other.appendix == appendix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,kind,appendix);

@override
String toString() {
  return 'FeedNankaiEarthquakeInfo(text: $text, kind: $kind, appendix: $appendix)';
}


}

/// @nodoc
abstract mixin class _$FeedNankaiEarthquakeInfoCopyWith<$Res> implements $FeedNankaiEarthquakeInfoCopyWith<$Res> {
  factory _$FeedNankaiEarthquakeInfoCopyWith(_FeedNankaiEarthquakeInfo value, $Res Function(_FeedNankaiEarthquakeInfo) _then) = __$FeedNankaiEarthquakeInfoCopyWithImpl;
@override @useResult
$Res call({
 String text,@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfoKind? kind,@JsonKey(includeIfNull: false) String? appendix
});


@override $FeedNankaiEarthquakeInfoKindCopyWith<$Res>? get kind;

}
/// @nodoc
class __$FeedNankaiEarthquakeInfoCopyWithImpl<$Res>
    implements _$FeedNankaiEarthquakeInfoCopyWith<$Res> {
  __$FeedNankaiEarthquakeInfoCopyWithImpl(this._self, this._then);

  final _FeedNankaiEarthquakeInfo _self;
  final $Res Function(_FeedNankaiEarthquakeInfo) _then;

/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? kind = freezed,Object? appendix = freezed,}) {
  return _then(_FeedNankaiEarthquakeInfo(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FeedNankaiEarthquakeInfoKind?,appendix: freezed == appendix ? _self.appendix : appendix // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoKindCopyWith<$Res>? get kind {
    if (_self.kind == null) {
    return null;
  }

  return $FeedNankaiEarthquakeInfoKindCopyWith<$Res>(_self.kind!, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}

// dart format on
