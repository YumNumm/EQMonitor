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
mixin _$TelegramV1 {

 int get id; int get eventId; String get type; String get schemaType; String get status; String get infoType; DateTime get pressTime; DateTime get reportTime; Map<String, dynamic> get body; DateTime? get validTime; int? get serialNo; String? get headline;
/// Create a copy of TelegramV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramV1CopyWith<TelegramV1> get copyWith => _$TelegramV1CopyWithImpl<TelegramV1>(this as TelegramV1, _$identity);

  /// Serializes this TelegramV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramV1&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaType, schemaType) || other.schemaType == schemaType)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.pressTime, pressTime) || other.pressTime == pressTime)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.validTime, validTime) || other.validTime == validTime)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,type,schemaType,status,infoType,pressTime,reportTime,const DeepCollectionEquality().hash(body),validTime,serialNo,headline);

@override
String toString() {
  return 'TelegramV1(id: $id, eventId: $eventId, type: $type, schemaType: $schemaType, status: $status, infoType: $infoType, pressTime: $pressTime, reportTime: $reportTime, body: $body, validTime: $validTime, serialNo: $serialNo, headline: $headline)';
}


}

/// @nodoc
abstract mixin class $TelegramV1CopyWith<$Res>  {
  factory $TelegramV1CopyWith(TelegramV1 value, $Res Function(TelegramV1) _then) = _$TelegramV1CopyWithImpl;
@useResult
$Res call({
 int id, int eventId, String type, String schemaType, String status, String infoType, DateTime pressTime, DateTime reportTime, Map<String, dynamic> body, DateTime? validTime, int? serialNo, String? headline
});




}
/// @nodoc
class _$TelegramV1CopyWithImpl<$Res>
    implements $TelegramV1CopyWith<$Res> {
  _$TelegramV1CopyWithImpl(this._self, this._then);

  final TelegramV1 _self;
  final $Res Function(TelegramV1) _then;

/// Create a copy of TelegramV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? schemaType = null,Object? status = null,Object? infoType = null,Object? pressTime = null,Object? reportTime = null,Object? body = null,Object? validTime = freezed,Object? serialNo = freezed,Object? headline = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schemaType: null == schemaType ? _self.schemaType : schemaType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,pressTime: null == pressTime ? _self.pressTime : pressTime // ignore: cast_nullable_to_non_nullable
as DateTime,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,validTime: freezed == validTime ? _self.validTime : validTime // ignore: cast_nullable_to_non_nullable
as DateTime?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TelegramV1].
extension TelegramV1Patterns on TelegramV1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramV1 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramV1() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramV1 value)  $default,){
final _that = this;
switch (_that) {
case _TelegramV1():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramV1 value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramV1() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int eventId,  String type,  String schemaType,  String status,  String infoType,  DateTime pressTime,  DateTime reportTime,  Map<String, dynamic> body,  DateTime? validTime,  int? serialNo,  String? headline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramV1() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.schemaType,_that.status,_that.infoType,_that.pressTime,_that.reportTime,_that.body,_that.validTime,_that.serialNo,_that.headline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int eventId,  String type,  String schemaType,  String status,  String infoType,  DateTime pressTime,  DateTime reportTime,  Map<String, dynamic> body,  DateTime? validTime,  int? serialNo,  String? headline)  $default,) {final _that = this;
switch (_that) {
case _TelegramV1():
return $default(_that.id,_that.eventId,_that.type,_that.schemaType,_that.status,_that.infoType,_that.pressTime,_that.reportTime,_that.body,_that.validTime,_that.serialNo,_that.headline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int eventId,  String type,  String schemaType,  String status,  String infoType,  DateTime pressTime,  DateTime reportTime,  Map<String, dynamic> body,  DateTime? validTime,  int? serialNo,  String? headline)?  $default,) {final _that = this;
switch (_that) {
case _TelegramV1() when $default != null:
return $default(_that.id,_that.eventId,_that.type,_that.schemaType,_that.status,_that.infoType,_that.pressTime,_that.reportTime,_that.body,_that.validTime,_that.serialNo,_that.headline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TelegramV1 implements TelegramV1 {
  const _TelegramV1({required this.id, required this.eventId, required this.type, required this.schemaType, required this.status, required this.infoType, required this.pressTime, required this.reportTime, required final  Map<String, dynamic> body, this.validTime, this.serialNo, this.headline}): _body = body;
  factory _TelegramV1.fromJson(Map<String, dynamic> json) => _$TelegramV1FromJson(json);

@override final  int id;
@override final  int eventId;
@override final  String type;
@override final  String schemaType;
@override final  String status;
@override final  String infoType;
@override final  DateTime pressTime;
@override final  DateTime reportTime;
 final  Map<String, dynamic> _body;
@override Map<String, dynamic> get body {
  if (_body is EqualUnmodifiableMapView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_body);
}

@override final  DateTime? validTime;
@override final  int? serialNo;
@override final  String? headline;

/// Create a copy of TelegramV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramV1CopyWith<_TelegramV1> get copyWith => __$TelegramV1CopyWithImpl<_TelegramV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TelegramV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramV1&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.type, type) || other.type == type)&&(identical(other.schemaType, schemaType) || other.schemaType == schemaType)&&(identical(other.status, status) || other.status == status)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.pressTime, pressTime) || other.pressTime == pressTime)&&(identical(other.reportTime, reportTime) || other.reportTime == reportTime)&&const DeepCollectionEquality().equals(other._body, _body)&&(identical(other.validTime, validTime) || other.validTime == validTime)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.headline, headline) || other.headline == headline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,eventId,type,schemaType,status,infoType,pressTime,reportTime,const DeepCollectionEquality().hash(_body),validTime,serialNo,headline);

@override
String toString() {
  return 'TelegramV1(id: $id, eventId: $eventId, type: $type, schemaType: $schemaType, status: $status, infoType: $infoType, pressTime: $pressTime, reportTime: $reportTime, body: $body, validTime: $validTime, serialNo: $serialNo, headline: $headline)';
}


}

/// @nodoc
abstract mixin class _$TelegramV1CopyWith<$Res> implements $TelegramV1CopyWith<$Res> {
  factory _$TelegramV1CopyWith(_TelegramV1 value, $Res Function(_TelegramV1) _then) = __$TelegramV1CopyWithImpl;
@override @useResult
$Res call({
 int id, int eventId, String type, String schemaType, String status, String infoType, DateTime pressTime, DateTime reportTime, Map<String, dynamic> body, DateTime? validTime, int? serialNo, String? headline
});




}
/// @nodoc
class __$TelegramV1CopyWithImpl<$Res>
    implements _$TelegramV1CopyWith<$Res> {
  __$TelegramV1CopyWithImpl(this._self, this._then);

  final _TelegramV1 _self;
  final $Res Function(_TelegramV1) _then;

/// Create a copy of TelegramV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? type = null,Object? schemaType = null,Object? status = null,Object? infoType = null,Object? pressTime = null,Object? reportTime = null,Object? body = null,Object? validTime = freezed,Object? serialNo = freezed,Object? headline = freezed,}) {
  return _then(_TelegramV1(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,schemaType: null == schemaType ? _self.schemaType : schemaType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,pressTime: null == pressTime ? _self.pressTime : pressTime // ignore: cast_nullable_to_non_nullable
as DateTime,reportTime: null == reportTime ? _self.reportTime : reportTime // ignore: cast_nullable_to_non_nullable
as DateTime,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,validTime: freezed == validTime ? _self.validTime : validTime // ignore: cast_nullable_to_non_nullable
as DateTime?,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
