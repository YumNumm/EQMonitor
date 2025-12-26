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

 String get id; String get eventId; int? get serialNo; TelegramType get type; String get title; TelegramStatus get status; TelegramInfoType get infoType; String get editorialOffice; List<String> get publishingOffice; DateTime get pressAt; DateTime get reportAt; DateTime? get targetAt; DateTime? get revokeAt; String? get headline; String get infoKind; String get infoKindVersion; String get hash; DateTime get createdAt;
/// Create a copy of Telegram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramCopyWith<Telegram> get copyWith => _$TelegramCopyWithImpl<Telegram>(this as Telegram, _$identity);

  /// Serializes this Telegram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Telegram&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other.publishingOffice, publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,serialNo,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(publishingOffice),pressAt,reportAt,targetAt,revokeAt,headline,infoKind,infoKindVersion,hash,createdAt);

@override
String toString() {
  return 'Telegram(id: $id, eventId: $eventId, serialNo: $serialNo, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TelegramCopyWith<$Res>  {
  factory $TelegramCopyWith(Telegram value, $Res Function(Telegram) _then) = _$TelegramCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, int? serialNo, TelegramType type, String title, TelegramStatus status, TelegramInfoType infoType, String editorialOffice, List<String> publishingOffice, DateTime pressAt, DateTime reportAt, DateTime? targetAt, DateTime? revokeAt, String? headline, String infoKind, String infoKindVersion, String hash, DateTime createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? serialNo = freezed,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self.publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  int? serialNo,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  DateTime? targetAt,  DateTime? revokeAt,  String? headline,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Telegram() when $default != null:
return $default(_that.id,_that.eventId,_that.serialNo,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.targetAt,_that.revokeAt,_that.headline,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  int? serialNo,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  DateTime? targetAt,  DateTime? revokeAt,  String? headline,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Telegram():
return $default(_that.id,_that.eventId,_that.serialNo,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.targetAt,_that.revokeAt,_that.headline,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  int? serialNo,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  DateTime? targetAt,  DateTime? revokeAt,  String? headline,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Telegram() when $default != null:
return $default(_that.id,_that.eventId,_that.serialNo,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.targetAt,_that.revokeAt,_that.headline,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Telegram implements Telegram {
  const _Telegram({required this.id, required this.eventId, this.serialNo, required this.type, required this.title, required this.status, required this.infoType, required this.editorialOffice, required final  List<String> publishingOffice, required this.pressAt, required this.reportAt, this.targetAt, this.revokeAt, this.headline, required this.infoKind, required this.infoKindVersion, required this.hash, required this.createdAt}): _publishingOffice = publishingOffice;
  factory _Telegram.fromJson(Map<String, dynamic> json) => _$TelegramFromJson(json);

@override final  String id;
@override final  String eventId;
@override final  int? serialNo;
@override final  TelegramType type;
@override final  String title;
@override final  TelegramStatus status;
@override final  TelegramInfoType infoType;
@override final  String editorialOffice;
 final  List<String> _publishingOffice;
@override List<String> get publishingOffice {
  if (_publishingOffice is EqualUnmodifiableListView) return _publishingOffice;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_publishingOffice);
}

@override final  DateTime pressAt;
@override final  DateTime reportAt;
@override final  DateTime? targetAt;
@override final  DateTime? revokeAt;
@override final  String? headline;
@override final  String infoKind;
@override final  String infoKindVersion;
@override final  String hash;
@override final  DateTime createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Telegram&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other._publishingOffice, _publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,serialNo,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(_publishingOffice),pressAt,reportAt,targetAt,revokeAt,headline,infoKind,infoKindVersion,hash,createdAt);

@override
String toString() {
  return 'Telegram(id: $id, eventId: $eventId, serialNo: $serialNo, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TelegramCopyWith<$Res> implements $TelegramCopyWith<$Res> {
  factory _$TelegramCopyWith(_Telegram value, $Res Function(_Telegram) _then) = __$TelegramCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, int? serialNo, TelegramType type, String title, TelegramStatus status, TelegramInfoType infoType, String editorialOffice, List<String> publishingOffice, DateTime pressAt, DateTime reportAt, DateTime? targetAt, DateTime? revokeAt, String? headline, String infoKind, String infoKindVersion, String hash, DateTime createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? serialNo = freezed,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,}) {
  return _then(_Telegram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self._publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$TelegramDetail {

 String get id; String get eventId; int? get serialNo; TelegramType get type; String get title; TelegramStatus get status; TelegramInfoType get infoType; String get editorialOffice; List<String> get publishingOffice; DateTime get pressAt; DateTime get reportAt; DateTime? get targetAt; DateTime? get revokeAt; String? get headline; String get infoKind; String get infoKindVersion; String get hash; DateTime get createdAt; Object? get body;
/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramDetailCopyWith<TelegramDetail> get copyWith => _$TelegramDetailCopyWithImpl<TelegramDetail>(this as TelegramDetail, _$identity);

  /// Serializes this TelegramDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other.publishingOffice, publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.body, body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,serialNo,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(publishingOffice),pressAt,reportAt,targetAt,revokeAt,headline,infoKind,infoKindVersion,hash,createdAt,const DeepCollectionEquality().hash(body)]);

@override
String toString() {
  return 'TelegramDetail(id: $id, eventId: $eventId, serialNo: $serialNo, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, body: $body)';
}


}

/// @nodoc
abstract mixin class $TelegramDetailCopyWith<$Res>  {
  factory $TelegramDetailCopyWith(TelegramDetail value, $Res Function(TelegramDetail) _then) = _$TelegramDetailCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, int? serialNo, TelegramType type, String title, TelegramStatus status, TelegramInfoType infoType, String editorialOffice, List<String> publishingOffice, DateTime pressAt, DateTime reportAt, DateTime? targetAt, DateTime? revokeAt, String? headline, String infoKind, String infoKindVersion, String hash, DateTime createdAt, Object? body
});




}
/// @nodoc
class _$TelegramDetailCopyWithImpl<$Res>
    implements $TelegramDetailCopyWith<$Res> {
  _$TelegramDetailCopyWithImpl(this._self, this._then);

  final TelegramDetail _self;
  final $Res Function(TelegramDetail) _then;

/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? serialNo = freezed,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? body = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self.publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,body: freezed == body ? _self.body : body ,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  int? serialNo,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  DateTime? targetAt,  DateTime? revokeAt,  String? headline,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt,  Object? body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramDetail() when $default != null:
return $default(_that.id,_that.eventId,_that.serialNo,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.targetAt,_that.revokeAt,_that.headline,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  int? serialNo,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  DateTime? targetAt,  DateTime? revokeAt,  String? headline,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt,  Object? body)  $default,) {final _that = this;
switch (_that) {
case _TelegramDetail():
return $default(_that.id,_that.eventId,_that.serialNo,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.targetAt,_that.revokeAt,_that.headline,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  int? serialNo,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  DateTime? targetAt,  DateTime? revokeAt,  String? headline,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt,  Object? body)?  $default,) {final _that = this;
switch (_that) {
case _TelegramDetail() when $default != null:
return $default(_that.id,_that.eventId,_that.serialNo,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.targetAt,_that.revokeAt,_that.headline,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramDetail implements TelegramDetail {
  const _TelegramDetail({required this.id, required this.eventId, this.serialNo, required this.type, required this.title, required this.status, required this.infoType, required this.editorialOffice, required final  List<String> publishingOffice, required this.pressAt, required this.reportAt, this.targetAt, this.revokeAt, this.headline, required this.infoKind, required this.infoKindVersion, required this.hash, required this.createdAt, this.body}): _publishingOffice = publishingOffice;
  factory _TelegramDetail.fromJson(Map<String, dynamic> json) => _$TelegramDetailFromJson(json);

@override final  String id;
@override final  String eventId;
@override final  int? serialNo;
@override final  TelegramType type;
@override final  String title;
@override final  TelegramStatus status;
@override final  TelegramInfoType infoType;
@override final  String editorialOffice;
 final  List<String> _publishingOffice;
@override List<String> get publishingOffice {
  if (_publishingOffice is EqualUnmodifiableListView) return _publishingOffice;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_publishingOffice);
}

@override final  DateTime pressAt;
@override final  DateTime reportAt;
@override final  DateTime? targetAt;
@override final  DateTime? revokeAt;
@override final  String? headline;
@override final  String infoKind;
@override final  String infoKindVersion;
@override final  String hash;
@override final  DateTime createdAt;
@override final  Object? body;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other._publishingOffice, _publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.body, body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,eventId,serialNo,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(_publishingOffice),pressAt,reportAt,targetAt,revokeAt,headline,infoKind,infoKindVersion,hash,createdAt,const DeepCollectionEquality().hash(body)]);

@override
String toString() {
  return 'TelegramDetail(id: $id, eventId: $eventId, serialNo: $serialNo, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, body: $body)';
}


}

/// @nodoc
abstract mixin class _$TelegramDetailCopyWith<$Res> implements $TelegramDetailCopyWith<$Res> {
  factory _$TelegramDetailCopyWith(_TelegramDetail value, $Res Function(_TelegramDetail) _then) = __$TelegramDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, int? serialNo, TelegramType type, String title, TelegramStatus status, TelegramInfoType infoType, String editorialOffice, List<String> publishingOffice, DateTime pressAt, DateTime reportAt, DateTime? targetAt, DateTime? revokeAt, String? headline, String infoKind, String infoKindVersion, String hash, DateTime createdAt, Object? body
});




}
/// @nodoc
class __$TelegramDetailCopyWithImpl<$Res>
    implements _$TelegramDetailCopyWith<$Res> {
  __$TelegramDetailCopyWithImpl(this._self, this._then);

  final _TelegramDetail _self;
  final $Res Function(_TelegramDetail) _then;

/// Create a copy of TelegramDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? serialNo = freezed,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? body = freezed,}) {
  return _then(_TelegramDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self._publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,body: freezed == body ? _self.body : body ,
  ));
}


}

// dart format on
