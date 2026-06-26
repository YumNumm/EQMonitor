// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest_telegram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatestTelegram {

 String get id; TelegramType get type; String get title;@JsonKey(name: 'editorial_office') String get editorialOffice;@JsonKey(name: 'publishing_office') List<String> get publishingOffice;@JsonKey(name: 'pressed_at') DateTime get pressedAt;@JsonKey(name: 'reported_at') DateTime get reportedAt;@JsonKey(name: 'info_kind') String get infoKind;@JsonKey(includeIfNull: false, name: 'serial_no') num? get serialNo;@JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? get targetedAt;@JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? get revokedAt;@JsonKey(includeIfNull: false) String? get headline;@JsonKey(includeIfNull: false) TsunamiTelegramComments? get comments;
/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatestTelegramCopyWith<LatestTelegram> get copyWith => _$LatestTelegramCopyWithImpl<LatestTelegram>(this as LatestTelegram, _$identity);

  /// Serializes this LatestTelegram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatestTelegram&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other.publishingOffice, publishingOffice)&&(identical(other.pressedAt, pressedAt) || other.pressedAt == pressedAt)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetedAt, targetedAt) || other.targetedAt == targetedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,editorialOffice,const DeepCollectionEquality().hash(publishingOffice),pressedAt,reportedAt,infoKind,serialNo,targetedAt,revokedAt,headline,comments);

@override
String toString() {
  return 'LatestTelegram(id: $id, type: $type, title: $title, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressedAt: $pressedAt, reportedAt: $reportedAt, infoKind: $infoKind, serialNo: $serialNo, targetedAt: $targetedAt, revokedAt: $revokedAt, headline: $headline, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $LatestTelegramCopyWith<$Res>  {
  factory $LatestTelegramCopyWith(LatestTelegram value, $Res Function(LatestTelegram) _then) = _$LatestTelegramCopyWithImpl;
@useResult
$Res call({
 String id, TelegramType type, String title,@JsonKey(name: 'editorial_office') String editorialOffice,@JsonKey(name: 'publishing_office') List<String> publishingOffice,@JsonKey(name: 'pressed_at') DateTime pressedAt,@JsonKey(name: 'reported_at') DateTime reportedAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? targetedAt,@JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? revokedAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) TsunamiTelegramComments? comments
});


$TsunamiTelegramCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$LatestTelegramCopyWithImpl<$Res>
    implements $LatestTelegramCopyWith<$Res> {
  _$LatestTelegramCopyWithImpl(this._self, this._then);

  final LatestTelegram _self;
  final $Res Function(LatestTelegram) _then;

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressedAt = null,Object? reportedAt = null,Object? infoKind = null,Object? serialNo = freezed,Object? targetedAt = freezed,Object? revokedAt = freezed,Object? headline = freezed,Object? comments = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self.publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressedAt: null == pressedAt ? _self.pressedAt : pressedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetedAt: freezed == targetedAt ? _self.targetedAt : targetedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramComments?,
  ));
}
/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiTelegramCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// Adds pattern-matching-related methods to [LatestTelegram].
extension LatestTelegramPatterns on LatestTelegram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatestTelegram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatestTelegram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatestTelegram value)  $default,){
final _that = this;
switch (_that) {
case _LatestTelegram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatestTelegram value)?  $default,){
final _that = this;
switch (_that) {
case _LatestTelegram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TelegramType type,  String title, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'pressed_at')  DateTime pressedAt, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at')  DateTime? targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at')  DateTime? revokedAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  TsunamiTelegramComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatestTelegram() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.editorialOffice,_that.publishingOffice,_that.pressedAt,_that.reportedAt,_that.infoKind,_that.serialNo,_that.targetedAt,_that.revokedAt,_that.headline,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TelegramType type,  String title, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'pressed_at')  DateTime pressedAt, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at')  DateTime? targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at')  DateTime? revokedAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  TsunamiTelegramComments? comments)  $default,) {final _that = this;
switch (_that) {
case _LatestTelegram():
return $default(_that.id,_that.type,_that.title,_that.editorialOffice,_that.publishingOffice,_that.pressedAt,_that.reportedAt,_that.infoKind,_that.serialNo,_that.targetedAt,_that.revokedAt,_that.headline,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TelegramType type,  String title, @JsonKey(name: 'editorial_office')  String editorialOffice, @JsonKey(name: 'publishing_office')  List<String> publishingOffice, @JsonKey(name: 'pressed_at')  DateTime pressedAt, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at')  DateTime? targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at')  DateTime? revokedAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  TsunamiTelegramComments? comments)?  $default,) {final _that = this;
switch (_that) {
case _LatestTelegram() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.editorialOffice,_that.publishingOffice,_that.pressedAt,_that.reportedAt,_that.infoKind,_that.serialNo,_that.targetedAt,_that.revokedAt,_that.headline,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatestTelegram implements LatestTelegram {
  const _LatestTelegram({required this.id, required this.type, required this.title, @JsonKey(name: 'editorial_office') required this.editorialOffice, @JsonKey(name: 'publishing_office') required final  List<String> publishingOffice, @JsonKey(name: 'pressed_at') required this.pressedAt, @JsonKey(name: 'reported_at') required this.reportedAt, @JsonKey(name: 'info_kind') required this.infoKind, @JsonKey(includeIfNull: false, name: 'serial_no') this.serialNo, @JsonKey(includeIfNull: false, name: 'targeted_at') this.targetedAt, @JsonKey(includeIfNull: false, name: 'revoked_at') this.revokedAt, @JsonKey(includeIfNull: false) this.headline, @JsonKey(includeIfNull: false) this.comments}): _publishingOffice = publishingOffice;
  factory _LatestTelegram.fromJson(Map<String, dynamic> json) => _$LatestTelegramFromJson(json);

@override final  String id;
@override final  TelegramType type;
@override final  String title;
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
@override@JsonKey(includeIfNull: false, name: 'serial_no') final  num? serialNo;
@override@JsonKey(includeIfNull: false, name: 'targeted_at') final  DateTime? targetedAt;
@override@JsonKey(includeIfNull: false, name: 'revoked_at') final  DateTime? revokedAt;
@override@JsonKey(includeIfNull: false) final  String? headline;
@override@JsonKey(includeIfNull: false) final  TsunamiTelegramComments? comments;

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatestTelegramCopyWith<_LatestTelegram> get copyWith => __$LatestTelegramCopyWithImpl<_LatestTelegram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatestTelegramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatestTelegram&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.editorialOffice, editorialOffice) || other.editorialOffice == editorialOffice)&&const DeepCollectionEquality().equals(other._publishingOffice, _publishingOffice)&&(identical(other.pressedAt, pressedAt) || other.pressedAt == pressedAt)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetedAt, targetedAt) || other.targetedAt == targetedAt)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,editorialOffice,const DeepCollectionEquality().hash(_publishingOffice),pressedAt,reportedAt,infoKind,serialNo,targetedAt,revokedAt,headline,comments);

@override
String toString() {
  return 'LatestTelegram(id: $id, type: $type, title: $title, editorialOffice: $editorialOffice, publishingOffice: $publishingOffice, pressedAt: $pressedAt, reportedAt: $reportedAt, infoKind: $infoKind, serialNo: $serialNo, targetedAt: $targetedAt, revokedAt: $revokedAt, headline: $headline, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$LatestTelegramCopyWith<$Res> implements $LatestTelegramCopyWith<$Res> {
  factory _$LatestTelegramCopyWith(_LatestTelegram value, $Res Function(_LatestTelegram) _then) = __$LatestTelegramCopyWithImpl;
@override @useResult
$Res call({
 String id, TelegramType type, String title,@JsonKey(name: 'editorial_office') String editorialOffice,@JsonKey(name: 'publishing_office') List<String> publishingOffice,@JsonKey(name: 'pressed_at') DateTime pressedAt,@JsonKey(name: 'reported_at') DateTime reportedAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'targeted_at') DateTime? targetedAt,@JsonKey(includeIfNull: false, name: 'revoked_at') DateTime? revokedAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) TsunamiTelegramComments? comments
});


@override $TsunamiTelegramCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$LatestTelegramCopyWithImpl<$Res>
    implements _$LatestTelegramCopyWith<$Res> {
  __$LatestTelegramCopyWithImpl(this._self, this._then);

  final _LatestTelegram _self;
  final $Res Function(_LatestTelegram) _then;

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? editorialOffice = null,Object? publishingOffice = null,Object? pressedAt = null,Object? reportedAt = null,Object? infoKind = null,Object? serialNo = freezed,Object? targetedAt = freezed,Object? revokedAt = freezed,Object? headline = freezed,Object? comments = freezed,}) {
  return _then(_LatestTelegram(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,editorialOffice: null == editorialOffice ? _self.editorialOffice : editorialOffice // ignore: cast_nullable_to_non_nullable
as String,publishingOffice: null == publishingOffice ? _self._publishingOffice : publishingOffice // ignore: cast_nullable_to_non_nullable
as List<String>,pressedAt: null == pressedAt ? _self.pressedAt : pressedAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetedAt: freezed == targetedAt ? _self.targetedAt : targetedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramComments?,
  ));
}

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiTelegramCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
