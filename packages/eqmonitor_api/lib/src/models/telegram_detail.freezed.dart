// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TelegramDetail {

 String get id;@JsonKey(name: 'event_id') String get eventId; TelegramType get type; String get title; TelegramStatus get status;@JsonKey(name: 'info_type') InfoType get infoType;@JsonKey(name: 'editorial_office') String get editorialOffice;@JsonKey(name: 'publishing_office') List<String> get publishingOffice;@JsonKey(name: 'pressed_at') DateTime get pressedAt;@JsonKey(name: 'reported_at') DateTime get reportedAt;@JsonKey(name: 'info_kind') String get infoKind;@JsonKey(name: 'info_kind_version') String get infoKindVersion; String get hash;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(includeIfNull: true) TelegramBodyUnion? get body;@JsonKey(includeIfNull: false, name: 'serial_no') num? get serialNo;@JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? get targetedAt;@JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? get revokedAt;@JsonKey(includeIfNull: false) String? get headline;
/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramDetailCopyWith<TelegramDetail> get copyWith => _$TelegramDetailCopyWithImpl<TelegramDetail>(this as TelegramDetail, _$identity);

  /// Serializes this TelegramDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other.publishingOffice, publishingOffice)&&(identical(other.pressedAt, pressedAt) || other.pressedAt == pressedAt)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.body, body) || other.body == body)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetedAt, targetedAt) || other.targetedAt == targetedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.headline, headline) || other.headline == headline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(publishingOffice),pressedAt,reportedAt,infoKind,infoKindVersion,hash,createdAt,body,serialNo,targetedAt,revokedAt,headline]);

@override
String toString() {
  return 'TelegramDetail(id: $id, eventId: $eventId, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressedAt: $pressedAt, reportedAt: $reportedAt, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, body: $body, serialNo: $serialNo, targetedAt: $targetedAt, revokedAt: $revokedAt, headline: $headline)';
}


}

/// @nodoc
abstract mixin class $TelegramDetailCopyWith<$Res>  {
  factory $TelegramDetailCopyWith(TelegramDetail value, $Res Function(TelegramDetail) _then) = _$TelegramDetailCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_id') String eventId, TelegramType type, String title, TelegramStatus status,@JsonKey(name: 'info_type') InfoType infoType,@JsonKey(name: 'editorial_office') String editorialOffice,@JsonKey(name: 'publishing_office') List<String> publishingOffice,@JsonKey(name: 'pressed_at') DateTime pressedAt,@JsonKey(name: 'reported_at') DateTime reportedAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(name: 'info_kind_version') String infoKindVersion, String hash,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(includeIfNull: true) TelegramBodyUnion? body,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? targetedAt,@JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? revokedAt,@JsonKey(includeIfNull: false) String? headline
});


$TelegramBodyUnionCopyWith<$Res>? get body;

}
/// @nodoc
class _$TelegramDetailCopyWithImpl<$Res>
    implements $TelegramDetailCopyWith<$Res> {
  _$TelegramDetailCopyWithImpl(this._self, this._then);

  final TelegramDetail _self;
  final $Res Function(TelegramDetail) _then;

/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressedAt = null,Object? reportedAt = null,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? body = freezed,Object? serialNo = freezed,Object? targetedAt = freezed,Object? revokedAt = freezed,Object? headline = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self.publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressedAt: null == pressedAt ? _self.pressedAt : pressedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as TelegramBodyUnion?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetedAt: freezed == targetedAt ? _self.targetedAt : targetedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramBodyUnionCopyWith<$Res>? get body {
    if (_self.body == null) {
    return null;
  }

  return $TelegramBodyUnionCopyWith<$Res>(_self.body!, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}


/// Adds pattern-matching-related methods to [TelegramDetail].
extension TelegramDetailPatterns on TelegramDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramDetail value)  $default,){
final _that = this;
switch (_that) {
case _TelegramDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_id')  String eventId,  TelegramType type,  String title,  TelegramStatus status, @JsonKey(name: 'info_type')  InfoType infoType, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'pressed_at')  DateTime pressedAt, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(name: 'info_kind_version')  String infoKindVersion,  String hash, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeIfNull: true)  TelegramBodyUnion? body, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at')  DateTime? targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at')  DateTime? revokedAt, @JsonKey(includeIfNull: false)  String? headline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramDetail() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressedAt,_that.reportedAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.body,_that.serialNo,_that.targetedAt,_that.revokedAt,_that.headline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_id')  String eventId,  TelegramType type,  String title,  TelegramStatus status, @JsonKey(name: 'info_type')  InfoType infoType, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'pressed_at')  DateTime pressedAt, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(name: 'info_kind_version')  String infoKindVersion,  String hash, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeIfNull: true)  TelegramBodyUnion? body, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at')  DateTime? targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at')  DateTime? revokedAt, @JsonKey(includeIfNull: false)  String? headline)  $default,) {final _that = this;
switch (_that) {
case _TelegramDetail():
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressedAt,_that.reportedAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.body,_that.serialNo,_that.targetedAt,_that.revokedAt,_that.headline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_id')  String eventId,  TelegramType type,  String title,  TelegramStatus status, @JsonKey(name: 'info_type')  InfoType infoType, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'pressed_at')  DateTime pressedAt, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(name: 'info_kind_version')  String infoKindVersion,  String hash, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(includeIfNull: true)  TelegramBodyUnion? body, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at')  DateTime? targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at')  DateTime? revokedAt, @JsonKey(includeIfNull: false)  String? headline)?  $default,) {final _that = this;
switch (_that) {
case _TelegramDetail() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressedAt,_that.reportedAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.body,_that.serialNo,_that.targetedAt,_that.revokedAt,_that.headline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramDetail implements TelegramDetail {
  const _TelegramDetail({required this.id, @JsonKey(name: 'event_id') required this.eventId, required this.type, required this.title, required this.status, @JsonKey(name: 'info_type') required this.infoType, @JsonKey(name: 'editorial_office') required this.editorialOffice, @JsonKey(name: 'publishing_office') required final  List<String> publishingOffice, @JsonKey(name: 'pressed_at') required this.pressedAt, @JsonKey(name: 'reported_at') required this.reportedAt, @JsonKey(name: 'info_kind') required this.infoKind, @JsonKey(name: 'info_kind_version') required this.infoKindVersion, required this.hash, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(includeIfNull: true) required this.body, @JsonKey(includeIfNull: false, name: 'serial_no') this.serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at') this.targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at') this.revokedAt, @JsonKey(includeIfNull: false) this.headline}): _publishingOffice = publishingOffice;
  factory _TelegramDetail.fromJson(Map<String, dynamic> json) => _$TelegramDetailFromJson(json);

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

@override@JsonKey(name: 'pressed_at') final  DateTime pressedAt;
@override@JsonKey(name: 'reported_at') final  DateTime reportedAt;
@override@JsonKey(name: 'info_kind') final  String infoKind;
@override@JsonKey(name: 'info_kind_version') final  String infoKindVersion;
@override final  String hash;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(includeIfNull: true) final  TelegramBodyUnion? body;
@override@JsonKey(includeIfNull: false, name: 'serial_no') final  num? serialNo;
@override@JsonKey(includeIfNull: false, name: 'targeted_at') final  DateTime? targetedAt;
@override@JsonKey(includeIfNull: false, name: 'revoked_at') final  DateTime? revokedAt;
@override@JsonKey(includeIfNull: false) final  String? headline;

/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramDetailCopyWith<_TelegramDetail> get copyWith => __$TelegramDetailCopyWithImpl<_TelegramDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other._publishingOffice, _publishingOffice)&&(identical(other.pressedAt, pressedAt) || other.pressedAt == pressedAt)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.body, body) || other.body == body)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetedAt, targetedAt) || other.targetedAt == targetedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.headline, headline) || other.headline == headline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(_publishingOffice),pressedAt,reportedAt,infoKind,infoKindVersion,hash,createdAt,body,serialNo,targetedAt,revokedAt,headline]);

@override
String toString() {
  return 'TelegramDetail(id: $id, eventId: $eventId, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressedAt: $pressedAt, reportedAt: $reportedAt, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, body: $body, serialNo: $serialNo, targetedAt: $targetedAt, revokedAt: $revokedAt, headline: $headline)';
}


}

/// @nodoc
abstract mixin class _$TelegramDetailCopyWith<$Res> implements $TelegramDetailCopyWith<$Res> {
  factory _$TelegramDetailCopyWith(_TelegramDetail value, $Res Function(_TelegramDetail) _then) = __$TelegramDetailCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_id') String eventId, TelegramType type, String title, TelegramStatus status,@JsonKey(name: 'info_type') InfoType infoType,@JsonKey(name: 'editorial_office') String editorialOffice,@JsonKey(name: 'publishing_office') List<String> publishingOffice,@JsonKey(name: 'pressed_at') DateTime pressedAt,@JsonKey(name: 'reported_at') DateTime reportedAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(name: 'info_kind_version') String infoKindVersion, String hash,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(includeIfNull: true) TelegramBodyUnion? body,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? targetedAt,@JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? revokedAt,@JsonKey(includeIfNull: false) String? headline
});


@override $TelegramBodyUnionCopyWith<$Res>? get body;

}
/// @nodoc
class __$TelegramDetailCopyWithImpl<$Res>
    implements _$TelegramDetailCopyWith<$Res> {
  __$TelegramDetailCopyWithImpl(this._self, this._then);

  final _TelegramDetail _self;
  final $Res Function(_TelegramDetail) _then;

/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressedAt = null,Object? reportedAt = null,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? body = freezed,Object? serialNo = freezed,Object? targetedAt = freezed,Object? revokedAt = freezed,Object? headline = freezed,}) {
  return _then(_TelegramDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self._publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressedAt: null == pressedAt ? _self.pressedAt : pressedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as TelegramBodyUnion?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetedAt: freezed == targetedAt ? _self.targetedAt : targetedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramBodyUnionCopyWith<$Res>? get body {
    if (_self.body == null) {
    return null;
  }

  return $TelegramBodyUnionCopyWith<$Res>(_self.body!, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}

// dart format on
