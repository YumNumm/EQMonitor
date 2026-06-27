// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_developer_message_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedDeveloperMessageData {

/// const: "DEVELOPER_MESSAGE"
 String get type;@JsonKey(includeIfNull: false) String? get url;
/// Create a copy of FeedDeveloperMessageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedDeveloperMessageDataCopyWith<FeedDeveloperMessageData> get copyWith => _$FeedDeveloperMessageDataCopyWithImpl<FeedDeveloperMessageData>(this as FeedDeveloperMessageData, _$identity);

  /// Serializes this FeedDeveloperMessageData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedDeveloperMessageData&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'FeedDeveloperMessageData(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedDeveloperMessageDataCopyWith<$Res>  {
  factory $FeedDeveloperMessageDataCopyWith(FeedDeveloperMessageData value, $Res Function(FeedDeveloperMessageData) _then) = _$FeedDeveloperMessageDataCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedDeveloperMessageDataCopyWithImpl<$Res>
    implements $FeedDeveloperMessageDataCopyWith<$Res> {
  _$FeedDeveloperMessageDataCopyWithImpl(this._self, this._then);

  final FeedDeveloperMessageData _self;
  final $Res Function(FeedDeveloperMessageData) _then;

/// Create a copy of FeedDeveloperMessageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedDeveloperMessageData].
extension FeedDeveloperMessageDataPatterns on FeedDeveloperMessageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedDeveloperMessageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedDeveloperMessageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedDeveloperMessageData value)  $default,){
final _that = this;
switch (_that) {
case _FeedDeveloperMessageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedDeveloperMessageData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedDeveloperMessageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(includeIfNull: false)  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedDeveloperMessageData() when $default != null:
return $default(_that.type,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(includeIfNull: false)  String? url)  $default,) {final _that = this;
switch (_that) {
case _FeedDeveloperMessageData():
return $default(_that.type,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(includeIfNull: false)  String? url)?  $default,) {final _that = this;
switch (_that) {
case _FeedDeveloperMessageData() when $default != null:
return $default(_that.type,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedDeveloperMessageData implements FeedDeveloperMessageData {
  const _FeedDeveloperMessageData({required this.type, @JsonKey(includeIfNull: false) this.url});
  factory _FeedDeveloperMessageData.fromJson(Map<String, dynamic> json) => _$FeedDeveloperMessageDataFromJson(json);

/// const: "DEVELOPER_MESSAGE"
@override final  String type;
@override@JsonKey(includeIfNull: false) final  String? url;

/// Create a copy of FeedDeveloperMessageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedDeveloperMessageDataCopyWith<_FeedDeveloperMessageData> get copyWith => __$FeedDeveloperMessageDataCopyWithImpl<_FeedDeveloperMessageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedDeveloperMessageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedDeveloperMessageData&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'FeedDeveloperMessageData(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class _$FeedDeveloperMessageDataCopyWith<$Res> implements $FeedDeveloperMessageDataCopyWith<$Res> {
  factory _$FeedDeveloperMessageDataCopyWith(_FeedDeveloperMessageData value, $Res Function(_FeedDeveloperMessageData) _then) = __$FeedDeveloperMessageDataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class __$FeedDeveloperMessageDataCopyWithImpl<$Res>
    implements _$FeedDeveloperMessageDataCopyWith<$Res> {
  __$FeedDeveloperMessageDataCopyWithImpl(this._self, this._then);

  final _FeedDeveloperMessageData _self;
  final $Res Function(_FeedDeveloperMessageData) _then;

/// Create a copy of FeedDeveloperMessageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = freezed,}) {
  return _then(_FeedDeveloperMessageData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
