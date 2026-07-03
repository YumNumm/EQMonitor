// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedDetailResponse {

 String get id;@JsonKey(name: 'feed_type') FeedType get feedType; FeedPriority get priority;@JsonKey(name: 'is_important') bool get isImportant;@JsonKey(name: 'published_at') String get publishedAt;@JsonKey(includeIfNull: true, name: 'expires_at') String? get expiresAt;@JsonKey(includeIfNull: true) String? get title;@JsonKey(includeIfNull: true) String? get summary;@JsonKey(includeIfNull: true) String? get body; FeedItemDataUnion get data;
/// Create a copy of FeedDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedDetailResponseCopyWith<FeedDetailResponse> get copyWith => _$FeedDetailResponseCopyWithImpl<FeedDetailResponse>(this as FeedDetailResponse, _$identity);

  /// Serializes this FeedDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedDetailResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.body, body) || other.body == body)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,priority,isImportant,publishedAt,expiresAt,title,summary,body,data);

@override
String toString() {
  return 'FeedDetailResponse(id: $id, feedType: $feedType, priority: $priority, isImportant: $isImportant, publishedAt: $publishedAt, expiresAt: $expiresAt, title: $title, summary: $summary, body: $body, data: $data)';
}


}

/// @nodoc
abstract mixin class $FeedDetailResponseCopyWith<$Res>  {
  factory $FeedDetailResponseCopyWith(FeedDetailResponse value, $Res Function(FeedDetailResponse) _then) = _$FeedDetailResponseCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'feed_type') FeedType feedType, FeedPriority priority,@JsonKey(name: 'is_important') bool isImportant,@JsonKey(name: 'published_at') String publishedAt,@JsonKey(includeIfNull: true, name: 'expires_at') String? expiresAt,@JsonKey(includeIfNull: true) String? title,@JsonKey(includeIfNull: true) String? summary,@JsonKey(includeIfNull: true) String? body, FeedItemDataUnion data
});


$FeedItemDataUnionCopyWith<$Res> get data;

}
/// @nodoc
class _$FeedDetailResponseCopyWithImpl<$Res>
    implements $FeedDetailResponseCopyWith<$Res> {
  _$FeedDetailResponseCopyWithImpl(this._self, this._then);

  final FeedDetailResponse _self;
  final $Res Function(FeedDetailResponse) _then;

/// Create a copy of FeedDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? feedType = null,Object? priority = null,Object? isImportant = null,Object? publishedAt = null,Object? expiresAt = freezed,Object? title = freezed,Object? summary = freezed,Object? body = freezed,Object? data = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedPriority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FeedItemDataUnion,
  ));
}
/// Create a copy of FeedDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedItemDataUnionCopyWith<$Res> get data {
  
  return $FeedItemDataUnionCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedDetailResponse].
extension FeedDetailResponsePatterns on FeedDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeedDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeedDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'feed_type')  FeedType feedType,  FeedPriority priority, @JsonKey(name: 'is_important')  bool isImportant, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at')  String? expiresAt, @JsonKey(includeIfNull: true)  String? title, @JsonKey(includeIfNull: true)  String? summary, @JsonKey(includeIfNull: true)  String? body,  FeedItemDataUnion data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedDetailResponse() when $default != null:
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.body,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'feed_type')  FeedType feedType,  FeedPriority priority, @JsonKey(name: 'is_important')  bool isImportant, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at')  String? expiresAt, @JsonKey(includeIfNull: true)  String? title, @JsonKey(includeIfNull: true)  String? summary, @JsonKey(includeIfNull: true)  String? body,  FeedItemDataUnion data)  $default,) {final _that = this;
switch (_that) {
case _FeedDetailResponse():
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.body,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'feed_type')  FeedType feedType,  FeedPriority priority, @JsonKey(name: 'is_important')  bool isImportant, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at')  String? expiresAt, @JsonKey(includeIfNull: true)  String? title, @JsonKey(includeIfNull: true)  String? summary, @JsonKey(includeIfNull: true)  String? body,  FeedItemDataUnion data)?  $default,) {final _that = this;
switch (_that) {
case _FeedDetailResponse() when $default != null:
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.body,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedDetailResponse implements FeedDetailResponse {
  const _FeedDetailResponse({required this.id, @JsonKey(name: 'feed_type') required this.feedType, required this.priority, @JsonKey(name: 'is_important') required this.isImportant, @JsonKey(name: 'published_at') required this.publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at') required this.expiresAt, @JsonKey(includeIfNull: true) required this.title, @JsonKey(includeIfNull: true) required this.summary, @JsonKey(includeIfNull: true) required this.body, required this.data});
  factory _FeedDetailResponse.fromJson(Map<String, dynamic> json) => _$FeedDetailResponseFromJson(json);

@override final  String id;
@override@JsonKey(name: 'feed_type') final  FeedType feedType;
@override final  FeedPriority priority;
@override@JsonKey(name: 'is_important') final  bool isImportant;
@override@JsonKey(name: 'published_at') final  String publishedAt;
@override@JsonKey(includeIfNull: true, name: 'expires_at') final  String? expiresAt;
@override@JsonKey(includeIfNull: true) final  String? title;
@override@JsonKey(includeIfNull: true) final  String? summary;
@override@JsonKey(includeIfNull: true) final  String? body;
@override final  FeedItemDataUnion data;

/// Create a copy of FeedDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedDetailResponseCopyWith<_FeedDetailResponse> get copyWith => __$FeedDetailResponseCopyWithImpl<_FeedDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedDetailResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.body, body) || other.body == body)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,priority,isImportant,publishedAt,expiresAt,title,summary,body,data);

@override
String toString() {
  return 'FeedDetailResponse(id: $id, feedType: $feedType, priority: $priority, isImportant: $isImportant, publishedAt: $publishedAt, expiresAt: $expiresAt, title: $title, summary: $summary, body: $body, data: $data)';
}


}

/// @nodoc
abstract mixin class _$FeedDetailResponseCopyWith<$Res> implements $FeedDetailResponseCopyWith<$Res> {
  factory _$FeedDetailResponseCopyWith(_FeedDetailResponse value, $Res Function(_FeedDetailResponse) _then) = __$FeedDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'feed_type') FeedType feedType, FeedPriority priority,@JsonKey(name: 'is_important') bool isImportant,@JsonKey(name: 'published_at') String publishedAt,@JsonKey(includeIfNull: true, name: 'expires_at') String? expiresAt,@JsonKey(includeIfNull: true) String? title,@JsonKey(includeIfNull: true) String? summary,@JsonKey(includeIfNull: true) String? body, FeedItemDataUnion data
});


@override $FeedItemDataUnionCopyWith<$Res> get data;

}
/// @nodoc
class __$FeedDetailResponseCopyWithImpl<$Res>
    implements _$FeedDetailResponseCopyWith<$Res> {
  __$FeedDetailResponseCopyWithImpl(this._self, this._then);

  final _FeedDetailResponse _self;
  final $Res Function(_FeedDetailResponse) _then;

/// Create a copy of FeedDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? feedType = null,Object? priority = null,Object? isImportant = null,Object? publishedAt = null,Object? expiresAt = freezed,Object? title = freezed,Object? summary = freezed,Object? body = freezed,Object? data = null,}) {
  return _then(_FeedDetailResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedPriority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FeedItemDataUnion,
  ));
}

/// Create a copy of FeedDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedItemDataUnionCopyWith<$Res> get data {
  
  return $FeedItemDataUnionCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
