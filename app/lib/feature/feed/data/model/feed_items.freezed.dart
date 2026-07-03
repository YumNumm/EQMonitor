// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedListResponse {

 List<FeedItem> get feeds; String? get nextCursor;
/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedListResponseCopyWith<FeedListResponse> get copyWith => _$FeedListResponseCopyWithImpl<FeedListResponse>(this as FeedListResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedListResponse&&const DeepCollectionEquality().equals(other.feeds, feeds)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(feeds),nextCursor);

@override
String toString() {
  return 'FeedListResponse(feeds: $feeds, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class $FeedListResponseCopyWith<$Res>  {
  factory $FeedListResponseCopyWith(FeedListResponse value, $Res Function(FeedListResponse) _then) = _$FeedListResponseCopyWithImpl;
@useResult
$Res call({
 List<FeedItem> feeds, String? nextCursor
});




}
/// @nodoc
class _$FeedListResponseCopyWithImpl<$Res>
    implements $FeedListResponseCopyWith<$Res> {
  _$FeedListResponseCopyWithImpl(this._self, this._then);

  final FeedListResponse _self;
  final $Res Function(FeedListResponse) _then;

/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feeds = null,Object? nextCursor = freezed,}) {
  return _then(_self.copyWith(
feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<FeedItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedListResponse].
extension FeedListResponsePatterns on FeedListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedListResponse value)  $default,){
final _that = this;
switch (_that) {
case _FeedListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FeedItem> feeds,  String? nextCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
return $default(_that.feeds,_that.nextCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FeedItem> feeds,  String? nextCursor)  $default,) {final _that = this;
switch (_that) {
case _FeedListResponse():
return $default(_that.feeds,_that.nextCursor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FeedItem> feeds,  String? nextCursor)?  $default,) {final _that = this;
switch (_that) {
case _FeedListResponse() when $default != null:
return $default(_that.feeds,_that.nextCursor);case _:
  return null;

}
}

}

/// @nodoc


class _FeedListResponse implements FeedListResponse {
  const _FeedListResponse({required final  List<FeedItem> feeds, required this.nextCursor}): _feeds = feeds;
  

 final  List<FeedItem> _feeds;
@override List<FeedItem> get feeds {
  if (_feeds is EqualUnmodifiableListView) return _feeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_feeds);
}

@override final  String? nextCursor;

/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedListResponseCopyWith<_FeedListResponse> get copyWith => __$FeedListResponseCopyWithImpl<_FeedListResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedListResponse&&const DeepCollectionEquality().equals(other._feeds, _feeds)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_feeds),nextCursor);

@override
String toString() {
  return 'FeedListResponse(feeds: $feeds, nextCursor: $nextCursor)';
}


}

/// @nodoc
abstract mixin class _$FeedListResponseCopyWith<$Res> implements $FeedListResponseCopyWith<$Res> {
  factory _$FeedListResponseCopyWith(_FeedListResponse value, $Res Function(_FeedListResponse) _then) = __$FeedListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<FeedItem> feeds, String? nextCursor
});




}
/// @nodoc
class __$FeedListResponseCopyWithImpl<$Res>
    implements _$FeedListResponseCopyWith<$Res> {
  __$FeedListResponseCopyWithImpl(this._self, this._then);

  final _FeedListResponse _self;
  final $Res Function(_FeedListResponse) _then;

/// Create a copy of FeedListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feeds = null,Object? nextCursor = freezed,}) {
  return _then(_FeedListResponse(
feeds: null == feeds ? _self._feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<FeedItem>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FeedItem {

 String get id; FeedType get feedType; FeedPriority get priority; bool get isImportant; DateTime get publishedAt; DateTime? get expiresAt; String? get title; String? get summary; FeedItemData get data;
/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemCopyWith<FeedItem> get copyWith => _$FeedItemCopyWithImpl<FeedItem>(this as FeedItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.data, data) || other.data == data));
}


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
 String id, FeedType feedType, FeedPriority priority, bool isImportant, DateTime publishedAt, DateTime? expiresAt, String? title, String? summary, FeedItemData data
});


$FeedItemDataCopyWith<$Res> get data;

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
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as FeedPriority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FeedItemData,
  ));
}
/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedItemDataCopyWith<$Res> get data {
  
  return $FeedItemDataCopyWith<$Res>(_self.data, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FeedType feedType,  FeedPriority priority,  bool isImportant,  DateTime publishedAt,  DateTime? expiresAt,  String? title,  String? summary,  FeedItemData data)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FeedType feedType,  FeedPriority priority,  bool isImportant,  DateTime publishedAt,  DateTime? expiresAt,  String? title,  String? summary,  FeedItemData data)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FeedType feedType,  FeedPriority priority,  bool isImportant,  DateTime publishedAt,  DateTime? expiresAt,  String? title,  String? summary,  FeedItemData data)?  $default,) {final _that = this;
switch (_that) {
case _FeedItem() when $default != null:
return $default(_that.id,_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.expiresAt,_that.title,_that.summary,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _FeedItem implements FeedItem {
  const _FeedItem({required this.id, required this.feedType, required this.priority, required this.isImportant, required this.publishedAt, required this.expiresAt, required this.title, required this.summary, required this.data});
  

@override final  String id;
@override final  FeedType feedType;
@override final  FeedPriority priority;
@override final  bool isImportant;
@override final  DateTime publishedAt;
@override final  DateTime? expiresAt;
@override final  String? title;
@override final  String? summary;
@override final  FeedItemData data;

/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedItemCopyWith<_FeedItem> get copyWith => __$FeedItemCopyWithImpl<_FeedItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedItem&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.data, data) || other.data == data));
}


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
 String id, FeedType feedType, FeedPriority priority, bool isImportant, DateTime publishedAt, DateTime? expiresAt, String? title, String? summary, FeedItemData data
});


@override $FeedItemDataCopyWith<$Res> get data;

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
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FeedItemData,
  ));
}

/// Create a copy of FeedItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedItemDataCopyWith<$Res> get data {
  
  return $FeedItemDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$FeedItemData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedItemData()';
}


}

/// @nodoc
class $FeedItemDataCopyWith<$Res>  {
$FeedItemDataCopyWith(FeedItemData _, $Res Function(FeedItemData) __);
}


/// Adds pattern-matching-related methods to [FeedItemData].
extension FeedItemDataPatterns on FeedItemData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedItemDataEarthquakeNotice value)?  earthquakeNotice,TResult Function( FeedItemDataEarthquakeExplanation value)?  earthquakeExplanation,TResult Function( FeedItemDataEarthquakeCounts value)?  earthquakeCounts,TResult Function( FeedItemDataEarthquakeNankai value)?  earthquakeNankai,TResult Function( FeedItemDataAppUpdate value)?  appUpdate,TResult Function( FeedItemDataIncident value)?  incident,TResult Function( FeedItemDataDeveloperMessage value)?  developerMessage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedItemDataEarthquakeNotice() when earthquakeNotice != null:
return earthquakeNotice(_that);case FeedItemDataEarthquakeExplanation() when earthquakeExplanation != null:
return earthquakeExplanation(_that);case FeedItemDataEarthquakeCounts() when earthquakeCounts != null:
return earthquakeCounts(_that);case FeedItemDataEarthquakeNankai() when earthquakeNankai != null:
return earthquakeNankai(_that);case FeedItemDataAppUpdate() when appUpdate != null:
return appUpdate(_that);case FeedItemDataIncident() when incident != null:
return incident(_that);case FeedItemDataDeveloperMessage() when developerMessage != null:
return developerMessage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedItemDataEarthquakeNotice value)  earthquakeNotice,required TResult Function( FeedItemDataEarthquakeExplanation value)  earthquakeExplanation,required TResult Function( FeedItemDataEarthquakeCounts value)  earthquakeCounts,required TResult Function( FeedItemDataEarthquakeNankai value)  earthquakeNankai,required TResult Function( FeedItemDataAppUpdate value)  appUpdate,required TResult Function( FeedItemDataIncident value)  incident,required TResult Function( FeedItemDataDeveloperMessage value)  developerMessage,}){
final _that = this;
switch (_that) {
case FeedItemDataEarthquakeNotice():
return earthquakeNotice(_that);case FeedItemDataEarthquakeExplanation():
return earthquakeExplanation(_that);case FeedItemDataEarthquakeCounts():
return earthquakeCounts(_that);case FeedItemDataEarthquakeNankai():
return earthquakeNankai(_that);case FeedItemDataAppUpdate():
return appUpdate(_that);case FeedItemDataIncident():
return incident(_that);case FeedItemDataDeveloperMessage():
return developerMessage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedItemDataEarthquakeNotice value)?  earthquakeNotice,TResult? Function( FeedItemDataEarthquakeExplanation value)?  earthquakeExplanation,TResult? Function( FeedItemDataEarthquakeCounts value)?  earthquakeCounts,TResult? Function( FeedItemDataEarthquakeNankai value)?  earthquakeNankai,TResult? Function( FeedItemDataAppUpdate value)?  appUpdate,TResult? Function( FeedItemDataIncident value)?  incident,TResult? Function( FeedItemDataDeveloperMessage value)?  developerMessage,}){
final _that = this;
switch (_that) {
case FeedItemDataEarthquakeNotice() when earthquakeNotice != null:
return earthquakeNotice(_that);case FeedItemDataEarthquakeExplanation() when earthquakeExplanation != null:
return earthquakeExplanation(_that);case FeedItemDataEarthquakeCounts() when earthquakeCounts != null:
return earthquakeCounts(_that);case FeedItemDataEarthquakeNankai() when earthquakeNankai != null:
return earthquakeNankai(_that);case FeedItemDataAppUpdate() when appUpdate != null:
return appUpdate(_that);case FeedItemDataIncident() when incident != null:
return incident(_that);case FeedItemDataDeveloperMessage() when developerMessage != null:
return developerMessage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  earthquakeNotice,TResult Function( FeedInfoType infoType,  String text,  FeedNaming? naming,  FeedComments? comments)?  earthquakeExplanation,TResult Function( FeedInfoType infoType,  List<FeedEarthquakeCount>? earthquakeCounts,  String? nextAdvisory,  String? text,  FeedComments? comments)?  earthquakeCounts,TResult Function( FeedInfoType infoType,  FeedNankaiEarthquakeInfo? earthquakeInfo,  String? nextAdvisory,  String? text)?  earthquakeNankai,TResult Function( String? version,  String? url)?  appUpdate,TResult Function( String? url)?  incident,TResult Function( String? url)?  developerMessage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedItemDataEarthquakeNotice() when earthquakeNotice != null:
return earthquakeNotice(_that.text);case FeedItemDataEarthquakeExplanation() when earthquakeExplanation != null:
return earthquakeExplanation(_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataEarthquakeCounts() when earthquakeCounts != null:
return earthquakeCounts(_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataEarthquakeNankai() when earthquakeNankai != null:
return earthquakeNankai(_that.infoType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataAppUpdate() when appUpdate != null:
return appUpdate(_that.version,_that.url);case FeedItemDataIncident() when incident != null:
return incident(_that.url);case FeedItemDataDeveloperMessage() when developerMessage != null:
return developerMessage(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  earthquakeNotice,required TResult Function( FeedInfoType infoType,  String text,  FeedNaming? naming,  FeedComments? comments)  earthquakeExplanation,required TResult Function( FeedInfoType infoType,  List<FeedEarthquakeCount>? earthquakeCounts,  String? nextAdvisory,  String? text,  FeedComments? comments)  earthquakeCounts,required TResult Function( FeedInfoType infoType,  FeedNankaiEarthquakeInfo? earthquakeInfo,  String? nextAdvisory,  String? text)  earthquakeNankai,required TResult Function( String? version,  String? url)  appUpdate,required TResult Function( String? url)  incident,required TResult Function( String? url)  developerMessage,}) {final _that = this;
switch (_that) {
case FeedItemDataEarthquakeNotice():
return earthquakeNotice(_that.text);case FeedItemDataEarthquakeExplanation():
return earthquakeExplanation(_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataEarthquakeCounts():
return earthquakeCounts(_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataEarthquakeNankai():
return earthquakeNankai(_that.infoType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataAppUpdate():
return appUpdate(_that.version,_that.url);case FeedItemDataIncident():
return incident(_that.url);case FeedItemDataDeveloperMessage():
return developerMessage(_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  earthquakeNotice,TResult? Function( FeedInfoType infoType,  String text,  FeedNaming? naming,  FeedComments? comments)?  earthquakeExplanation,TResult? Function( FeedInfoType infoType,  List<FeedEarthquakeCount>? earthquakeCounts,  String? nextAdvisory,  String? text,  FeedComments? comments)?  earthquakeCounts,TResult? Function( FeedInfoType infoType,  FeedNankaiEarthquakeInfo? earthquakeInfo,  String? nextAdvisory,  String? text)?  earthquakeNankai,TResult? Function( String? version,  String? url)?  appUpdate,TResult? Function( String? url)?  incident,TResult? Function( String? url)?  developerMessage,}) {final _that = this;
switch (_that) {
case FeedItemDataEarthquakeNotice() when earthquakeNotice != null:
return earthquakeNotice(_that.text);case FeedItemDataEarthquakeExplanation() when earthquakeExplanation != null:
return earthquakeExplanation(_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataEarthquakeCounts() when earthquakeCounts != null:
return earthquakeCounts(_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataEarthquakeNankai() when earthquakeNankai != null:
return earthquakeNankai(_that.infoType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataAppUpdate() when appUpdate != null:
return appUpdate(_that.version,_that.url);case FeedItemDataIncident() when incident != null:
return incident(_that.url);case FeedItemDataDeveloperMessage() when developerMessage != null:
return developerMessage(_that.url);case _:
  return null;

}
}

}

/// @nodoc


class FeedItemDataEarthquakeNotice implements FeedItemData {
  const FeedItemDataEarthquakeNotice({required this.text});
  

 final  String text;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataEarthquakeNoticeCopyWith<FeedItemDataEarthquakeNotice> get copyWith => _$FeedItemDataEarthquakeNoticeCopyWithImpl<FeedItemDataEarthquakeNotice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataEarthquakeNotice&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'FeedItemData.earthquakeNotice(text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataEarthquakeNoticeCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataEarthquakeNoticeCopyWith(FeedItemDataEarthquakeNotice value, $Res Function(FeedItemDataEarthquakeNotice) _then) = _$FeedItemDataEarthquakeNoticeCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$FeedItemDataEarthquakeNoticeCopyWithImpl<$Res>
    implements $FeedItemDataEarthquakeNoticeCopyWith<$Res> {
  _$FeedItemDataEarthquakeNoticeCopyWithImpl(this._self, this._then);

  final FeedItemDataEarthquakeNotice _self;
  final $Res Function(FeedItemDataEarthquakeNotice) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(FeedItemDataEarthquakeNotice(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FeedItemDataEarthquakeExplanation implements FeedItemData {
  const FeedItemDataEarthquakeExplanation({required this.infoType, required this.text, this.naming, this.comments});
  

 final  FeedInfoType infoType;
 final  String text;
 final  FeedNaming? naming;
 final  FeedComments? comments;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataEarthquakeExplanationCopyWith<FeedItemDataEarthquakeExplanation> get copyWith => _$FeedItemDataEarthquakeExplanationCopyWithImpl<FeedItemDataEarthquakeExplanation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataEarthquakeExplanation&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.text, text) || other.text == text)&&(identical(other.naming, naming) || other.naming == naming)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,infoType,text,naming,comments);

@override
String toString() {
  return 'FeedItemData.earthquakeExplanation(infoType: $infoType, text: $text, naming: $naming, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataEarthquakeExplanationCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataEarthquakeExplanationCopyWith(FeedItemDataEarthquakeExplanation value, $Res Function(FeedItemDataEarthquakeExplanation) _then) = _$FeedItemDataEarthquakeExplanationCopyWithImpl;
@useResult
$Res call({
 FeedInfoType infoType, String text, FeedNaming? naming, FeedComments? comments
});


$FeedNamingCopyWith<$Res>? get naming;$FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedItemDataEarthquakeExplanationCopyWithImpl<$Res>
    implements $FeedItemDataEarthquakeExplanationCopyWith<$Res> {
  _$FeedItemDataEarthquakeExplanationCopyWithImpl(this._self, this._then);

  final FeedItemDataEarthquakeExplanation _self;
  final $Res Function(FeedItemDataEarthquakeExplanation) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? infoType = null,Object? text = null,Object? naming = freezed,Object? comments = freezed,}) {
  return _then(FeedItemDataEarthquakeExplanation(
infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as FeedInfoType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,naming: freezed == naming ? _self.naming : naming // ignore: cast_nullable_to_non_nullable
as FeedNaming?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNamingCopyWith<$Res>? get naming {
    if (_self.naming == null) {
    return null;
  }

  return $FeedNamingCopyWith<$Res>(_self.naming!, (value) {
    return _then(_self.copyWith(naming: value));
  });
}/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $FeedCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

/// @nodoc


class FeedItemDataEarthquakeCounts implements FeedItemData {
  const FeedItemDataEarthquakeCounts({required this.infoType, final  List<FeedEarthquakeCount>? earthquakeCounts, this.nextAdvisory, this.text, this.comments}): _earthquakeCounts = earthquakeCounts;
  

 final  FeedInfoType infoType;
 final  List<FeedEarthquakeCount>? _earthquakeCounts;
 List<FeedEarthquakeCount>? get earthquakeCounts {
  final value = _earthquakeCounts;
  if (value == null) return null;
  if (_earthquakeCounts is EqualUnmodifiableListView) return _earthquakeCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  String? nextAdvisory;
 final  String? text;
 final  FeedComments? comments;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataEarthquakeCountsCopyWith<FeedItemDataEarthquakeCounts> get copyWith => _$FeedItemDataEarthquakeCountsCopyWithImpl<FeedItemDataEarthquakeCounts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataEarthquakeCounts&&(identical(other.infoType, infoType) || other.infoType == infoType)&&const DeepCollectionEquality().equals(other._earthquakeCounts, _earthquakeCounts)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,infoType,const DeepCollectionEquality().hash(_earthquakeCounts),nextAdvisory,text,comments);

@override
String toString() {
  return 'FeedItemData.earthquakeCounts(infoType: $infoType, earthquakeCounts: $earthquakeCounts, nextAdvisory: $nextAdvisory, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataEarthquakeCountsCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataEarthquakeCountsCopyWith(FeedItemDataEarthquakeCounts value, $Res Function(FeedItemDataEarthquakeCounts) _then) = _$FeedItemDataEarthquakeCountsCopyWithImpl;
@useResult
$Res call({
 FeedInfoType infoType, List<FeedEarthquakeCount>? earthquakeCounts, String? nextAdvisory, String? text, FeedComments? comments
});


$FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedItemDataEarthquakeCountsCopyWithImpl<$Res>
    implements $FeedItemDataEarthquakeCountsCopyWith<$Res> {
  _$FeedItemDataEarthquakeCountsCopyWithImpl(this._self, this._then);

  final FeedItemDataEarthquakeCounts _self;
  final $Res Function(FeedItemDataEarthquakeCounts) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? infoType = null,Object? earthquakeCounts = freezed,Object? nextAdvisory = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(FeedItemDataEarthquakeCounts(
infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as FeedInfoType,earthquakeCounts: freezed == earthquakeCounts ? _self._earthquakeCounts : earthquakeCounts // ignore: cast_nullable_to_non_nullable
as List<FeedEarthquakeCount>?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $FeedCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

/// @nodoc


class FeedItemDataEarthquakeNankai implements FeedItemData {
  const FeedItemDataEarthquakeNankai({required this.infoType, this.earthquakeInfo, this.nextAdvisory, this.text});
  

 final  FeedInfoType infoType;
 final  FeedNankaiEarthquakeInfo? earthquakeInfo;
 final  String? nextAdvisory;
 final  String? text;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataEarthquakeNankaiCopyWith<FeedItemDataEarthquakeNankai> get copyWith => _$FeedItemDataEarthquakeNankaiCopyWithImpl<FeedItemDataEarthquakeNankai>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataEarthquakeNankai&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,infoType,earthquakeInfo,nextAdvisory,text);

@override
String toString() {
  return 'FeedItemData.earthquakeNankai(infoType: $infoType, earthquakeInfo: $earthquakeInfo, nextAdvisory: $nextAdvisory, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataEarthquakeNankaiCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataEarthquakeNankaiCopyWith(FeedItemDataEarthquakeNankai value, $Res Function(FeedItemDataEarthquakeNankai) _then) = _$FeedItemDataEarthquakeNankaiCopyWithImpl;
@useResult
$Res call({
 FeedInfoType infoType, FeedNankaiEarthquakeInfo? earthquakeInfo, String? nextAdvisory, String? text
});


$FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo;

}
/// @nodoc
class _$FeedItemDataEarthquakeNankaiCopyWithImpl<$Res>
    implements $FeedItemDataEarthquakeNankaiCopyWith<$Res> {
  _$FeedItemDataEarthquakeNankaiCopyWithImpl(this._self, this._then);

  final FeedItemDataEarthquakeNankai _self;
  final $Res Function(FeedItemDataEarthquakeNankai) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? infoType = null,Object? earthquakeInfo = freezed,Object? nextAdvisory = freezed,Object? text = freezed,}) {
  return _then(FeedItemDataEarthquakeNankai(
infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as FeedInfoType,earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as FeedNankaiEarthquakeInfo?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FeedItemData
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

/// @nodoc


class FeedItemDataAppUpdate implements FeedItemData {
  const FeedItemDataAppUpdate({this.version, this.url});
  

 final  String? version;
 final  String? url;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataAppUpdateCopyWith<FeedItemDataAppUpdate> get copyWith => _$FeedItemDataAppUpdateCopyWithImpl<FeedItemDataAppUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataAppUpdate&&(identical(other.version, version) || other.version == version)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,version,url);

@override
String toString() {
  return 'FeedItemData.appUpdate(version: $version, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataAppUpdateCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataAppUpdateCopyWith(FeedItemDataAppUpdate value, $Res Function(FeedItemDataAppUpdate) _then) = _$FeedItemDataAppUpdateCopyWithImpl;
@useResult
$Res call({
 String? version, String? url
});




}
/// @nodoc
class _$FeedItemDataAppUpdateCopyWithImpl<$Res>
    implements $FeedItemDataAppUpdateCopyWith<$Res> {
  _$FeedItemDataAppUpdateCopyWithImpl(this._self, this._then);

  final FeedItemDataAppUpdate _self;
  final $Res Function(FeedItemDataAppUpdate) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? version = freezed,Object? url = freezed,}) {
  return _then(FeedItemDataAppUpdate(
version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FeedItemDataIncident implements FeedItemData {
  const FeedItemDataIncident({this.url});
  

 final  String? url;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataIncidentCopyWith<FeedItemDataIncident> get copyWith => _$FeedItemDataIncidentCopyWithImpl<FeedItemDataIncident>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataIncident&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'FeedItemData.incident(url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataIncidentCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataIncidentCopyWith(FeedItemDataIncident value, $Res Function(FeedItemDataIncident) _then) = _$FeedItemDataIncidentCopyWithImpl;
@useResult
$Res call({
 String? url
});




}
/// @nodoc
class _$FeedItemDataIncidentCopyWithImpl<$Res>
    implements $FeedItemDataIncidentCopyWith<$Res> {
  _$FeedItemDataIncidentCopyWithImpl(this._self, this._then);

  final FeedItemDataIncident _self;
  final $Res Function(FeedItemDataIncident) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = freezed,}) {
  return _then(FeedItemDataIncident(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FeedItemDataDeveloperMessage implements FeedItemData {
  const FeedItemDataDeveloperMessage({this.url});
  

 final  String? url;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataDeveloperMessageCopyWith<FeedItemDataDeveloperMessage> get copyWith => _$FeedItemDataDeveloperMessageCopyWithImpl<FeedItemDataDeveloperMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataDeveloperMessage&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'FeedItemData.developerMessage(url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataDeveloperMessageCopyWith<$Res> implements $FeedItemDataCopyWith<$Res> {
  factory $FeedItemDataDeveloperMessageCopyWith(FeedItemDataDeveloperMessage value, $Res Function(FeedItemDataDeveloperMessage) _then) = _$FeedItemDataDeveloperMessageCopyWithImpl;
@useResult
$Res call({
 String? url
});




}
/// @nodoc
class _$FeedItemDataDeveloperMessageCopyWithImpl<$Res>
    implements $FeedItemDataDeveloperMessageCopyWith<$Res> {
  _$FeedItemDataDeveloperMessageCopyWithImpl(this._self, this._then);

  final FeedItemDataDeveloperMessage _self;
  final $Res Function(FeedItemDataDeveloperMessage) _then;

/// Create a copy of FeedItemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? url = freezed,}) {
  return _then(FeedItemDataDeveloperMessage(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FeedComments {

 String get free;
/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedCommentsCopyWith<FeedComments> get copyWith => _$FeedCommentsCopyWithImpl<FeedComments>(this as FeedComments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedComments&&(identical(other.free, free) || other.free == free));
}


@override
int get hashCode => Object.hash(runtimeType,free);

@override
String toString() {
  return 'FeedComments(free: $free)';
}


}

/// @nodoc
abstract mixin class $FeedCommentsCopyWith<$Res>  {
  factory $FeedCommentsCopyWith(FeedComments value, $Res Function(FeedComments) _then) = _$FeedCommentsCopyWithImpl;
@useResult
$Res call({
 String free
});




}
/// @nodoc
class _$FeedCommentsCopyWithImpl<$Res>
    implements $FeedCommentsCopyWith<$Res> {
  _$FeedCommentsCopyWithImpl(this._self, this._then);

  final FeedComments _self;
  final $Res Function(FeedComments) _then;

/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = null,}) {
  return _then(_self.copyWith(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedComments].
extension FeedCommentsPatterns on FeedComments {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedComments value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedComments value)  $default,){
final _that = this;
switch (_that) {
case _FeedComments():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedComments value)?  $default,){
final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String free)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
return $default(_that.free);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String free)  $default,) {final _that = this;
switch (_that) {
case _FeedComments():
return $default(_that.free);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String free)?  $default,) {final _that = this;
switch (_that) {
case _FeedComments() when $default != null:
return $default(_that.free);case _:
  return null;

}
}

}

/// @nodoc


class _FeedComments implements FeedComments {
  const _FeedComments({required this.free});
  

@override final  String free;

/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedCommentsCopyWith<_FeedComments> get copyWith => __$FeedCommentsCopyWithImpl<_FeedComments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedComments&&(identical(other.free, free) || other.free == free));
}


@override
int get hashCode => Object.hash(runtimeType,free);

@override
String toString() {
  return 'FeedComments(free: $free)';
}


}

/// @nodoc
abstract mixin class _$FeedCommentsCopyWith<$Res> implements $FeedCommentsCopyWith<$Res> {
  factory _$FeedCommentsCopyWith(_FeedComments value, $Res Function(_FeedComments) _then) = __$FeedCommentsCopyWithImpl;
@override @useResult
$Res call({
 String free
});




}
/// @nodoc
class __$FeedCommentsCopyWithImpl<$Res>
    implements _$FeedCommentsCopyWith<$Res> {
  __$FeedCommentsCopyWithImpl(this._self, this._then);

  final _FeedComments _self;
  final $Res Function(_FeedComments) _then;

/// Create a copy of FeedComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = null,}) {
  return _then(_FeedComments(
free: null == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FeedNaming {

 String get text; String? get en;
/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedNamingCopyWith<FeedNaming> get copyWith => _$FeedNamingCopyWithImpl<FeedNaming>(this as FeedNaming, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedNaming&&(identical(other.text, text) || other.text == text)&&(identical(other.en, en) || other.en == en));
}


@override
int get hashCode => Object.hash(runtimeType,text,en);

@override
String toString() {
  return 'FeedNaming(text: $text, en: $en)';
}


}

/// @nodoc
abstract mixin class $FeedNamingCopyWith<$Res>  {
  factory $FeedNamingCopyWith(FeedNaming value, $Res Function(FeedNaming) _then) = _$FeedNamingCopyWithImpl;
@useResult
$Res call({
 String text, String? en
});




}
/// @nodoc
class _$FeedNamingCopyWithImpl<$Res>
    implements $FeedNamingCopyWith<$Res> {
  _$FeedNamingCopyWithImpl(this._self, this._then);

  final FeedNaming _self;
  final $Res Function(FeedNaming) _then;

/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? en = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedNaming].
extension FeedNamingPatterns on FeedNaming {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedNaming value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedNaming value)  $default,){
final _that = this;
switch (_that) {
case _FeedNaming():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedNaming value)?  $default,){
final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String? en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
return $default(_that.text,_that.en);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String? en)  $default,) {final _that = this;
switch (_that) {
case _FeedNaming():
return $default(_that.text,_that.en);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String? en)?  $default,) {final _that = this;
switch (_that) {
case _FeedNaming() when $default != null:
return $default(_that.text,_that.en);case _:
  return null;

}
}

}

/// @nodoc


class _FeedNaming implements FeedNaming {
  const _FeedNaming({required this.text, this.en});
  

@override final  String text;
@override final  String? en;

/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedNamingCopyWith<_FeedNaming> get copyWith => __$FeedNamingCopyWithImpl<_FeedNaming>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedNaming&&(identical(other.text, text) || other.text == text)&&(identical(other.en, en) || other.en == en));
}


@override
int get hashCode => Object.hash(runtimeType,text,en);

@override
String toString() {
  return 'FeedNaming(text: $text, en: $en)';
}


}

/// @nodoc
abstract mixin class _$FeedNamingCopyWith<$Res> implements $FeedNamingCopyWith<$Res> {
  factory _$FeedNamingCopyWith(_FeedNaming value, $Res Function(_FeedNaming) _then) = __$FeedNamingCopyWithImpl;
@override @useResult
$Res call({
 String text, String? en
});




}
/// @nodoc
class __$FeedNamingCopyWithImpl<$Res>
    implements _$FeedNamingCopyWith<$Res> {
  __$FeedNamingCopyWithImpl(this._self, this._then);

  final _FeedNaming _self;
  final $Res Function(_FeedNaming) _then;

/// Create a copy of FeedNaming
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? en = freezed,}) {
  return _then(_FeedNaming(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FeedEarthquakeCount {

 FeedTelegramType get type; FeedEarthquakeCountTargetTime get targetTime; FeedEarthquakeCountValues get values;
/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountCopyWith<FeedEarthquakeCount> get copyWith => _$FeedEarthquakeCountCopyWithImpl<FeedEarthquakeCount>(this as FeedEarthquakeCount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCount&&(identical(other.type, type) || other.type == type)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.values, values) || other.values == values));
}


@override
int get hashCode => Object.hash(runtimeType,type,targetTime,values);

@override
String toString() {
  return 'FeedEarthquakeCount(type: $type, targetTime: $targetTime, values: $values)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountCopyWith<$Res>  {
  factory $FeedEarthquakeCountCopyWith(FeedEarthquakeCount value, $Res Function(FeedEarthquakeCount) _then) = _$FeedEarthquakeCountCopyWithImpl;
@useResult
$Res call({
 FeedTelegramType type, FeedEarthquakeCountTargetTime targetTime, FeedEarthquakeCountValues values
});


$FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime;$FeedEarthquakeCountValuesCopyWith<$Res> get values;

}
/// @nodoc
class _$FeedEarthquakeCountCopyWithImpl<$Res>
    implements $FeedEarthquakeCountCopyWith<$Res> {
  _$FeedEarthquakeCountCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCount _self;
  final $Res Function(FeedEarthquakeCount) _then;

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? targetTime = null,Object? values = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeedTelegramType,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountTargetTime,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountValues,
  ));
}
/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime {
  
  return $FeedEarthquakeCountTargetTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountValuesCopyWith<$Res> get values {
  
  return $FeedEarthquakeCountValuesCopyWith<$Res>(_self.values, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedEarthquakeCount].
extension FeedEarthquakeCountPatterns on FeedEarthquakeCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCount value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCount value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeedTelegramType type,  FeedEarthquakeCountTargetTime targetTime,  FeedEarthquakeCountValues values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
return $default(_that.type,_that.targetTime,_that.values);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeedTelegramType type,  FeedEarthquakeCountTargetTime targetTime,  FeedEarthquakeCountValues values)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCount():
return $default(_that.type,_that.targetTime,_that.values);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeedTelegramType type,  FeedEarthquakeCountTargetTime targetTime,  FeedEarthquakeCountValues values)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCount() when $default != null:
return $default(_that.type,_that.targetTime,_that.values);case _:
  return null;

}
}

}

/// @nodoc


class _FeedEarthquakeCount implements FeedEarthquakeCount {
  const _FeedEarthquakeCount({required this.type, required this.targetTime, required this.values});
  

@override final  FeedTelegramType type;
@override final  FeedEarthquakeCountTargetTime targetTime;
@override final  FeedEarthquakeCountValues values;

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountCopyWith<_FeedEarthquakeCount> get copyWith => __$FeedEarthquakeCountCopyWithImpl<_FeedEarthquakeCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCount&&(identical(other.type, type) || other.type == type)&&(identical(other.targetTime, targetTime) || other.targetTime == targetTime)&&(identical(other.values, values) || other.values == values));
}


@override
int get hashCode => Object.hash(runtimeType,type,targetTime,values);

@override
String toString() {
  return 'FeedEarthquakeCount(type: $type, targetTime: $targetTime, values: $values)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountCopyWith<$Res> implements $FeedEarthquakeCountCopyWith<$Res> {
  factory _$FeedEarthquakeCountCopyWith(_FeedEarthquakeCount value, $Res Function(_FeedEarthquakeCount) _then) = __$FeedEarthquakeCountCopyWithImpl;
@override @useResult
$Res call({
 FeedTelegramType type, FeedEarthquakeCountTargetTime targetTime, FeedEarthquakeCountValues values
});


@override $FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime;@override $FeedEarthquakeCountValuesCopyWith<$Res> get values;

}
/// @nodoc
class __$FeedEarthquakeCountCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountCopyWith<$Res> {
  __$FeedEarthquakeCountCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCount _self;
  final $Res Function(_FeedEarthquakeCount) _then;

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? targetTime = null,Object? values = null,}) {
  return _then(_FeedEarthquakeCount(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FeedTelegramType,targetTime: null == targetTime ? _self.targetTime : targetTime // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountTargetTime,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as FeedEarthquakeCountValues,
  ));
}

/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountTargetTimeCopyWith<$Res> get targetTime {
  
  return $FeedEarthquakeCountTargetTimeCopyWith<$Res>(_self.targetTime, (value) {
    return _then(_self.copyWith(targetTime: value));
  });
}/// Create a copy of FeedEarthquakeCount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedEarthquakeCountValuesCopyWith<$Res> get values {
  
  return $FeedEarthquakeCountValuesCopyWith<$Res>(_self.values, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}

/// @nodoc
mixin _$FeedEarthquakeCountTargetTime {

 String get start; String get end;
/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountTargetTimeCopyWith<FeedEarthquakeCountTargetTime> get copyWith => _$FeedEarthquakeCountTargetTimeCopyWithImpl<FeedEarthquakeCountTargetTime>(this as FeedEarthquakeCountTargetTime, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCountTargetTime&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FeedEarthquakeCountTargetTime(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountTargetTimeCopyWith<$Res>  {
  factory $FeedEarthquakeCountTargetTimeCopyWith(FeedEarthquakeCountTargetTime value, $Res Function(FeedEarthquakeCountTargetTime) _then) = _$FeedEarthquakeCountTargetTimeCopyWithImpl;
@useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class _$FeedEarthquakeCountTargetTimeCopyWithImpl<$Res>
    implements $FeedEarthquakeCountTargetTimeCopyWith<$Res> {
  _$FeedEarthquakeCountTargetTimeCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCountTargetTime _self;
  final $Res Function(FeedEarthquakeCountTargetTime) _then;

/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(_self.copyWith(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEarthquakeCountTargetTime].
extension FeedEarthquakeCountTargetTimePatterns on FeedEarthquakeCountTargetTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCountTargetTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCountTargetTime value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCountTargetTime value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String start,  String end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String start,  String end)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String start,  String end)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountTargetTime() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _FeedEarthquakeCountTargetTime implements FeedEarthquakeCountTargetTime {
  const _FeedEarthquakeCountTargetTime({required this.start, required this.end});
  

@override final  String start;
@override final  String end;

/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountTargetTimeCopyWith<_FeedEarthquakeCountTargetTime> get copyWith => __$FeedEarthquakeCountTargetTimeCopyWithImpl<_FeedEarthquakeCountTargetTime>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCountTargetTime&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'FeedEarthquakeCountTargetTime(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountTargetTimeCopyWith<$Res> implements $FeedEarthquakeCountTargetTimeCopyWith<$Res> {
  factory _$FeedEarthquakeCountTargetTimeCopyWith(_FeedEarthquakeCountTargetTime value, $Res Function(_FeedEarthquakeCountTargetTime) _then) = __$FeedEarthquakeCountTargetTimeCopyWithImpl;
@override @useResult
$Res call({
 String start, String end
});




}
/// @nodoc
class __$FeedEarthquakeCountTargetTimeCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountTargetTimeCopyWith<$Res> {
  __$FeedEarthquakeCountTargetTimeCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCountTargetTime _self;
  final $Res Function(_FeedEarthquakeCountTargetTime) _then;

/// Create a copy of FeedEarthquakeCountTargetTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_FeedEarthquakeCountTargetTime(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FeedEarthquakeCountValues {

 String? get all; String? get felt;
/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountValuesCopyWith<FeedEarthquakeCountValues> get copyWith => _$FeedEarthquakeCountValuesCopyWithImpl<FeedEarthquakeCountValues>(this as FeedEarthquakeCountValues, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCountValues&&(identical(other.all, all) || other.all == all)&&(identical(other.felt, felt) || other.felt == felt));
}


@override
int get hashCode => Object.hash(runtimeType,all,felt);

@override
String toString() {
  return 'FeedEarthquakeCountValues(all: $all, felt: $felt)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountValuesCopyWith<$Res>  {
  factory $FeedEarthquakeCountValuesCopyWith(FeedEarthquakeCountValues value, $Res Function(FeedEarthquakeCountValues) _then) = _$FeedEarthquakeCountValuesCopyWithImpl;
@useResult
$Res call({
 String? all, String? felt
});




}
/// @nodoc
class _$FeedEarthquakeCountValuesCopyWithImpl<$Res>
    implements $FeedEarthquakeCountValuesCopyWith<$Res> {
  _$FeedEarthquakeCountValuesCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCountValues _self;
  final $Res Function(FeedEarthquakeCountValues) _then;

/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? all = freezed,Object? felt = freezed,}) {
  return _then(_self.copyWith(
all: freezed == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as String?,felt: freezed == felt ? _self.felt : felt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEarthquakeCountValues].
extension FeedEarthquakeCountValuesPatterns on FeedEarthquakeCountValues {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCountValues value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCountValues value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCountValues value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? all,  String? felt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues() when $default != null:
return $default(_that.all,_that.felt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? all,  String? felt)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues():
return $default(_that.all,_that.felt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? all,  String? felt)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountValues() when $default != null:
return $default(_that.all,_that.felt);case _:
  return null;

}
}

}

/// @nodoc


class _FeedEarthquakeCountValues implements FeedEarthquakeCountValues {
  const _FeedEarthquakeCountValues({required this.all, required this.felt});
  

@override final  String? all;
@override final  String? felt;

/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountValuesCopyWith<_FeedEarthquakeCountValues> get copyWith => __$FeedEarthquakeCountValuesCopyWithImpl<_FeedEarthquakeCountValues>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCountValues&&(identical(other.all, all) || other.all == all)&&(identical(other.felt, felt) || other.felt == felt));
}


@override
int get hashCode => Object.hash(runtimeType,all,felt);

@override
String toString() {
  return 'FeedEarthquakeCountValues(all: $all, felt: $felt)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountValuesCopyWith<$Res> implements $FeedEarthquakeCountValuesCopyWith<$Res> {
  factory _$FeedEarthquakeCountValuesCopyWith(_FeedEarthquakeCountValues value, $Res Function(_FeedEarthquakeCountValues) _then) = __$FeedEarthquakeCountValuesCopyWithImpl;
@override @useResult
$Res call({
 String? all, String? felt
});




}
/// @nodoc
class __$FeedEarthquakeCountValuesCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountValuesCopyWith<$Res> {
  __$FeedEarthquakeCountValuesCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCountValues _self;
  final $Res Function(_FeedEarthquakeCountValues) _then;

/// Create a copy of FeedEarthquakeCountValues
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? all = freezed,Object? felt = freezed,}) {
  return _then(_FeedEarthquakeCountValues(
all: freezed == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as String?,felt: freezed == felt ? _self.felt : felt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$FeedNankaiEarthquakeInfo {

 String get text; FeedNankaiEarthquakeInfoKind? get kind; String? get appendix;
/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoCopyWith<FeedNankaiEarthquakeInfo> get copyWith => _$FeedNankaiEarthquakeInfoCopyWithImpl<FeedNankaiEarthquakeInfo>(this as FeedNankaiEarthquakeInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedNankaiEarthquakeInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.appendix, appendix) || other.appendix == appendix));
}


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
 String text, FeedNankaiEarthquakeInfoKind? kind, String? appendix
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
  return _then(_self.copyWith(
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  FeedNankaiEarthquakeInfoKind? kind,  String? appendix)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  FeedNankaiEarthquakeInfoKind? kind,  String? appendix)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  FeedNankaiEarthquakeInfoKind? kind,  String? appendix)?  $default,) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfo() when $default != null:
return $default(_that.text,_that.kind,_that.appendix);case _:
  return null;

}
}

}

/// @nodoc


class _FeedNankaiEarthquakeInfo implements FeedNankaiEarthquakeInfo {
  const _FeedNankaiEarthquakeInfo({required this.text, this.kind, this.appendix});
  

@override final  String text;
@override final  FeedNankaiEarthquakeInfoKind? kind;
@override final  String? appendix;

/// Create a copy of FeedNankaiEarthquakeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedNankaiEarthquakeInfoCopyWith<_FeedNankaiEarthquakeInfo> get copyWith => __$FeedNankaiEarthquakeInfoCopyWithImpl<_FeedNankaiEarthquakeInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedNankaiEarthquakeInfo&&(identical(other.text, text) || other.text == text)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.appendix, appendix) || other.appendix == appendix));
}


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
 String text, FeedNankaiEarthquakeInfoKind? kind, String? appendix
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

/// @nodoc
mixin _$FeedNankaiEarthquakeInfoKind {

 String get code; String get name;
/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoKindCopyWith<FeedNankaiEarthquakeInfoKind> get copyWith => _$FeedNankaiEarthquakeInfoKindCopyWithImpl<FeedNankaiEarthquakeInfoKind>(this as FeedNankaiEarthquakeInfoKind, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedNankaiEarthquakeInfoKind&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'FeedNankaiEarthquakeInfoKind(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $FeedNankaiEarthquakeInfoKindCopyWith<$Res>  {
  factory $FeedNankaiEarthquakeInfoKindCopyWith(FeedNankaiEarthquakeInfoKind value, $Res Function(FeedNankaiEarthquakeInfoKind) _then) = _$FeedNankaiEarthquakeInfoKindCopyWithImpl;
@useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class _$FeedNankaiEarthquakeInfoKindCopyWithImpl<$Res>
    implements $FeedNankaiEarthquakeInfoKindCopyWith<$Res> {
  _$FeedNankaiEarthquakeInfoKindCopyWithImpl(this._self, this._then);

  final FeedNankaiEarthquakeInfoKind _self;
  final $Res Function(FeedNankaiEarthquakeInfoKind) _then;

/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedNankaiEarthquakeInfoKind].
extension FeedNankaiEarthquakeInfoKindPatterns on FeedNankaiEarthquakeInfoKind {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedNankaiEarthquakeInfoKind value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedNankaiEarthquakeInfoKind value)  $default,){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedNankaiEarthquakeInfoKind value)?  $default,){
final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind() when $default != null:
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name)  $default,) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind():
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _FeedNankaiEarthquakeInfoKind() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _FeedNankaiEarthquakeInfoKind implements FeedNankaiEarthquakeInfoKind {
  const _FeedNankaiEarthquakeInfoKind({required this.code, required this.name});
  

@override final  String code;
@override final  String name;

/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedNankaiEarthquakeInfoKindCopyWith<_FeedNankaiEarthquakeInfoKind> get copyWith => __$FeedNankaiEarthquakeInfoKindCopyWithImpl<_FeedNankaiEarthquakeInfoKind>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedNankaiEarthquakeInfoKind&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'FeedNankaiEarthquakeInfoKind(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$FeedNankaiEarthquakeInfoKindCopyWith<$Res> implements $FeedNankaiEarthquakeInfoKindCopyWith<$Res> {
  factory _$FeedNankaiEarthquakeInfoKindCopyWith(_FeedNankaiEarthquakeInfoKind value, $Res Function(_FeedNankaiEarthquakeInfoKind) _then) = __$FeedNankaiEarthquakeInfoKindCopyWithImpl;
@override @useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class __$FeedNankaiEarthquakeInfoKindCopyWithImpl<$Res>
    implements _$FeedNankaiEarthquakeInfoKindCopyWith<$Res> {
  __$FeedNankaiEarthquakeInfoKindCopyWithImpl(this._self, this._then);

  final _FeedNankaiEarthquakeInfoKind _self;
  final $Res Function(_FeedNankaiEarthquakeInfoKind) _then;

/// Create a copy of FeedNankaiEarthquakeInfoKind
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_FeedNankaiEarthquakeInfoKind(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
