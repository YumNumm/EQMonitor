// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedItem {

 String get id;@JsonKey(name: 'feed_type') FeedType get feedType; FeedPriority get priority;@JsonKey(name: 'is_important') bool get isImportant;@JsonKey(name: 'published_at') String get publishedAt;@JsonKey(includeIfNull: true, name: 'expires_at') String? get expiresAt;@JsonKey(includeIfNull: true) String? get title;@JsonKey(includeIfNull: true) String? get summary; FeedItemDataUnion get data;
/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemCopyWith<FeedItem> get copyWith => _$FeedItemCopyWithImpl<FeedItem>(this as FeedItem, _$identity);

  /// Serializes this FeedItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,priority,isImportant,publishedAt,expiresAt,title,summary,data);

@override
String toString() {
  return 'FeedItem(id: $id, feedType: $feedType, priority: $priority, isImportant: $isImportant, publishedAt: $publishedAt, expiresAt: $expiresAt, title: $title, summary: $summary, data: $data)';
}


}

/// @nodoc
abstract mixin class $FeedItemCopyWith<$Res>  {
  factory $FeedItemCopyWith(FeedItem value, $Res Function(FeedItem) _then) = _$FeedItemCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'feed_type') FeedType feedType, FeedPriority priority,@JsonKey(name: 'is_important') bool isImportant,@JsonKey(name: 'published_at') String publishedAt,@JsonKey(includeIfNull: true, name: 'expires_at') String? expiresAt,@JsonKey(includeIfNull: true) String? title,@JsonKey(includeIfNull: true) String? summary, FeedItemDataUnion data
});


$FeedItemDataUnionCopyWith<$Res> get data;

}
/// @nodoc
class _$FeedItemCopyWithImpl<$Res>
    implements $FeedItemCopyWith<$Res> {
  _$FeedItemCopyWithImpl(this._self, this._then);

  final FeedItem _self;
  final $Res Function(FeedItem) _then;

/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? feedType = null,Object? priority = null,Object? isImportant = null,Object? publishedAt = null,Object? expiresAt = freezed,Object? title = freezed,Object? summary = freezed,Object? data = null,}) {
  return _then(FeedItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedPriority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FeedItemDataUnion,
  ));
}
/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedItemDataUnionCopyWith<$Res> get data {
  
  return $FeedItemDataUnionCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedItem].
extension FeedItemPatterns on FeedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedItem value)  $default,){
final _that = this;
switch (_that) {
case _FeedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedItem value)?  $default,){
final _that = this;
switch (_that) {
case _FeedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'feed_type')  FeedType feedType,  FeedPriority priority, @JsonKey(name: 'is_important')  bool isImportant, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at')  String? expiresAt, @JsonKey(includeIfNull: true)  String? title, @JsonKey(includeIfNull: true)  String? summary,  FeedItemDataUnion data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedItem() when $default != null:
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'feed_type')  FeedType feedType,  FeedPriority priority, @JsonKey(name: 'is_important')  bool isImportant, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at')  String? expiresAt, @JsonKey(includeIfNull: true)  String? title, @JsonKey(includeIfNull: true)  String? summary,  FeedItemDataUnion data)  $default,) {final _that = this;
switch (_that) {
case _FeedItem():
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'feed_type')  FeedType feedType,  FeedPriority priority, @JsonKey(name: 'is_important')  bool isImportant, @JsonKey(name: 'published_at')  String publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at')  String? expiresAt, @JsonKey(includeIfNull: true)  String? title, @JsonKey(includeIfNull: true)  String? summary,  FeedItemDataUnion data)?  $default,) {final _that = this;
switch (_that) {
case _FeedItem() when $default != null:
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedItem implements FeedItem {
  const _FeedItem({required this.id, @JsonKey(name: 'feed_type') required this.feedType, required this.priority, @JsonKey(name: 'is_important') required this.isImportant, @JsonKey(name: 'published_at') required this.publishedAt, @JsonKey(includeIfNull: true, name: 'expires_at') required this.expiresAt, @JsonKey(includeIfNull: true) required this.title, @JsonKey(includeIfNull: true) required this.summary, required this.data});
  factory _FeedItem.fromJson(Map<String, dynamic> json) => _$FeedItemFromJson(json);

@override final  String id;
@override@JsonKey(name: 'feed_type') final  FeedType feedType;
@override final  FeedPriority priority;
@override@JsonKey(name: 'is_important') final  bool isImportant;
@override@JsonKey(name: 'published_at') final  String publishedAt;
@override@JsonKey(includeIfNull: true, name: 'expires_at') final  String? expiresAt;
@override@JsonKey(includeIfNull: true) final  String? title;
@override@JsonKey(includeIfNull: true) final  String? summary;
@override final  FeedItemDataUnion data;

/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedItemCopyWith<_FeedItem> get copyWith => __$FeedItemCopyWithImpl<_FeedItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,priority,isImportant,publishedAt,expiresAt,title,summary,data);

@override
String toString() {
  return 'FeedItem(id: $id, feedType: $feedType, priority: $priority, isImportant: $isImportant, publishedAt: $publishedAt, expiresAt: $expiresAt, title: $title, summary: $summary, data: $data)';
}


}

/// @nodoc
abstract mixin class _$FeedItemCopyWith<$Res> implements $FeedItemCopyWith<$Res> {
  factory _$FeedItemCopyWith(_FeedItem value, $Res Function(_FeedItem) _then) = __$FeedItemCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'feed_type') FeedType feedType, FeedPriority priority,@JsonKey(name: 'is_important') bool isImportant,@JsonKey(name: 'published_at') String publishedAt,@JsonKey(includeIfNull: true, name: 'expires_at') String? expiresAt,@JsonKey(includeIfNull: true) String? title,@JsonKey(includeIfNull: true) String? summary, FeedItemDataUnion data
});


@override $FeedItemDataUnionCopyWith<$Res> get data;

}
/// @nodoc
class __$FeedItemCopyWithImpl<$Res>
    implements _$FeedItemCopyWith<$Res> {
  __$FeedItemCopyWithImpl(this._self, this._then);

  final _FeedItem _self;
  final $Res Function(_FeedItem) _then;

/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? feedType = null,Object? priority = null,Object? isImportant = null,Object? publishedAt = null,Object? expiresAt = freezed,Object? title = freezed,Object? summary = freezed,Object? data = null,}) {
  return _then(_FeedItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedPriority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FeedItemDataUnion,
  ));
}

/// Create a copy of FeedItem
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
