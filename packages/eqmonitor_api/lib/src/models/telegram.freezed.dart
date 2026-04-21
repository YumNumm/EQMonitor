// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Telegram {

 String get id;@JsonKey(name: 'event_id') String get eventId; TelegramType get type; String get title; TelegramStatus get status;@JsonKey(name: 'info_type') InfoType get infoType;@JsonKey(name: 'editorial_office') String get editorialOffice;@JsonKey(name: 'publishing_office') List<String> get publishingOffice;@JsonKey(name: 'press_at') DateTime get pressAt;@JsonKey(name: 'report_at') DateTime get reportAt;@JsonKey(name: 'info_kind') String get infoKind;@JsonKey(name: 'info_kind_version') String get infoKindVersion; String get hash;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(includeIfNull: false, name: 'serial_no') num? get serialNo;@JsonKey(includeIfNull: false, name: 'target_at') DateTime? get targetAt;@JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? get revokeAt;@JsonKey(includeIfNull: false) String? get headline;@JsonKey(includeIfNull: false) dynamic get body;
/// Create a copy of Telegram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramCopyWith<Telegram> get copyWith => _$TelegramCopyWithImpl<Telegram>(this as Telegram, _$identity);

  /// Serializes this Telegram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Telegram&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other.publishingOffice, publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other.body, body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(publishingOffice),pressAt,reportAt,infoKind,infoKindVersion,hash,createdAt,serialNo,targetAt,revokeAt,headline,const DeepCollectionEquality().hash(body)]);

@override
String toString() {
  return 'Telegram(id: $id, eventId: $eventId, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, serialNo: $serialNo, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, body: $body)';
}


}

/// @nodoc
abstract mixin class $TelegramCopyWith<$Res>  {
  factory $TelegramCopyWith(Telegram value, $Res Function(Telegram) _then) = _$TelegramCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_id') String eventId, TelegramType type, String title, TelegramStatus status,@JsonKey(name: 'info_type') InfoType infoType,@JsonKey(name: 'editorial_office') String editorialOffice,@JsonKey(name: 'publishing_office') List<String> publishingOffice,@JsonKey(name: 'press_at') DateTime pressAt,@JsonKey(name: 'report_at') DateTime reportAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(name: 'info_kind_version') String infoKindVersion, String hash,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'target_at') DateTime? targetAt,@JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? revokeAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) dynamic body
});




}
/// @nodoc
class _$TelegramCopyWithImpl<$Res>
    implements $TelegramCopyWith<$Res> {
  _$TelegramCopyWithImpl(this._self, this._then);

  final Telegram _self;
  final $Res Function(Telegram) _then;

/// Create a copy of Telegram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? serialNo = freezed,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? body = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self.publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [Telegram].
extension TelegramPatterns on Telegram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Telegram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Telegram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Telegram value)  $default,){
final _that = this;
switch (_that) {
case _Telegram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Telegram value)?  $default,){
final _that = this;
switch (_that) {
case _Telegram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_id')  String eventId,  TelegramType type,  String title,  TelegramStatus status, @JsonKey(name: 'info_type')  InfoType infoType, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'press_at')  DateTime pressAt, @JsonKey(name: 'report_at')  DateTime reportAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(name: 'info_kind_version')  String infoKindVersion,  String hash, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'target_at')  DateTime? targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at')  DateTime? revokeAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  dynamic body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Telegram() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_id')  String eventId,  TelegramType type,  String title,  TelegramStatus status, @JsonKey(name: 'info_type')  InfoType infoType, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'press_at')  DateTime pressAt, @JsonKey(name: 'report_at')  DateTime reportAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(name: 'info_kind_version')  String infoKindVersion,  String hash, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'target_at')  DateTime? targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at')  DateTime? revokeAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  dynamic body)  $default,) {final _that = this;
switch (_that) {
case _Telegram():
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_id')  String eventId,  TelegramType type,  String title,  TelegramStatus status, @JsonKey(name: 'info_type')  InfoType infoType, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'press_at')  DateTime pressAt, @JsonKey(name: 'report_at')  DateTime reportAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(name: 'info_kind_version')  String infoKindVersion,  String hash, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'target_at')  DateTime? targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at')  DateTime? revokeAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  dynamic body)?  $default,) {final _that = this;
switch (_that) {
case _Telegram() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Telegram implements Telegram {
  const _Telegram({required this.id, @JsonKey(name: 'event_id') required this.eventId, required this.type, required this.title, required this.status, @JsonKey(name: 'info_type') required this.infoType, @JsonKey(name: 'editorial_office') required this.editorialOffice, @JsonKey(name: 'publishing_office') required final  List<String> publishingOffice, @JsonKey(name: 'press_at') required this.pressAt, @JsonKey(name: 'report_at') required this.reportAt, @JsonKey(name: 'info_kind') required this.infoKind, @JsonKey(name: 'info_kind_version') required this.infoKindVersion, required this.hash, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(includeIfNull: false, name: 'serial_no') this.serialNo, @JsonKey(includeIfNull: false, name: 'target_at') this.targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at') this.revokeAt, @JsonKey(includeIfNull: false) this.headline, @JsonKey(includeIfNull: false) this.body}): _publishingOffice = publishingOffice;
  factory _Telegram.fromJson(Map<String, dynamic> json) => _$TelegramFromJson(json);

@override final  String id;
@override@JsonKey(name: 'event_id') final  String eventId;
@override final  TelegramType type;
@override final  String title;
@override final  TelegramStatus status;
@override@JsonKey(name: 'info_type') final  InfoType infoType;
@override@JsonKey(name: 'editorial_office') final  String editorialOffice;
 final  List<String> _publishingOffice;
@override@JsonKey(name: 'publishing_office') List<String> get publishingOffice {
  if (_publishingOffice is EqualUnmodifiableListView) return _publishingOffice;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_publishingOffice);
}

@override@JsonKey(name: 'press_at') final  DateTime pressAt;
@override@JsonKey(name: 'report_at') final  DateTime reportAt;
@override@JsonKey(name: 'info_kind') final  String infoKind;
@override@JsonKey(name: 'info_kind_version') final  String infoKindVersion;
@override final  String hash;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(includeIfNull: false, name: 'serial_no') final  num? serialNo;
@override@JsonKey(includeIfNull: false, name: 'target_at') final  DateTime? targetAt;
@override@JsonKey(includeIfNull: false, name: 'revoke_at') final  DateTime? revokeAt;
@override@JsonKey(includeIfNull: false) final  String? headline;
@override@JsonKey(includeIfNull: false) final  dynamic body;

/// Create a copy of Telegram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramCopyWith<_Telegram> get copyWith => __$TelegramCopyWithImpl<_Telegram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Telegram&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other._publishingOffice, _publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&const DeepCollectionEquality().equals(other.body, body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(_publishingOffice),pressAt,reportAt,infoKind,infoKindVersion,hash,createdAt,serialNo,targetAt,revokeAt,headline,const DeepCollectionEquality().hash(body)]);

@override
String toString() {
  return 'Telegram(id: $id, eventId: $eventId, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, serialNo: $serialNo, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, body: $body)';
}


}

/// @nodoc
abstract mixin class _$TelegramCopyWith<$Res> implements $TelegramCopyWith<$Res> {
  factory _$TelegramCopyWith(_Telegram value, $Res Function(_Telegram) _then) = __$TelegramCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_id') String eventId, TelegramType type, String title, TelegramStatus status,@JsonKey(name: 'info_type') InfoType infoType,@JsonKey(name: 'editorial_office') String editorialOffice,@JsonKey(name: 'publishing_office') List<String> publishingOffice,@JsonKey(name: 'press_at') DateTime pressAt,@JsonKey(name: 'report_at') DateTime reportAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(name: 'info_kind_version') String infoKindVersion, String hash,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'target_at') DateTime? targetAt,@JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? revokeAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) dynamic body
});




}
/// @nodoc
class __$TelegramCopyWithImpl<$Res>
    implements _$TelegramCopyWith<$Res> {
  __$TelegramCopyWithImpl(this._self, this._then);

  final _Telegram _self;
  final $Res Function(_Telegram) _then;

/// Create a copy of Telegram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? serialNo = freezed,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? body = freezed,}) {
  return _then(_Telegram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self._publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
