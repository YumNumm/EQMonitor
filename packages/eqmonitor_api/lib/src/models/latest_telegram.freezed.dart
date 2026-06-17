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

 TelegramType get type; String get title;@JsonKey(name: 'press_at') DateTime get pressAt;@JsonKey(name: 'report_at') DateTime get reportAt;@JsonKey(name: 'info_kind') String get infoKind;@JsonKey(includeIfNull: false, name: 'serial_no') num? get serialNo;@JsonKey(includeIfNull: false, name: 'target_at') DateTime? get targetAt;@JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? get revokeAt;@JsonKey(includeIfNull: false) String? get headline;@JsonKey(includeIfNull: false) TsunamiComments? get comments;@JsonKey(includeIfNull: false) String? get text;
/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatestTelegramCopyWith<LatestTelegram> get copyWith => _$LatestTelegramCopyWithImpl<LatestTelegram>(this as LatestTelegram, _$identity);

  /// Serializes this LatestTelegram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatestTelegram&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,pressAt,reportAt,infoKind,serialNo,targetAt,revokeAt,headline,comments,text);

@override
String toString() {
  return 'LatestTelegram(type: $type, title: $title, pressAt: $pressAt, reportAt: $reportAt, infoKind: $infoKind, serialNo: $serialNo, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, comments: $comments, text: $text)';
}


}

/// @nodoc
abstract mixin class $LatestTelegramCopyWith<$Res>  {
  factory $LatestTelegramCopyWith(LatestTelegram value, $Res Function(LatestTelegram) _then) = _$LatestTelegramCopyWithImpl;
@useResult
$Res call({
 TelegramType type, String title,@JsonKey(name: 'press_at') DateTime pressAt,@JsonKey(name: 'report_at') DateTime reportAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'target_at') DateTime? targetAt,@JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? revokeAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) TsunamiComments? comments,@JsonKey(includeIfNull: false) String? text
});


$TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$LatestTelegramCopyWithImpl<$Res>
    implements $LatestTelegramCopyWith<$Res> {
  _$LatestTelegramCopyWithImpl(this._self, this._then);

  final LatestTelegram _self;
  final $Res Function(LatestTelegram) _then;

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? title = null,Object? pressAt = null,Object? reportAt = null,Object? infoKind = null,Object? serialNo = freezed,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? comments = freezed,Object? text = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TelegramType type,  String title, @JsonKey(name: 'press_at')  DateTime pressAt, @JsonKey(name: 'report_at')  DateTime reportAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'target_at')  DateTime? targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at')  DateTime? revokeAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  TsunamiComments? comments, @JsonKey(includeIfNull: false)  String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatestTelegram() when $default != null:
return $default(_that.type,_that.title,_that.pressAt,_that.reportAt,_that.infoKind,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline,_that.comments,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TelegramType type,  String title, @JsonKey(name: 'press_at')  DateTime pressAt, @JsonKey(name: 'report_at')  DateTime reportAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'target_at')  DateTime? targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at')  DateTime? revokeAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  TsunamiComments? comments, @JsonKey(includeIfNull: false)  String? text)  $default,) {final _that = this;
switch (_that) {
case _LatestTelegram():
return $default(_that.type,_that.title,_that.pressAt,_that.reportAt,_that.infoKind,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline,_that.comments,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TelegramType type,  String title, @JsonKey(name: 'press_at')  DateTime pressAt, @JsonKey(name: 'report_at')  DateTime reportAt, @JsonKey(name: 'info_kind')  String infoKind, @JsonKey(includeIfNull: false, name: 'serial_no')  num? serialNo, @JsonKey(includeIfNull: false, name: 'target_at')  DateTime? targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at')  DateTime? revokeAt, @JsonKey(includeIfNull: false)  String? headline, @JsonKey(includeIfNull: false)  TsunamiComments? comments, @JsonKey(includeIfNull: false)  String? text)?  $default,) {final _that = this;
switch (_that) {
case _LatestTelegram() when $default != null:
return $default(_that.type,_that.title,_that.pressAt,_that.reportAt,_that.infoKind,_that.serialNo,_that.targetAt,_that.revokeAt,_that.headline,_that.comments,_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatestTelegram implements LatestTelegram {
  const _LatestTelegram({required this.type, required this.title, @JsonKey(name: 'press_at') required this.pressAt, @JsonKey(name: 'report_at') required this.reportAt, @JsonKey(name: 'info_kind') required this.infoKind, @JsonKey(includeIfNull: false, name: 'serial_no') this.serialNo, @JsonKey(includeIfNull: false, name: 'target_at') this.targetAt, @JsonKey(includeIfNull: false, name: 'revoke_at') this.revokeAt, @JsonKey(includeIfNull: false) this.headline, @JsonKey(includeIfNull: false) this.comments, @JsonKey(includeIfNull: false) this.text});
  factory _LatestTelegram.fromJson(Map<String, dynamic> json) => _$LatestTelegramFromJson(json);

@override final  TelegramType type;
@override final  String title;
@override@JsonKey(name: 'press_at') final  DateTime pressAt;
@override@JsonKey(name: 'report_at') final  DateTime reportAt;
@override@JsonKey(name: 'info_kind') final  String infoKind;
@override@JsonKey(includeIfNull: false, name: 'serial_no') final  num? serialNo;
@override@JsonKey(includeIfNull: false, name: 'target_at') final  DateTime? targetAt;
@override@JsonKey(includeIfNull: false, name: 'revoke_at') final  DateTime? revokeAt;
@override@JsonKey(includeIfNull: false) final  String? headline;
@override@JsonKey(includeIfNull: false) final  TsunamiComments? comments;
@override@JsonKey(includeIfNull: false) final  String? text;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatestTelegram&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.infoKind, infoKind) || other.infoKind == infoKind)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.targetAt, targetAt) || other.targetAt == targetAt)&&(identical(other.revokeAt, revokeAt) || other.revokeAt == revokeAt)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.comments, comments) || other.comments == comments)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,pressAt,reportAt,infoKind,serialNo,targetAt,revokeAt,headline,comments,text);

@override
String toString() {
  return 'LatestTelegram(type: $type, title: $title, pressAt: $pressAt, reportAt: $reportAt, infoKind: $infoKind, serialNo: $serialNo, targetAt: $targetAt, revokeAt: $revokeAt, headline: $headline, comments: $comments, text: $text)';
}


}

/// @nodoc
abstract mixin class _$LatestTelegramCopyWith<$Res> implements $LatestTelegramCopyWith<$Res> {
  factory _$LatestTelegramCopyWith(_LatestTelegram value, $Res Function(_LatestTelegram) _then) = __$LatestTelegramCopyWithImpl;
@override @useResult
$Res call({
 TelegramType type, String title,@JsonKey(name: 'press_at') DateTime pressAt,@JsonKey(name: 'report_at') DateTime reportAt,@JsonKey(name: 'info_kind') String infoKind,@JsonKey(includeIfNull: false, name: 'serial_no') num? serialNo,@JsonKey(includeIfNull: false, name: 'target_at') DateTime? targetAt,@JsonKey(includeIfNull: false, name: 'revoke_at') DateTime? revokeAt,@JsonKey(includeIfNull: false) String? headline,@JsonKey(includeIfNull: false) TsunamiComments? comments,@JsonKey(includeIfNull: false) String? text
});


@override $TsunamiCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$LatestTelegramCopyWithImpl<$Res>
    implements _$LatestTelegramCopyWith<$Res> {
  __$LatestTelegramCopyWithImpl(this._self, this._then);

  final _LatestTelegram _self;
  final $Res Function(_LatestTelegram) _then;

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? title = null,Object? pressAt = null,Object? reportAt = null,Object? infoKind = null,Object? serialNo = freezed,Object? targetAt = freezed,Object? revokeAt = freezed,Object? headline = freezed,Object? comments = freezed,Object? text = freezed,}) {
  return _then(_LatestTelegram(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TelegramType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,infoKind: null == infoKind ? _self.infoKind : infoKind // ignore: cast_nullable_to_non_nullable
as String,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as num?,targetAt: freezed == targetAt ? _self.targetAt : targetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokeAt: freezed == revokeAt ? _self.revokeAt : revokeAt // ignore: cast_nullable_to_non_nullable
as DateTime?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TsunamiComments?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LatestTelegram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TsunamiCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
