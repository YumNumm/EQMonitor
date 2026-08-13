// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_app_update_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedAppUpdateData {

/// const: "APP_UPDATE"
 String get type;@JsonKey(includeIfNull: false) String? get version;@JsonKey(includeIfNull: false) String? get url;
/// Create a copy of FeedAppUpdateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedAppUpdateDataCopyWith<FeedAppUpdateData> get copyWith => _$FeedAppUpdateDataCopyWithImpl<FeedAppUpdateData>(this as FeedAppUpdateData, _$identity);

  /// Serializes this FeedAppUpdateData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedAppUpdateData&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,url);

@override
String toString() {
  return 'FeedAppUpdateData(type: $type, version: $version, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedAppUpdateDataCopyWith<$Res>  {
  factory $FeedAppUpdateDataCopyWith(FeedAppUpdateData value, $Res Function(FeedAppUpdateData) _then) = _$FeedAppUpdateDataCopyWithImpl;
@useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? version,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedAppUpdateDataCopyWithImpl<$Res>
    implements $FeedAppUpdateDataCopyWith<$Res> {
  _$FeedAppUpdateDataCopyWithImpl(this._self, this._then);

  final FeedAppUpdateData _self;
  final $Res Function(FeedAppUpdateData) _then;

/// Create a copy of FeedAppUpdateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = freezed,Object? url = freezed,}) {
  return _then(FeedAppUpdateData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedAppUpdateData].
extension FeedAppUpdateDataPatterns on FeedAppUpdateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedAppUpdateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedAppUpdateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedAppUpdateData value)  $default,){
final _that = this;
switch (_that) {
case _FeedAppUpdateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedAppUpdateData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedAppUpdateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedAppUpdateData() when $default != null:
return $default(_that.type,_that.version,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)  $default,) {final _that = this;
switch (_that) {
case _FeedAppUpdateData():
return $default(_that.type,_that.version,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)?  $default,) {final _that = this;
switch (_that) {
case _FeedAppUpdateData() when $default != null:
return $default(_that.type,_that.version,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedAppUpdateData implements FeedAppUpdateData {
  const _FeedAppUpdateData({required this.type, @JsonKey(includeIfNull: false) this.version, @JsonKey(includeIfNull: false) this.url});
  factory _FeedAppUpdateData.fromJson(Map<String, dynamic> json) => _$FeedAppUpdateDataFromJson(json);

/// const: "APP_UPDATE"
@override final  String type;
@override@JsonKey(includeIfNull: false) final  String? version;
@override@JsonKey(includeIfNull: false) final  String? url;

/// Create a copy of FeedAppUpdateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedAppUpdateDataCopyWith<_FeedAppUpdateData> get copyWith => __$FeedAppUpdateDataCopyWithImpl<_FeedAppUpdateData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedAppUpdateDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedAppUpdateData&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,url);

@override
String toString() {
  return 'FeedAppUpdateData(type: $type, version: $version, url: $url)';
}


}

/// @nodoc
abstract mixin class _$FeedAppUpdateDataCopyWith<$Res> implements $FeedAppUpdateDataCopyWith<$Res> {
  factory _$FeedAppUpdateDataCopyWith(_FeedAppUpdateData value, $Res Function(_FeedAppUpdateData) _then) = __$FeedAppUpdateDataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? version,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class __$FeedAppUpdateDataCopyWithImpl<$Res>
    implements _$FeedAppUpdateDataCopyWith<$Res> {
  __$FeedAppUpdateDataCopyWithImpl(this._self, this._then);

  final _FeedAppUpdateData _self;
  final $Res Function(_FeedAppUpdateData) _then;

/// Create a copy of FeedAppUpdateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = freezed,Object? url = freezed,}) {
  return _then(_FeedAppUpdateData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
