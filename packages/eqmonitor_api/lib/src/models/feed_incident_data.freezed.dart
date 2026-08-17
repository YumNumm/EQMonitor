// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_incident_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedIncidentData {

/// const: "INCIDENT"
 String get type;@JsonKey(includeIfNull: false) String? get url;
/// Create a copy of FeedIncidentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedIncidentDataCopyWith<FeedIncidentData> get copyWith => _$FeedIncidentDataCopyWithImpl<FeedIncidentData>(this as FeedIncidentData, _$identity);

  /// Serializes this FeedIncidentData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedIncidentData&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'FeedIncidentData(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedIncidentDataCopyWith<$Res>  {
  factory $FeedIncidentDataCopyWith(FeedIncidentData value, $Res Function(FeedIncidentData) _then) = _$FeedIncidentDataCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedIncidentDataCopyWithImpl<$Res>
    implements $FeedIncidentDataCopyWith<$Res> {
  _$FeedIncidentDataCopyWithImpl(this._self, this._then);

  final FeedIncidentData _self;
  final $Res Function(FeedIncidentData) _then;

/// Create a copy of FeedIncidentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? url = freezed,}) {
  return _then(FeedIncidentData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedIncidentData].
extension FeedIncidentDataPatterns on FeedIncidentData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedIncidentData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedIncidentData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedIncidentData value)  $default,){
final _that = this;
switch (_that) {
case _FeedIncidentData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedIncidentData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedIncidentData() when $default != null:
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
case _FeedIncidentData() when $default != null:
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
case _FeedIncidentData():
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
case _FeedIncidentData() when $default != null:
return $default(_that.type,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedIncidentData implements FeedIncidentData {
  const _FeedIncidentData({required this.type, @JsonKey(includeIfNull: false) this.url});
  factory _FeedIncidentData.fromJson(Map<String, dynamic> json) => _$FeedIncidentDataFromJson(json);

/// const: "INCIDENT"
@override final  String type;
@override@JsonKey(includeIfNull: false) final  String? url;

/// Create a copy of FeedIncidentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedIncidentDataCopyWith<_FeedIncidentData> get copyWith => __$FeedIncidentDataCopyWithImpl<_FeedIncidentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedIncidentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedIncidentData&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'FeedIncidentData(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class _$FeedIncidentDataCopyWith<$Res> implements $FeedIncidentDataCopyWith<$Res> {
  factory _$FeedIncidentDataCopyWith(_FeedIncidentData value, $Res Function(_FeedIncidentData) _then) = __$FeedIncidentDataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class __$FeedIncidentDataCopyWithImpl<$Res>
    implements _$FeedIncidentDataCopyWith<$Res> {
  __$FeedIncidentDataCopyWithImpl(this._self, this._then);

  final _FeedIncidentData _self;
  final $Res Function(_FeedIncidentData) _then;

/// Create a copy of FeedIncidentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = freezed,}) {
  return _then(_FeedIncidentData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
