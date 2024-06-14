// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppInformation _$AppInformationFromJson(Map<String, dynamic> json) {
  return _AppInformation.fromJson(json);
}

/// @nodoc
mixin _$AppInformation {
  PlatformAppInformation get ios => throw _privateConstructorUsedError;
  PlatformAppInformation get android => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppInformationCopyWith<AppInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInformationCopyWith<$Res> {
  factory $AppInformationCopyWith(
          AppInformation value, $Res Function(AppInformation) then) =
      _$AppInformationCopyWithImpl<$Res, AppInformation>;
  @useResult
  $Res call({PlatformAppInformation ios, PlatformAppInformation android});

  $PlatformAppInformationCopyWith<$Res> get ios;
  $PlatformAppInformationCopyWith<$Res> get android;
}

/// @nodoc
class _$AppInformationCopyWithImpl<$Res, $Val extends AppInformation>
    implements $AppInformationCopyWith<$Res> {
  _$AppInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ios = null,
    Object? android = null,
  }) {
    return _then(_value.copyWith(
      ios: null == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as PlatformAppInformation,
      android: null == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as PlatformAppInformation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlatformAppInformationCopyWith<$Res> get ios {
    return $PlatformAppInformationCopyWith<$Res>(_value.ios, (value) {
      return _then(_value.copyWith(ios: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlatformAppInformationCopyWith<$Res> get android {
    return $PlatformAppInformationCopyWith<$Res>(_value.android, (value) {
      return _then(_value.copyWith(android: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppInformationImplCopyWith<$Res>
    implements $AppInformationCopyWith<$Res> {
  factory _$$AppInformationImplCopyWith(_$AppInformationImpl value,
          $Res Function(_$AppInformationImpl) then) =
      __$$AppInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlatformAppInformation ios, PlatformAppInformation android});

  @override
  $PlatformAppInformationCopyWith<$Res> get ios;
  @override
  $PlatformAppInformationCopyWith<$Res> get android;
}

/// @nodoc
class __$$AppInformationImplCopyWithImpl<$Res>
    extends _$AppInformationCopyWithImpl<$Res, _$AppInformationImpl>
    implements _$$AppInformationImplCopyWith<$Res> {
  __$$AppInformationImplCopyWithImpl(
      _$AppInformationImpl _value, $Res Function(_$AppInformationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ios = null,
    Object? android = null,
  }) {
    return _then(_$AppInformationImpl(
      ios: null == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as PlatformAppInformation,
      android: null == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as PlatformAppInformation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppInformationImpl implements _AppInformation {
  const _$AppInformationImpl({required this.ios, required this.android});

  factory _$AppInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppInformationImplFromJson(json);

  @override
  final PlatformAppInformation ios;
  @override
  final PlatformAppInformation android;

  @override
  String toString() {
    return 'AppInformation(ios: $ios, android: $android)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInformationImpl &&
            (identical(other.ios, ios) || other.ios == ios) &&
            (identical(other.android, android) || other.android == android));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ios, android);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInformationImplCopyWith<_$AppInformationImpl> get copyWith =>
      __$$AppInformationImplCopyWithImpl<_$AppInformationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppInformationImplToJson(
      this,
    );
  }
}

abstract class _AppInformation implements AppInformation {
  const factory _AppInformation(
      {required final PlatformAppInformation ios,
      required final PlatformAppInformation android}) = _$AppInformationImpl;

  factory _AppInformation.fromJson(Map<String, dynamic> json) =
      _$AppInformationImpl.fromJson;

  @override
  PlatformAppInformation get ios;
  @override
  PlatformAppInformation get android;
  @override
  @JsonKey(ignore: true)
  _$$AppInformationImplCopyWith<_$AppInformationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlatformAppInformation _$PlatformAppInformationFromJson(
    Map<String, dynamic> json) {
  return _PlatformAppInformation.fromJson(json);
}

/// @nodoc
mixin _$PlatformAppInformation {
  AppVersion? get latest => throw _privateConstructorUsedError;
  AppVersion? get minimum => throw _privateConstructorUsedError;
  String? get downloadUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlatformAppInformationCopyWith<PlatformAppInformation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlatformAppInformationCopyWith<$Res> {
  factory $PlatformAppInformationCopyWith(PlatformAppInformation value,
          $Res Function(PlatformAppInformation) then) =
      _$PlatformAppInformationCopyWithImpl<$Res, PlatformAppInformation>;
  @useResult
  $Res call({AppVersion? latest, AppVersion? minimum, String? downloadUrl});

  $AppVersionCopyWith<$Res>? get latest;
  $AppVersionCopyWith<$Res>? get minimum;
}

/// @nodoc
class _$PlatformAppInformationCopyWithImpl<$Res,
        $Val extends PlatformAppInformation>
    implements $PlatformAppInformationCopyWith<$Res> {
  _$PlatformAppInformationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latest = freezed,
    Object? minimum = freezed,
    Object? downloadUrl = freezed,
  }) {
    return _then(_value.copyWith(
      latest: freezed == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      minimum: freezed == minimum
          ? _value.minimum
          : minimum // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppVersionCopyWith<$Res>? get latest {
    if (_value.latest == null) {
      return null;
    }

    return $AppVersionCopyWith<$Res>(_value.latest!, (value) {
      return _then(_value.copyWith(latest: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppVersionCopyWith<$Res>? get minimum {
    if (_value.minimum == null) {
      return null;
    }

    return $AppVersionCopyWith<$Res>(_value.minimum!, (value) {
      return _then(_value.copyWith(minimum: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlatformAppInformationImplCopyWith<$Res>
    implements $PlatformAppInformationCopyWith<$Res> {
  factory _$$PlatformAppInformationImplCopyWith(
          _$PlatformAppInformationImpl value,
          $Res Function(_$PlatformAppInformationImpl) then) =
      __$$PlatformAppInformationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppVersion? latest, AppVersion? minimum, String? downloadUrl});

  @override
  $AppVersionCopyWith<$Res>? get latest;
  @override
  $AppVersionCopyWith<$Res>? get minimum;
}

/// @nodoc
class __$$PlatformAppInformationImplCopyWithImpl<$Res>
    extends _$PlatformAppInformationCopyWithImpl<$Res,
        _$PlatformAppInformationImpl>
    implements _$$PlatformAppInformationImplCopyWith<$Res> {
  __$$PlatformAppInformationImplCopyWithImpl(
      _$PlatformAppInformationImpl _value,
      $Res Function(_$PlatformAppInformationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latest = freezed,
    Object? minimum = freezed,
    Object? downloadUrl = freezed,
  }) {
    return _then(_$PlatformAppInformationImpl(
      latest: freezed == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      minimum: freezed == minimum
          ? _value.minimum
          : minimum // ignore: cast_nullable_to_non_nullable
              as AppVersion?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlatformAppInformationImpl implements _PlatformAppInformation {
  const _$PlatformAppInformationImpl(
      {required this.latest, required this.minimum, required this.downloadUrl});

  factory _$PlatformAppInformationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlatformAppInformationImplFromJson(json);

  @override
  final AppVersion? latest;
  @override
  final AppVersion? minimum;
  @override
  final String? downloadUrl;

  @override
  String toString() {
    return 'PlatformAppInformation(latest: $latest, minimum: $minimum, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlatformAppInformationImpl &&
            (identical(other.latest, latest) || other.latest == latest) &&
            (identical(other.minimum, minimum) || other.minimum == minimum) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latest, minimum, downloadUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlatformAppInformationImplCopyWith<_$PlatformAppInformationImpl>
      get copyWith => __$$PlatformAppInformationImplCopyWithImpl<
          _$PlatformAppInformationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlatformAppInformationImplToJson(
      this,
    );
  }
}

abstract class _PlatformAppInformation implements PlatformAppInformation {
  const factory _PlatformAppInformation(
      {required final AppVersion? latest,
      required final AppVersion? minimum,
      required final String? downloadUrl}) = _$PlatformAppInformationImpl;

  factory _PlatformAppInformation.fromJson(Map<String, dynamic> json) =
      _$PlatformAppInformationImpl.fromJson;

  @override
  AppVersion? get latest;
  @override
  AppVersion? get minimum;
  @override
  String? get downloadUrl;
  @override
  @JsonKey(ignore: true)
  _$$PlatformAppInformationImplCopyWith<_$PlatformAppInformationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AppVersion _$AppVersionFromJson(Map<String, dynamic> json) {
  return _AppVersion.fromJson(json);
}

/// @nodoc
mixin _$AppVersion {
  String get version => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppVersionCopyWith<AppVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionCopyWith<$Res> {
  factory $AppVersionCopyWith(
          AppVersion value, $Res Function(AppVersion) then) =
      _$AppVersionCopyWithImpl<$Res, AppVersion>;
  @useResult
  $Res call({String version, String? message});
}

/// @nodoc
class _$AppVersionCopyWithImpl<$Res, $Val extends AppVersion>
    implements $AppVersionCopyWith<$Res> {
  _$AppVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppVersionImplCopyWith<$Res>
    implements $AppVersionCopyWith<$Res> {
  factory _$$AppVersionImplCopyWith(
          _$AppVersionImpl value, $Res Function(_$AppVersionImpl) then) =
      __$$AppVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String version, String? message});
}

/// @nodoc
class __$$AppVersionImplCopyWithImpl<$Res>
    extends _$AppVersionCopyWithImpl<$Res, _$AppVersionImpl>
    implements _$$AppVersionImplCopyWith<$Res> {
  __$$AppVersionImplCopyWithImpl(
      _$AppVersionImpl _value, $Res Function(_$AppVersionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? message = freezed,
  }) {
    return _then(_$AppVersionImpl(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppVersionImpl implements _AppVersion {
  const _$AppVersionImpl({required this.version, required this.message});

  factory _$AppVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppVersionImplFromJson(json);

  @override
  final String version;
  @override
  final String? message;

  @override
  String toString() {
    return 'AppVersion(version: $version, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppVersionImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppVersionImplCopyWith<_$AppVersionImpl> get copyWith =>
      __$$AppVersionImplCopyWithImpl<_$AppVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppVersionImplToJson(
      this,
    );
  }
}

abstract class _AppVersion implements AppVersion {
  const factory _AppVersion(
      {required final String version,
      required final String? message}) = _$AppVersionImpl;

  factory _AppVersion.fromJson(Map<String, dynamic> json) =
      _$AppVersionImpl.fromJson;

  @override
  String get version;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AppVersionImplCopyWith<_$AppVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
