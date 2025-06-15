// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
_TsunamiV1Base _$TsunamiV1BaseFromJson(
  Map<String, dynamic> json
) {
    return __TsunamiV1Base.fromJson(
      json
    );
}

/// @nodoc
mixin _$TsunamiV1Base {

 int get eventId; String? get headline; int get id; String get infoType; DateTime get pressAt; DateTime get reportAt; int? get serialNo; String get status; String get type; DateTime? get validAt;
/// Create a copy of _TsunamiV1Base
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiV1BaseCopyWith<_TsunamiV1Base> get copyWith => __$TsunamiV1BaseCopyWithImpl<_TsunamiV1Base>(this as _TsunamiV1Base, _$identity);

  /// Serializes this _TsunamiV1Base to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiV1Base&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.id, id) || other.id == id)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.validAt, validAt) || other.validAt == validAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,headline,id,infoType,pressAt,reportAt,serialNo,status,type,validAt);

@override
String toString() {
  return '_TsunamiV1Base(eventId: $eventId, headline: $headline, id: $id, infoType: $infoType, pressAt: $pressAt, reportAt: $reportAt, serialNo: $serialNo, status: $status, type: $type, validAt: $validAt)';
}


}

/// @nodoc
abstract mixin class _$TsunamiV1BaseCopyWith<$Res>  {
  factory _$TsunamiV1BaseCopyWith(_TsunamiV1Base value, $Res Function(_TsunamiV1Base) _then) = __$TsunamiV1BaseCopyWithImpl;
@useResult
$Res call({
 int eventId, String? headline, int id, String infoType, DateTime pressAt, DateTime reportAt, int? serialNo, String status, String type, DateTime? validAt
});




}
/// @nodoc
class __$TsunamiV1BaseCopyWithImpl<$Res>
    implements _$TsunamiV1BaseCopyWith<$Res> {
  __$TsunamiV1BaseCopyWithImpl(this._self, this._then);

  final _TsunamiV1Base _self;
  final $Res Function(_TsunamiV1Base) _then;

/// Create a copy of _TsunamiV1Base
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? headline = freezed,Object? id = null,Object? infoType = null,Object? pressAt = null,Object? reportAt = null,Object? serialNo = freezed,Object? status = null,Object? type = null,Object? validAt = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,validAt: freezed == validAt ? _self.validAt : validAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class __TsunamiV1Base implements _TsunamiV1Base {
  const __TsunamiV1Base({required this.eventId, required this.headline, required this.id, required this.infoType, required this.pressAt, required this.reportAt, required this.serialNo, required this.status, required this.type, required this.validAt});
  factory __TsunamiV1Base.fromJson(Map<String, dynamic> json) => _$_TsunamiV1BaseFromJson(json);

@override final  int eventId;
@override final  String? headline;
@override final  int id;
@override final  String infoType;
@override final  DateTime pressAt;
@override final  DateTime reportAt;
@override final  int? serialNo;
@override final  String status;
@override final  String type;
@override final  DateTime? validAt;

/// Create a copy of _TsunamiV1Base
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$_TsunamiV1BaseCopyWith<__TsunamiV1Base> get copyWith => __$_TsunamiV1BaseCopyWithImpl<__TsunamiV1Base>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$_TsunamiV1BaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is __TsunamiV1Base&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.id, id) || other.id == id)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.pressAt, pressAt) || other.pressAt == pressAt)&&(identical(other.reportAt, reportAt) || other.reportAt == reportAt)&&(identical(other.serialNo, serialNo) || other.serialNo == serialNo)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.validAt, validAt) || other.validAt == validAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,headline,id,infoType,pressAt,reportAt,serialNo,status,type,validAt);

@override
String toString() {
  return '_TsunamiV1Base(eventId: $eventId, headline: $headline, id: $id, infoType: $infoType, pressAt: $pressAt, reportAt: $reportAt, serialNo: $serialNo, status: $status, type: $type, validAt: $validAt)';
}


}

/// @nodoc
abstract mixin class _$_TsunamiV1BaseCopyWith<$Res> implements _$TsunamiV1BaseCopyWith<$Res> {
  factory _$_TsunamiV1BaseCopyWith(__TsunamiV1Base value, $Res Function(__TsunamiV1Base) _then) = __$_TsunamiV1BaseCopyWithImpl;
@override @useResult
$Res call({
 int eventId, String? headline, int id, String infoType, DateTime pressAt, DateTime reportAt, int? serialNo, String status, String type, DateTime? validAt
});




}
/// @nodoc
class __$_TsunamiV1BaseCopyWithImpl<$Res>
    implements _$_TsunamiV1BaseCopyWith<$Res> {
  __$_TsunamiV1BaseCopyWithImpl(this._self, this._then);

  final __TsunamiV1Base _self;
  final $Res Function(__TsunamiV1Base) _then;

/// Create a copy of _TsunamiV1Base
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? headline = freezed,Object? id = null,Object? infoType = null,Object? pressAt = null,Object? reportAt = null,Object? serialNo = freezed,Object? status = null,Object? type = null,Object? validAt = freezed,}) {
  return _then(__TsunamiV1Base(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,headline: freezed == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as String,pressAt: null == pressAt ? _self.pressAt : pressAt // ignore: cast_nullable_to_non_nullable
as DateTime,reportAt: null == reportAt ? _self.reportAt : reportAt // ignore: cast_nullable_to_non_nullable
as DateTime,serialNo: freezed == serialNo ? _self.serialNo : serialNo // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,validAt: freezed == validAt ? _self.validAt : validAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Comment {

 String? get free; CommentWarning? get warning;
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCopyWith<Comment> get copyWith => _$CommentCopyWithImpl<Comment>(this as Comment, _$identity);

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comment&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'Comment(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $CommentCopyWith<$Res>  {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) _then) = _$CommentCopyWithImpl;
@useResult
$Res call({
 String? free, CommentWarning? warning
});


$CommentWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class _$CommentCopyWithImpl<$Res>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._self, this._then);

  final Comment _self;
  final $Res Function(Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_self.copyWith(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as CommentWarning?,
  ));
}
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentWarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $CommentWarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Comment implements Comment {
  const _Comment({required this.free, required this.warning});
  factory _Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

@override final  String? free;
@override final  CommentWarning? warning;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentCopyWith<_Comment> get copyWith => __$CommentCopyWithImpl<_Comment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comment&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'Comment(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) _then) = __$CommentCopyWithImpl;
@override @useResult
$Res call({
 String? free, CommentWarning? warning
});


@override $CommentWarningCopyWith<$Res>? get warning;

}
/// @nodoc
class __$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(this._self, this._then);

  final _Comment _self;
  final $Res Function(_Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_Comment(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as CommentWarning?,
  ));
}

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentWarningCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $CommentWarningCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// @nodoc
mixin _$CommentWarning {

 String get text; List<String> get codes;
/// Create a copy of CommentWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentWarningCopyWith<CommentWarning> get copyWith => _$CommentWarningCopyWithImpl<CommentWarning>(this as CommentWarning, _$identity);

  /// Serializes this CommentWarning to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentWarning&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.codes, codes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(codes));

@override
String toString() {
  return 'CommentWarning(text: $text, codes: $codes)';
}


}

/// @nodoc
abstract mixin class $CommentWarningCopyWith<$Res>  {
  factory $CommentWarningCopyWith(CommentWarning value, $Res Function(CommentWarning) _then) = _$CommentWarningCopyWithImpl;
@useResult
$Res call({
 String text, List<String> codes
});




}
/// @nodoc
class _$CommentWarningCopyWithImpl<$Res>
    implements $CommentWarningCopyWith<$Res> {
  _$CommentWarningCopyWithImpl(this._self, this._then);

  final CommentWarning _self;
  final $Res Function(CommentWarning) _then;

/// Create a copy of CommentWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? codes = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,codes: null == codes ? _self.codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CommentWarning implements CommentWarning {
  const _CommentWarning({required this.text, required final  List<String> codes}): _codes = codes;
  factory _CommentWarning.fromJson(Map<String, dynamic> json) => _$CommentWarningFromJson(json);

@override final  String text;
 final  List<String> _codes;
@override List<String> get codes {
  if (_codes is EqualUnmodifiableListView) return _codes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_codes);
}


/// Create a copy of CommentWarning
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentWarningCopyWith<_CommentWarning> get copyWith => __$CommentWarningCopyWithImpl<_CommentWarning>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentWarningToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentWarning&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._codes, _codes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_codes));

@override
String toString() {
  return 'CommentWarning(text: $text, codes: $codes)';
}


}

/// @nodoc
abstract mixin class _$CommentWarningCopyWith<$Res> implements $CommentWarningCopyWith<$Res> {
  factory _$CommentWarningCopyWith(_CommentWarning value, $Res Function(_CommentWarning) _then) = __$CommentWarningCopyWithImpl;
@override @useResult
$Res call({
 String text, List<String> codes
});




}
/// @nodoc
class __$CommentWarningCopyWithImpl<$Res>
    implements _$CommentWarningCopyWith<$Res> {
  __$CommentWarningCopyWithImpl(this._self, this._then);

  final _CommentWarning _self;
  final $Res Function(_CommentWarning) _then;

/// Create a copy of CommentWarning
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? codes = null,}) {
  return _then(_CommentWarning(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,codes: null == codes ? _self._codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$CancelBody {

 String get text;
/// Create a copy of CancelBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelBodyCopyWith<CancelBody> get copyWith => _$CancelBodyCopyWithImpl<CancelBody>(this as CancelBody, _$identity);

  /// Serializes this CancelBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBody&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'CancelBody(text: $text)';
}


}

/// @nodoc
abstract mixin class $CancelBodyCopyWith<$Res>  {
  factory $CancelBodyCopyWith(CancelBody value, $Res Function(CancelBody) _then) = _$CancelBodyCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$CancelBodyCopyWithImpl<$Res>
    implements $CancelBodyCopyWith<$Res> {
  _$CancelBodyCopyWithImpl(this._self, this._then);

  final CancelBody _self;
  final $Res Function(CancelBody) _then;

/// Create a copy of CancelBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CancelBody implements CancelBody {
  const _CancelBody({required this.text});
  factory _CancelBody.fromJson(Map<String, dynamic> json) => _$CancelBodyFromJson(json);

@override final  String text;

/// Create a copy of CancelBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CancelBodyCopyWith<_CancelBody> get copyWith => __$CancelBodyCopyWithImpl<_CancelBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CancelBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CancelBody&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'CancelBody(text: $text)';
}


}

/// @nodoc
abstract mixin class _$CancelBodyCopyWith<$Res> implements $CancelBodyCopyWith<$Res> {
  factory _$CancelBodyCopyWith(_CancelBody value, $Res Function(_CancelBody) _then) = __$CancelBodyCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class __$CancelBodyCopyWithImpl<$Res>
    implements _$CancelBodyCopyWith<$Res> {
  __$CancelBodyCopyWithImpl(this._self, this._then);

  final _CancelBody _self;
  final $Res Function(_CancelBody) _then;

/// Create a copy of CancelBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_CancelBody(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PublicBodyVTSE41Tsunami {

 List<TsunamiForecast> get forecasts;
/// Create a copy of PublicBodyVTSE41Tsunami
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicBodyVTSE41TsunamiCopyWith<PublicBodyVTSE41Tsunami> get copyWith => _$PublicBodyVTSE41TsunamiCopyWithImpl<PublicBodyVTSE41Tsunami>(this as PublicBodyVTSE41Tsunami, _$identity);

  /// Serializes this PublicBodyVTSE41Tsunami to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicBodyVTSE41Tsunami&&const DeepCollectionEquality().equals(other.forecasts, forecasts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(forecasts));

@override
String toString() {
  return 'PublicBodyVTSE41Tsunami(forecasts: $forecasts)';
}


}

/// @nodoc
abstract mixin class $PublicBodyVTSE41TsunamiCopyWith<$Res>  {
  factory $PublicBodyVTSE41TsunamiCopyWith(PublicBodyVTSE41Tsunami value, $Res Function(PublicBodyVTSE41Tsunami) _then) = _$PublicBodyVTSE41TsunamiCopyWithImpl;
@useResult
$Res call({
 List<TsunamiForecast> forecasts
});




}
/// @nodoc
class _$PublicBodyVTSE41TsunamiCopyWithImpl<$Res>
    implements $PublicBodyVTSE41TsunamiCopyWith<$Res> {
  _$PublicBodyVTSE41TsunamiCopyWithImpl(this._self, this._then);

  final PublicBodyVTSE41Tsunami _self;
  final $Res Function(PublicBodyVTSE41Tsunami) _then;

/// Create a copy of PublicBodyVTSE41Tsunami
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecasts = null,}) {
  return _then(_self.copyWith(
forecasts: null == forecasts ? _self.forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PublicBodyVTSE41Tsunami implements PublicBodyVTSE41Tsunami {
  const _PublicBodyVTSE41Tsunami({required final  List<TsunamiForecast> forecasts}): _forecasts = forecasts;
  factory _PublicBodyVTSE41Tsunami.fromJson(Map<String, dynamic> json) => _$PublicBodyVTSE41TsunamiFromJson(json);

 final  List<TsunamiForecast> _forecasts;
@override List<TsunamiForecast> get forecasts {
  if (_forecasts is EqualUnmodifiableListView) return _forecasts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecasts);
}


/// Create a copy of PublicBodyVTSE41Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicBodyVTSE41TsunamiCopyWith<_PublicBodyVTSE41Tsunami> get copyWith => __$PublicBodyVTSE41TsunamiCopyWithImpl<_PublicBodyVTSE41Tsunami>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicBodyVTSE41TsunamiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicBodyVTSE41Tsunami&&const DeepCollectionEquality().equals(other._forecasts, _forecasts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_forecasts));

@override
String toString() {
  return 'PublicBodyVTSE41Tsunami(forecasts: $forecasts)';
}


}

/// @nodoc
abstract mixin class _$PublicBodyVTSE41TsunamiCopyWith<$Res> implements $PublicBodyVTSE41TsunamiCopyWith<$Res> {
  factory _$PublicBodyVTSE41TsunamiCopyWith(_PublicBodyVTSE41Tsunami value, $Res Function(_PublicBodyVTSE41Tsunami) _then) = __$PublicBodyVTSE41TsunamiCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiForecast> forecasts
});




}
/// @nodoc
class __$PublicBodyVTSE41TsunamiCopyWithImpl<$Res>
    implements _$PublicBodyVTSE41TsunamiCopyWith<$Res> {
  __$PublicBodyVTSE41TsunamiCopyWithImpl(this._self, this._then);

  final _PublicBodyVTSE41Tsunami _self;
  final $Res Function(_PublicBodyVTSE41Tsunami) _then;

/// Create a copy of PublicBodyVTSE41Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecasts = null,}) {
  return _then(_PublicBodyVTSE41Tsunami(
forecasts: null == forecasts ? _self._forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>,
  ));
}


}


/// @nodoc
mixin _$PublicBodyVTSE51Tsunami {

 List<TsunamiForecast> get forecasts; List<TsunamiObservation>? get observations;
/// Create a copy of PublicBodyVTSE51Tsunami
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicBodyVTSE51TsunamiCopyWith<PublicBodyVTSE51Tsunami> get copyWith => _$PublicBodyVTSE51TsunamiCopyWithImpl<PublicBodyVTSE51Tsunami>(this as PublicBodyVTSE51Tsunami, _$identity);

  /// Serializes this PublicBodyVTSE51Tsunami to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicBodyVTSE51Tsunami&&const DeepCollectionEquality().equals(other.forecasts, forecasts)&&const DeepCollectionEquality().equals(other.observations, observations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(forecasts),const DeepCollectionEquality().hash(observations));

@override
String toString() {
  return 'PublicBodyVTSE51Tsunami(forecasts: $forecasts, observations: $observations)';
}


}

/// @nodoc
abstract mixin class $PublicBodyVTSE51TsunamiCopyWith<$Res>  {
  factory $PublicBodyVTSE51TsunamiCopyWith(PublicBodyVTSE51Tsunami value, $Res Function(PublicBodyVTSE51Tsunami) _then) = _$PublicBodyVTSE51TsunamiCopyWithImpl;
@useResult
$Res call({
 List<TsunamiForecast> forecasts, List<TsunamiObservation>? observations
});




}
/// @nodoc
class _$PublicBodyVTSE51TsunamiCopyWithImpl<$Res>
    implements $PublicBodyVTSE51TsunamiCopyWith<$Res> {
  _$PublicBodyVTSE51TsunamiCopyWithImpl(this._self, this._then);

  final PublicBodyVTSE51Tsunami _self;
  final $Res Function(PublicBodyVTSE51Tsunami) _then;

/// Create a copy of PublicBodyVTSE51Tsunami
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forecasts = null,Object? observations = freezed,}) {
  return _then(_self.copyWith(
forecasts: null == forecasts ? _self.forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>,observations: freezed == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PublicBodyVTSE51Tsunami implements PublicBodyVTSE51Tsunami {
  const _PublicBodyVTSE51Tsunami({required final  List<TsunamiForecast> forecasts, required final  List<TsunamiObservation>? observations}): _forecasts = forecasts,_observations = observations;
  factory _PublicBodyVTSE51Tsunami.fromJson(Map<String, dynamic> json) => _$PublicBodyVTSE51TsunamiFromJson(json);

 final  List<TsunamiForecast> _forecasts;
@override List<TsunamiForecast> get forecasts {
  if (_forecasts is EqualUnmodifiableListView) return _forecasts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forecasts);
}

 final  List<TsunamiObservation>? _observations;
@override List<TsunamiObservation>? get observations {
  final value = _observations;
  if (value == null) return null;
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PublicBodyVTSE51Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicBodyVTSE51TsunamiCopyWith<_PublicBodyVTSE51Tsunami> get copyWith => __$PublicBodyVTSE51TsunamiCopyWithImpl<_PublicBodyVTSE51Tsunami>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicBodyVTSE51TsunamiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicBodyVTSE51Tsunami&&const DeepCollectionEquality().equals(other._forecasts, _forecasts)&&const DeepCollectionEquality().equals(other._observations, _observations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_forecasts),const DeepCollectionEquality().hash(_observations));

@override
String toString() {
  return 'PublicBodyVTSE51Tsunami(forecasts: $forecasts, observations: $observations)';
}


}

/// @nodoc
abstract mixin class _$PublicBodyVTSE51TsunamiCopyWith<$Res> implements $PublicBodyVTSE51TsunamiCopyWith<$Res> {
  factory _$PublicBodyVTSE51TsunamiCopyWith(_PublicBodyVTSE51Tsunami value, $Res Function(_PublicBodyVTSE51Tsunami) _then) = __$PublicBodyVTSE51TsunamiCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiForecast> forecasts, List<TsunamiObservation>? observations
});




}
/// @nodoc
class __$PublicBodyVTSE51TsunamiCopyWithImpl<$Res>
    implements _$PublicBodyVTSE51TsunamiCopyWith<$Res> {
  __$PublicBodyVTSE51TsunamiCopyWithImpl(this._self, this._then);

  final _PublicBodyVTSE51Tsunami _self;
  final $Res Function(_PublicBodyVTSE51Tsunami) _then;

/// Create a copy of PublicBodyVTSE51Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? forecasts = null,Object? observations = freezed,}) {
  return _then(_PublicBodyVTSE51Tsunami(
forecasts: null == forecasts ? _self._forecasts : forecasts // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecast>,observations: freezed == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,
  ));
}


}


/// @nodoc
mixin _$PublicBodyVTSE52Tsunami {

 List<TsunamiObservation>? get observations; List<TsunamiEstimation> get estimations;
/// Create a copy of PublicBodyVTSE52Tsunami
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicBodyVTSE52TsunamiCopyWith<PublicBodyVTSE52Tsunami> get copyWith => _$PublicBodyVTSE52TsunamiCopyWithImpl<PublicBodyVTSE52Tsunami>(this as PublicBodyVTSE52Tsunami, _$identity);

  /// Serializes this PublicBodyVTSE52Tsunami to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicBodyVTSE52Tsunami&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.estimations, estimations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(estimations));

@override
String toString() {
  return 'PublicBodyVTSE52Tsunami(observations: $observations, estimations: $estimations)';
}


}

/// @nodoc
abstract mixin class $PublicBodyVTSE52TsunamiCopyWith<$Res>  {
  factory $PublicBodyVTSE52TsunamiCopyWith(PublicBodyVTSE52Tsunami value, $Res Function(PublicBodyVTSE52Tsunami) _then) = _$PublicBodyVTSE52TsunamiCopyWithImpl;
@useResult
$Res call({
 List<TsunamiObservation>? observations, List<TsunamiEstimation> estimations
});




}
/// @nodoc
class _$PublicBodyVTSE52TsunamiCopyWithImpl<$Res>
    implements $PublicBodyVTSE52TsunamiCopyWith<$Res> {
  _$PublicBodyVTSE52TsunamiCopyWithImpl(this._self, this._then);

  final PublicBodyVTSE52Tsunami _self;
  final $Res Function(PublicBodyVTSE52Tsunami) _then;

/// Create a copy of PublicBodyVTSE52Tsunami
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? observations = freezed,Object? estimations = null,}) {
  return _then(_self.copyWith(
observations: freezed == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,estimations: null == estimations ? _self.estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PublicBodyVTSE52Tsunami implements PublicBodyVTSE52Tsunami {
  const _PublicBodyVTSE52Tsunami({required final  List<TsunamiObservation>? observations, required final  List<TsunamiEstimation> estimations}): _observations = observations,_estimations = estimations;
  factory _PublicBodyVTSE52Tsunami.fromJson(Map<String, dynamic> json) => _$PublicBodyVTSE52TsunamiFromJson(json);

 final  List<TsunamiObservation>? _observations;
@override List<TsunamiObservation>? get observations {
  final value = _observations;
  if (value == null) return null;
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TsunamiEstimation> _estimations;
@override List<TsunamiEstimation> get estimations {
  if (_estimations is EqualUnmodifiableListView) return _estimations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimations);
}


/// Create a copy of PublicBodyVTSE52Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicBodyVTSE52TsunamiCopyWith<_PublicBodyVTSE52Tsunami> get copyWith => __$PublicBodyVTSE52TsunamiCopyWithImpl<_PublicBodyVTSE52Tsunami>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicBodyVTSE52TsunamiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicBodyVTSE52Tsunami&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._estimations, _estimations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_estimations));

@override
String toString() {
  return 'PublicBodyVTSE52Tsunami(observations: $observations, estimations: $estimations)';
}


}

/// @nodoc
abstract mixin class _$PublicBodyVTSE52TsunamiCopyWith<$Res> implements $PublicBodyVTSE52TsunamiCopyWith<$Res> {
  factory _$PublicBodyVTSE52TsunamiCopyWith(_PublicBodyVTSE52Tsunami value, $Res Function(_PublicBodyVTSE52Tsunami) _then) = __$PublicBodyVTSE52TsunamiCopyWithImpl;
@override @useResult
$Res call({
 List<TsunamiObservation>? observations, List<TsunamiEstimation> estimations
});




}
/// @nodoc
class __$PublicBodyVTSE52TsunamiCopyWithImpl<$Res>
    implements _$PublicBodyVTSE52TsunamiCopyWith<$Res> {
  __$PublicBodyVTSE52TsunamiCopyWithImpl(this._self, this._then);

  final _PublicBodyVTSE52Tsunami _self;
  final $Res Function(_PublicBodyVTSE52Tsunami) _then;

/// Create a copy of PublicBodyVTSE52Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? observations = freezed,Object? estimations = null,}) {
  return _then(_PublicBodyVTSE52Tsunami(
observations: freezed == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservation>?,estimations: null == estimations ? _self._estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<TsunamiEstimation>,
  ));
}


}


/// @nodoc
mixin _$TsunamiForecast {

 String get code; String get name; String get kind; String get lastKind; TsunamiForecastFirstHeight? get firstHeight; TsunamiForecastMaxHeight? get maxHeight; List<TsunamiForecastStation>? get stations;
/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastCopyWith<TsunamiForecast> get copyWith => _$TsunamiForecastCopyWithImpl<TsunamiForecast>(this as TsunamiForecast, _$identity);

  /// Serializes this TsunamiForecast to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecast&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,lastKind,firstHeight,maxHeight,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TsunamiForecast(code: $code, name: $name, kind: $kind, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastCopyWith<$Res>  {
  factory $TsunamiForecastCopyWith(TsunamiForecast value, $Res Function(TsunamiForecast) _then) = _$TsunamiForecastCopyWithImpl;
@useResult
$Res call({
 String code, String name, String kind, String lastKind, TsunamiForecastFirstHeight? firstHeight, TsunamiForecastMaxHeight? maxHeight, List<TsunamiForecastStation>? stations
});


$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class _$TsunamiForecastCopyWithImpl<$Res>
    implements $TsunamiForecastCopyWith<$Res> {
  _$TsunamiForecastCopyWithImpl(this._self, this._then);

  final TsunamiForecast _self;
  final $Res Function(TsunamiForecast) _then;

/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as String,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,stations: freezed == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecastStation>?,
  ));
}
/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiForecast implements TsunamiForecast {
  const _TsunamiForecast({required this.code, required this.name, required this.kind, required this.lastKind, required this.firstHeight, required this.maxHeight, required final  List<TsunamiForecastStation>? stations}): _stations = stations;
  factory _TsunamiForecast.fromJson(Map<String, dynamic> json) => _$TsunamiForecastFromJson(json);

@override final  String code;
@override final  String name;
@override final  String kind;
@override final  String lastKind;
@override final  TsunamiForecastFirstHeight? firstHeight;
@override final  TsunamiForecastMaxHeight? maxHeight;
 final  List<TsunamiForecastStation>? _stations;
@override List<TsunamiForecastStation>? get stations {
  final value = _stations;
  if (value == null) return null;
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastCopyWith<_TsunamiForecast> get copyWith => __$TsunamiForecastCopyWithImpl<_TsunamiForecast>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecast&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.lastKind, lastKind) || other.lastKind == lastKind)&&(identical(other.firstHeight, firstHeight) || other.firstHeight == firstHeight)&&(identical(other.maxHeight, maxHeight) || other.maxHeight == maxHeight)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kind,lastKind,firstHeight,maxHeight,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TsunamiForecast(code: $code, name: $name, kind: $kind, lastKind: $lastKind, firstHeight: $firstHeight, maxHeight: $maxHeight, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastCopyWith<$Res> implements $TsunamiForecastCopyWith<$Res> {
  factory _$TsunamiForecastCopyWith(_TsunamiForecast value, $Res Function(_TsunamiForecast) _then) = __$TsunamiForecastCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String kind, String lastKind, TsunamiForecastFirstHeight? firstHeight, TsunamiForecastMaxHeight? maxHeight, List<TsunamiForecastStation>? stations
});


@override $TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight;@override $TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight;

}
/// @nodoc
class __$TsunamiForecastCopyWithImpl<$Res>
    implements _$TsunamiForecastCopyWith<$Res> {
  __$TsunamiForecastCopyWithImpl(this._self, this._then);

  final _TsunamiForecast _self;
  final $Res Function(_TsunamiForecast) _then;

/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kind = null,Object? lastKind = null,Object? firstHeight = freezed,Object? maxHeight = freezed,Object? stations = freezed,}) {
  return _then(_TsunamiForecast(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,lastKind: null == lastKind ? _self.lastKind : lastKind // ignore: cast_nullable_to_non_nullable
as String,firstHeight: freezed == firstHeight ? _self.firstHeight : firstHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeight?,maxHeight: freezed == maxHeight ? _self.maxHeight : maxHeight // ignore: cast_nullable_to_non_nullable
as TsunamiForecastMaxHeight?,stations: freezed == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiForecastStation>?,
  ));
}

/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<$Res>? get firstHeight {
    if (_self.firstHeight == null) {
    return null;
  }

  return $TsunamiForecastFirstHeightCopyWith<$Res>(_self.firstHeight!, (value) {
    return _then(_self.copyWith(firstHeight: value));
  });
}/// Create a copy of TsunamiForecast
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<$Res>? get maxHeight {
    if (_self.maxHeight == null) {
    return null;
  }

  return $TsunamiForecastMaxHeightCopyWith<$Res>(_self.maxHeight!, (value) {
    return _then(_self.copyWith(maxHeight: value));
  });
}
}


/// @nodoc
mixin _$TsunamiForecastFirstHeight {

 DateTime? get arrivalTime; TsunamiForecastFirstHeightCondition? get condition;
/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastFirstHeightCopyWith<TsunamiForecastFirstHeight> get copyWith => _$TsunamiForecastFirstHeightCopyWithImpl<TsunamiForecastFirstHeight>(this as TsunamiForecastFirstHeight, _$identity);

  /// Serializes this TsunamiForecastFirstHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition);

@override
String toString() {
  return 'TsunamiForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastFirstHeightCopyWith<$Res>  {
  factory $TsunamiForecastFirstHeightCopyWith(TsunamiForecastFirstHeight value, $Res Function(TsunamiForecastFirstHeight) _then) = _$TsunamiForecastFirstHeightCopyWithImpl;
@useResult
$Res call({
 DateTime? arrivalTime, TsunamiForecastFirstHeightCondition? condition
});




}
/// @nodoc
class _$TsunamiForecastFirstHeightCopyWithImpl<$Res>
    implements $TsunamiForecastFirstHeightCopyWith<$Res> {
  _$TsunamiForecastFirstHeightCopyWithImpl(this._self, this._then);

  final TsunamiForecastFirstHeight _self;
  final $Res Function(TsunamiForecastFirstHeight) _then;

/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? arrivalTime = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeightCondition?,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiForecastFirstHeight implements TsunamiForecastFirstHeight {
  const _TsunamiForecastFirstHeight({required this.arrivalTime, required this.condition});
  factory _TsunamiForecastFirstHeight.fromJson(Map<String, dynamic> json) => _$TsunamiForecastFirstHeightFromJson(json);

@override final  DateTime? arrivalTime;
@override final  TsunamiForecastFirstHeightCondition? condition;

/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastFirstHeightCopyWith<_TsunamiForecastFirstHeight> get copyWith => __$TsunamiForecastFirstHeightCopyWithImpl<_TsunamiForecastFirstHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastFirstHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastFirstHeight&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,arrivalTime,condition);

@override
String toString() {
  return 'TsunamiForecastFirstHeight(arrivalTime: $arrivalTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastFirstHeightCopyWith<$Res> implements $TsunamiForecastFirstHeightCopyWith<$Res> {
  factory _$TsunamiForecastFirstHeightCopyWith(_TsunamiForecastFirstHeight value, $Res Function(_TsunamiForecastFirstHeight) _then) = __$TsunamiForecastFirstHeightCopyWithImpl;
@override @useResult
$Res call({
 DateTime? arrivalTime, TsunamiForecastFirstHeightCondition? condition
});




}
/// @nodoc
class __$TsunamiForecastFirstHeightCopyWithImpl<$Res>
    implements _$TsunamiForecastFirstHeightCopyWith<$Res> {
  __$TsunamiForecastFirstHeightCopyWithImpl(this._self, this._then);

  final _TsunamiForecastFirstHeight _self;
  final $Res Function(_TsunamiForecastFirstHeight) _then;

/// Create a copy of TsunamiForecastFirstHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? arrivalTime = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiForecastFirstHeight(
arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeightCondition?,
  ));
}


}


/// @nodoc
mixin _$TsunamiForecastMaxHeight {

/// 定量表現
 double? get value; bool? get isOver;/// 定性表現
 TsunamiMaxHeightCondition? get condition;
/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastMaxHeightCopyWith<TsunamiForecastMaxHeight> get copyWith => _$TsunamiForecastMaxHeightCopyWithImpl<TsunamiForecastMaxHeight>(this as TsunamiForecastMaxHeight, _$identity);

  /// Serializes this TsunamiForecastMaxHeight to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver,condition);

@override
String toString() {
  return 'TsunamiForecastMaxHeight(value: $value, isOver: $isOver, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastMaxHeightCopyWith<$Res>  {
  factory $TsunamiForecastMaxHeightCopyWith(TsunamiForecastMaxHeight value, $Res Function(TsunamiForecastMaxHeight) _then) = _$TsunamiForecastMaxHeightCopyWithImpl;
@useResult
$Res call({
 double? value, bool? isOver, TsunamiMaxHeightCondition? condition
});




}
/// @nodoc
class _$TsunamiForecastMaxHeightCopyWithImpl<$Res>
    implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  _$TsunamiForecastMaxHeightCopyWithImpl(this._self, this._then);

  final TsunamiForecastMaxHeight _self;
  final $Res Function(TsunamiForecastMaxHeight) _then;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? isOver = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiMaxHeightCondition?,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiForecastMaxHeight implements TsunamiForecastMaxHeight {
  const _TsunamiForecastMaxHeight({required this.value, required this.isOver, required this.condition});
  factory _TsunamiForecastMaxHeight.fromJson(Map<String, dynamic> json) => _$TsunamiForecastMaxHeightFromJson(json);

/// 定量表現
@override final  double? value;
@override final  bool? isOver;
/// 定性表現
@override final  TsunamiMaxHeightCondition? condition;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastMaxHeightCopyWith<_TsunamiForecastMaxHeight> get copyWith => __$TsunamiForecastMaxHeightCopyWithImpl<_TsunamiForecastMaxHeight>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastMaxHeightToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastMaxHeight&&(identical(other.value, value) || other.value == value)&&(identical(other.isOver, isOver) || other.isOver == isOver)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,isOver,condition);

@override
String toString() {
  return 'TsunamiForecastMaxHeight(value: $value, isOver: $isOver, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastMaxHeightCopyWith<$Res> implements $TsunamiForecastMaxHeightCopyWith<$Res> {
  factory _$TsunamiForecastMaxHeightCopyWith(_TsunamiForecastMaxHeight value, $Res Function(_TsunamiForecastMaxHeight) _then) = __$TsunamiForecastMaxHeightCopyWithImpl;
@override @useResult
$Res call({
 double? value, bool? isOver, TsunamiMaxHeightCondition? condition
});




}
/// @nodoc
class __$TsunamiForecastMaxHeightCopyWithImpl<$Res>
    implements _$TsunamiForecastMaxHeightCopyWith<$Res> {
  __$TsunamiForecastMaxHeightCopyWithImpl(this._self, this._then);

  final _TsunamiForecastMaxHeight _self;
  final $Res Function(_TsunamiForecastMaxHeight) _then;

/// Create a copy of TsunamiForecastMaxHeight
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? isOver = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiForecastMaxHeight(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,isOver: freezed == isOver ? _self.isOver : isOver // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiMaxHeightCondition?,
  ));
}


}


/// @nodoc
mixin _$TsunamiForecastStation {

 String get code; String get name; DateTime get highTideTime; DateTime? get firstHeightTime; TsunamiForecastFirstHeightCondition? get condition;
/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiForecastStationCopyWith<TsunamiForecastStation> get copyWith => _$TsunamiForecastStationCopyWithImpl<TsunamiForecastStation>(this as TsunamiForecastStation, _$identity);

  /// Serializes this TsunamiForecastStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiForecastStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.highTideTime, highTideTime) || other.highTideTime == highTideTime)&&(identical(other.firstHeightTime, firstHeightTime) || other.firstHeightTime == firstHeightTime)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,highTideTime,firstHeightTime,condition);

@override
String toString() {
  return 'TsunamiForecastStation(code: $code, name: $name, highTideTime: $highTideTime, firstHeightTime: $firstHeightTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiForecastStationCopyWith<$Res>  {
  factory $TsunamiForecastStationCopyWith(TsunamiForecastStation value, $Res Function(TsunamiForecastStation) _then) = _$TsunamiForecastStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, DateTime highTideTime, DateTime? firstHeightTime, TsunamiForecastFirstHeightCondition? condition
});




}
/// @nodoc
class _$TsunamiForecastStationCopyWithImpl<$Res>
    implements $TsunamiForecastStationCopyWith<$Res> {
  _$TsunamiForecastStationCopyWithImpl(this._self, this._then);

  final TsunamiForecastStation _self;
  final $Res Function(TsunamiForecastStation) _then;

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? highTideTime = null,Object? firstHeightTime = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,highTideTime: null == highTideTime ? _self.highTideTime : highTideTime // ignore: cast_nullable_to_non_nullable
as DateTime,firstHeightTime: freezed == firstHeightTime ? _self.firstHeightTime : firstHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeightCondition?,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiForecastStation implements TsunamiForecastStation {
  const _TsunamiForecastStation({required this.code, required this.name, required this.highTideTime, required this.firstHeightTime, required this.condition});
  factory _TsunamiForecastStation.fromJson(Map<String, dynamic> json) => _$TsunamiForecastStationFromJson(json);

@override final  String code;
@override final  String name;
@override final  DateTime highTideTime;
@override final  DateTime? firstHeightTime;
@override final  TsunamiForecastFirstHeightCondition? condition;

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiForecastStationCopyWith<_TsunamiForecastStation> get copyWith => __$TsunamiForecastStationCopyWithImpl<_TsunamiForecastStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiForecastStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiForecastStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.highTideTime, highTideTime) || other.highTideTime == highTideTime)&&(identical(other.firstHeightTime, firstHeightTime) || other.firstHeightTime == firstHeightTime)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,highTideTime,firstHeightTime,condition);

@override
String toString() {
  return 'TsunamiForecastStation(code: $code, name: $name, highTideTime: $highTideTime, firstHeightTime: $firstHeightTime, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiForecastStationCopyWith<$Res> implements $TsunamiForecastStationCopyWith<$Res> {
  factory _$TsunamiForecastStationCopyWith(_TsunamiForecastStation value, $Res Function(_TsunamiForecastStation) _then) = __$TsunamiForecastStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, DateTime highTideTime, DateTime? firstHeightTime, TsunamiForecastFirstHeightCondition? condition
});




}
/// @nodoc
class __$TsunamiForecastStationCopyWithImpl<$Res>
    implements _$TsunamiForecastStationCopyWith<$Res> {
  __$TsunamiForecastStationCopyWithImpl(this._self, this._then);

  final _TsunamiForecastStation _self;
  final $Res Function(_TsunamiForecastStation) _then;

/// Create a copy of TsunamiForecastStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? highTideTime = null,Object? firstHeightTime = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiForecastStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,highTideTime: null == highTideTime ? _self.highTideTime : highTideTime // ignore: cast_nullable_to_non_nullable
as DateTime,firstHeightTime: freezed == firstHeightTime ? _self.firstHeightTime : firstHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiForecastFirstHeightCondition?,
  ));
}


}


/// @nodoc
mixin _$TsunamiObservation {

 String? get code; String? get name; List<TsunamiObservationStation> get stations;
/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationCopyWith<TsunamiObservation> get copyWith => _$TsunamiObservationCopyWithImpl<TsunamiObservation>(this as TsunamiObservation, _$identity);

  /// Serializes this TsunamiObservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.stations, stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(stations));

@override
String toString() {
  return 'TsunamiObservation(code: $code, name: $name, stations: $stations)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationCopyWith<$Res>  {
  factory $TsunamiObservationCopyWith(TsunamiObservation value, $Res Function(TsunamiObservation) _then) = _$TsunamiObservationCopyWithImpl;
@useResult
$Res call({
 String? code, String? name, List<TsunamiObservationStation> stations
});




}
/// @nodoc
class _$TsunamiObservationCopyWithImpl<$Res>
    implements $TsunamiObservationCopyWith<$Res> {
  _$TsunamiObservationCopyWithImpl(this._self, this._then);

  final TsunamiObservation _self;
  final $Res Function(TsunamiObservation) _then;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,Object? stations = null,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiObservation implements TsunamiObservation {
  const _TsunamiObservation({required this.code, required this.name, required final  List<TsunamiObservationStation> stations}): _stations = stations;
  factory _TsunamiObservation.fromJson(Map<String, dynamic> json) => _$TsunamiObservationFromJson(json);

@override final  String? code;
@override final  String? name;
 final  List<TsunamiObservationStation> _stations;
@override List<TsunamiObservationStation> get stations {
  if (_stations is EqualUnmodifiableListView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stations);
}


/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationCopyWith<_TsunamiObservation> get copyWith => __$TsunamiObservationCopyWithImpl<_TsunamiObservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiObservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._stations, _stations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,const DeepCollectionEquality().hash(_stations));

@override
String toString() {
  return 'TsunamiObservation(code: $code, name: $name, stations: $stations)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationCopyWith<$Res> implements $TsunamiObservationCopyWith<$Res> {
  factory _$TsunamiObservationCopyWith(_TsunamiObservation value, $Res Function(_TsunamiObservation) _then) = __$TsunamiObservationCopyWithImpl;
@override @useResult
$Res call({
 String? code, String? name, List<TsunamiObservationStation> stations
});




}
/// @nodoc
class __$TsunamiObservationCopyWithImpl<$Res>
    implements _$TsunamiObservationCopyWith<$Res> {
  __$TsunamiObservationCopyWithImpl(this._self, this._then);

  final _TsunamiObservation _self;
  final $Res Function(_TsunamiObservation) _then;

/// Create a copy of TsunamiObservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,Object? stations = null,}) {
  return _then(_TsunamiObservation(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as List<TsunamiObservationStation>,
  ));
}


}


/// @nodoc
mixin _$TsunamiObservationStation {

 String get code; String get name;/// null: `識別不能`
 DateTime? get firstHeightArrivalTime; TsunamiObservationStationFirstHeightIntial? get firstHeightInitial; DateTime? get maxHeightTime; double? get maxHeightValue; bool? get maxHeightIsOver;/// 上昇中かどうか
 bool? get maxHeightIsRising; TsunamiObservationStationCondition? get condition;
/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiObservationStationCopyWith<TsunamiObservationStation> get copyWith => _$TsunamiObservationStationCopyWithImpl<TsunamiObservationStation>(this as TsunamiObservationStation, _$identity);

  /// Serializes this TsunamiObservationStation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiObservationStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeightArrivalTime, firstHeightArrivalTime) || other.firstHeightArrivalTime == firstHeightArrivalTime)&&(identical(other.firstHeightInitial, firstHeightInitial) || other.firstHeightInitial == firstHeightInitial)&&(identical(other.maxHeightTime, maxHeightTime) || other.maxHeightTime == maxHeightTime)&&(identical(other.maxHeightValue, maxHeightValue) || other.maxHeightValue == maxHeightValue)&&(identical(other.maxHeightIsOver, maxHeightIsOver) || other.maxHeightIsOver == maxHeightIsOver)&&(identical(other.maxHeightIsRising, maxHeightIsRising) || other.maxHeightIsRising == maxHeightIsRising)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeightArrivalTime,firstHeightInitial,maxHeightTime,maxHeightValue,maxHeightIsOver,maxHeightIsRising,condition);

@override
String toString() {
  return 'TsunamiObservationStation(code: $code, name: $name, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightInitial: $firstHeightInitial, maxHeightTime: $maxHeightTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightIsRising: $maxHeightIsRising, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $TsunamiObservationStationCopyWith<$Res>  {
  factory $TsunamiObservationStationCopyWith(TsunamiObservationStation value, $Res Function(TsunamiObservationStation) _then) = _$TsunamiObservationStationCopyWithImpl;
@useResult
$Res call({
 String code, String name, DateTime? firstHeightArrivalTime, TsunamiObservationStationFirstHeightIntial? firstHeightInitial, DateTime? maxHeightTime, double? maxHeightValue, bool? maxHeightIsOver, bool? maxHeightIsRising, TsunamiObservationStationCondition? condition
});




}
/// @nodoc
class _$TsunamiObservationStationCopyWithImpl<$Res>
    implements $TsunamiObservationStationCopyWith<$Res> {
  _$TsunamiObservationStationCopyWithImpl(this._self, this._then);

  final TsunamiObservationStation _self;
  final $Res Function(TsunamiObservationStation) _then;

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeightArrivalTime = freezed,Object? firstHeightInitial = freezed,Object? maxHeightTime = freezed,Object? maxHeightValue = freezed,Object? maxHeightIsOver = freezed,Object? maxHeightIsRising = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeightArrivalTime: freezed == firstHeightArrivalTime ? _self.firstHeightArrivalTime : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightInitial: freezed == firstHeightInitial ? _self.firstHeightInitial : firstHeightInitial // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationFirstHeightIntial?,maxHeightTime: freezed == maxHeightTime ? _self.maxHeightTime : maxHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxHeightValue: freezed == maxHeightValue ? _self.maxHeightValue : maxHeightValue // ignore: cast_nullable_to_non_nullable
as double?,maxHeightIsOver: freezed == maxHeightIsOver ? _self.maxHeightIsOver : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightIsRising: freezed == maxHeightIsRising ? _self.maxHeightIsRising : maxHeightIsRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationCondition?,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiObservationStation implements TsunamiObservationStation {
  const _TsunamiObservationStation({required this.code, required this.name, required this.firstHeightArrivalTime, required this.firstHeightInitial, required this.maxHeightTime, required this.maxHeightValue, required this.maxHeightIsOver, required this.maxHeightIsRising, required this.condition});
  factory _TsunamiObservationStation.fromJson(Map<String, dynamic> json) => _$TsunamiObservationStationFromJson(json);

@override final  String code;
@override final  String name;
/// null: `識別不能`
@override final  DateTime? firstHeightArrivalTime;
@override final  TsunamiObservationStationFirstHeightIntial? firstHeightInitial;
@override final  DateTime? maxHeightTime;
@override final  double? maxHeightValue;
@override final  bool? maxHeightIsOver;
/// 上昇中かどうか
@override final  bool? maxHeightIsRising;
@override final  TsunamiObservationStationCondition? condition;

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiObservationStationCopyWith<_TsunamiObservationStation> get copyWith => __$TsunamiObservationStationCopyWithImpl<_TsunamiObservationStation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiObservationStationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiObservationStation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeightArrivalTime, firstHeightArrivalTime) || other.firstHeightArrivalTime == firstHeightArrivalTime)&&(identical(other.firstHeightInitial, firstHeightInitial) || other.firstHeightInitial == firstHeightInitial)&&(identical(other.maxHeightTime, maxHeightTime) || other.maxHeightTime == maxHeightTime)&&(identical(other.maxHeightValue, maxHeightValue) || other.maxHeightValue == maxHeightValue)&&(identical(other.maxHeightIsOver, maxHeightIsOver) || other.maxHeightIsOver == maxHeightIsOver)&&(identical(other.maxHeightIsRising, maxHeightIsRising) || other.maxHeightIsRising == maxHeightIsRising)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeightArrivalTime,firstHeightInitial,maxHeightTime,maxHeightValue,maxHeightIsOver,maxHeightIsRising,condition);

@override
String toString() {
  return 'TsunamiObservationStation(code: $code, name: $name, firstHeightArrivalTime: $firstHeightArrivalTime, firstHeightInitial: $firstHeightInitial, maxHeightTime: $maxHeightTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightIsRising: $maxHeightIsRising, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$TsunamiObservationStationCopyWith<$Res> implements $TsunamiObservationStationCopyWith<$Res> {
  factory _$TsunamiObservationStationCopyWith(_TsunamiObservationStation value, $Res Function(_TsunamiObservationStation) _then) = __$TsunamiObservationStationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, DateTime? firstHeightArrivalTime, TsunamiObservationStationFirstHeightIntial? firstHeightInitial, DateTime? maxHeightTime, double? maxHeightValue, bool? maxHeightIsOver, bool? maxHeightIsRising, TsunamiObservationStationCondition? condition
});




}
/// @nodoc
class __$TsunamiObservationStationCopyWithImpl<$Res>
    implements _$TsunamiObservationStationCopyWith<$Res> {
  __$TsunamiObservationStationCopyWithImpl(this._self, this._then);

  final _TsunamiObservationStation _self;
  final $Res Function(_TsunamiObservationStation) _then;

/// Create a copy of TsunamiObservationStation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeightArrivalTime = freezed,Object? firstHeightInitial = freezed,Object? maxHeightTime = freezed,Object? maxHeightValue = freezed,Object? maxHeightIsOver = freezed,Object? maxHeightIsRising = freezed,Object? condition = freezed,}) {
  return _then(_TsunamiObservationStation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeightArrivalTime: freezed == firstHeightArrivalTime ? _self.firstHeightArrivalTime : firstHeightArrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightInitial: freezed == firstHeightInitial ? _self.firstHeightInitial : firstHeightInitial // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationFirstHeightIntial?,maxHeightTime: freezed == maxHeightTime ? _self.maxHeightTime : maxHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxHeightValue: freezed == maxHeightValue ? _self.maxHeightValue : maxHeightValue // ignore: cast_nullable_to_non_nullable
as double?,maxHeightIsOver: freezed == maxHeightIsOver ? _self.maxHeightIsOver : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightIsRising: freezed == maxHeightIsRising ? _self.maxHeightIsRising : maxHeightIsRising // ignore: cast_nullable_to_non_nullable
as bool?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as TsunamiObservationStationCondition?,
  ));
}


}


/// @nodoc
mixin _$TsunamiEstimation {

 String get code; String get name; DateTime? get firstHeightTime; TsunamiEstimationFirstHeightCondition? get firstHeightCondition; DateTime? get maxHeightTime; double? get maxHeightValue; bool? get maxHeightIsOver; TsunamiMaxHeightCondition? get maxHeightCondition;// 津波警報以上でまだ津波の観測値が小さい場合に出現する
// *津波観測中*
 bool? get isObserving;
/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiEstimationCopyWith<TsunamiEstimation> get copyWith => _$TsunamiEstimationCopyWithImpl<TsunamiEstimation>(this as TsunamiEstimation, _$identity);

  /// Serializes this TsunamiEstimation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiEstimation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeightTime, firstHeightTime) || other.firstHeightTime == firstHeightTime)&&(identical(other.firstHeightCondition, firstHeightCondition) || other.firstHeightCondition == firstHeightCondition)&&(identical(other.maxHeightTime, maxHeightTime) || other.maxHeightTime == maxHeightTime)&&(identical(other.maxHeightValue, maxHeightValue) || other.maxHeightValue == maxHeightValue)&&(identical(other.maxHeightIsOver, maxHeightIsOver) || other.maxHeightIsOver == maxHeightIsOver)&&(identical(other.maxHeightCondition, maxHeightCondition) || other.maxHeightCondition == maxHeightCondition)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeightTime,firstHeightCondition,maxHeightTime,maxHeightValue,maxHeightIsOver,maxHeightCondition,isObserving);

@override
String toString() {
  return 'TsunamiEstimation(code: $code, name: $name, firstHeightTime: $firstHeightTime, firstHeightCondition: $firstHeightCondition, maxHeightTime: $maxHeightTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightCondition: $maxHeightCondition, isObserving: $isObserving)';
}


}

/// @nodoc
abstract mixin class $TsunamiEstimationCopyWith<$Res>  {
  factory $TsunamiEstimationCopyWith(TsunamiEstimation value, $Res Function(TsunamiEstimation) _then) = _$TsunamiEstimationCopyWithImpl;
@useResult
$Res call({
 String code, String name, DateTime? firstHeightTime, TsunamiEstimationFirstHeightCondition? firstHeightCondition, DateTime? maxHeightTime, double? maxHeightValue, bool? maxHeightIsOver, TsunamiMaxHeightCondition? maxHeightCondition, bool? isObserving
});




}
/// @nodoc
class _$TsunamiEstimationCopyWithImpl<$Res>
    implements $TsunamiEstimationCopyWith<$Res> {
  _$TsunamiEstimationCopyWithImpl(this._self, this._then);

  final TsunamiEstimation _self;
  final $Res Function(TsunamiEstimation) _then;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? firstHeightTime = freezed,Object? firstHeightCondition = freezed,Object? maxHeightTime = freezed,Object? maxHeightValue = freezed,Object? maxHeightIsOver = freezed,Object? maxHeightCondition = freezed,Object? isObserving = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeightTime: freezed == firstHeightTime ? _self.firstHeightTime : firstHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightCondition: freezed == firstHeightCondition ? _self.firstHeightCondition : firstHeightCondition // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeightCondition?,maxHeightTime: freezed == maxHeightTime ? _self.maxHeightTime : maxHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxHeightValue: freezed == maxHeightValue ? _self.maxHeightValue : maxHeightValue // ignore: cast_nullable_to_non_nullable
as double?,maxHeightIsOver: freezed == maxHeightIsOver ? _self.maxHeightIsOver : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightCondition: freezed == maxHeightCondition ? _self.maxHeightCondition : maxHeightCondition // ignore: cast_nullable_to_non_nullable
as TsunamiMaxHeightCondition?,isObserving: freezed == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc

@JsonSerializable(fieldRename: FieldRename.none)
class _TsunamiEstimation implements TsunamiEstimation {
  const _TsunamiEstimation({required this.code, required this.name, required this.firstHeightTime, required this.firstHeightCondition, required this.maxHeightTime, required this.maxHeightValue, required this.maxHeightIsOver, required this.maxHeightCondition, required this.isObserving});
  factory _TsunamiEstimation.fromJson(Map<String, dynamic> json) => _$TsunamiEstimationFromJson(json);

@override final  String code;
@override final  String name;
@override final  DateTime? firstHeightTime;
@override final  TsunamiEstimationFirstHeightCondition? firstHeightCondition;
@override final  DateTime? maxHeightTime;
@override final  double? maxHeightValue;
@override final  bool? maxHeightIsOver;
@override final  TsunamiMaxHeightCondition? maxHeightCondition;
// 津波警報以上でまだ津波の観測値が小さい場合に出現する
// *津波観測中*
@override final  bool? isObserving;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiEstimationCopyWith<_TsunamiEstimation> get copyWith => __$TsunamiEstimationCopyWithImpl<_TsunamiEstimation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiEstimationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiEstimation&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.firstHeightTime, firstHeightTime) || other.firstHeightTime == firstHeightTime)&&(identical(other.firstHeightCondition, firstHeightCondition) || other.firstHeightCondition == firstHeightCondition)&&(identical(other.maxHeightTime, maxHeightTime) || other.maxHeightTime == maxHeightTime)&&(identical(other.maxHeightValue, maxHeightValue) || other.maxHeightValue == maxHeightValue)&&(identical(other.maxHeightIsOver, maxHeightIsOver) || other.maxHeightIsOver == maxHeightIsOver)&&(identical(other.maxHeightCondition, maxHeightCondition) || other.maxHeightCondition == maxHeightCondition)&&(identical(other.isObserving, isObserving) || other.isObserving == isObserving));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,firstHeightTime,firstHeightCondition,maxHeightTime,maxHeightValue,maxHeightIsOver,maxHeightCondition,isObserving);

@override
String toString() {
  return 'TsunamiEstimation(code: $code, name: $name, firstHeightTime: $firstHeightTime, firstHeightCondition: $firstHeightCondition, maxHeightTime: $maxHeightTime, maxHeightValue: $maxHeightValue, maxHeightIsOver: $maxHeightIsOver, maxHeightCondition: $maxHeightCondition, isObserving: $isObserving)';
}


}

/// @nodoc
abstract mixin class _$TsunamiEstimationCopyWith<$Res> implements $TsunamiEstimationCopyWith<$Res> {
  factory _$TsunamiEstimationCopyWith(_TsunamiEstimation value, $Res Function(_TsunamiEstimation) _then) = __$TsunamiEstimationCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, DateTime? firstHeightTime, TsunamiEstimationFirstHeightCondition? firstHeightCondition, DateTime? maxHeightTime, double? maxHeightValue, bool? maxHeightIsOver, TsunamiMaxHeightCondition? maxHeightCondition, bool? isObserving
});




}
/// @nodoc
class __$TsunamiEstimationCopyWithImpl<$Res>
    implements _$TsunamiEstimationCopyWith<$Res> {
  __$TsunamiEstimationCopyWithImpl(this._self, this._then);

  final _TsunamiEstimation _self;
  final $Res Function(_TsunamiEstimation) _then;

/// Create a copy of TsunamiEstimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? firstHeightTime = freezed,Object? firstHeightCondition = freezed,Object? maxHeightTime = freezed,Object? maxHeightValue = freezed,Object? maxHeightIsOver = freezed,Object? maxHeightCondition = freezed,Object? isObserving = freezed,}) {
  return _then(_TsunamiEstimation(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,firstHeightTime: freezed == firstHeightTime ? _self.firstHeightTime : firstHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,firstHeightCondition: freezed == firstHeightCondition ? _self.firstHeightCondition : firstHeightCondition // ignore: cast_nullable_to_non_nullable
as TsunamiEstimationFirstHeightCondition?,maxHeightTime: freezed == maxHeightTime ? _self.maxHeightTime : maxHeightTime // ignore: cast_nullable_to_non_nullable
as DateTime?,maxHeightValue: freezed == maxHeightValue ? _self.maxHeightValue : maxHeightValue // ignore: cast_nullable_to_non_nullable
as double?,maxHeightIsOver: freezed == maxHeightIsOver ? _self.maxHeightIsOver : maxHeightIsOver // ignore: cast_nullable_to_non_nullable
as bool?,maxHeightCondition: freezed == maxHeightCondition ? _self.maxHeightCondition : maxHeightCondition // ignore: cast_nullable_to_non_nullable
as TsunamiMaxHeightCondition?,isObserving: freezed == isObserving ? _self.isObserving : isObserving // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$PublicBodyVTSE41 {

 PublicBodyVTSE41Tsunami get tsunami; List<Earthquake> get earthquakes; String? get text; Comment? get comment;
/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicBodyVTSE41CopyWith<PublicBodyVTSE41> get copyWith => _$PublicBodyVTSE41CopyWithImpl<PublicBodyVTSE41>(this as PublicBodyVTSE41, _$identity);

  /// Serializes this PublicBodyVTSE41 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicBodyVTSE41&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami,const DeepCollectionEquality().hash(earthquakes),text,comment);

@override
String toString() {
  return 'PublicBodyVTSE41(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $PublicBodyVTSE41CopyWith<$Res>  {
  factory $PublicBodyVTSE41CopyWith(PublicBodyVTSE41 value, $Res Function(PublicBodyVTSE41) _then) = _$PublicBodyVTSE41CopyWithImpl;
@useResult
$Res call({
 PublicBodyVTSE41Tsunami tsunami, List<Earthquake> earthquakes, String? text, Comment? comment
});


$PublicBodyVTSE41TsunamiCopyWith<$Res> get tsunami;$CommentCopyWith<$Res>? get comment;

}
/// @nodoc
class _$PublicBodyVTSE41CopyWithImpl<$Res>
    implements $PublicBodyVTSE41CopyWith<$Res> {
  _$PublicBodyVTSE41CopyWithImpl(this._self, this._then);

  final PublicBodyVTSE41 _self;
  final $Res Function(PublicBodyVTSE41) _then;

/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunami = null,Object? earthquakes = null,Object? text = freezed,Object? comment = freezed,}) {
  return _then(_self.copyWith(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as PublicBodyVTSE41Tsunami,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment?,
  ));
}
/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicBodyVTSE41TsunamiCopyWith<$Res> get tsunami {
  
  return $PublicBodyVTSE41TsunamiCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $CommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PublicBodyVTSE41 implements PublicBodyVTSE41 {
  const _PublicBodyVTSE41({required this.tsunami, required final  List<Earthquake> earthquakes, required this.text, required this.comment}): _earthquakes = earthquakes;
  factory _PublicBodyVTSE41.fromJson(Map<String, dynamic> json) => _$PublicBodyVTSE41FromJson(json);

@override final  PublicBodyVTSE41Tsunami tsunami;
 final  List<Earthquake> _earthquakes;
@override List<Earthquake> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

@override final  String? text;
@override final  Comment? comment;

/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicBodyVTSE41CopyWith<_PublicBodyVTSE41> get copyWith => __$PublicBodyVTSE41CopyWithImpl<_PublicBodyVTSE41>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicBodyVTSE41ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicBodyVTSE41&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami,const DeepCollectionEquality().hash(_earthquakes),text,comment);

@override
String toString() {
  return 'PublicBodyVTSE41(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$PublicBodyVTSE41CopyWith<$Res> implements $PublicBodyVTSE41CopyWith<$Res> {
  factory _$PublicBodyVTSE41CopyWith(_PublicBodyVTSE41 value, $Res Function(_PublicBodyVTSE41) _then) = __$PublicBodyVTSE41CopyWithImpl;
@override @useResult
$Res call({
 PublicBodyVTSE41Tsunami tsunami, List<Earthquake> earthquakes, String? text, Comment? comment
});


@override $PublicBodyVTSE41TsunamiCopyWith<$Res> get tsunami;@override $CommentCopyWith<$Res>? get comment;

}
/// @nodoc
class __$PublicBodyVTSE41CopyWithImpl<$Res>
    implements _$PublicBodyVTSE41CopyWith<$Res> {
  __$PublicBodyVTSE41CopyWithImpl(this._self, this._then);

  final _PublicBodyVTSE41 _self;
  final $Res Function(_PublicBodyVTSE41) _then;

/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunami = null,Object? earthquakes = null,Object? text = freezed,Object? comment = freezed,}) {
  return _then(_PublicBodyVTSE41(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as PublicBodyVTSE41Tsunami,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment?,
  ));
}

/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicBodyVTSE41TsunamiCopyWith<$Res> get tsunami {
  
  return $PublicBodyVTSE41TsunamiCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of PublicBodyVTSE41
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $CommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// @nodoc
mixin _$PublicBodyVTSE51 {

 PublicBodyVTSE51Tsunami get tsunami; List<Earthquake> get earthquakes; String? get text; Comment? get comment;
/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicBodyVTSE51CopyWith<PublicBodyVTSE51> get copyWith => _$PublicBodyVTSE51CopyWithImpl<PublicBodyVTSE51>(this as PublicBodyVTSE51, _$identity);

  /// Serializes this PublicBodyVTSE51 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicBodyVTSE51&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami,const DeepCollectionEquality().hash(earthquakes),text,comment);

@override
String toString() {
  return 'PublicBodyVTSE51(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $PublicBodyVTSE51CopyWith<$Res>  {
  factory $PublicBodyVTSE51CopyWith(PublicBodyVTSE51 value, $Res Function(PublicBodyVTSE51) _then) = _$PublicBodyVTSE51CopyWithImpl;
@useResult
$Res call({
 PublicBodyVTSE51Tsunami tsunami, List<Earthquake> earthquakes, String? text, Comment? comment
});


$PublicBodyVTSE51TsunamiCopyWith<$Res> get tsunami;$CommentCopyWith<$Res>? get comment;

}
/// @nodoc
class _$PublicBodyVTSE51CopyWithImpl<$Res>
    implements $PublicBodyVTSE51CopyWith<$Res> {
  _$PublicBodyVTSE51CopyWithImpl(this._self, this._then);

  final PublicBodyVTSE51 _self;
  final $Res Function(PublicBodyVTSE51) _then;

/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunami = null,Object? earthquakes = null,Object? text = freezed,Object? comment = freezed,}) {
  return _then(_self.copyWith(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as PublicBodyVTSE51Tsunami,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment?,
  ));
}
/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicBodyVTSE51TsunamiCopyWith<$Res> get tsunami {
  
  return $PublicBodyVTSE51TsunamiCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $CommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PublicBodyVTSE51 implements PublicBodyVTSE51 {
  const _PublicBodyVTSE51({required this.tsunami, required final  List<Earthquake> earthquakes, required this.text, required this.comment}): _earthquakes = earthquakes;
  factory _PublicBodyVTSE51.fromJson(Map<String, dynamic> json) => _$PublicBodyVTSE51FromJson(json);

@override final  PublicBodyVTSE51Tsunami tsunami;
 final  List<Earthquake> _earthquakes;
@override List<Earthquake> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

@override final  String? text;
@override final  Comment? comment;

/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicBodyVTSE51CopyWith<_PublicBodyVTSE51> get copyWith => __$PublicBodyVTSE51CopyWithImpl<_PublicBodyVTSE51>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicBodyVTSE51ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicBodyVTSE51&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami,const DeepCollectionEquality().hash(_earthquakes),text,comment);

@override
String toString() {
  return 'PublicBodyVTSE51(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$PublicBodyVTSE51CopyWith<$Res> implements $PublicBodyVTSE51CopyWith<$Res> {
  factory _$PublicBodyVTSE51CopyWith(_PublicBodyVTSE51 value, $Res Function(_PublicBodyVTSE51) _then) = __$PublicBodyVTSE51CopyWithImpl;
@override @useResult
$Res call({
 PublicBodyVTSE51Tsunami tsunami, List<Earthquake> earthquakes, String? text, Comment? comment
});


@override $PublicBodyVTSE51TsunamiCopyWith<$Res> get tsunami;@override $CommentCopyWith<$Res>? get comment;

}
/// @nodoc
class __$PublicBodyVTSE51CopyWithImpl<$Res>
    implements _$PublicBodyVTSE51CopyWith<$Res> {
  __$PublicBodyVTSE51CopyWithImpl(this._self, this._then);

  final _PublicBodyVTSE51 _self;
  final $Res Function(_PublicBodyVTSE51) _then;

/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunami = null,Object? earthquakes = null,Object? text = freezed,Object? comment = freezed,}) {
  return _then(_PublicBodyVTSE51(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as PublicBodyVTSE51Tsunami,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment?,
  ));
}

/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicBodyVTSE51TsunamiCopyWith<$Res> get tsunami {
  
  return $PublicBodyVTSE51TsunamiCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of PublicBodyVTSE51
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $CommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// @nodoc
mixin _$PublicBodyVTSE52 {

 PublicBodyVTSE52Tsunami get tsunami; List<Earthquake> get earthquakes; String? get text; Comment? get comment;
/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicBodyVTSE52CopyWith<PublicBodyVTSE52> get copyWith => _$PublicBodyVTSE52CopyWithImpl<PublicBodyVTSE52>(this as PublicBodyVTSE52, _$identity);

  /// Serializes this PublicBodyVTSE52 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicBodyVTSE52&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other.earthquakes, earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami,const DeepCollectionEquality().hash(earthquakes),text,comment);

@override
String toString() {
  return 'PublicBodyVTSE52(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $PublicBodyVTSE52CopyWith<$Res>  {
  factory $PublicBodyVTSE52CopyWith(PublicBodyVTSE52 value, $Res Function(PublicBodyVTSE52) _then) = _$PublicBodyVTSE52CopyWithImpl;
@useResult
$Res call({
 PublicBodyVTSE52Tsunami tsunami, List<Earthquake> earthquakes, String? text, Comment? comment
});


$PublicBodyVTSE52TsunamiCopyWith<$Res> get tsunami;$CommentCopyWith<$Res>? get comment;

}
/// @nodoc
class _$PublicBodyVTSE52CopyWithImpl<$Res>
    implements $PublicBodyVTSE52CopyWith<$Res> {
  _$PublicBodyVTSE52CopyWithImpl(this._self, this._then);

  final PublicBodyVTSE52 _self;
  final $Res Function(PublicBodyVTSE52) _then;

/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tsunami = null,Object? earthquakes = null,Object? text = freezed,Object? comment = freezed,}) {
  return _then(_self.copyWith(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as PublicBodyVTSE52Tsunami,earthquakes: null == earthquakes ? _self.earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment?,
  ));
}
/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicBodyVTSE52TsunamiCopyWith<$Res> get tsunami {
  
  return $PublicBodyVTSE52TsunamiCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $CommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PublicBodyVTSE52 implements PublicBodyVTSE52 {
  const _PublicBodyVTSE52({required this.tsunami, required final  List<Earthquake> earthquakes, required this.text, required this.comment}): _earthquakes = earthquakes;
  factory _PublicBodyVTSE52.fromJson(Map<String, dynamic> json) => _$PublicBodyVTSE52FromJson(json);

@override final  PublicBodyVTSE52Tsunami tsunami;
 final  List<Earthquake> _earthquakes;
@override List<Earthquake> get earthquakes {
  if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_earthquakes);
}

@override final  String? text;
@override final  Comment? comment;

/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicBodyVTSE52CopyWith<_PublicBodyVTSE52> get copyWith => __$PublicBodyVTSE52CopyWithImpl<_PublicBodyVTSE52>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicBodyVTSE52ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicBodyVTSE52&&(identical(other.tsunami, tsunami) || other.tsunami == tsunami)&&const DeepCollectionEquality().equals(other._earthquakes, _earthquakes)&&(identical(other.text, text) || other.text == text)&&(identical(other.comment, comment) || other.comment == comment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tsunami,const DeepCollectionEquality().hash(_earthquakes),text,comment);

@override
String toString() {
  return 'PublicBodyVTSE52(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$PublicBodyVTSE52CopyWith<$Res> implements $PublicBodyVTSE52CopyWith<$Res> {
  factory _$PublicBodyVTSE52CopyWith(_PublicBodyVTSE52 value, $Res Function(_PublicBodyVTSE52) _then) = __$PublicBodyVTSE52CopyWithImpl;
@override @useResult
$Res call({
 PublicBodyVTSE52Tsunami tsunami, List<Earthquake> earthquakes, String? text, Comment? comment
});


@override $PublicBodyVTSE52TsunamiCopyWith<$Res> get tsunami;@override $CommentCopyWith<$Res>? get comment;

}
/// @nodoc
class __$PublicBodyVTSE52CopyWithImpl<$Res>
    implements _$PublicBodyVTSE52CopyWith<$Res> {
  __$PublicBodyVTSE52CopyWithImpl(this._self, this._then);

  final _PublicBodyVTSE52 _self;
  final $Res Function(_PublicBodyVTSE52) _then;

/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tsunami = null,Object? earthquakes = null,Object? text = freezed,Object? comment = freezed,}) {
  return _then(_PublicBodyVTSE52(
tsunami: null == tsunami ? _self.tsunami : tsunami // ignore: cast_nullable_to_non_nullable
as PublicBodyVTSE52Tsunami,earthquakes: null == earthquakes ? _self._earthquakes : earthquakes // ignore: cast_nullable_to_non_nullable
as List<Earthquake>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as Comment?,
  ));
}

/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicBodyVTSE52TsunamiCopyWith<$Res> get tsunami {
  
  return $PublicBodyVTSE52TsunamiCopyWith<$Res>(_self.tsunami, (value) {
    return _then(_self.copyWith(tsunami: value));
  });
}/// Create a copy of PublicBodyVTSE52
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentCopyWith<$Res>? get comment {
    if (_self.comment == null) {
    return null;
  }

  return $CommentCopyWith<$Res>(_self.comment!, (value) {
    return _then(_self.copyWith(comment: value));
  });
}
}


/// @nodoc
mixin _$Earthquake {

 DateTime get originTime; DateTime get arrivalTime; EarthquakeHypocenter get hypocenter; EarthquakeMagnitude get magnitude;
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<Earthquake> get copyWith => _$EarthquakeCopyWithImpl<Earthquake>(this as Earthquake, _$identity);

  /// Serializes this Earthquake to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Earthquake&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,arrivalTime,hypocenter,magnitude);

@override
String toString() {
  return 'Earthquake(originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, magnitude: $magnitude)';
}


}

/// @nodoc
abstract mixin class $EarthquakeCopyWith<$Res>  {
  factory $EarthquakeCopyWith(Earthquake value, $Res Function(Earthquake) _then) = _$EarthquakeCopyWithImpl;
@useResult
$Res call({
 DateTime originTime, DateTime arrivalTime, EarthquakeHypocenter hypocenter, EarthquakeMagnitude magnitude
});


$EarthquakeHypocenterCopyWith<$Res> get hypocenter;$EarthquakeMagnitudeCopyWith<$Res> get magnitude;

}
/// @nodoc
class _$EarthquakeCopyWithImpl<$Res>
    implements $EarthquakeCopyWith<$Res> {
  _$EarthquakeCopyWithImpl(this._self, this._then);

  final Earthquake _self;
  final $Res Function(Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = null,Object? arrivalTime = null,Object? hypocenter = null,Object? magnitude = null,}) {
  return _then(_self.copyWith(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude,
  ));
}
/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res> get magnitude {
  
  return $EarthquakeMagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Earthquake implements Earthquake {
  const _Earthquake({required this.originTime, required this.arrivalTime, required this.hypocenter, required this.magnitude});
  factory _Earthquake.fromJson(Map<String, dynamic> json) => _$EarthquakeFromJson(json);

@override final  DateTime originTime;
@override final  DateTime arrivalTime;
@override final  EarthquakeHypocenter hypocenter;
@override final  EarthquakeMagnitude magnitude;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeCopyWith<_Earthquake> get copyWith => __$EarthquakeCopyWithImpl<_Earthquake>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Earthquake&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.magnitude, magnitude) || other.magnitude == magnitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originTime,arrivalTime,hypocenter,magnitude);

@override
String toString() {
  return 'Earthquake(originTime: $originTime, arrivalTime: $arrivalTime, hypocenter: $hypocenter, magnitude: $magnitude)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeCopyWith<$Res> implements $EarthquakeCopyWith<$Res> {
  factory _$EarthquakeCopyWith(_Earthquake value, $Res Function(_Earthquake) _then) = __$EarthquakeCopyWithImpl;
@override @useResult
$Res call({
 DateTime originTime, DateTime arrivalTime, EarthquakeHypocenter hypocenter, EarthquakeMagnitude magnitude
});


@override $EarthquakeHypocenterCopyWith<$Res> get hypocenter;@override $EarthquakeMagnitudeCopyWith<$Res> get magnitude;

}
/// @nodoc
class __$EarthquakeCopyWithImpl<$Res>
    implements _$EarthquakeCopyWith<$Res> {
  __$EarthquakeCopyWithImpl(this._self, this._then);

  final _Earthquake _self;
  final $Res Function(_Earthquake) _then;

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originTime = null,Object? arrivalTime = null,Object? hypocenter = null,Object? magnitude = null,}) {
  return _then(_Earthquake(
originTime: null == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime,arrivalTime: null == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter,magnitude: null == magnitude ? _self.magnitude : magnitude // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitude,
  ));
}

/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of Earthquake
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<$Res> get magnitude {
  
  return $EarthquakeMagnitudeCopyWith<$Res>(_self.magnitude, (value) {
    return _then(_self.copyWith(magnitude: value));
  });
}
}


/// @nodoc
mixin _$EarthquakeHypocenter {

 String get name; String get code; int? get depth; EarthquakeHypocenterDetailed? get detailed; EarthquakeHypocenterCoordinate? get coordinate;
/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<EarthquakeHypocenter> get copyWith => _$EarthquakeHypocenterCopyWithImpl<EarthquakeHypocenter>(this as EarthquakeHypocenter, _$identity);

  /// Serializes this EarthquakeHypocenter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocenter&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailed, detailed) || other.detailed == detailed)&&(identical(other.coordinate, coordinate) || other.coordinate == coordinate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,depth,detailed,coordinate);

@override
String toString() {
  return 'EarthquakeHypocenter(name: $name, code: $code, depth: $depth, detailed: $detailed, coordinate: $coordinate)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocenterCopyWith<$Res>  {
  factory $EarthquakeHypocenterCopyWith(EarthquakeHypocenter value, $Res Function(EarthquakeHypocenter) _then) = _$EarthquakeHypocenterCopyWithImpl;
@useResult
$Res call({
 String name, String code, int? depth, EarthquakeHypocenterDetailed? detailed, EarthquakeHypocenterCoordinate? coordinate
});


$EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed;$EarthquakeHypocenterCoordinateCopyWith<$Res>? get coordinate;

}
/// @nodoc
class _$EarthquakeHypocenterCopyWithImpl<$Res>
    implements $EarthquakeHypocenterCopyWith<$Res> {
  _$EarthquakeHypocenterCopyWithImpl(this._self, this._then);

  final EarthquakeHypocenter _self;
  final $Res Function(EarthquakeHypocenter) _then;

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? code = null,Object? depth = freezed,Object? detailed = freezed,Object? coordinate = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenterDetailed?,coordinate: freezed == coordinate ? _self.coordinate : coordinate // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenterCoordinate?,
  ));
}
/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed {
    if (_self.detailed == null) {
    return null;
  }

  return $EarthquakeHypocenterDetailedCopyWith<$Res>(_self.detailed!, (value) {
    return _then(_self.copyWith(detailed: value));
  });
}/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCoordinateCopyWith<$Res>? get coordinate {
    if (_self.coordinate == null) {
    return null;
  }

  return $EarthquakeHypocenterCoordinateCopyWith<$Res>(_self.coordinate!, (value) {
    return _then(_self.copyWith(coordinate: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _EarthquakeHypocenter implements EarthquakeHypocenter {
  const _EarthquakeHypocenter({required this.name, required this.code, required this.depth, required this.detailed, required this.coordinate});
  factory _EarthquakeHypocenter.fromJson(Map<String, dynamic> json) => _$EarthquakeHypocenterFromJson(json);

@override final  String name;
@override final  String code;
@override final  int? depth;
@override final  EarthquakeHypocenterDetailed? detailed;
@override final  EarthquakeHypocenterCoordinate? coordinate;

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHypocenterCopyWith<_EarthquakeHypocenter> get copyWith => __$EarthquakeHypocenterCopyWithImpl<_EarthquakeHypocenter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHypocenterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHypocenter&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.detailed, detailed) || other.detailed == detailed)&&(identical(other.coordinate, coordinate) || other.coordinate == coordinate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,code,depth,detailed,coordinate);

@override
String toString() {
  return 'EarthquakeHypocenter(name: $name, code: $code, depth: $depth, detailed: $detailed, coordinate: $coordinate)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHypocenterCopyWith<$Res> implements $EarthquakeHypocenterCopyWith<$Res> {
  factory _$EarthquakeHypocenterCopyWith(_EarthquakeHypocenter value, $Res Function(_EarthquakeHypocenter) _then) = __$EarthquakeHypocenterCopyWithImpl;
@override @useResult
$Res call({
 String name, String code, int? depth, EarthquakeHypocenterDetailed? detailed, EarthquakeHypocenterCoordinate? coordinate
});


@override $EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed;@override $EarthquakeHypocenterCoordinateCopyWith<$Res>? get coordinate;

}
/// @nodoc
class __$EarthquakeHypocenterCopyWithImpl<$Res>
    implements _$EarthquakeHypocenterCopyWith<$Res> {
  __$EarthquakeHypocenterCopyWithImpl(this._self, this._then);

  final _EarthquakeHypocenter _self;
  final $Res Function(_EarthquakeHypocenter) _then;

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? code = null,Object? depth = freezed,Object? detailed = freezed,Object? coordinate = freezed,}) {
  return _then(_EarthquakeHypocenter(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,depth: freezed == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int?,detailed: freezed == detailed ? _self.detailed : detailed // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenterDetailed?,coordinate: freezed == coordinate ? _self.coordinate : coordinate // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenterCoordinate?,
  ));
}

/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterDetailedCopyWith<$Res>? get detailed {
    if (_self.detailed == null) {
    return null;
  }

  return $EarthquakeHypocenterDetailedCopyWith<$Res>(_self.detailed!, (value) {
    return _then(_self.copyWith(detailed: value));
  });
}/// Create a copy of EarthquakeHypocenter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCoordinateCopyWith<$Res>? get coordinate {
    if (_self.coordinate == null) {
    return null;
  }

  return $EarthquakeHypocenterCoordinateCopyWith<$Res>(_self.coordinate!, (value) {
    return _then(_self.copyWith(coordinate: value));
  });
}
}


/// @nodoc
mixin _$EarthquakeHypocenterDetailed {

 String get code; String get name;
/// Create a copy of EarthquakeHypocenterDetailed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocenterDetailedCopyWith<EarthquakeHypocenterDetailed> get copyWith => _$EarthquakeHypocenterDetailedCopyWithImpl<EarthquakeHypocenterDetailed>(this as EarthquakeHypocenterDetailed, _$identity);

  /// Serializes this EarthquakeHypocenterDetailed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocenterDetailed&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'EarthquakeHypocenterDetailed(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocenterDetailedCopyWith<$Res>  {
  factory $EarthquakeHypocenterDetailedCopyWith(EarthquakeHypocenterDetailed value, $Res Function(EarthquakeHypocenterDetailed) _then) = _$EarthquakeHypocenterDetailedCopyWithImpl;
@useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class _$EarthquakeHypocenterDetailedCopyWithImpl<$Res>
    implements $EarthquakeHypocenterDetailedCopyWith<$Res> {
  _$EarthquakeHypocenterDetailedCopyWithImpl(this._self, this._then);

  final EarthquakeHypocenterDetailed _self;
  final $Res Function(EarthquakeHypocenterDetailed) _then;

/// Create a copy of EarthquakeHypocenterDetailed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeHypocenterDetailed implements EarthquakeHypocenterDetailed {
  const _EarthquakeHypocenterDetailed({required this.code, required this.name});
  factory _EarthquakeHypocenterDetailed.fromJson(Map<String, dynamic> json) => _$EarthquakeHypocenterDetailedFromJson(json);

@override final  String code;
@override final  String name;

/// Create a copy of EarthquakeHypocenterDetailed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHypocenterDetailedCopyWith<_EarthquakeHypocenterDetailed> get copyWith => __$EarthquakeHypocenterDetailedCopyWithImpl<_EarthquakeHypocenterDetailed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHypocenterDetailedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHypocenterDetailed&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'EarthquakeHypocenterDetailed(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHypocenterDetailedCopyWith<$Res> implements $EarthquakeHypocenterDetailedCopyWith<$Res> {
  factory _$EarthquakeHypocenterDetailedCopyWith(_EarthquakeHypocenterDetailed value, $Res Function(_EarthquakeHypocenterDetailed) _then) = __$EarthquakeHypocenterDetailedCopyWithImpl;
@override @useResult
$Res call({
 String code, String name
});




}
/// @nodoc
class __$EarthquakeHypocenterDetailedCopyWithImpl<$Res>
    implements _$EarthquakeHypocenterDetailedCopyWith<$Res> {
  __$EarthquakeHypocenterDetailedCopyWithImpl(this._self, this._then);

  final _EarthquakeHypocenterDetailed _self;
  final $Res Function(_EarthquakeHypocenterDetailed) _then;

/// Create a copy of EarthquakeHypocenterDetailed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_EarthquakeHypocenterDetailed(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EarthquakeHypocenterCoordinate {

 double get lat; double get lon;
/// Create a copy of EarthquakeHypocenterCoordinate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCoordinateCopyWith<EarthquakeHypocenterCoordinate> get copyWith => _$EarthquakeHypocenterCoordinateCopyWithImpl<EarthquakeHypocenterCoordinate>(this as EarthquakeHypocenterCoordinate, _$identity);

  /// Serializes this EarthquakeHypocenterCoordinate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocenterCoordinate&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon);

@override
String toString() {
  return 'EarthquakeHypocenterCoordinate(lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocenterCoordinateCopyWith<$Res>  {
  factory $EarthquakeHypocenterCoordinateCopyWith(EarthquakeHypocenterCoordinate value, $Res Function(EarthquakeHypocenterCoordinate) _then) = _$EarthquakeHypocenterCoordinateCopyWithImpl;
@useResult
$Res call({
 double lat, double lon
});




}
/// @nodoc
class _$EarthquakeHypocenterCoordinateCopyWithImpl<$Res>
    implements $EarthquakeHypocenterCoordinateCopyWith<$Res> {
  _$EarthquakeHypocenterCoordinateCopyWithImpl(this._self, this._then);

  final EarthquakeHypocenterCoordinate _self;
  final $Res Function(EarthquakeHypocenterCoordinate) _then;

/// Create a copy of EarthquakeHypocenterCoordinate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lon = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeHypocenterCoordinate implements EarthquakeHypocenterCoordinate {
  const _EarthquakeHypocenterCoordinate({required this.lat, required this.lon});
  factory _EarthquakeHypocenterCoordinate.fromJson(Map<String, dynamic> json) => _$EarthquakeHypocenterCoordinateFromJson(json);

@override final  double lat;
@override final  double lon;

/// Create a copy of EarthquakeHypocenterCoordinate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeHypocenterCoordinateCopyWith<_EarthquakeHypocenterCoordinate> get copyWith => __$EarthquakeHypocenterCoordinateCopyWithImpl<_EarthquakeHypocenterCoordinate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHypocenterCoordinateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeHypocenterCoordinate&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon);

@override
String toString() {
  return 'EarthquakeHypocenterCoordinate(lat: $lat, lon: $lon)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeHypocenterCoordinateCopyWith<$Res> implements $EarthquakeHypocenterCoordinateCopyWith<$Res> {
  factory _$EarthquakeHypocenterCoordinateCopyWith(_EarthquakeHypocenterCoordinate value, $Res Function(_EarthquakeHypocenterCoordinate) _then) = __$EarthquakeHypocenterCoordinateCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lon
});




}
/// @nodoc
class __$EarthquakeHypocenterCoordinateCopyWithImpl<$Res>
    implements _$EarthquakeHypocenterCoordinateCopyWith<$Res> {
  __$EarthquakeHypocenterCoordinateCopyWithImpl(this._self, this._then);

  final _EarthquakeHypocenterCoordinate _self;
  final $Res Function(_EarthquakeHypocenterCoordinate) _then;

/// Create a copy of EarthquakeHypocenterCoordinate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lon = null,}) {
  return _then(_EarthquakeHypocenterCoordinate(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EarthquakeMagnitude {

 double? get value; EarthquakeMagnitudeCondition? get condition;
/// Create a copy of EarthquakeMagnitude
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeMagnitudeCopyWith<EarthquakeMagnitude> get copyWith => _$EarthquakeMagnitudeCopyWithImpl<EarthquakeMagnitude>(this as EarthquakeMagnitude, _$identity);

  /// Serializes this EarthquakeMagnitude to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeMagnitude&&(identical(other.value, value) || other.value == value)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,condition);

@override
String toString() {
  return 'EarthquakeMagnitude(value: $value, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $EarthquakeMagnitudeCopyWith<$Res>  {
  factory $EarthquakeMagnitudeCopyWith(EarthquakeMagnitude value, $Res Function(EarthquakeMagnitude) _then) = _$EarthquakeMagnitudeCopyWithImpl;
@useResult
$Res call({
 double? value, EarthquakeMagnitudeCondition? condition
});




}
/// @nodoc
class _$EarthquakeMagnitudeCopyWithImpl<$Res>
    implements $EarthquakeMagnitudeCopyWith<$Res> {
  _$EarthquakeMagnitudeCopyWithImpl(this._self, this._then);

  final EarthquakeMagnitude _self;
  final $Res Function(EarthquakeMagnitude) _then;

/// Create a copy of EarthquakeMagnitude
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,Object? condition = freezed,}) {
  return _then(_self.copyWith(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitudeCondition?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EarthquakeMagnitude implements EarthquakeMagnitude {
  const _EarthquakeMagnitude({required this.value, required this.condition});
  factory _EarthquakeMagnitude.fromJson(Map<String, dynamic> json) => _$EarthquakeMagnitudeFromJson(json);

@override final  double? value;
@override final  EarthquakeMagnitudeCondition? condition;

/// Create a copy of EarthquakeMagnitude
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeMagnitudeCopyWith<_EarthquakeMagnitude> get copyWith => __$EarthquakeMagnitudeCopyWithImpl<_EarthquakeMagnitude>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeMagnitudeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeMagnitude&&(identical(other.value, value) || other.value == value)&&(identical(other.condition, condition) || other.condition == condition));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,condition);

@override
String toString() {
  return 'EarthquakeMagnitude(value: $value, condition: $condition)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeMagnitudeCopyWith<$Res> implements $EarthquakeMagnitudeCopyWith<$Res> {
  factory _$EarthquakeMagnitudeCopyWith(_EarthquakeMagnitude value, $Res Function(_EarthquakeMagnitude) _then) = __$EarthquakeMagnitudeCopyWithImpl;
@override @useResult
$Res call({
 double? value, EarthquakeMagnitudeCondition? condition
});




}
/// @nodoc
class __$EarthquakeMagnitudeCopyWithImpl<$Res>
    implements _$EarthquakeMagnitudeCopyWith<$Res> {
  __$EarthquakeMagnitudeCopyWithImpl(this._self, this._then);

  final _EarthquakeMagnitude _self;
  final $Res Function(_EarthquakeMagnitude) _then;

/// Create a copy of EarthquakeMagnitude
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,Object? condition = freezed,}) {
  return _then(_EarthquakeMagnitude(
value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double?,condition: freezed == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as EarthquakeMagnitudeCondition?,
  ));
}


}

// dart format on
