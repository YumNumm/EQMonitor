// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_notice_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeNoticeData {

/// const: "EARTHQUAKE_NOTICE"
 String get type; String get text;
/// Create a copy of FeedEarthquakeNoticeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeNoticeDataCopyWith<FeedEarthquakeNoticeData> get copyWith => _$FeedEarthquakeNoticeDataCopyWithImpl<FeedEarthquakeNoticeData>(this as FeedEarthquakeNoticeData, _$identity);

  /// Serializes this FeedEarthquakeNoticeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeNoticeData&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'FeedEarthquakeNoticeData(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeNoticeDataCopyWith<$Res>  {
  factory $FeedEarthquakeNoticeDataCopyWith(FeedEarthquakeNoticeData value, $Res Function(FeedEarthquakeNoticeData) _then) = _$FeedEarthquakeNoticeDataCopyWithImpl;
@useResult
$Res call({
 String type, String text
});




}
/// @nodoc
class _$FeedEarthquakeNoticeDataCopyWithImpl<$Res>
    implements $FeedEarthquakeNoticeDataCopyWith<$Res> {
  _$FeedEarthquakeNoticeDataCopyWithImpl(this._self, this._then);

  final FeedEarthquakeNoticeData _self;
  final $Res Function(FeedEarthquakeNoticeData) _then;

/// Create a copy of FeedEarthquakeNoticeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? text = null,}) {
  return _then(FeedEarthquakeNoticeData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEarthquakeNoticeData].
extension FeedEarthquakeNoticeDataPatterns on FeedEarthquakeNoticeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeNoticeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeNoticeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeNoticeData value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeNoticeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeNoticeData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeNoticeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeNoticeData() when $default != null:
return $default(_that.type,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String text)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeNoticeData():
return $default(_that.type,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String text)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeNoticeData() when $default != null:
return $default(_that.type,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeNoticeData implements FeedEarthquakeNoticeData {
  const _FeedEarthquakeNoticeData({required this.type, required this.text});
  factory _FeedEarthquakeNoticeData.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeNoticeDataFromJson(json);

/// const: "EARTHQUAKE_NOTICE"
@override final  String type;
@override final  String text;

/// Create a copy of FeedEarthquakeNoticeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeNoticeDataCopyWith<_FeedEarthquakeNoticeData> get copyWith => __$FeedEarthquakeNoticeDataCopyWithImpl<_FeedEarthquakeNoticeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeNoticeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeNoticeData&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'FeedEarthquakeNoticeData(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeNoticeDataCopyWith<$Res> implements $FeedEarthquakeNoticeDataCopyWith<$Res> {
  factory _$FeedEarthquakeNoticeDataCopyWith(_FeedEarthquakeNoticeData value, $Res Function(_FeedEarthquakeNoticeData) _then) = __$FeedEarthquakeNoticeDataCopyWithImpl;
@override @useResult
$Res call({
 String type, String text
});




}
/// @nodoc
class __$FeedEarthquakeNoticeDataCopyWithImpl<$Res>
    implements _$FeedEarthquakeNoticeDataCopyWith<$Res> {
  __$FeedEarthquakeNoticeDataCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeNoticeData _self;
  final $Res Function(_FeedEarthquakeNoticeData) _then;

/// Create a copy of FeedEarthquakeNoticeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? text = null,}) {
  return _then(_FeedEarthquakeNoticeData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
