// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_file_header.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReplayFileHeader _$ReplayFileHeaderFromJson(Map<String, dynamic> json) {
  return _ReplayFileHeader.fromJson(json);
}

/// @nodoc
mixin _$ReplayFileHeader {
  int get version => throw _privateConstructorUsedError;
  String get softwareName => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  ReplayFileCompressionMode get compressionMode =>
      throw _privateConstructorUsedError;

  /// Serializes this ReplayFileHeader to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReplayFileHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReplayFileHeaderCopyWith<ReplayFileHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplayFileHeaderCopyWith<$Res> {
  factory $ReplayFileHeaderCopyWith(
          ReplayFileHeader value, $Res Function(ReplayFileHeader) then) =
      _$ReplayFileHeaderCopyWithImpl<$Res, ReplayFileHeader>;
  @useResult
  $Res call(
      {int version,
      String softwareName,
      DateTime startTime,
      DateTime endTime,
      ReplayFileCompressionMode compressionMode});
}

/// @nodoc
class _$ReplayFileHeaderCopyWithImpl<$Res, $Val extends ReplayFileHeader>
    implements $ReplayFileHeaderCopyWith<$Res> {
  _$ReplayFileHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReplayFileHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? softwareName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? compressionMode = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      softwareName: null == softwareName
          ? _value.softwareName
          : softwareName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      compressionMode: null == compressionMode
          ? _value.compressionMode
          : compressionMode // ignore: cast_nullable_to_non_nullable
              as ReplayFileCompressionMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReplayFileHeaderImplCopyWith<$Res>
    implements $ReplayFileHeaderCopyWith<$Res> {
  factory _$$ReplayFileHeaderImplCopyWith(_$ReplayFileHeaderImpl value,
          $Res Function(_$ReplayFileHeaderImpl) then) =
      __$$ReplayFileHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int version,
      String softwareName,
      DateTime startTime,
      DateTime endTime,
      ReplayFileCompressionMode compressionMode});
}

/// @nodoc
class __$$ReplayFileHeaderImplCopyWithImpl<$Res>
    extends _$ReplayFileHeaderCopyWithImpl<$Res, _$ReplayFileHeaderImpl>
    implements _$$ReplayFileHeaderImplCopyWith<$Res> {
  __$$ReplayFileHeaderImplCopyWithImpl(_$ReplayFileHeaderImpl _value,
      $Res Function(_$ReplayFileHeaderImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReplayFileHeader
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? softwareName = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? compressionMode = null,
  }) {
    return _then(_$ReplayFileHeaderImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      softwareName: null == softwareName
          ? _value.softwareName
          : softwareName // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      compressionMode: null == compressionMode
          ? _value.compressionMode
          : compressionMode // ignore: cast_nullable_to_non_nullable
              as ReplayFileCompressionMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplayFileHeaderImpl implements _ReplayFileHeader {
  const _$ReplayFileHeaderImpl(
      {required this.version,
      required this.softwareName,
      required this.startTime,
      required this.endTime,
      required this.compressionMode});

  factory _$ReplayFileHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplayFileHeaderImplFromJson(json);

  @override
  final int version;
  @override
  final String softwareName;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final ReplayFileCompressionMode compressionMode;

  @override
  String toString() {
    return 'ReplayFileHeader(version: $version, softwareName: $softwareName, startTime: $startTime, endTime: $endTime, compressionMode: $compressionMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplayFileHeaderImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.softwareName, softwareName) ||
                other.softwareName == softwareName) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.compressionMode, compressionMode) ||
                other.compressionMode == compressionMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, version, softwareName, startTime, endTime, compressionMode);

  /// Create a copy of ReplayFileHeader
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplayFileHeaderImplCopyWith<_$ReplayFileHeaderImpl> get copyWith =>
      __$$ReplayFileHeaderImplCopyWithImpl<_$ReplayFileHeaderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplayFileHeaderImplToJson(
      this,
    );
  }
}

abstract class _ReplayFileHeader implements ReplayFileHeader {
  const factory _ReplayFileHeader(
          {required final int version,
          required final String softwareName,
          required final DateTime startTime,
          required final DateTime endTime,
          required final ReplayFileCompressionMode compressionMode}) =
      _$ReplayFileHeaderImpl;

  factory _ReplayFileHeader.fromJson(Map<String, dynamic> json) =
      _$ReplayFileHeaderImpl.fromJson;

  @override
  int get version;
  @override
  String get softwareName;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  ReplayFileCompressionMode get compressionMode;

  /// Create a copy of ReplayFileHeader
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplayFileHeaderImplCopyWith<_$ReplayFileHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
