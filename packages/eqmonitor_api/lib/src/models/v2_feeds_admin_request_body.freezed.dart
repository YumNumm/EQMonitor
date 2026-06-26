// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'v2_feeds_admin_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$V2FeedsAdminRequestBody {

/// const: "APP_UPDATE" | const: "INCIDENT" | const: "DEVELOPER_MESSAGE"
 FeedType get feedType;/// const: "CRITICAL" | const: "HIGH" | const: "NORMAL" | const: "LOW"
 Priority get priority; bool get isImportant; String get publishedAt; Data get data; List<Translations> get translations;@JsonKey(includeIfNull: false) String? get expiresAt;
/// Create a copy of V2FeedsAdminRequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$V2FeedsAdminRequestBodyCopyWith<V2FeedsAdminRequestBody> get copyWith => _$V2FeedsAdminRequestBodyCopyWithImpl<V2FeedsAdminRequestBody>(this as V2FeedsAdminRequestBody, _$identity);

  /// Serializes this V2FeedsAdminRequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is V2FeedsAdminRequestBody&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.data, data) || other.data == data)&&const DeepCollectionEquality().equals(other.translations, translations)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedType,priority,isImportant,publishedAt,data,const DeepCollectionEquality().hash(translations),expiresAt);

@override
String toString() {
  return 'V2FeedsAdminRequestBody(feedType: $feedType, priority: $priority, isImportant: $isImportant, publishedAt: $publishedAt, data: $data, translations: $translations, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $V2FeedsAdminRequestBodyCopyWith<$Res>  {
  factory $V2FeedsAdminRequestBodyCopyWith(V2FeedsAdminRequestBody value, $Res Function(V2FeedsAdminRequestBody) _then) = _$V2FeedsAdminRequestBodyCopyWithImpl;
@useResult
$Res call({
 FeedType feedType, Priority priority, bool isImportant, String publishedAt, Data data, List<Translations> translations,@JsonKey(includeIfNull: false) String? expiresAt
});


$DataCopyWith<$Res> get data;

}
/// @nodoc
class _$V2FeedsAdminRequestBodyCopyWithImpl<$Res>
    implements $V2FeedsAdminRequestBodyCopyWith<$Res> {
  _$V2FeedsAdminRequestBodyCopyWithImpl(this._self, this._then);

  final V2FeedsAdminRequestBody _self;
  final $Res Function(V2FeedsAdminRequestBody) _then;

/// Create a copy of V2FeedsAdminRequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feedType = null,Object? priority = null,Object? isImportant = null,Object? publishedAt = null,Object? data = null,Object? translations = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data,translations: null == translations ? _self.translations : translations // ignore: cast_nullable_to_non_nullable
as List<Translations>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of V2FeedsAdminRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res> get data {
  
  return $DataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [V2FeedsAdminRequestBody].
extension V2FeedsAdminRequestBodyPatterns on V2FeedsAdminRequestBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _V2FeedsAdminRequestBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _V2FeedsAdminRequestBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _V2FeedsAdminRequestBody value)  $default,){
final _that = this;
switch (_that) {
case _V2FeedsAdminRequestBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _V2FeedsAdminRequestBody value)?  $default,){
final _that = this;
switch (_that) {
case _V2FeedsAdminRequestBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeedType feedType,  Priority priority,  bool isImportant,  String publishedAt,  Data data,  List<Translations> translations, @JsonKey(includeIfNull: false)  String? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _V2FeedsAdminRequestBody() when $default != null:
return $default(_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.data,_that.translations,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeedType feedType,  Priority priority,  bool isImportant,  String publishedAt,  Data data,  List<Translations> translations, @JsonKey(includeIfNull: false)  String? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _V2FeedsAdminRequestBody():
return $default(_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.data,_that.translations,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeedType feedType,  Priority priority,  bool isImportant,  String publishedAt,  Data data,  List<Translations> translations, @JsonKey(includeIfNull: false)  String? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _V2FeedsAdminRequestBody() when $default != null:
return $default(_that.feedType,_that.priority,_that.isImportant,_that.publishedAt,_that.data,_that.translations,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _V2FeedsAdminRequestBody implements V2FeedsAdminRequestBody {
  const _V2FeedsAdminRequestBody({required this.feedType, required this.priority, required this.isImportant, required this.publishedAt, required this.data, required final  List<Translations> translations, @JsonKey(includeIfNull: false) this.expiresAt}): _translations = translations;
  factory _V2FeedsAdminRequestBody.fromJson(Map<String, dynamic> json) => _$V2FeedsAdminRequestBodyFromJson(json);

/// const: "APP_UPDATE" | const: "INCIDENT" | const: "DEVELOPER_MESSAGE"
@override final  FeedType feedType;
/// const: "CRITICAL" | const: "HIGH" | const: "NORMAL" | const: "LOW"
@override final  Priority priority;
@override final  bool isImportant;
@override final  String publishedAt;
@override final  Data data;
 final  List<Translations> _translations;
@override List<Translations> get translations {
  if (_translations is EqualUnmodifiableListView) return _translations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_translations);
}

@override@JsonKey(includeIfNull: false) final  String? expiresAt;

/// Create a copy of V2FeedsAdminRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$V2FeedsAdminRequestBodyCopyWith<_V2FeedsAdminRequestBody> get copyWith => __$V2FeedsAdminRequestBodyCopyWithImpl<_V2FeedsAdminRequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$V2FeedsAdminRequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _V2FeedsAdminRequestBody&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.data, data) || other.data == data)&&const DeepCollectionEquality().equals(other._translations, _translations)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,feedType,priority,isImportant,publishedAt,data,const DeepCollectionEquality().hash(_translations),expiresAt);

@override
String toString() {
  return 'V2FeedsAdminRequestBody(feedType: $feedType, priority: $priority, isImportant: $isImportant, publishedAt: $publishedAt, data: $data, translations: $translations, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$V2FeedsAdminRequestBodyCopyWith<$Res> implements $V2FeedsAdminRequestBodyCopyWith<$Res> {
  factory _$V2FeedsAdminRequestBodyCopyWith(_V2FeedsAdminRequestBody value, $Res Function(_V2FeedsAdminRequestBody) _then) = __$V2FeedsAdminRequestBodyCopyWithImpl;
@override @useResult
$Res call({
 FeedType feedType, Priority priority, bool isImportant, String publishedAt, Data data, List<Translations> translations,@JsonKey(includeIfNull: false) String? expiresAt
});


@override $DataCopyWith<$Res> get data;

}
/// @nodoc
class __$V2FeedsAdminRequestBodyCopyWithImpl<$Res>
    implements _$V2FeedsAdminRequestBodyCopyWith<$Res> {
  __$V2FeedsAdminRequestBodyCopyWithImpl(this._self, this._then);

  final _V2FeedsAdminRequestBody _self;
  final $Res Function(_V2FeedsAdminRequestBody) _then;

/// Create a copy of V2FeedsAdminRequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feedType = null,Object? priority = null,Object? isImportant = null,Object? publishedAt = null,Object? data = null,Object? translations = null,Object? expiresAt = freezed,}) {
  return _then(_V2FeedsAdminRequestBody(
feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data,translations: null == translations ? _self._translations : translations // ignore: cast_nullable_to_non_nullable
as List<Translations>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of V2FeedsAdminRequestBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res> get data {
  
  return $DataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
