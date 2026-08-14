// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_nankai_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeNankaiData {

/// const: "EARTHQUAKE_NANKAI"
 String get type; InfoType get infoType; NankaiTelegramType get telegramType;@JsonKey(includeIfNull: false) NankaiTelegramCode? get telegramCode;@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfo? get earthquakeInfo;@JsonKey(includeIfNull: false) String? get nextAdvisory;@JsonKey(includeIfNull: false) String? get text;
/// Create a copy of FeedEarthquakeNankaiData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeNankaiDataCopyWith<FeedEarthquakeNankaiData> get copyWith => _$FeedEarthquakeNankaiDataCopyWithImpl<FeedEarthquakeNankaiData>(this as FeedEarthquakeNankaiData, _$identity);

  /// Serializes this FeedEarthquakeNankaiData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeNankaiData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.telegramType, telegramType) || other.telegramType == telegramType)&&(identical(other.telegramCode, telegramCode) || other.telegramCode == telegramCode)&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,telegramType,telegramCode,earthquakeInfo,nextAdvisory,text);

@override
String toString() {
  return 'FeedEarthquakeNankaiData(type: $type, infoType: $infoType, telegramType: $telegramType, telegramCode: $telegramCode, earthquakeInfo: $earthquakeInfo, nextAdvisory: $nextAdvisory, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeNankaiDataCopyWith<$Res>  {
  factory $FeedEarthquakeNankaiDataCopyWith(FeedEarthquakeNankaiData value, $Res Function(FeedEarthquakeNankaiData) _then) = _$FeedEarthquakeNankaiDataCopyWithImpl;
@useResult
$Res call({
 String type, InfoType infoType, NankaiTelegramType telegramType,@JsonKey(includeIfNull: false) NankaiTelegramCode? telegramCode,@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfo? earthquakeInfo,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text
});


$FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo;

}
/// @nodoc
class _$FeedEarthquakeNankaiDataCopyWithImpl<$Res>
    implements $FeedEarthquakeNankaiDataCopyWith<$Res> {
  _$FeedEarthquakeNankaiDataCopyWithImpl(this._self, this._then);

  final FeedEarthquakeNankaiData _self;
  final $Res Function(FeedEarthquakeNankaiData) _then;

/// Create a copy of FeedEarthquakeNankaiData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? infoType = null,Object? telegramType = null,Object? telegramCode = freezed,Object? earthquakeInfo = freezed,Object? nextAdvisory = freezed,Object? text = freezed,}) {
  return _then(FeedEarthquakeNankaiData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,telegramType: null == telegramType ? _self.telegramType : telegramType // ignore: cast_nullable_to_non_nullable
as NankaiTelegramType,telegramCode: freezed == telegramCode ? _self.telegramCode : telegramCode // ignore: cast_nullable_to_non_nullable
as NankaiTelegramCode?,earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as FeedNankaiEarthquakeInfo?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FeedEarthquakeNankaiData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo {
    if (_self.earthquakeInfo == null) {
    return null;
  }

  return $FeedNankaiEarthquakeInfoCopyWith<$Res>(_self.earthquakeInfo!, (value) {
    return _then(_self.copyWith(earthquakeInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedEarthquakeNankaiData].
extension FeedEarthquakeNankaiDataPatterns on FeedEarthquakeNankaiData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeNankaiData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeNankaiData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeNankaiData value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeNankaiData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeNankaiData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeNankaiData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  InfoType infoType,  NankaiTelegramType telegramType, @JsonKey(includeIfNull: false)  NankaiTelegramCode? telegramCode, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeNankaiData() when $default != null:
return $default(_that.type,_that.infoType,_that.telegramType,_that.telegramCode,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  InfoType infoType,  NankaiTelegramType telegramType, @JsonKey(includeIfNull: false)  NankaiTelegramCode? telegramCode, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeNankaiData():
return $default(_that.type,_that.infoType,_that.telegramType,_that.telegramCode,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  InfoType infoType,  NankaiTelegramType telegramType, @JsonKey(includeIfNull: false)  NankaiTelegramCode? telegramCode, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeNankaiData() when $default != null:
return $default(_that.type,_that.infoType,_that.telegramType,_that.telegramCode,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeNankaiData implements FeedEarthquakeNankaiData {
  const _FeedEarthquakeNankaiData({required this.type, required this.infoType, required this.telegramType, @JsonKey(includeIfNull: false) this.telegramCode, @JsonKey(includeIfNull: false) this.earthquakeInfo, @JsonKey(includeIfNull: false) this.nextAdvisory, @JsonKey(includeIfNull: false) this.text});
  factory _FeedEarthquakeNankaiData.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeNankaiDataFromJson(json);

/// const: "EARTHQUAKE_NANKAI"
@override final  String type;
@override final  InfoType infoType;
@override final  NankaiTelegramType telegramType;
@override@JsonKey(includeIfNull: false) final  NankaiTelegramCode? telegramCode;
@override@JsonKey(includeIfNull: false) final  FeedNankaiEarthquakeInfo? earthquakeInfo;
@override@JsonKey(includeIfNull: false) final  String? nextAdvisory;
@override@JsonKey(includeIfNull: false) final  String? text;

/// Create a copy of FeedEarthquakeNankaiData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeNankaiDataCopyWith<_FeedEarthquakeNankaiData> get copyWith => __$FeedEarthquakeNankaiDataCopyWithImpl<_FeedEarthquakeNankaiData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeNankaiDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeNankaiData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.telegramType, telegramType) || other.telegramType == telegramType)&&(identical(other.telegramCode, telegramCode) || other.telegramCode == telegramCode)&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,telegramType,telegramCode,earthquakeInfo,nextAdvisory,text);

@override
String toString() {
  return 'FeedEarthquakeNankaiData(type: $type, infoType: $infoType, telegramType: $telegramType, telegramCode: $telegramCode, earthquakeInfo: $earthquakeInfo, nextAdvisory: $nextAdvisory, text: $text)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeNankaiDataCopyWith<$Res> implements $FeedEarthquakeNankaiDataCopyWith<$Res> {
  factory _$FeedEarthquakeNankaiDataCopyWith(_FeedEarthquakeNankaiData value, $Res Function(_FeedEarthquakeNankaiData) _then) = __$FeedEarthquakeNankaiDataCopyWithImpl;
@override @useResult
$Res call({
 String type, InfoType infoType, NankaiTelegramType telegramType,@JsonKey(includeIfNull: false) NankaiTelegramCode? telegramCode,@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfo? earthquakeInfo,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text
});


@override $FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo;

}
/// @nodoc
class __$FeedEarthquakeNankaiDataCopyWithImpl<$Res>
    implements _$FeedEarthquakeNankaiDataCopyWith<$Res> {
  __$FeedEarthquakeNankaiDataCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeNankaiData _self;
  final $Res Function(_FeedEarthquakeNankaiData) _then;

/// Create a copy of FeedEarthquakeNankaiData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? infoType = null,Object? telegramType = null,Object? telegramCode = freezed,Object? earthquakeInfo = freezed,Object? nextAdvisory = freezed,Object? text = freezed,}) {
  return _then(_FeedEarthquakeNankaiData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,telegramType: null == telegramType ? _self.telegramType : telegramType // ignore: cast_nullable_to_non_nullable
as NankaiTelegramType,telegramCode: freezed == telegramCode ? _self.telegramCode : telegramCode // ignore: cast_nullable_to_non_nullable
as NankaiTelegramCode?,earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as FeedNankaiEarthquakeInfo?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FeedEarthquakeNankaiData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo {
    if (_self.earthquakeInfo == null) {
    return null;
  }

  return $FeedNankaiEarthquakeInfoCopyWith<$Res>(_self.earthquakeInfo!, (value) {
    return _then(_self.copyWith(earthquakeInfo: value));
  });
}
}

// dart format on
