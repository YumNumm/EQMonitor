// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JmaXmlTelegramReplayData _$JmaXmlTelegramReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _JmaXmlTelegramReplayData.fromJson(json);
}

/// @nodoc
mixin _$JmaXmlTelegramReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get telegram => throw _privateConstructorUsedError;

  /// Serializes this JmaXmlTelegramReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of JmaXmlTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JmaXmlTelegramReplayDataCopyWith<
    JmaXmlTelegramReplayData
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JmaXmlTelegramReplayDataCopyWith<$Res> {
  factory $JmaXmlTelegramReplayDataCopyWith(
    JmaXmlTelegramReplayData value,
    $Res Function(JmaXmlTelegramReplayData) then,
  ) =
      _$JmaXmlTelegramReplayDataCopyWithImpl<
        $Res,
        JmaXmlTelegramReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String title,
    String telegram,
  });
}

/// @nodoc
class _$JmaXmlTelegramReplayDataCopyWithImpl<
  $Res,
  $Val extends JmaXmlTelegramReplayData
>
    implements $JmaXmlTelegramReplayDataCopyWith<$Res> {
  _$JmaXmlTelegramReplayDataCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JmaXmlTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? title = null,
    Object? telegram = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            telegram:
                null == telegram
                    ? _value.telegram
                    : telegram // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JmaXmlTelegramReplayDataImplCopyWith<$Res>
    implements $JmaXmlTelegramReplayDataCopyWith<$Res> {
  factory _$$JmaXmlTelegramReplayDataImplCopyWith(
    _$JmaXmlTelegramReplayDataImpl value,
    $Res Function(_$JmaXmlTelegramReplayDataImpl) then,
  ) = __$$JmaXmlTelegramReplayDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String title,
    String telegram,
  });
}

/// @nodoc
class __$$JmaXmlTelegramReplayDataImplCopyWithImpl<$Res>
    extends
        _$JmaXmlTelegramReplayDataCopyWithImpl<
          $Res,
          _$JmaXmlTelegramReplayDataImpl
        >
    implements
        _$$JmaXmlTelegramReplayDataImplCopyWith<$Res> {
  __$$JmaXmlTelegramReplayDataImplCopyWithImpl(
    _$JmaXmlTelegramReplayDataImpl _value,
    $Res Function(_$JmaXmlTelegramReplayDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JmaXmlTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? title = null,
    Object? telegram = null,
  }) {
    return _then(
      _$JmaXmlTelegramReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        telegram:
            null == telegram
                ? _value.telegram
                : telegram // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JmaXmlTelegramReplayDataImpl
    extends _JmaXmlTelegramReplayData {
  const _$JmaXmlTelegramReplayDataImpl({
    required this.type,
    required this.time,
    required this.title,
    required this.telegram,
  }) : super._();

  factory _$JmaXmlTelegramReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$JmaXmlTelegramReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  @override
  final String title;
  @override
  final String telegram;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JmaXmlTelegramReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            (identical(other.title, title) ||
                other.title == title) &&
            (identical(other.telegram, telegram) ||
                other.telegram == telegram));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, time, title, telegram);

  /// Create a copy of JmaXmlTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JmaXmlTelegramReplayDataImplCopyWith<
    _$JmaXmlTelegramReplayDataImpl
  >
  get copyWith =>
      __$$JmaXmlTelegramReplayDataImplCopyWithImpl<
        _$JmaXmlTelegramReplayDataImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JmaXmlTelegramReplayDataImplToJson(this);
  }
}

abstract class _JmaXmlTelegramReplayData
    extends JmaXmlTelegramReplayData {
  const factory _JmaXmlTelegramReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final String title,
    required final String telegram,
  }) = _$JmaXmlTelegramReplayDataImpl;
  const _JmaXmlTelegramReplayData._() : super._();

  factory _JmaXmlTelegramReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$JmaXmlTelegramReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  String get title;
  @override
  String get telegram;

  /// Create a copy of JmaXmlTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JmaXmlTelegramReplayDataImplCopyWith<
    _$JmaXmlTelegramReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

JmaBinaryTelegramReplayData
_$JmaBinaryTelegramReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _JmaBinaryTelegramReplayData.fromJson(json);
}

/// @nodoc
mixin _$JmaBinaryTelegramReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get telegramType =>
      throw _privateConstructorUsedError;
  List<int> get data => throw _privateConstructorUsedError;

  /// Serializes this JmaBinaryTelegramReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of JmaBinaryTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JmaBinaryTelegramReplayDataCopyWith<
    JmaBinaryTelegramReplayData
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JmaBinaryTelegramReplayDataCopyWith<$Res> {
  factory $JmaBinaryTelegramReplayDataCopyWith(
    JmaBinaryTelegramReplayData value,
    $Res Function(JmaBinaryTelegramReplayData) then,
  ) =
      _$JmaBinaryTelegramReplayDataCopyWithImpl<
        $Res,
        JmaBinaryTelegramReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String telegramType,
    List<int> data,
  });
}

/// @nodoc
class _$JmaBinaryTelegramReplayDataCopyWithImpl<
  $Res,
  $Val extends JmaBinaryTelegramReplayData
>
    implements $JmaBinaryTelegramReplayDataCopyWith<$Res> {
  _$JmaBinaryTelegramReplayDataCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JmaBinaryTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? telegramType = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            telegramType:
                null == telegramType
                    ? _value.telegramType
                    : telegramType // ignore: cast_nullable_to_non_nullable
                        as String,
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JmaBinaryTelegramReplayDataImplCopyWith<
  $Res
>
    implements $JmaBinaryTelegramReplayDataCopyWith<$Res> {
  factory _$$JmaBinaryTelegramReplayDataImplCopyWith(
    _$JmaBinaryTelegramReplayDataImpl value,
    $Res Function(_$JmaBinaryTelegramReplayDataImpl) then,
  ) = __$$JmaBinaryTelegramReplayDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String telegramType,
    List<int> data,
  });
}

/// @nodoc
class __$$JmaBinaryTelegramReplayDataImplCopyWithImpl<$Res>
    extends
        _$JmaBinaryTelegramReplayDataCopyWithImpl<
          $Res,
          _$JmaBinaryTelegramReplayDataImpl
        >
    implements
        _$$JmaBinaryTelegramReplayDataImplCopyWith<$Res> {
  __$$JmaBinaryTelegramReplayDataImplCopyWithImpl(
    _$JmaBinaryTelegramReplayDataImpl _value,
    $Res Function(_$JmaBinaryTelegramReplayDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JmaBinaryTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? telegramType = null,
    Object? data = null,
  }) {
    return _then(
      _$JmaBinaryTelegramReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        telegramType:
            null == telegramType
                ? _value.telegramType
                : telegramType // ignore: cast_nullable_to_non_nullable
                    as String,
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JmaBinaryTelegramReplayDataImpl
    extends _JmaBinaryTelegramReplayData {
  const _$JmaBinaryTelegramReplayDataImpl({
    required this.type,
    required this.time,
    required this.telegramType,
    required final List<int> data,
  }) : _data = data,
       super._();

  factory _$JmaBinaryTelegramReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$JmaBinaryTelegramReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  @override
  final String telegramType;
  final List<int> _data;
  @override
  List<int> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JmaBinaryTelegramReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            (identical(other.telegramType, telegramType) ||
                other.telegramType == telegramType) &&
            const DeepCollectionEquality().equals(
              other._data,
              _data,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    time,
    telegramType,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of JmaBinaryTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JmaBinaryTelegramReplayDataImplCopyWith<
    _$JmaBinaryTelegramReplayDataImpl
  >
  get copyWith =>
      __$$JmaBinaryTelegramReplayDataImplCopyWithImpl<
        _$JmaBinaryTelegramReplayDataImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JmaBinaryTelegramReplayDataImplToJson(this);
  }
}

abstract class _JmaBinaryTelegramReplayData
    extends JmaBinaryTelegramReplayData {
  const factory _JmaBinaryTelegramReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final String telegramType,
    required final List<int> data,
  }) = _$JmaBinaryTelegramReplayDataImpl;
  const _JmaBinaryTelegramReplayData._() : super._();

  factory _JmaBinaryTelegramReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$JmaBinaryTelegramReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  String get telegramType;
  @override
  List<int> get data;

  /// Create a copy of JmaBinaryTelegramReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JmaBinaryTelegramReplayDataImplCopyWith<
    _$JmaBinaryTelegramReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

KyoshinMonitorImageReplayData
_$KyoshinMonitorImageReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _KyoshinMonitorImageReplayData.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorImageReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  Map<ImageType, List<int>> get images =>
      throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorImageReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorImageReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorImageReplayDataCopyWith<
    KyoshinMonitorImageReplayData
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorImageReplayDataCopyWith<
  $Res
> {
  factory $KyoshinMonitorImageReplayDataCopyWith(
    KyoshinMonitorImageReplayData value,
    $Res Function(KyoshinMonitorImageReplayData) then,
  ) =
      _$KyoshinMonitorImageReplayDataCopyWithImpl<
        $Res,
        KyoshinMonitorImageReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    Map<ImageType, List<int>> images,
  });
}

/// @nodoc
class _$KyoshinMonitorImageReplayDataCopyWithImpl<
  $Res,
  $Val extends KyoshinMonitorImageReplayData
>
    implements
        $KyoshinMonitorImageReplayDataCopyWith<$Res> {
  _$KyoshinMonitorImageReplayDataCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorImageReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? images = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            images:
                null == images
                    ? _value.images
                    : images // ignore: cast_nullable_to_non_nullable
                        as Map<ImageType, List<int>>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorImageReplayDataImplCopyWith<
  $Res
>
    implements
        $KyoshinMonitorImageReplayDataCopyWith<$Res> {
  factory _$$KyoshinMonitorImageReplayDataImplCopyWith(
    _$KyoshinMonitorImageReplayDataImpl value,
    $Res Function(_$KyoshinMonitorImageReplayDataImpl) then,
  ) =
      __$$KyoshinMonitorImageReplayDataImplCopyWithImpl<
        $Res
      >;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    Map<ImageType, List<int>> images,
  });
}

/// @nodoc
class __$$KyoshinMonitorImageReplayDataImplCopyWithImpl<
  $Res
>
    extends
        _$KyoshinMonitorImageReplayDataCopyWithImpl<
          $Res,
          _$KyoshinMonitorImageReplayDataImpl
        >
    implements
        _$$KyoshinMonitorImageReplayDataImplCopyWith<$Res> {
  __$$KyoshinMonitorImageReplayDataImplCopyWithImpl(
    _$KyoshinMonitorImageReplayDataImpl _value,
    $Res Function(_$KyoshinMonitorImageReplayDataImpl)
    _then,
  ) : super(_value, _then);

  /// Create a copy of KyoshinMonitorImageReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? images = null,
  }) {
    return _then(
      _$KyoshinMonitorImageReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        images:
            null == images
                ? _value._images
                : images // ignore: cast_nullable_to_non_nullable
                    as Map<ImageType, List<int>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorImageReplayDataImpl
    extends _KyoshinMonitorImageReplayData {
  const _$KyoshinMonitorImageReplayDataImpl({
    required this.type,
    required this.time,
    required final Map<ImageType, List<int>> images,
  }) : _images = images,
       super._();

  factory _$KyoshinMonitorImageReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$KyoshinMonitorImageReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  final Map<ImageType, List<int>> _images;
  @override
  Map<ImageType, List<int>> get images {
    if (_images is EqualUnmodifiableMapView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_images);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KyoshinMonitorImageReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            const DeepCollectionEquality().equals(
              other._images,
              _images,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    time,
    const DeepCollectionEquality().hash(_images),
  );

  /// Create a copy of KyoshinMonitorImageReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorImageReplayDataImplCopyWith<
    _$KyoshinMonitorImageReplayDataImpl
  >
  get copyWith =>
      __$$KyoshinMonitorImageReplayDataImplCopyWithImpl<
        _$KyoshinMonitorImageReplayDataImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorImageReplayDataImplToJson(this);
  }
}

abstract class _KyoshinMonitorImageReplayData
    extends KyoshinMonitorImageReplayData {
  const factory _KyoshinMonitorImageReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final Map<ImageType, List<int>> images,
  }) = _$KyoshinMonitorImageReplayDataImpl;
  const _KyoshinMonitorImageReplayData._() : super._();

  factory _KyoshinMonitorImageReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$KyoshinMonitorImageReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  Map<ImageType, List<int>> get images;

  /// Create a copy of KyoshinMonitorImageReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorImageReplayDataImplCopyWith<
    _$KyoshinMonitorImageReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

KyoshinMonitorEewJsonReplayData
_$KyoshinMonitorEewJsonReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _KyoshinMonitorEewJsonReplayData.fromJson(json);
}

/// @nodoc
mixin _$KyoshinMonitorEewJsonReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get json => throw _privateConstructorUsedError;

  /// Serializes this KyoshinMonitorEewJsonReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of KyoshinMonitorEewJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KyoshinMonitorEewJsonReplayDataCopyWith<
    KyoshinMonitorEewJsonReplayData
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KyoshinMonitorEewJsonReplayDataCopyWith<
  $Res
> {
  factory $KyoshinMonitorEewJsonReplayDataCopyWith(
    KyoshinMonitorEewJsonReplayData value,
    $Res Function(KyoshinMonitorEewJsonReplayData) then,
  ) =
      _$KyoshinMonitorEewJsonReplayDataCopyWithImpl<
        $Res,
        KyoshinMonitorEewJsonReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String json,
  });
}

/// @nodoc
class _$KyoshinMonitorEewJsonReplayDataCopyWithImpl<
  $Res,
  $Val extends KyoshinMonitorEewJsonReplayData
>
    implements
        $KyoshinMonitorEewJsonReplayDataCopyWith<$Res> {
  _$KyoshinMonitorEewJsonReplayDataCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KyoshinMonitorEewJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? json = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            json:
                null == json
                    ? _value.json
                    : json // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KyoshinMonitorEewJsonReplayDataImplCopyWith<
  $Res
>
    implements
        $KyoshinMonitorEewJsonReplayDataCopyWith<$Res> {
  factory _$$KyoshinMonitorEewJsonReplayDataImplCopyWith(
    _$KyoshinMonitorEewJsonReplayDataImpl value,
    $Res Function(_$KyoshinMonitorEewJsonReplayDataImpl)
    then,
  ) =
      __$$KyoshinMonitorEewJsonReplayDataImplCopyWithImpl<
        $Res
      >;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String json,
  });
}

/// @nodoc
class __$$KyoshinMonitorEewJsonReplayDataImplCopyWithImpl<
  $Res
>
    extends
        _$KyoshinMonitorEewJsonReplayDataCopyWithImpl<
          $Res,
          _$KyoshinMonitorEewJsonReplayDataImpl
        >
    implements
        _$$KyoshinMonitorEewJsonReplayDataImplCopyWith<
          $Res
        > {
  __$$KyoshinMonitorEewJsonReplayDataImplCopyWithImpl(
    _$KyoshinMonitorEewJsonReplayDataImpl _value,
    $Res Function(_$KyoshinMonitorEewJsonReplayDataImpl)
    _then,
  ) : super(_value, _then);

  /// Create a copy of KyoshinMonitorEewJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? json = null,
  }) {
    return _then(
      _$KyoshinMonitorEewJsonReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        json:
            null == json
                ? _value.json
                : json // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KyoshinMonitorEewJsonReplayDataImpl
    extends _KyoshinMonitorEewJsonReplayData {
  const _$KyoshinMonitorEewJsonReplayDataImpl({
    required this.type,
    required this.time,
    required this.json,
  }) : super._();

  factory _$KyoshinMonitorEewJsonReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$KyoshinMonitorEewJsonReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  @override
  final String json;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other
                is _$KyoshinMonitorEewJsonReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            (identical(other.json, json) ||
                other.json == json));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, time, json);

  /// Create a copy of KyoshinMonitorEewJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KyoshinMonitorEewJsonReplayDataImplCopyWith<
    _$KyoshinMonitorEewJsonReplayDataImpl
  >
  get copyWith =>
      __$$KyoshinMonitorEewJsonReplayDataImplCopyWithImpl<
        _$KyoshinMonitorEewJsonReplayDataImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KyoshinMonitorEewJsonReplayDataImplToJson(
      this,
    );
  }
}

abstract class _KyoshinMonitorEewJsonReplayData
    extends KyoshinMonitorEewJsonReplayData {
  const factory _KyoshinMonitorEewJsonReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final String json,
  }) = _$KyoshinMonitorEewJsonReplayDataImpl;
  const _KyoshinMonitorEewJsonReplayData._() : super._();

  factory _KyoshinMonitorEewJsonReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$KyoshinMonitorEewJsonReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  String get json;

  /// Create a copy of KyoshinMonitorEewJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KyoshinMonitorEewJsonReplayDataImplCopyWith<
    _$KyoshinMonitorEewJsonReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

KeviJsonReplayData _$KeviJsonReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _KeviJsonReplayData.fromJson(json);
}

/// @nodoc
mixin _$KeviJsonReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  JsonType get jsonType =>
      throw _privateConstructorUsedError;
  String get json => throw _privateConstructorUsedError;

  /// Serializes this KeviJsonReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of KeviJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeviJsonReplayDataCopyWith<KeviJsonReplayData>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeviJsonReplayDataCopyWith<$Res> {
  factory $KeviJsonReplayDataCopyWith(
    KeviJsonReplayData value,
    $Res Function(KeviJsonReplayData) then,
  ) =
      _$KeviJsonReplayDataCopyWithImpl<
        $Res,
        KeviJsonReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    JsonType jsonType,
    String json,
  });
}

/// @nodoc
class _$KeviJsonReplayDataCopyWithImpl<
  $Res,
  $Val extends KeviJsonReplayData
>
    implements $KeviJsonReplayDataCopyWith<$Res> {
  _$KeviJsonReplayDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeviJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? jsonType = null,
    Object? json = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            jsonType:
                null == jsonType
                    ? _value.jsonType
                    : jsonType // ignore: cast_nullable_to_non_nullable
                        as JsonType,
            json:
                null == json
                    ? _value.json
                    : json // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$KeviJsonReplayDataImplCopyWith<$Res>
    implements $KeviJsonReplayDataCopyWith<$Res> {
  factory _$$KeviJsonReplayDataImplCopyWith(
    _$KeviJsonReplayDataImpl value,
    $Res Function(_$KeviJsonReplayDataImpl) then,
  ) = __$$KeviJsonReplayDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    JsonType jsonType,
    String json,
  });
}

/// @nodoc
class __$$KeviJsonReplayDataImplCopyWithImpl<$Res>
    extends
        _$KeviJsonReplayDataCopyWithImpl<
          $Res,
          _$KeviJsonReplayDataImpl
        >
    implements _$$KeviJsonReplayDataImplCopyWith<$Res> {
  __$$KeviJsonReplayDataImplCopyWithImpl(
    _$KeviJsonReplayDataImpl _value,
    $Res Function(_$KeviJsonReplayDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of KeviJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? jsonType = null,
    Object? json = null,
  }) {
    return _then(
      _$KeviJsonReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        jsonType:
            null == jsonType
                ? _value.jsonType
                : jsonType // ignore: cast_nullable_to_non_nullable
                    as JsonType,
        json:
            null == json
                ? _value.json
                : json // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$KeviJsonReplayDataImpl extends _KeviJsonReplayData {
  const _$KeviJsonReplayDataImpl({
    required this.type,
    required this.time,
    required this.jsonType,
    required this.json,
  }) : super._();

  factory _$KeviJsonReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$KeviJsonReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  @override
  final JsonType jsonType;
  @override
  final String json;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeviJsonReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            (identical(other.jsonType, jsonType) ||
                other.jsonType == jsonType) &&
            (identical(other.json, json) ||
                other.json == json));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, time, jsonType, json);

  /// Create a copy of KeviJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeviJsonReplayDataImplCopyWith<
    _$KeviJsonReplayDataImpl
  >
  get copyWith => __$$KeviJsonReplayDataImplCopyWithImpl<
    _$KeviJsonReplayDataImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeviJsonReplayDataImplToJson(this);
  }
}

abstract class _KeviJsonReplayData
    extends KeviJsonReplayData {
  const factory _KeviJsonReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final JsonType jsonType,
    required final String json,
  }) = _$KeviJsonReplayDataImpl;
  const _KeviJsonReplayData._() : super._();

  factory _KeviJsonReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$KeviJsonReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  JsonType get jsonType;
  @override
  String get json;

  /// Create a copy of KeviJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeviJsonReplayDataImplCopyWith<
    _$KeviJsonReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

SnpLogEntryReplayData _$SnpLogEntryReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _SnpLogEntryReplayData.fromJson(json);
}

/// @nodoc
mixin _$SnpLogEntryReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this SnpLogEntryReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of SnpLogEntryReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnpLogEntryReplayDataCopyWith<SnpLogEntryReplayData>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnpLogEntryReplayDataCopyWith<$Res> {
  factory $SnpLogEntryReplayDataCopyWith(
    SnpLogEntryReplayData value,
    $Res Function(SnpLogEntryReplayData) then,
  ) =
      _$SnpLogEntryReplayDataCopyWithImpl<
        $Res,
        SnpLogEntryReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String message,
  });
}

/// @nodoc
class _$SnpLogEntryReplayDataCopyWithImpl<
  $Res,
  $Val extends SnpLogEntryReplayData
>
    implements $SnpLogEntryReplayDataCopyWith<$Res> {
  _$SnpLogEntryReplayDataCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnpLogEntryReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? message = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SnpLogEntryReplayDataImplCopyWith<$Res>
    implements $SnpLogEntryReplayDataCopyWith<$Res> {
  factory _$$SnpLogEntryReplayDataImplCopyWith(
    _$SnpLogEntryReplayDataImpl value,
    $Res Function(_$SnpLogEntryReplayDataImpl) then,
  ) = __$$SnpLogEntryReplayDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String message,
  });
}

/// @nodoc
class __$$SnpLogEntryReplayDataImplCopyWithImpl<$Res>
    extends
        _$SnpLogEntryReplayDataCopyWithImpl<
          $Res,
          _$SnpLogEntryReplayDataImpl
        >
    implements _$$SnpLogEntryReplayDataImplCopyWith<$Res> {
  __$$SnpLogEntryReplayDataImplCopyWithImpl(
    _$SnpLogEntryReplayDataImpl _value,
    $Res Function(_$SnpLogEntryReplayDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SnpLogEntryReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? message = null,
  }) {
    return _then(
      _$SnpLogEntryReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SnpLogEntryReplayDataImpl
    extends _SnpLogEntryReplayData {
  const _$SnpLogEntryReplayDataImpl({
    required this.type,
    required this.time,
    required this.message,
  }) : super._();

  factory _$SnpLogEntryReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SnpLogEntryReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  @override
  final String message;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnpLogEntryReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            (identical(other.message, message) ||
                other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, time, message);

  /// Create a copy of SnpLogEntryReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnpLogEntryReplayDataImplCopyWith<
    _$SnpLogEntryReplayDataImpl
  >
  get copyWith => __$$SnpLogEntryReplayDataImplCopyWithImpl<
    _$SnpLogEntryReplayDataImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnpLogEntryReplayDataImplToJson(this);
  }
}

abstract class _SnpLogEntryReplayData
    extends SnpLogEntryReplayData {
  const factory _SnpLogEntryReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final String message,
  }) = _$SnpLogEntryReplayDataImpl;
  const _SnpLogEntryReplayData._() : super._();

  factory _SnpLogEntryReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$SnpLogEntryReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  String get message;

  /// Create a copy of SnpLogEntryReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnpLogEntryReplayDataImplCopyWith<
    _$SnpLogEntryReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

AxisJsonReplayData _$AxisJsonReplayDataFromJson(
  Map<String, dynamic> json,
) {
  return _AxisJsonReplayData.fromJson(json);
}

/// @nodoc
mixin _$AxisJsonReplayData {
  ReplayDataType get type =>
      throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  String get json => throw _privateConstructorUsedError;

  /// Serializes this AxisJsonReplayData to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of AxisJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AxisJsonReplayDataCopyWith<AxisJsonReplayData>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AxisJsonReplayDataCopyWith<$Res> {
  factory $AxisJsonReplayDataCopyWith(
    AxisJsonReplayData value,
    $Res Function(AxisJsonReplayData) then,
  ) =
      _$AxisJsonReplayDataCopyWithImpl<
        $Res,
        AxisJsonReplayData
      >;
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String json,
  });
}

/// @nodoc
class _$AxisJsonReplayDataCopyWithImpl<
  $Res,
  $Val extends AxisJsonReplayData
>
    implements $AxisJsonReplayDataCopyWith<$Res> {
  _$AxisJsonReplayDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AxisJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? json = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ReplayDataType,
            time:
                null == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            json:
                null == json
                    ? _value.json
                    : json // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AxisJsonReplayDataImplCopyWith<$Res>
    implements $AxisJsonReplayDataCopyWith<$Res> {
  factory _$$AxisJsonReplayDataImplCopyWith(
    _$AxisJsonReplayDataImpl value,
    $Res Function(_$AxisJsonReplayDataImpl) then,
  ) = __$$AxisJsonReplayDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ReplayDataType type,
    DateTime time,
    String json,
  });
}

/// @nodoc
class __$$AxisJsonReplayDataImplCopyWithImpl<$Res>
    extends
        _$AxisJsonReplayDataCopyWithImpl<
          $Res,
          _$AxisJsonReplayDataImpl
        >
    implements _$$AxisJsonReplayDataImplCopyWith<$Res> {
  __$$AxisJsonReplayDataImplCopyWithImpl(
    _$AxisJsonReplayDataImpl _value,
    $Res Function(_$AxisJsonReplayDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AxisJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? time = null,
    Object? json = null,
  }) {
    return _then(
      _$AxisJsonReplayDataImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ReplayDataType,
        time:
            null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        json:
            null == json
                ? _value.json
                : json // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AxisJsonReplayDataImpl extends _AxisJsonReplayData {
  const _$AxisJsonReplayDataImpl({
    required this.type,
    required this.time,
    required this.json,
  }) : super._();

  factory _$AxisJsonReplayDataImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AxisJsonReplayDataImplFromJson(json);

  @override
  final ReplayDataType type;
  @override
  final DateTime time;
  @override
  final String json;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AxisJsonReplayDataImpl &&
            (identical(other.type, type) ||
                other.type == type) &&
            (identical(other.time, time) ||
                other.time == time) &&
            (identical(other.json, json) ||
                other.json == json));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, time, json);

  /// Create a copy of AxisJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AxisJsonReplayDataImplCopyWith<
    _$AxisJsonReplayDataImpl
  >
  get copyWith => __$$AxisJsonReplayDataImplCopyWithImpl<
    _$AxisJsonReplayDataImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AxisJsonReplayDataImplToJson(this);
  }
}

abstract class _AxisJsonReplayData
    extends AxisJsonReplayData {
  const factory _AxisJsonReplayData({
    required final ReplayDataType type,
    required final DateTime time,
    required final String json,
  }) = _$AxisJsonReplayDataImpl;
  const _AxisJsonReplayData._() : super._();

  factory _AxisJsonReplayData.fromJson(
    Map<String, dynamic> json,
  ) = _$AxisJsonReplayDataImpl.fromJson;

  @override
  ReplayDataType get type;
  @override
  DateTime get time;
  @override
  String get json;

  /// Create a copy of AxisJsonReplayData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AxisJsonReplayDataImplCopyWith<
    _$AxisJsonReplayDataImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
