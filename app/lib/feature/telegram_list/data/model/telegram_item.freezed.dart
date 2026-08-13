// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TelegramItem {

 String get id; String get eventId; TelegramType get type; String get title; TelegramStatus get status; TelegramInfoType get infoType; String get editorialOffice; List<String> get publishingOffice; DateTime get pressAt; DateTime get reportAt; String get infoKind; String get infoKindVersion; String get hash; DateTime get createdAt; int? get serialNo; DateTime? get targetAt; DateTime? get revokeAt; String? get headline;
/// Create a copy of TelegramItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramItemCopyWith<TelegramItem> get copyWith => _$TelegramItemCopyWithImpl<TelegramItem>(this as TelegramItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramItem&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other.publishingOffice, publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline));
}


@override
int get hashCode => Object.hash(runtimeType,id,eventId,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(publishingOffice),pressAt,reportAt,infoKind,infoKindVersion,hash,createdAt,serialNo,targetAt,revokeAt,headline);

@override
String toString() {
  return 'TelegramItem(id: $id, eventId: $eventId, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, serialNo: $serialNo, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline)';
}


}

/// @nodoc
abstract mixin class $TelegramItemCopyWith<$Res>  {
  factory $TelegramItemCopyWith(TelegramItem value, $Res Function(TelegramItem) _then) = _$TelegramItemCopyWithImpl;
@useResult
$Res call({
 String id, String eventId, TelegramType type, String title, TelegramStatus status, TelegramInfoType infoType, String editorialOffice, List<String> publishingOffice, DateTime pressAt, DateTime reportAt, String infoKind, String infoKindVersion, String hash, DateTime createdAt, int? serialNo, DateTime? targetAt, DateTime? revokeAt, String? headline
});




}
/// @nodoc
class _$TelegramItemCopyWithImpl<$Res>
    implements $TelegramItemCopyWith<$Res> {
  _$TelegramItemCopyWithImpl(this._self, this._then);

  final TelegramItem _self;
  final $Res Function(TelegramItem) _then;

/// Create a copy of TelegramItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? serialNo = freezed,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,}) {
  return _then(TelegramItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self.publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramItem].
extension TelegramItemPatterns on TelegramItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramItem value)  $default,){
final _that = this;
switch (_that) {
case _TelegramItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramItem value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String eventId,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt,  int? serialNo,  DateTime? targetAt,  DateTime? revokeAt,  String? headline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramItem() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String eventId,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt,  int? serialNo,  DateTime? targetAt,  DateTime? revokeAt,  String? headline)  $default,) {final _that = this;
switch (_that) {
case _TelegramItem():
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String eventId,  TelegramType type,  String title,  TelegramStatus status,  TelegramInfoType infoType,  String editorialOffice,  List<String> publishingOffice,  DateTime pressAt,  DateTime reportAt,  String infoKind,  String infoKindVersion,  String hash,  DateTime createdAt,  int? serialNo,  DateTime? targetAt,  DateTime? revokeAt,  String? headline)?  $default,) {final _that = this;
switch (_that) {
case _TelegramItem() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.title,_that.status,_that.infoType,_that.editorialOffice,_that.publishingOffice,_that.pressAt,_that.reportAt,_that.infoKind,_that.infoKindVersion,_that.hash,_that.createdAt,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline);case _:
  return null;

}
}

}

/// @nodoc


class _TelegramItem implements TelegramItem {
  const _TelegramItem({required this.id, required this.eventId, required this.type, required this.title, required this.status, required this.infoType, required this.editorialOffice, required  List<String> publishingOffice, required this.pressAt, required this.reportAt, required this.infoKind, required this.infoKindVersion, required this.hash, required this.createdAt, this.serialNo, this.targetAt, this.revokeAt, this.headline}): _publishingOffice = publishingOffice;
  

@override final  String id;
@override final  String eventId;
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
@override final  String infoKind;
@override final  String infoKindVersion;
@override final  String hash;
@override final  DateTime createdAt;
@override final  int? serialNo;
@override final  DateTime? targetAt;
@override final  DateTime? revokeAt;
@override final  String? headline;

/// Create a copy of TelegramItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramItemCopyWith<_TelegramItem> get copyWith => __$TelegramItemCopyWithImpl<_TelegramItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramItem&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other._publishingOffice, _publishingOffice)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.infoKindVersion, infoKindVersion) || other.infoKindVersion == infoKindVersion)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline));
}


@override
int get hashCode => Object.hash(runtimeType,id,eventId,type,title,status,infoType,editorialOffice,const DeepCollectionEquality().hash(_publishingOffice),pressAt,reportAt,infoKind,infoKindVersion,hash,createdAt,serialNo,targetAt,revokeAt,headline);

@override
String toString() {
  return 'TelegramItem(id: $id, eventId: $eventId, type: $type, title: $title, status: $status, infoType: $infoType, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressAt: $pressAt, reportAt: $reportAt, infoKind: $infoKind, infoKindVersion: $infoKindVersion, hash: $hash, createdAt: $createdAt, serialNo: $serialNo, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline)';
}


}

/// @nodoc
abstract mixin class _$TelegramItemCopyWith<$Res> implements $TelegramItemCopyWith<$Res> {
  factory _$TelegramItemCopyWith(_TelegramItem value, $Res Function(_TelegramItem) _then) = __$TelegramItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String eventId, TelegramType type, String title, TelegramStatus status, TelegramInfoType infoType, String editorialOffice, List<String> publishingOffice, DateTime pressAt, DateTime reportAt, String infoKind, String infoKindVersion, String hash, DateTime createdAt, int? serialNo, DateTime? targetAt, DateTime? revokeAt, String? headline
});




}
/// @nodoc
class __$TelegramItemCopyWithImpl<$Res>
    implements _$TelegramItemCopyWith<$Res> {
  __$TelegramItemCopyWithImpl(this._self, this._then);

  final _TelegramItem _self;
  final $Res Function(_TelegramItem) _then;

/// Create a copy of TelegramItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? title = null,Object? status = null,Object? infoType = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressAt = null,Object? reportAt = null,Object? infoKind = null,Object? infoKindVersion = null,Object? hash = null,Object? createdAt = null,Object? serialNo = freezed,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,}) {
  return _then(_TelegramItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as TelegramInfoType,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self._publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,infoKindVersion: null == infoKindVersion ? _self.infoKindVersion : infoKindVersion // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
