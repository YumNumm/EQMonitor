// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TelegramV3Base _$TelegramV3BaseFromJson(Map<String, dynamic> json) {
  return _TelegramV3Base.fromJson(json);
}

/// @nodoc
mixin _$TelegramV3Base {
  int? get id => throw _privateConstructorUsedError;
  String? get hash =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  int get eventId => throw _privateConstructorUsedError;
  TelegramType get type => throw _privateConstructorUsedError;
  SchemaType get schemaType => throw _privateConstructorUsedError;
  TelegramStatus get status => throw _privateConstructorUsedError;
  TelegramInfoType get infoType => throw _privateConstructorUsedError;
  DateTime get pressTime => throw _privateConstructorUsedError;
  DateTime? get reportTime => throw _privateConstructorUsedError;
  DateTime? get validTime => throw _privateConstructorUsedError;
  int? get serialNo => throw _privateConstructorUsedError;
  String? get headline => throw _privateConstructorUsedError;
  Map<String, dynamic> get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramV3BaseCopyWith<TelegramV3Base> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramV3BaseCopyWith<$Res> {
  factory $TelegramV3BaseCopyWith(
          TelegramV3Base value, $Res Function(TelegramV3Base) then) =
      _$TelegramV3BaseCopyWithImpl<$Res, TelegramV3Base>;
  @useResult
  $Res call(
      {int? id,
      String? hash,
      int eventId,
      TelegramType type,
      SchemaType schemaType,
      TelegramStatus status,
      TelegramInfoType infoType,
      DateTime pressTime,
      DateTime? reportTime,
      DateTime? validTime,
      int? serialNo,
      String? headline,
      Map<String, dynamic> body});
}

/// @nodoc
class _$TelegramV3BaseCopyWithImpl<$Res, $Val extends TelegramV3Base>
    implements $TelegramV3BaseCopyWith<$Res> {
  _$TelegramV3BaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? hash = freezed,
    Object? eventId = null,
    Object? type = null,
    Object? schemaType = null,
    Object? status = null,
    Object? infoType = null,
    Object? pressTime = null,
    Object? reportTime = freezed,
    Object? validTime = freezed,
    Object? serialNo = freezed,
    Object? headline = freezed,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TelegramType,
      schemaType: null == schemaType
          ? _value.schemaType
          : schemaType // ignore: cast_nullable_to_non_nullable
              as SchemaType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TelegramStatus,
      infoType: null == infoType
          ? _value.infoType
          : infoType // ignore: cast_nullable_to_non_nullable
              as TelegramInfoType,
      pressTime: null == pressTime
          ? _value.pressTime
          : pressTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reportTime: freezed == reportTime
          ? _value.reportTime
          : reportTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validTime: freezed == validTime
          ? _value.validTime
          : validTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as int?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TelegramV3BaseCopyWith<$Res>
    implements $TelegramV3BaseCopyWith<$Res> {
  factory _$$_TelegramV3BaseCopyWith(
          _$_TelegramV3Base value, $Res Function(_$_TelegramV3Base) then) =
      __$$_TelegramV3BaseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? hash,
      int eventId,
      TelegramType type,
      SchemaType schemaType,
      TelegramStatus status,
      TelegramInfoType infoType,
      DateTime pressTime,
      DateTime? reportTime,
      DateTime? validTime,
      int? serialNo,
      String? headline,
      Map<String, dynamic> body});
}

/// @nodoc
class __$$_TelegramV3BaseCopyWithImpl<$Res>
    extends _$TelegramV3BaseCopyWithImpl<$Res, _$_TelegramV3Base>
    implements _$$_TelegramV3BaseCopyWith<$Res> {
  __$$_TelegramV3BaseCopyWithImpl(
      _$_TelegramV3Base _value, $Res Function(_$_TelegramV3Base) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? hash = freezed,
    Object? eventId = null,
    Object? type = null,
    Object? schemaType = null,
    Object? status = null,
    Object? infoType = null,
    Object? pressTime = null,
    Object? reportTime = freezed,
    Object? validTime = freezed,
    Object? serialNo = freezed,
    Object? headline = freezed,
    Object? body = null,
  }) {
    return _then(_$_TelegramV3Base(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      hash: freezed == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String?,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TelegramType,
      schemaType: null == schemaType
          ? _value.schemaType
          : schemaType // ignore: cast_nullable_to_non_nullable
              as SchemaType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TelegramStatus,
      infoType: null == infoType
          ? _value.infoType
          : infoType // ignore: cast_nullable_to_non_nullable
              as TelegramInfoType,
      pressTime: null == pressTime
          ? _value.pressTime
          : pressTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      reportTime: freezed == reportTime
          ? _value.reportTime
          : reportTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      validTime: freezed == validTime
          ? _value.validTime
          : validTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serialNo: freezed == serialNo
          ? _value.serialNo
          : serialNo // ignore: cast_nullable_to_non_nullable
              as int?,
      headline: freezed == headline
          ? _value.headline
          : headline // ignore: cast_nullable_to_non_nullable
              as String?,
      body: null == body
          ? _value._body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramV3Base implements _TelegramV3Base {
  const _$_TelegramV3Base(
      {required this.id,
      required this.hash,
      required this.eventId,
      required this.type,
      required this.schemaType,
      required this.status,
      required this.infoType,
      required this.pressTime,
      required this.reportTime,
      required this.validTime,
      required this.serialNo,
      required this.headline,
      required final Map<String, dynamic> body})
      : _body = body;

  factory _$_TelegramV3Base.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramV3BaseFromJson(json);

  @override
  final int? id;
  @override
  final String? hash;
// ignore: invalid_annotation_target
  @override
  final int eventId;
  @override
  final TelegramType type;
  @override
  final SchemaType schemaType;
  @override
  final TelegramStatus status;
  @override
  final TelegramInfoType infoType;
  @override
  final DateTime pressTime;
  @override
  final DateTime? reportTime;
  @override
  final DateTime? validTime;
  @override
  final int? serialNo;
  @override
  final String? headline;
  final Map<String, dynamic> _body;
  @override
  Map<String, dynamic> get body {
    if (_body is EqualUnmodifiableMapView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_body);
  }

  @override
  String toString() {
    return 'TelegramV3Base(id: $id, hash: $hash, eventId: $eventId, type: $type, schemaType: $schemaType, status: $status, infoType: $infoType, pressTime: $pressTime, reportTime: $reportTime, validTime: $validTime, serialNo: $serialNo, headline: $headline, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramV3Base &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.schemaType, schemaType) ||
                other.schemaType == schemaType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.infoType, infoType) ||
                other.infoType == infoType) &&
            (identical(other.pressTime, pressTime) ||
                other.pressTime == pressTime) &&
            (identical(other.reportTime, reportTime) ||
                other.reportTime == reportTime) &&
            (identical(other.validTime, validTime) ||
                other.validTime == validTime) &&
            (identical(other.serialNo, serialNo) ||
                other.serialNo == serialNo) &&
            (identical(other.headline, headline) ||
                other.headline == headline) &&
            const DeepCollectionEquality().equals(other._body, _body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hash,
      eventId,
      type,
      schemaType,
      status,
      infoType,
      pressTime,
      reportTime,
      validTime,
      serialNo,
      headline,
      const DeepCollectionEquality().hash(_body));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramV3BaseCopyWith<_$_TelegramV3Base> get copyWith =>
      __$$_TelegramV3BaseCopyWithImpl<_$_TelegramV3Base>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramV3BaseToJson(
      this,
    );
  }
}

abstract class _TelegramV3Base implements TelegramV3Base {
  const factory _TelegramV3Base(
      {required final int? id,
      required final String? hash,
      required final int eventId,
      required final TelegramType type,
      required final SchemaType schemaType,
      required final TelegramStatus status,
      required final TelegramInfoType infoType,
      required final DateTime pressTime,
      required final DateTime? reportTime,
      required final DateTime? validTime,
      required final int? serialNo,
      required final String? headline,
      required final Map<String, dynamic> body}) = _$_TelegramV3Base;

  factory _TelegramV3Base.fromJson(Map<String, dynamic> json) =
      _$_TelegramV3Base.fromJson;

  @override
  int? get id;
  @override
  String? get hash;
  @override // ignore: invalid_annotation_target
  int get eventId;
  @override
  TelegramType get type;
  @override
  SchemaType get schemaType;
  @override
  TelegramStatus get status;
  @override
  TelegramInfoType get infoType;
  @override
  DateTime get pressTime;
  @override
  DateTime? get reportTime;
  @override
  DateTime? get validTime;
  @override
  int? get serialNo;
  @override
  String? get headline;
  @override
  Map<String, dynamic> get body;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramV3BaseCopyWith<_$_TelegramV3Base> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse51Body _$TelegramVxse51BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse51Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse51Body {
  Intensity? get intensity => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  CommentsOmitVar get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse51BodyCopyWith<TelegramVxse51Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse51BodyCopyWith<$Res> {
  factory $TelegramVxse51BodyCopyWith(
          TelegramVxse51Body value, $Res Function(TelegramVxse51Body) then) =
      _$TelegramVxse51BodyCopyWithImpl<$Res, TelegramVxse51Body>;
  @useResult
  $Res call({Intensity? intensity, String? text, CommentsOmitVar comment});

  $IntensityCopyWith<$Res>? get intensity;
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class _$TelegramVxse51BodyCopyWithImpl<$Res, $Val extends TelegramVxse51Body>
    implements $TelegramVxse51BodyCopyWith<$Res> {
  _$TelegramVxse51BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = freezed,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_value.copyWith(
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IntensityCopyWith<$Res>? get intensity {
    if (_value.intensity == null) {
      return null;
    }

    return $IntensityCopyWith<$Res>(_value.intensity!, (value) {
      return _then(_value.copyWith(intensity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOmitVarCopyWith<$Res> get comment {
    return $CommentsOmitVarCopyWith<$Res>(_value.comment, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse51BodyCopyWith<$Res>
    implements $TelegramVxse51BodyCopyWith<$Res> {
  factory _$$_TelegramVxse51BodyCopyWith(_$_TelegramVxse51Body value,
          $Res Function(_$_TelegramVxse51Body) then) =
      __$$_TelegramVxse51BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Intensity? intensity, String? text, CommentsOmitVar comment});

  @override
  $IntensityCopyWith<$Res>? get intensity;
  @override
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class __$$_TelegramVxse51BodyCopyWithImpl<$Res>
    extends _$TelegramVxse51BodyCopyWithImpl<$Res, _$_TelegramVxse51Body>
    implements _$$_TelegramVxse51BodyCopyWith<$Res> {
  __$$_TelegramVxse51BodyCopyWithImpl(
      _$_TelegramVxse51Body _value, $Res Function(_$_TelegramVxse51Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = freezed,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_$_TelegramVxse51Body(
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse51Body implements _TelegramVxse51Body {
  const _$_TelegramVxse51Body(
      {required this.intensity, required this.text, required this.comment});

  factory _$_TelegramVxse51Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse51BodyFromJson(json);

  @override
  final Intensity? intensity;
  @override
  final String? text;
  @override
  final CommentsOmitVar comment;

  @override
  String toString() {
    return 'TelegramVxse51Body(intensity: $intensity, text: $text, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse51Body &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, intensity, text, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse51BodyCopyWith<_$_TelegramVxse51Body> get copyWith =>
      __$$_TelegramVxse51BodyCopyWithImpl<_$_TelegramVxse51Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse51BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse51Body implements TelegramVxse51Body {
  const factory _TelegramVxse51Body(
      {required final Intensity? intensity,
      required final String? text,
      required final CommentsOmitVar comment}) = _$_TelegramVxse51Body;

  factory _TelegramVxse51Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse51Body.fromJson;

  @override
  Intensity? get intensity;
  @override
  String? get text;
  @override
  CommentsOmitVar get comment;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse51BodyCopyWith<_$_TelegramVxse51Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse52Body _$TelegramVxse52BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse52Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse52Body {
  Earthquake get earthquake => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  CommentsOmitVar get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse52BodyCopyWith<TelegramVxse52Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse52BodyCopyWith<$Res> {
  factory $TelegramVxse52BodyCopyWith(
          TelegramVxse52Body value, $Res Function(TelegramVxse52Body) then) =
      _$TelegramVxse52BodyCopyWithImpl<$Res, TelegramVxse52Body>;
  @useResult
  $Res call({Earthquake earthquake, String? text, CommentsOmitVar comment});

  $EarthquakeCopyWith<$Res> get earthquake;
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class _$TelegramVxse52BodyCopyWithImpl<$Res, $Val extends TelegramVxse52Body>
    implements $TelegramVxse52BodyCopyWith<$Res> {
  _$TelegramVxse52BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_value.copyWith(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeCopyWith<$Res> get earthquake {
    return $EarthquakeCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOmitVarCopyWith<$Res> get comment {
    return $CommentsOmitVarCopyWith<$Res>(_value.comment, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse52BodyCopyWith<$Res>
    implements $TelegramVxse52BodyCopyWith<$Res> {
  factory _$$_TelegramVxse52BodyCopyWith(_$_TelegramVxse52Body value,
          $Res Function(_$_TelegramVxse52Body) then) =
      __$$_TelegramVxse52BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Earthquake earthquake, String? text, CommentsOmitVar comment});

  @override
  $EarthquakeCopyWith<$Res> get earthquake;
  @override
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class __$$_TelegramVxse52BodyCopyWithImpl<$Res>
    extends _$TelegramVxse52BodyCopyWithImpl<$Res, _$_TelegramVxse52Body>
    implements _$$_TelegramVxse52BodyCopyWith<$Res> {
  __$$_TelegramVxse52BodyCopyWithImpl(
      _$_TelegramVxse52Body _value, $Res Function(_$_TelegramVxse52Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_$_TelegramVxse52Body(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse52Body implements _TelegramVxse52Body {
  const _$_TelegramVxse52Body(
      {required this.earthquake, required this.text, required this.comment});

  factory _$_TelegramVxse52Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse52BodyFromJson(json);

  @override
  final Earthquake earthquake;
  @override
  final String? text;
  @override
  final CommentsOmitVar comment;

  @override
  String toString() {
    return 'TelegramVxse52Body(earthquake: $earthquake, text: $text, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse52Body &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, earthquake, text, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse52BodyCopyWith<_$_TelegramVxse52Body> get copyWith =>
      __$$_TelegramVxse52BodyCopyWithImpl<_$_TelegramVxse52Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse52BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse52Body implements TelegramVxse52Body {
  const factory _TelegramVxse52Body(
      {required final Earthquake earthquake,
      required final String? text,
      required final CommentsOmitVar comment}) = _$_TelegramVxse52Body;

  factory _TelegramVxse52Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse52Body.fromJson;

  @override
  Earthquake get earthquake;
  @override
  String? get text;
  @override
  CommentsOmitVar get comment;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse52BodyCopyWith<_$_TelegramVxse52Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse53Body _$TelegramVxse53BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse53Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse53Body {
  Earthquake get earthquake => throw _privateConstructorUsedError;
  Intensity? get intensity => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  CommentsOmitVar get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse53BodyCopyWith<TelegramVxse53Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse53BodyCopyWith<$Res> {
  factory $TelegramVxse53BodyCopyWith(
          TelegramVxse53Body value, $Res Function(TelegramVxse53Body) then) =
      _$TelegramVxse53BodyCopyWithImpl<$Res, TelegramVxse53Body>;
  @useResult
  $Res call(
      {Earthquake earthquake,
      Intensity? intensity,
      String? text,
      CommentsOmitVar comment});

  $EarthquakeCopyWith<$Res> get earthquake;
  $IntensityCopyWith<$Res>? get intensity;
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class _$TelegramVxse53BodyCopyWithImpl<$Res, $Val extends TelegramVxse53Body>
    implements $TelegramVxse53BodyCopyWith<$Res> {
  _$TelegramVxse53BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? intensity = freezed,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_value.copyWith(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeCopyWith<$Res> get earthquake {
    return $EarthquakeCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntensityCopyWith<$Res>? get intensity {
    if (_value.intensity == null) {
      return null;
    }

    return $IntensityCopyWith<$Res>(_value.intensity!, (value) {
      return _then(_value.copyWith(intensity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOmitVarCopyWith<$Res> get comment {
    return $CommentsOmitVarCopyWith<$Res>(_value.comment, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse53BodyCopyWith<$Res>
    implements $TelegramVxse53BodyCopyWith<$Res> {
  factory _$$_TelegramVxse53BodyCopyWith(_$_TelegramVxse53Body value,
          $Res Function(_$_TelegramVxse53Body) then) =
      __$$_TelegramVxse53BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Earthquake earthquake,
      Intensity? intensity,
      String? text,
      CommentsOmitVar comment});

  @override
  $EarthquakeCopyWith<$Res> get earthquake;
  @override
  $IntensityCopyWith<$Res>? get intensity;
  @override
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class __$$_TelegramVxse53BodyCopyWithImpl<$Res>
    extends _$TelegramVxse53BodyCopyWithImpl<$Res, _$_TelegramVxse53Body>
    implements _$$_TelegramVxse53BodyCopyWith<$Res> {
  __$$_TelegramVxse53BodyCopyWithImpl(
      _$_TelegramVxse53Body _value, $Res Function(_$_TelegramVxse53Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? intensity = freezed,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_$_TelegramVxse53Body(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse53Body implements _TelegramVxse53Body {
  const _$_TelegramVxse53Body(
      {required this.earthquake,
      required this.intensity,
      required this.text,
      required this.comment});

  factory _$_TelegramVxse53Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse53BodyFromJson(json);

  @override
  final Earthquake earthquake;
  @override
  final Intensity? intensity;
  @override
  final String? text;
  @override
  final CommentsOmitVar comment;

  @override
  String toString() {
    return 'TelegramVxse53Body(earthquake: $earthquake, intensity: $intensity, text: $text, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse53Body &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, earthquake, intensity, text, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse53BodyCopyWith<_$_TelegramVxse53Body> get copyWith =>
      __$$_TelegramVxse53BodyCopyWithImpl<_$_TelegramVxse53Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse53BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse53Body implements TelegramVxse53Body {
  const factory _TelegramVxse53Body(
      {required final Earthquake earthquake,
      required final Intensity? intensity,
      required final String? text,
      required final CommentsOmitVar comment}) = _$_TelegramVxse53Body;

  factory _TelegramVxse53Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse53Body.fromJson;

  @override
  Earthquake get earthquake;
  @override
  Intensity? get intensity;
  @override
  String? get text;
  @override
  CommentsOmitVar get comment;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse53BodyCopyWith<_$_TelegramVxse53Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse62Body _$TelegramVxse62BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse62Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse62Body {
  Earthquake get earthquake => throw _privateConstructorUsedError;
  Intensity? get intensity => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  CommentsOmitVar get comment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse62BodyCopyWith<TelegramVxse62Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse62BodyCopyWith<$Res> {
  factory $TelegramVxse62BodyCopyWith(
          TelegramVxse62Body value, $Res Function(TelegramVxse62Body) then) =
      _$TelegramVxse62BodyCopyWithImpl<$Res, TelegramVxse62Body>;
  @useResult
  $Res call(
      {Earthquake earthquake,
      Intensity? intensity,
      String? text,
      CommentsOmitVar comment});

  $EarthquakeCopyWith<$Res> get earthquake;
  $IntensityCopyWith<$Res>? get intensity;
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class _$TelegramVxse62BodyCopyWithImpl<$Res, $Val extends TelegramVxse62Body>
    implements $TelegramVxse62BodyCopyWith<$Res> {
  _$TelegramVxse62BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? intensity = freezed,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_value.copyWith(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeCopyWith<$Res> get earthquake {
    return $EarthquakeCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntensityCopyWith<$Res>? get intensity {
    if (_value.intensity == null) {
      return null;
    }

    return $IntensityCopyWith<$Res>(_value.intensity!, (value) {
      return _then(_value.copyWith(intensity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOmitVarCopyWith<$Res> get comment {
    return $CommentsOmitVarCopyWith<$Res>(_value.comment, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse62BodyCopyWith<$Res>
    implements $TelegramVxse62BodyCopyWith<$Res> {
  factory _$$_TelegramVxse62BodyCopyWith(_$_TelegramVxse62Body value,
          $Res Function(_$_TelegramVxse62Body) then) =
      __$$_TelegramVxse62BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Earthquake earthquake,
      Intensity? intensity,
      String? text,
      CommentsOmitVar comment});

  @override
  $EarthquakeCopyWith<$Res> get earthquake;
  @override
  $IntensityCopyWith<$Res>? get intensity;
  @override
  $CommentsOmitVarCopyWith<$Res> get comment;
}

/// @nodoc
class __$$_TelegramVxse62BodyCopyWithImpl<$Res>
    extends _$TelegramVxse62BodyCopyWithImpl<$Res, _$_TelegramVxse62Body>
    implements _$$_TelegramVxse62BodyCopyWith<$Res> {
  __$$_TelegramVxse62BodyCopyWithImpl(
      _$_TelegramVxse62Body _value, $Res Function(_$_TelegramVxse62Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? intensity = freezed,
    Object? text = freezed,
    Object? comment = null,
  }) {
    return _then(_$_TelegramVxse62Body(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse62Body implements _TelegramVxse62Body {
  const _$_TelegramVxse62Body(
      {required this.earthquake,
      required this.intensity,
      required this.text,
      required this.comment});

  factory _$_TelegramVxse62Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse62BodyFromJson(json);

  @override
  final Earthquake earthquake;
  @override
  final Intensity? intensity;
  @override
  final String? text;
  @override
  final CommentsOmitVar comment;

  @override
  String toString() {
    return 'TelegramVxse62Body(earthquake: $earthquake, intensity: $intensity, text: $text, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse62Body &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, earthquake, intensity, text, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse62BodyCopyWith<_$_TelegramVxse62Body> get copyWith =>
      __$$_TelegramVxse62BodyCopyWithImpl<_$_TelegramVxse62Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse62BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse62Body implements TelegramVxse62Body {
  const factory _TelegramVxse62Body(
      {required final Earthquake earthquake,
      required final Intensity? intensity,
      required final String? text,
      required final CommentsOmitVar comment}) = _$_TelegramVxse62Body;

  factory _TelegramVxse62Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse62Body.fromJson;

  @override
  Earthquake get earthquake;
  @override
  Intensity? get intensity;
  @override
  String? get text;
  @override
  CommentsOmitVar get comment;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse62BodyCopyWith<_$_TelegramVxse62Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVtse41Body _$TelegramVtse41BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVtse41Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVtse41Body {
  PublicBodyVtse41Tsunami get tsunami => throw _privateConstructorUsedError;
  List<Earthquake> get earthquakes => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  TsunamiComments? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVtse41BodyCopyWith<TelegramVtse41Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVtse41BodyCopyWith<$Res> {
  factory $TelegramVtse41BodyCopyWith(
          TelegramVtse41Body value, $Res Function(TelegramVtse41Body) then) =
      _$TelegramVtse41BodyCopyWithImpl<$Res, TelegramVtse41Body>;
  @useResult
  $Res call(
      {PublicBodyVtse41Tsunami tsunami,
      List<Earthquake> earthquakes,
      String? text,
      TsunamiComments? comments});

  $PublicBodyVtse41TsunamiCopyWith<$Res> get tsunami;
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class _$TelegramVtse41BodyCopyWithImpl<$Res, $Val extends TelegramVtse41Body>
    implements $TelegramVtse41BodyCopyWith<$Res> {
  _$TelegramVtse41BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tsunami = null,
    Object? earthquakes = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      tsunami: null == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as PublicBodyVtse41Tsunami,
      earthquakes: null == earthquakes
          ? _value.earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<Earthquake>,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PublicBodyVtse41TsunamiCopyWith<$Res> get tsunami {
    return $PublicBodyVtse41TsunamiCopyWith<$Res>(_value.tsunami, (value) {
      return _then(_value.copyWith(tsunami: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiCommentsCopyWith<$Res>? get comments {
    if (_value.comments == null) {
      return null;
    }

    return $TsunamiCommentsCopyWith<$Res>(_value.comments!, (value) {
      return _then(_value.copyWith(comments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVtse41BodyCopyWith<$Res>
    implements $TelegramVtse41BodyCopyWith<$Res> {
  factory _$$_TelegramVtse41BodyCopyWith(_$_TelegramVtse41Body value,
          $Res Function(_$_TelegramVtse41Body) then) =
      __$$_TelegramVtse41BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PublicBodyVtse41Tsunami tsunami,
      List<Earthquake> earthquakes,
      String? text,
      TsunamiComments? comments});

  @override
  $PublicBodyVtse41TsunamiCopyWith<$Res> get tsunami;
  @override
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$_TelegramVtse41BodyCopyWithImpl<$Res>
    extends _$TelegramVtse41BodyCopyWithImpl<$Res, _$_TelegramVtse41Body>
    implements _$$_TelegramVtse41BodyCopyWith<$Res> {
  __$$_TelegramVtse41BodyCopyWithImpl(
      _$_TelegramVtse41Body _value, $Res Function(_$_TelegramVtse41Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tsunami = null,
    Object? earthquakes = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_$_TelegramVtse41Body(
      tsunami: null == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as PublicBodyVtse41Tsunami,
      earthquakes: null == earthquakes
          ? _value._earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<Earthquake>,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVtse41Body implements _TelegramVtse41Body {
  const _$_TelegramVtse41Body(
      {required this.tsunami,
      required final List<Earthquake> earthquakes,
      required this.text,
      required this.comments})
      : _earthquakes = earthquakes;

  factory _$_TelegramVtse41Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVtse41BodyFromJson(json);

  @override
  final PublicBodyVtse41Tsunami tsunami;
  final List<Earthquake> _earthquakes;
  @override
  List<Earthquake> get earthquakes {
    if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earthquakes);
  }

  @override
  final String? text;
  @override
  final TsunamiComments? comments;

  @override
  String toString() {
    return 'TelegramVtse41Body(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVtse41Body &&
            (identical(other.tsunami, tsunami) || other.tsunami == tsunami) &&
            const DeepCollectionEquality()
                .equals(other._earthquakes, _earthquakes) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tsunami,
      const DeepCollectionEquality().hash(_earthquakes), text, comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVtse41BodyCopyWith<_$_TelegramVtse41Body> get copyWith =>
      __$$_TelegramVtse41BodyCopyWithImpl<_$_TelegramVtse41Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVtse41BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVtse41Body implements TelegramVtse41Body {
  const factory _TelegramVtse41Body(
      {required final PublicBodyVtse41Tsunami tsunami,
      required final List<Earthquake> earthquakes,
      required final String? text,
      required final TsunamiComments? comments}) = _$_TelegramVtse41Body;

  factory _TelegramVtse41Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVtse41Body.fromJson;

  @override
  PublicBodyVtse41Tsunami get tsunami;
  @override
  List<Earthquake> get earthquakes;
  @override
  String? get text;
  @override
  TsunamiComments? get comments;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVtse41BodyCopyWith<_$_TelegramVtse41Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVtse51Body _$TelegramVtse51BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVtse51Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVtse51Body {
  PublicBodyVtse51Tsunami get tsunami => throw _privateConstructorUsedError;
  List<Earthquake> get earthquakes => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  TsunamiComments? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVtse51BodyCopyWith<TelegramVtse51Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVtse51BodyCopyWith<$Res> {
  factory $TelegramVtse51BodyCopyWith(
          TelegramVtse51Body value, $Res Function(TelegramVtse51Body) then) =
      _$TelegramVtse51BodyCopyWithImpl<$Res, TelegramVtse51Body>;
  @useResult
  $Res call(
      {PublicBodyVtse51Tsunami tsunami,
      List<Earthquake> earthquakes,
      String? text,
      TsunamiComments? comments});

  $PublicBodyVtse51TsunamiCopyWith<$Res> get tsunami;
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class _$TelegramVtse51BodyCopyWithImpl<$Res, $Val extends TelegramVtse51Body>
    implements $TelegramVtse51BodyCopyWith<$Res> {
  _$TelegramVtse51BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tsunami = null,
    Object? earthquakes = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      tsunami: null == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as PublicBodyVtse51Tsunami,
      earthquakes: null == earthquakes
          ? _value.earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<Earthquake>,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PublicBodyVtse51TsunamiCopyWith<$Res> get tsunami {
    return $PublicBodyVtse51TsunamiCopyWith<$Res>(_value.tsunami, (value) {
      return _then(_value.copyWith(tsunami: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiCommentsCopyWith<$Res>? get comments {
    if (_value.comments == null) {
      return null;
    }

    return $TsunamiCommentsCopyWith<$Res>(_value.comments!, (value) {
      return _then(_value.copyWith(comments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVtse51BodyCopyWith<$Res>
    implements $TelegramVtse51BodyCopyWith<$Res> {
  factory _$$_TelegramVtse51BodyCopyWith(_$_TelegramVtse51Body value,
          $Res Function(_$_TelegramVtse51Body) then) =
      __$$_TelegramVtse51BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PublicBodyVtse51Tsunami tsunami,
      List<Earthquake> earthquakes,
      String? text,
      TsunamiComments? comments});

  @override
  $PublicBodyVtse51TsunamiCopyWith<$Res> get tsunami;
  @override
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$_TelegramVtse51BodyCopyWithImpl<$Res>
    extends _$TelegramVtse51BodyCopyWithImpl<$Res, _$_TelegramVtse51Body>
    implements _$$_TelegramVtse51BodyCopyWith<$Res> {
  __$$_TelegramVtse51BodyCopyWithImpl(
      _$_TelegramVtse51Body _value, $Res Function(_$_TelegramVtse51Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tsunami = null,
    Object? earthquakes = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_$_TelegramVtse51Body(
      tsunami: null == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as PublicBodyVtse51Tsunami,
      earthquakes: null == earthquakes
          ? _value._earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<Earthquake>,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVtse51Body implements _TelegramVtse51Body {
  const _$_TelegramVtse51Body(
      {required this.tsunami,
      required final List<Earthquake> earthquakes,
      required this.text,
      required this.comments})
      : _earthquakes = earthquakes;

  factory _$_TelegramVtse51Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVtse51BodyFromJson(json);

  @override
  final PublicBodyVtse51Tsunami tsunami;
  final List<Earthquake> _earthquakes;
  @override
  List<Earthquake> get earthquakes {
    if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earthquakes);
  }

  @override
  final String? text;
  @override
  final TsunamiComments? comments;

  @override
  String toString() {
    return 'TelegramVtse51Body(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVtse51Body &&
            (identical(other.tsunami, tsunami) || other.tsunami == tsunami) &&
            const DeepCollectionEquality()
                .equals(other._earthquakes, _earthquakes) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tsunami,
      const DeepCollectionEquality().hash(_earthquakes), text, comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVtse51BodyCopyWith<_$_TelegramVtse51Body> get copyWith =>
      __$$_TelegramVtse51BodyCopyWithImpl<_$_TelegramVtse51Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVtse51BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVtse51Body implements TelegramVtse51Body {
  const factory _TelegramVtse51Body(
      {required final PublicBodyVtse51Tsunami tsunami,
      required final List<Earthquake> earthquakes,
      required final String? text,
      required final TsunamiComments? comments}) = _$_TelegramVtse51Body;

  factory _TelegramVtse51Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVtse51Body.fromJson;

  @override
  PublicBodyVtse51Tsunami get tsunami;
  @override
  List<Earthquake> get earthquakes;
  @override
  String? get text;
  @override
  TsunamiComments? get comments;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVtse51BodyCopyWith<_$_TelegramVtse51Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVtse52Body _$TelegramVtse52BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVtse52Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVtse52Body {
  PublicBodyVtse52Tsunami get tsunami => throw _privateConstructorUsedError;
  List<Earthquake> get earthquakes => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  TsunamiComments? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVtse52BodyCopyWith<TelegramVtse52Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVtse52BodyCopyWith<$Res> {
  factory $TelegramVtse52BodyCopyWith(
          TelegramVtse52Body value, $Res Function(TelegramVtse52Body) then) =
      _$TelegramVtse52BodyCopyWithImpl<$Res, TelegramVtse52Body>;
  @useResult
  $Res call(
      {PublicBodyVtse52Tsunami tsunami,
      List<Earthquake> earthquakes,
      String? text,
      TsunamiComments? comments});

  $PublicBodyVtse52TsunamiCopyWith<$Res> get tsunami;
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class _$TelegramVtse52BodyCopyWithImpl<$Res, $Val extends TelegramVtse52Body>
    implements $TelegramVtse52BodyCopyWith<$Res> {
  _$TelegramVtse52BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tsunami = null,
    Object? earthquakes = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      tsunami: null == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as PublicBodyVtse52Tsunami,
      earthquakes: null == earthquakes
          ? _value.earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<Earthquake>,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PublicBodyVtse52TsunamiCopyWith<$Res> get tsunami {
    return $PublicBodyVtse52TsunamiCopyWith<$Res>(_value.tsunami, (value) {
      return _then(_value.copyWith(tsunami: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiCommentsCopyWith<$Res>? get comments {
    if (_value.comments == null) {
      return null;
    }

    return $TsunamiCommentsCopyWith<$Res>(_value.comments!, (value) {
      return _then(_value.copyWith(comments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVtse52BodyCopyWith<$Res>
    implements $TelegramVtse52BodyCopyWith<$Res> {
  factory _$$_TelegramVtse52BodyCopyWith(_$_TelegramVtse52Body value,
          $Res Function(_$_TelegramVtse52Body) then) =
      __$$_TelegramVtse52BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PublicBodyVtse52Tsunami tsunami,
      List<Earthquake> earthquakes,
      String? text,
      TsunamiComments? comments});

  @override
  $PublicBodyVtse52TsunamiCopyWith<$Res> get tsunami;
  @override
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$_TelegramVtse52BodyCopyWithImpl<$Res>
    extends _$TelegramVtse52BodyCopyWithImpl<$Res, _$_TelegramVtse52Body>
    implements _$$_TelegramVtse52BodyCopyWith<$Res> {
  __$$_TelegramVtse52BodyCopyWithImpl(
      _$_TelegramVtse52Body _value, $Res Function(_$_TelegramVtse52Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tsunami = null,
    Object? earthquakes = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_$_TelegramVtse52Body(
      tsunami: null == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as PublicBodyVtse52Tsunami,
      earthquakes: null == earthquakes
          ? _value._earthquakes
          : earthquakes // ignore: cast_nullable_to_non_nullable
              as List<Earthquake>,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVtse52Body implements _TelegramVtse52Body {
  const _$_TelegramVtse52Body(
      {required this.tsunami,
      required final List<Earthquake> earthquakes,
      required this.text,
      required this.comments})
      : _earthquakes = earthquakes;

  factory _$_TelegramVtse52Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVtse52BodyFromJson(json);

  @override
  final PublicBodyVtse52Tsunami tsunami;
  final List<Earthquake> _earthquakes;
  @override
  List<Earthquake> get earthquakes {
    if (_earthquakes is EqualUnmodifiableListView) return _earthquakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earthquakes);
  }

  @override
  final String? text;
  @override
  final TsunamiComments? comments;

  @override
  String toString() {
    return 'TelegramVtse52Body(tsunami: $tsunami, earthquakes: $earthquakes, text: $text, comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVtse52Body &&
            (identical(other.tsunami, tsunami) || other.tsunami == tsunami) &&
            const DeepCollectionEquality()
                .equals(other._earthquakes, _earthquakes) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tsunami,
      const DeepCollectionEquality().hash(_earthquakes), text, comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVtse52BodyCopyWith<_$_TelegramVtse52Body> get copyWith =>
      __$$_TelegramVtse52BodyCopyWithImpl<_$_TelegramVtse52Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVtse52BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVtse52Body implements TelegramVtse52Body {
  const factory _TelegramVtse52Body(
      {required final PublicBodyVtse52Tsunami tsunami,
      required final List<Earthquake> earthquakes,
      required final String? text,
      required final TsunamiComments? comments}) = _$_TelegramVtse52Body;

  factory _TelegramVtse52Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVtse52Body.fromJson;

  @override
  PublicBodyVtse52Tsunami get tsunami;
  @override
  List<Earthquake> get earthquakes;
  @override
  String? get text;
  @override
  TsunamiComments? get comments;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVtse52BodyCopyWith<_$_TelegramVtse52Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse61Body _$TelegramVxse61BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse61Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse61Body {
  Earthquake get earthquake => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  CommentsOnlyFree? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse61BodyCopyWith<TelegramVxse61Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse61BodyCopyWith<$Res> {
  factory $TelegramVxse61BodyCopyWith(
          TelegramVxse61Body value, $Res Function(TelegramVxse61Body) then) =
      _$TelegramVxse61BodyCopyWithImpl<$Res, TelegramVxse61Body>;
  @useResult
  $Res call({Earthquake earthquake, String? text, CommentsOnlyFree? comments});

  $EarthquakeCopyWith<$Res> get earthquake;
  $CommentsOnlyFreeCopyWith<$Res>? get comments;
}

/// @nodoc
class _$TelegramVxse61BodyCopyWithImpl<$Res, $Val extends TelegramVxse61Body>
    implements $TelegramVxse61BodyCopyWith<$Res> {
  _$TelegramVxse61BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as CommentsOnlyFree?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeCopyWith<$Res> get earthquake {
    return $EarthquakeCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOnlyFreeCopyWith<$Res>? get comments {
    if (_value.comments == null) {
      return null;
    }

    return $CommentsOnlyFreeCopyWith<$Res>(_value.comments!, (value) {
      return _then(_value.copyWith(comments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse61BodyCopyWith<$Res>
    implements $TelegramVxse61BodyCopyWith<$Res> {
  factory _$$_TelegramVxse61BodyCopyWith(_$_TelegramVxse61Body value,
          $Res Function(_$_TelegramVxse61Body) then) =
      __$$_TelegramVxse61BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Earthquake earthquake, String? text, CommentsOnlyFree? comments});

  @override
  $EarthquakeCopyWith<$Res> get earthquake;
  @override
  $CommentsOnlyFreeCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$_TelegramVxse61BodyCopyWithImpl<$Res>
    extends _$TelegramVxse61BodyCopyWithImpl<$Res, _$_TelegramVxse61Body>
    implements _$$_TelegramVxse61BodyCopyWith<$Res> {
  __$$_TelegramVxse61BodyCopyWithImpl(
      _$_TelegramVxse61Body _value, $Res Function(_$_TelegramVxse61Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? text = freezed,
    Object? comments = freezed,
  }) {
    return _then(_$_TelegramVxse61Body(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as CommentsOnlyFree?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse61Body implements _TelegramVxse61Body {
  const _$_TelegramVxse61Body(
      {required this.earthquake, required this.text, required this.comments});

  factory _$_TelegramVxse61Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse61BodyFromJson(json);

  @override
  final Earthquake earthquake;
  @override
  final String? text;
  @override
  final CommentsOnlyFree? comments;

  @override
  String toString() {
    return 'TelegramVxse61Body(earthquake: $earthquake, text: $text, comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse61Body &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, earthquake, text, comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse61BodyCopyWith<_$_TelegramVxse61Body> get copyWith =>
      __$$_TelegramVxse61BodyCopyWithImpl<_$_TelegramVxse61Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse61BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse61Body implements TelegramVxse61Body {
  const factory _TelegramVxse61Body(
      {required final Earthquake earthquake,
      required final String? text,
      required final CommentsOnlyFree? comments}) = _$_TelegramVxse61Body;

  factory _TelegramVxse61Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse61Body.fromJson;

  @override
  Earthquake get earthquake;
  @override
  String? get text;
  @override
  CommentsOnlyFree? get comments;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse61BodyCopyWith<_$_TelegramVxse61Body> get copyWith =>
      throw _privateConstructorUsedError;
}

EarthquakeNankaiBody _$EarthquakeNankaiBodyFromJson(Map<String, dynamic> json) {
  return _EarthquakeNankaiBody.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeNankaiBody {
  EarthquakeNankaiInfo? get earthquakeInfo =>
      throw _privateConstructorUsedError;
  String? get nextAdvisory => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeNankaiBodyCopyWith<EarthquakeNankaiBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeNankaiBodyCopyWith<$Res> {
  factory $EarthquakeNankaiBodyCopyWith(EarthquakeNankaiBody value,
          $Res Function(EarthquakeNankaiBody) then) =
      _$EarthquakeNankaiBodyCopyWithImpl<$Res, EarthquakeNankaiBody>;
  @useResult
  $Res call(
      {EarthquakeNankaiInfo? earthquakeInfo,
      String? nextAdvisory,
      String? text});

  $EarthquakeNankaiInfoCopyWith<$Res>? get earthquakeInfo;
}

/// @nodoc
class _$EarthquakeNankaiBodyCopyWithImpl<$Res,
        $Val extends EarthquakeNankaiBody>
    implements $EarthquakeNankaiBodyCopyWith<$Res> {
  _$EarthquakeNankaiBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquakeInfo = freezed,
    Object? nextAdvisory = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      earthquakeInfo: freezed == earthquakeInfo
          ? _value.earthquakeInfo
          : earthquakeInfo // ignore: cast_nullable_to_non_nullable
              as EarthquakeNankaiInfo?,
      nextAdvisory: freezed == nextAdvisory
          ? _value.nextAdvisory
          : nextAdvisory // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeNankaiInfoCopyWith<$Res>? get earthquakeInfo {
    if (_value.earthquakeInfo == null) {
      return null;
    }

    return $EarthquakeNankaiInfoCopyWith<$Res>(_value.earthquakeInfo!, (value) {
      return _then(_value.copyWith(earthquakeInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EarthquakeNankaiBodyCopyWith<$Res>
    implements $EarthquakeNankaiBodyCopyWith<$Res> {
  factory _$$_EarthquakeNankaiBodyCopyWith(_$_EarthquakeNankaiBody value,
          $Res Function(_$_EarthquakeNankaiBody) then) =
      __$$_EarthquakeNankaiBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EarthquakeNankaiInfo? earthquakeInfo,
      String? nextAdvisory,
      String? text});

  @override
  $EarthquakeNankaiInfoCopyWith<$Res>? get earthquakeInfo;
}

/// @nodoc
class __$$_EarthquakeNankaiBodyCopyWithImpl<$Res>
    extends _$EarthquakeNankaiBodyCopyWithImpl<$Res, _$_EarthquakeNankaiBody>
    implements _$$_EarthquakeNankaiBodyCopyWith<$Res> {
  __$$_EarthquakeNankaiBodyCopyWithImpl(_$_EarthquakeNankaiBody _value,
      $Res Function(_$_EarthquakeNankaiBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquakeInfo = freezed,
    Object? nextAdvisory = freezed,
    Object? text = freezed,
  }) {
    return _then(_$_EarthquakeNankaiBody(
      earthquakeInfo: freezed == earthquakeInfo
          ? _value.earthquakeInfo
          : earthquakeInfo // ignore: cast_nullable_to_non_nullable
              as EarthquakeNankaiInfo?,
      nextAdvisory: freezed == nextAdvisory
          ? _value.nextAdvisory
          : nextAdvisory // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EarthquakeNankaiBody implements _EarthquakeNankaiBody {
  const _$_EarthquakeNankaiBody(
      {required this.earthquakeInfo,
      required this.nextAdvisory,
      required this.text});

  factory _$_EarthquakeNankaiBody.fromJson(Map<String, dynamic> json) =>
      _$$_EarthquakeNankaiBodyFromJson(json);

  @override
  final EarthquakeNankaiInfo? earthquakeInfo;
  @override
  final String? nextAdvisory;
  @override
  final String? text;

  @override
  String toString() {
    return 'EarthquakeNankaiBody(earthquakeInfo: $earthquakeInfo, nextAdvisory: $nextAdvisory, text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EarthquakeNankaiBody &&
            (identical(other.earthquakeInfo, earthquakeInfo) ||
                other.earthquakeInfo == earthquakeInfo) &&
            (identical(other.nextAdvisory, nextAdvisory) ||
                other.nextAdvisory == nextAdvisory) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, earthquakeInfo, nextAdvisory, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EarthquakeNankaiBodyCopyWith<_$_EarthquakeNankaiBody> get copyWith =>
      __$$_EarthquakeNankaiBodyCopyWithImpl<_$_EarthquakeNankaiBody>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EarthquakeNankaiBodyToJson(
      this,
    );
  }
}

abstract class _EarthquakeNankaiBody implements EarthquakeNankaiBody {
  const factory _EarthquakeNankaiBody(
      {required final EarthquakeNankaiInfo? earthquakeInfo,
      required final String? nextAdvisory,
      required final String? text}) = _$_EarthquakeNankaiBody;

  factory _EarthquakeNankaiBody.fromJson(Map<String, dynamic> json) =
      _$_EarthquakeNankaiBody.fromJson;

  @override
  EarthquakeNankaiInfo? get earthquakeInfo;
  @override
  String? get nextAdvisory;
  @override
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$_EarthquakeNankaiBodyCopyWith<_$_EarthquakeNankaiBody> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse56Body _$TelegramVxse56BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse56Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse56Body {
  Naming? get naming => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  CommentsOnlyFree? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse56BodyCopyWith<TelegramVxse56Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse56BodyCopyWith<$Res> {
  factory $TelegramVxse56BodyCopyWith(
          TelegramVxse56Body value, $Res Function(TelegramVxse56Body) then) =
      _$TelegramVxse56BodyCopyWithImpl<$Res, TelegramVxse56Body>;
  @useResult
  $Res call({Naming? naming, String text, CommentsOnlyFree? comments});

  $NamingCopyWith<$Res>? get naming;
  $CommentsOnlyFreeCopyWith<$Res>? get comments;
}

/// @nodoc
class _$TelegramVxse56BodyCopyWithImpl<$Res, $Val extends TelegramVxse56Body>
    implements $TelegramVxse56BodyCopyWith<$Res> {
  _$TelegramVxse56BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? naming = freezed,
    Object? text = null,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      naming: freezed == naming
          ? _value.naming
          : naming // ignore: cast_nullable_to_non_nullable
              as Naming?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as CommentsOnlyFree?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NamingCopyWith<$Res>? get naming {
    if (_value.naming == null) {
      return null;
    }

    return $NamingCopyWith<$Res>(_value.naming!, (value) {
      return _then(_value.copyWith(naming: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOnlyFreeCopyWith<$Res>? get comments {
    if (_value.comments == null) {
      return null;
    }

    return $CommentsOnlyFreeCopyWith<$Res>(_value.comments!, (value) {
      return _then(_value.copyWith(comments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse56BodyCopyWith<$Res>
    implements $TelegramVxse56BodyCopyWith<$Res> {
  factory _$$_TelegramVxse56BodyCopyWith(_$_TelegramVxse56Body value,
          $Res Function(_$_TelegramVxse56Body) then) =
      __$$_TelegramVxse56BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Naming? naming, String text, CommentsOnlyFree? comments});

  @override
  $NamingCopyWith<$Res>? get naming;
  @override
  $CommentsOnlyFreeCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$_TelegramVxse56BodyCopyWithImpl<$Res>
    extends _$TelegramVxse56BodyCopyWithImpl<$Res, _$_TelegramVxse56Body>
    implements _$$_TelegramVxse56BodyCopyWith<$Res> {
  __$$_TelegramVxse56BodyCopyWithImpl(
      _$_TelegramVxse56Body _value, $Res Function(_$_TelegramVxse56Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? naming = freezed,
    Object? text = null,
    Object? comments = freezed,
  }) {
    return _then(_$_TelegramVxse56Body(
      naming: freezed == naming
          ? _value.naming
          : naming // ignore: cast_nullable_to_non_nullable
              as Naming?,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as CommentsOnlyFree?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse56Body implements _TelegramVxse56Body {
  const _$_TelegramVxse56Body(
      {required this.naming, required this.text, required this.comments});

  factory _$_TelegramVxse56Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse56BodyFromJson(json);

  @override
  final Naming? naming;
  @override
  final String text;
  @override
  final CommentsOnlyFree? comments;

  @override
  String toString() {
    return 'TelegramVxse56Body(naming: $naming, text: $text, comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse56Body &&
            (identical(other.naming, naming) || other.naming == naming) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, naming, text, comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse56BodyCopyWith<_$_TelegramVxse56Body> get copyWith =>
      __$$_TelegramVxse56BodyCopyWithImpl<_$_TelegramVxse56Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse56BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse56Body implements TelegramVxse56Body {
  const factory _TelegramVxse56Body(
      {required final Naming? naming,
      required final String text,
      required final CommentsOnlyFree? comments}) = _$_TelegramVxse56Body;

  factory _TelegramVxse56Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse56Body.fromJson;

  @override
  Naming? get naming;
  @override
  String get text;
  @override
  CommentsOnlyFree? get comments;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse56BodyCopyWith<_$_TelegramVxse56Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramCancelBody _$TelegramCancelBodyFromJson(Map<String, dynamic> json) {
  return _TelegramCancelBody.fromJson(json);
}

/// @nodoc
mixin _$TelegramCancelBody {
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramCancelBodyCopyWith<TelegramCancelBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramCancelBodyCopyWith<$Res> {
  factory $TelegramCancelBodyCopyWith(
          TelegramCancelBody value, $Res Function(TelegramCancelBody) then) =
      _$TelegramCancelBodyCopyWithImpl<$Res, TelegramCancelBody>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class _$TelegramCancelBodyCopyWithImpl<$Res, $Val extends TelegramCancelBody>
    implements $TelegramCancelBodyCopyWith<$Res> {
  _$TelegramCancelBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TelegramCancelBodyCopyWith<$Res>
    implements $TelegramCancelBodyCopyWith<$Res> {
  factory _$$_TelegramCancelBodyCopyWith(_$_TelegramCancelBody value,
          $Res Function(_$_TelegramCancelBody) then) =
      __$$_TelegramCancelBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$_TelegramCancelBodyCopyWithImpl<$Res>
    extends _$TelegramCancelBodyCopyWithImpl<$Res, _$_TelegramCancelBody>
    implements _$$_TelegramCancelBodyCopyWith<$Res> {
  __$$_TelegramCancelBodyCopyWithImpl(
      _$_TelegramCancelBody _value, $Res Function(_$_TelegramCancelBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$_TelegramCancelBody(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramCancelBody implements _TelegramCancelBody {
  const _$_TelegramCancelBody({required this.text});

  factory _$_TelegramCancelBody.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramCancelBodyFromJson(json);

  @override
  final String text;

  @override
  String toString() {
    return 'TelegramCancelBody(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramCancelBody &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramCancelBodyCopyWith<_$_TelegramCancelBody> get copyWith =>
      __$$_TelegramCancelBodyCopyWithImpl<_$_TelegramCancelBody>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramCancelBodyToJson(
      this,
    );
  }
}

abstract class _TelegramCancelBody implements TelegramCancelBody {
  const factory _TelegramCancelBody({required final String text}) =
      _$_TelegramCancelBody;

  factory _TelegramCancelBody.fromJson(Map<String, dynamic> json) =
      _$_TelegramCancelBody.fromJson;

  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramCancelBodyCopyWith<_$_TelegramCancelBody> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse45Body _$TelegramVxse45BodyFromJson(Map<String, dynamic> json) {
  return _TelegramVxse45Body.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse45Body {
  double? get magnitude => throw _privateConstructorUsedError;
  EewHypocenter? get hypocenter => throw _privateConstructorUsedError;
  int? get depth => throw _privateConstructorUsedError;
  ForecastMaxInt? get forecastMaxInt => throw _privateConstructorUsedError;
  ForecastMaxLgInt? get forecastMaxLgInt => throw _privateConstructorUsedError;
  List<EewRegion>? get regions => throw _privateConstructorUsedError;
  DateTime? get originTime => throw _privateConstructorUsedError;
  DateTime get arrivalTime => throw _privateConstructorUsedError;
  EewAccuracy get accuracy => throw _privateConstructorUsedError;
  bool get isPlum => throw _privateConstructorUsedError;
  bool get isLastInfo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse45BodyCopyWith<TelegramVxse45Body> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse45BodyCopyWith<$Res> {
  factory $TelegramVxse45BodyCopyWith(
          TelegramVxse45Body value, $Res Function(TelegramVxse45Body) then) =
      _$TelegramVxse45BodyCopyWithImpl<$Res, TelegramVxse45Body>;
  @useResult
  $Res call(
      {double? magnitude,
      EewHypocenter? hypocenter,
      int? depth,
      ForecastMaxInt? forecastMaxInt,
      ForecastMaxLgInt? forecastMaxLgInt,
      List<EewRegion>? regions,
      DateTime? originTime,
      DateTime arrivalTime,
      EewAccuracy accuracy,
      bool isPlum,
      bool isLastInfo});

  $EewHypocenterCopyWith<$Res>? get hypocenter;
  $ForecastMaxIntCopyWith<$Res>? get forecastMaxInt;
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;
  $EewAccuracyCopyWith<$Res> get accuracy;
}

/// @nodoc
class _$TelegramVxse45BodyCopyWithImpl<$Res, $Val extends TelegramVxse45Body>
    implements $TelegramVxse45BodyCopyWith<$Res> {
  _$TelegramVxse45BodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? magnitude = freezed,
    Object? hypocenter = freezed,
    Object? depth = freezed,
    Object? forecastMaxInt = freezed,
    Object? forecastMaxLgInt = freezed,
    Object? regions = freezed,
    Object? originTime = freezed,
    Object? arrivalTime = null,
    Object? accuracy = null,
    Object? isPlum = null,
    Object? isLastInfo = null,
  }) {
    return _then(_value.copyWith(
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      hypocenter: freezed == hypocenter
          ? _value.hypocenter
          : hypocenter // ignore: cast_nullable_to_non_nullable
              as EewHypocenter?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      forecastMaxInt: freezed == forecastMaxInt
          ? _value.forecastMaxInt
          : forecastMaxInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxInt?,
      forecastMaxLgInt: freezed == forecastMaxLgInt
          ? _value.forecastMaxLgInt
          : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxLgInt?,
      regions: freezed == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<EewRegion>?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivalTime: null == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as EewAccuracy,
      isPlum: null == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool,
      isLastInfo: null == isLastInfo
          ? _value.isLastInfo
          : isLastInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EewHypocenterCopyWith<$Res>? get hypocenter {
    if (_value.hypocenter == null) {
      return null;
    }

    return $EewHypocenterCopyWith<$Res>(_value.hypocenter!, (value) {
      return _then(_value.copyWith(hypocenter: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastMaxIntCopyWith<$Res>? get forecastMaxInt {
    if (_value.forecastMaxInt == null) {
      return null;
    }

    return $ForecastMaxIntCopyWith<$Res>(_value.forecastMaxInt!, (value) {
      return _then(_value.copyWith(forecastMaxInt: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt {
    if (_value.forecastMaxLgInt == null) {
      return null;
    }

    return $ForecastMaxLgIntCopyWith<$Res>(_value.forecastMaxLgInt!, (value) {
      return _then(_value.copyWith(forecastMaxLgInt: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EewAccuracyCopyWith<$Res> get accuracy {
    return $EewAccuracyCopyWith<$Res>(_value.accuracy, (value) {
      return _then(_value.copyWith(accuracy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TelegramVxse45BodyCopyWith<$Res>
    implements $TelegramVxse45BodyCopyWith<$Res> {
  factory _$$_TelegramVxse45BodyCopyWith(_$_TelegramVxse45Body value,
          $Res Function(_$_TelegramVxse45Body) then) =
      __$$_TelegramVxse45BodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? magnitude,
      EewHypocenter? hypocenter,
      int? depth,
      ForecastMaxInt? forecastMaxInt,
      ForecastMaxLgInt? forecastMaxLgInt,
      List<EewRegion>? regions,
      DateTime? originTime,
      DateTime arrivalTime,
      EewAccuracy accuracy,
      bool isPlum,
      bool isLastInfo});

  @override
  $EewHypocenterCopyWith<$Res>? get hypocenter;
  @override
  $ForecastMaxIntCopyWith<$Res>? get forecastMaxInt;
  @override
  $ForecastMaxLgIntCopyWith<$Res>? get forecastMaxLgInt;
  @override
  $EewAccuracyCopyWith<$Res> get accuracy;
}

/// @nodoc
class __$$_TelegramVxse45BodyCopyWithImpl<$Res>
    extends _$TelegramVxse45BodyCopyWithImpl<$Res, _$_TelegramVxse45Body>
    implements _$$_TelegramVxse45BodyCopyWith<$Res> {
  __$$_TelegramVxse45BodyCopyWithImpl(
      _$_TelegramVxse45Body _value, $Res Function(_$_TelegramVxse45Body) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? magnitude = freezed,
    Object? hypocenter = freezed,
    Object? depth = freezed,
    Object? forecastMaxInt = freezed,
    Object? forecastMaxLgInt = freezed,
    Object? regions = freezed,
    Object? originTime = freezed,
    Object? arrivalTime = null,
    Object? accuracy = null,
    Object? isPlum = null,
    Object? isLastInfo = null,
  }) {
    return _then(_$_TelegramVxse45Body(
      magnitude: freezed == magnitude
          ? _value.magnitude
          : magnitude // ignore: cast_nullable_to_non_nullable
              as double?,
      hypocenter: freezed == hypocenter
          ? _value.hypocenter
          : hypocenter // ignore: cast_nullable_to_non_nullable
              as EewHypocenter?,
      depth: freezed == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int?,
      forecastMaxInt: freezed == forecastMaxInt
          ? _value.forecastMaxInt
          : forecastMaxInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxInt?,
      forecastMaxLgInt: freezed == forecastMaxLgInt
          ? _value.forecastMaxLgInt
          : forecastMaxLgInt // ignore: cast_nullable_to_non_nullable
              as ForecastMaxLgInt?,
      regions: freezed == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<EewRegion>?,
      originTime: freezed == originTime
          ? _value.originTime
          : originTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivalTime: null == arrivalTime
          ? _value.arrivalTime
          : arrivalTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accuracy: null == accuracy
          ? _value.accuracy
          : accuracy // ignore: cast_nullable_to_non_nullable
              as EewAccuracy,
      isPlum: null == isPlum
          ? _value.isPlum
          : isPlum // ignore: cast_nullable_to_non_nullable
              as bool,
      isLastInfo: null == isLastInfo
          ? _value.isLastInfo
          : isLastInfo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TelegramVxse45Body implements _TelegramVxse45Body {
  const _$_TelegramVxse45Body(
      {required this.magnitude,
      required this.hypocenter,
      required this.depth,
      required this.forecastMaxInt,
      required this.forecastMaxLgInt,
      required final List<EewRegion>? regions,
      required this.originTime,
      required this.arrivalTime,
      required this.accuracy,
      required this.isPlum,
      required this.isLastInfo})
      : _regions = regions;

  factory _$_TelegramVxse45Body.fromJson(Map<String, dynamic> json) =>
      _$$_TelegramVxse45BodyFromJson(json);

  @override
  final double? magnitude;
  @override
  final EewHypocenter? hypocenter;
  @override
  final int? depth;
  @override
  final ForecastMaxInt? forecastMaxInt;
  @override
  final ForecastMaxLgInt? forecastMaxLgInt;
  final List<EewRegion>? _regions;
  @override
  List<EewRegion>? get regions {
    final value = _regions;
    if (value == null) return null;
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? originTime;
  @override
  final DateTime arrivalTime;
  @override
  final EewAccuracy accuracy;
  @override
  final bool isPlum;
  @override
  final bool isLastInfo;

  @override
  String toString() {
    return 'TelegramVxse45Body(magnitude: $magnitude, hypocenter: $hypocenter, depth: $depth, forecastMaxInt: $forecastMaxInt, forecastMaxLgInt: $forecastMaxLgInt, regions: $regions, originTime: $originTime, arrivalTime: $arrivalTime, accuracy: $accuracy, isPlum: $isPlum, isLastInfo: $isLastInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TelegramVxse45Body &&
            (identical(other.magnitude, magnitude) ||
                other.magnitude == magnitude) &&
            (identical(other.hypocenter, hypocenter) ||
                other.hypocenter == hypocenter) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.forecastMaxInt, forecastMaxInt) ||
                other.forecastMaxInt == forecastMaxInt) &&
            (identical(other.forecastMaxLgInt, forecastMaxLgInt) ||
                other.forecastMaxLgInt == forecastMaxLgInt) &&
            const DeepCollectionEquality().equals(other._regions, _regions) &&
            (identical(other.originTime, originTime) ||
                other.originTime == originTime) &&
            (identical(other.arrivalTime, arrivalTime) ||
                other.arrivalTime == arrivalTime) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.isPlum, isPlum) || other.isPlum == isPlum) &&
            (identical(other.isLastInfo, isLastInfo) ||
                other.isLastInfo == isLastInfo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      magnitude,
      hypocenter,
      depth,
      forecastMaxInt,
      forecastMaxLgInt,
      const DeepCollectionEquality().hash(_regions),
      originTime,
      arrivalTime,
      accuracy,
      isPlum,
      isLastInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TelegramVxse45BodyCopyWith<_$_TelegramVxse45Body> get copyWith =>
      __$$_TelegramVxse45BodyCopyWithImpl<_$_TelegramVxse45Body>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TelegramVxse45BodyToJson(
      this,
    );
  }
}

abstract class _TelegramVxse45Body implements TelegramVxse45Body {
  const factory _TelegramVxse45Body(
      {required final double? magnitude,
      required final EewHypocenter? hypocenter,
      required final int? depth,
      required final ForecastMaxInt? forecastMaxInt,
      required final ForecastMaxLgInt? forecastMaxLgInt,
      required final List<EewRegion>? regions,
      required final DateTime? originTime,
      required final DateTime arrivalTime,
      required final EewAccuracy accuracy,
      required final bool isPlum,
      required final bool isLastInfo}) = _$_TelegramVxse45Body;

  factory _TelegramVxse45Body.fromJson(Map<String, dynamic> json) =
      _$_TelegramVxse45Body.fromJson;

  @override
  double? get magnitude;
  @override
  EewHypocenter? get hypocenter;
  @override
  int? get depth;
  @override
  ForecastMaxInt? get forecastMaxInt;
  @override
  ForecastMaxLgInt? get forecastMaxLgInt;
  @override
  List<EewRegion>? get regions;
  @override
  DateTime? get originTime;
  @override
  DateTime get arrivalTime;
  @override
  EewAccuracy get accuracy;
  @override
  bool get isPlum;
  @override
  bool get isLastInfo;
  @override
  @JsonKey(ignore: true)
  _$$_TelegramVxse45BodyCopyWith<_$_TelegramVxse45Body> get copyWith =>
      throw _privateConstructorUsedError;
}

TelegramVxse45Cancel _$TelegramVxse45CancelFromJson(Map<String, dynamic> json) {
  return _EarthquakeInformationBody.fromJson(json);
}

/// @nodoc
mixin _$TelegramVxse45Cancel {
  bool get isLastInfo => throw _privateConstructorUsedError;
  bool get isCanceled => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelegramVxse45CancelCopyWith<TelegramVxse45Cancel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramVxse45CancelCopyWith<$Res> {
  factory $TelegramVxse45CancelCopyWith(TelegramVxse45Cancel value,
          $Res Function(TelegramVxse45Cancel) then) =
      _$TelegramVxse45CancelCopyWithImpl<$Res, TelegramVxse45Cancel>;
  @useResult
  $Res call({bool isLastInfo, bool isCanceled, String text});
}

/// @nodoc
class _$TelegramVxse45CancelCopyWithImpl<$Res,
        $Val extends TelegramVxse45Cancel>
    implements $TelegramVxse45CancelCopyWith<$Res> {
  _$TelegramVxse45CancelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLastInfo = null,
    Object? isCanceled = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      isLastInfo: null == isLastInfo
          ? _value.isLastInfo
          : isLastInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanceled: null == isCanceled
          ? _value.isCanceled
          : isCanceled // ignore: cast_nullable_to_non_nullable
              as bool,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EarthquakeInformationBodyCopyWith<$Res>
    implements $TelegramVxse45CancelCopyWith<$Res> {
  factory _$$_EarthquakeInformationBodyCopyWith(
          _$_EarthquakeInformationBody value,
          $Res Function(_$_EarthquakeInformationBody) then) =
      __$$_EarthquakeInformationBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLastInfo, bool isCanceled, String text});
}

/// @nodoc
class __$$_EarthquakeInformationBodyCopyWithImpl<$Res>
    extends _$TelegramVxse45CancelCopyWithImpl<$Res,
        _$_EarthquakeInformationBody>
    implements _$$_EarthquakeInformationBodyCopyWith<$Res> {
  __$$_EarthquakeInformationBodyCopyWithImpl(
      _$_EarthquakeInformationBody _value,
      $Res Function(_$_EarthquakeInformationBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLastInfo = null,
    Object? isCanceled = null,
    Object? text = null,
  }) {
    return _then(_$_EarthquakeInformationBody(
      isLastInfo: null == isLastInfo
          ? _value.isLastInfo
          : isLastInfo // ignore: cast_nullable_to_non_nullable
              as bool,
      isCanceled: null == isCanceled
          ? _value.isCanceled
          : isCanceled // ignore: cast_nullable_to_non_nullable
              as bool,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EarthquakeInformationBody implements _EarthquakeInformationBody {
  const _$_EarthquakeInformationBody(
      {required this.isLastInfo, required this.isCanceled, required this.text});

  factory _$_EarthquakeInformationBody.fromJson(Map<String, dynamic> json) =>
      _$$_EarthquakeInformationBodyFromJson(json);

  @override
  final bool isLastInfo;
  @override
  final bool isCanceled;
  @override
  final String text;

  @override
  String toString() {
    return 'TelegramVxse45Cancel(isLastInfo: $isLastInfo, isCanceled: $isCanceled, text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EarthquakeInformationBody &&
            (identical(other.isLastInfo, isLastInfo) ||
                other.isLastInfo == isLastInfo) &&
            (identical(other.isCanceled, isCanceled) ||
                other.isCanceled == isCanceled) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isLastInfo, isCanceled, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EarthquakeInformationBodyCopyWith<_$_EarthquakeInformationBody>
      get copyWith => __$$_EarthquakeInformationBodyCopyWithImpl<
          _$_EarthquakeInformationBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EarthquakeInformationBodyToJson(
      this,
    );
  }
}

abstract class _EarthquakeInformationBody implements TelegramVxse45Cancel {
  const factory _EarthquakeInformationBody(
      {required final bool isLastInfo,
      required final bool isCanceled,
      required final String text}) = _$_EarthquakeInformationBody;

  factory _EarthquakeInformationBody.fromJson(Map<String, dynamic> json) =
      _$_EarthquakeInformationBody.fromJson;

  @override
  bool get isLastInfo;
  @override
  bool get isCanceled;
  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$_EarthquakeInformationBodyCopyWith<_$_EarthquakeInformationBody>
      get copyWith => throw _privateConstructorUsedError;
}
