// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_replay_file_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminReplayFileListResponse {

 List<ReplayFile> get items;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_token') String? get nextToken;/// カーソル情報（base64エンコード）
@JsonKey(includeIfNull: false, name: 'next_pooling') String? get nextPooling;
/// Create a copy of AdminReplayFileListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminReplayFileListResponseCopyWith<AdminReplayFileListResponse> get copyWith => _$AdminReplayFileListResponseCopyWithImpl<AdminReplayFileListResponse>(this as AdminReplayFileListResponse, _$identity);

  /// Serializes this AdminReplayFileListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminReplayFileListResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'AdminReplayFileListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $AdminReplayFileListResponseCopyWith<$Res>  {
  factory $AdminReplayFileListResponseCopyWith(AdminReplayFileListResponse value, $Res Function(AdminReplayFileListResponse) _then) = _$AdminReplayFileListResponseCopyWithImpl;
@useResult
$Res call({
 List<ReplayFile> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class _$AdminReplayFileListResponseCopyWithImpl<$Res>
    implements $AdminReplayFileListResponseCopyWith<$Res> {
  _$AdminReplayFileListResponseCopyWithImpl(this._self, this._then);

  final AdminReplayFileListResponse _self;
  final $Res Function(AdminReplayFileListResponse) _then;

/// Create a copy of AdminReplayFileListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ReplayFile>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminReplayFileListResponse].
extension AdminReplayFileListResponsePatterns on AdminReplayFileListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminReplayFileListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminReplayFileListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminReplayFileListResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminReplayFileListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ReplayFile> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminReplayFileListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ReplayFile> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileListResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ReplayFile> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling')  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminReplayFileListResponse implements AdminReplayFileListResponse {
  const _AdminReplayFileListResponse({required final  List<ReplayFile> items, @JsonKey(includeIfNull: false, name: 'next_token') this.nextToken, @JsonKey(includeIfNull: false, name: 'next_pooling') this.nextPooling}): _items = items;
  factory _AdminReplayFileListResponse.fromJson(Map<String, dynamic> json) => _$AdminReplayFileListResponseFromJson(json);

 final  List<ReplayFile> _items;
@override List<ReplayFile> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_token') final  String? nextToken;
/// カーソル情報（base64エンコード）
@override@JsonKey(includeIfNull: false, name: 'next_pooling') final  String? nextPooling;

/// Create a copy of AdminReplayFileListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminReplayFileListResponseCopyWith<_AdminReplayFileListResponse> get copyWith => __$AdminReplayFileListResponseCopyWithImpl<_AdminReplayFileListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminReplayFileListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminReplayFileListResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'AdminReplayFileListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$AdminReplayFileListResponseCopyWith<$Res> implements $AdminReplayFileListResponseCopyWith<$Res> {
  factory _$AdminReplayFileListResponseCopyWith(_AdminReplayFileListResponse value, $Res Function(_AdminReplayFileListResponse) _then) = __$AdminReplayFileListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ReplayFile> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken,@JsonKey(includeIfNull: false, name: 'next_pooling') String? nextPooling
});




}
/// @nodoc
class __$AdminReplayFileListResponseCopyWithImpl<$Res>
    implements _$AdminReplayFileListResponseCopyWith<$Res> {
  __$AdminReplayFileListResponseCopyWithImpl(this._self, this._then);

  final _AdminReplayFileListResponse _self;
  final $Res Function(_AdminReplayFileListResponse) _then;

/// Create a copy of AdminReplayFileListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_AdminReplayFileListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ReplayFile>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
