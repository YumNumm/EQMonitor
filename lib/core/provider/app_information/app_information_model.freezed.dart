// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_information_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppInformationModel _$AppInformationModelFromJson(Map<String, dynamic> json) {
  return _AppInformationModel.fromJson(json);
}

/// @nodoc
mixin _$AppInformationModel {
  @JsonKey(fromJson: versionFromJson, toJson: versionToJson)
  Version get latestVersion => throw _privateConstructorUsedError;
  @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
  Version? get minimumVersion => throw _privateConstructorUsedError;
  @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
  Uri? get downloadUrl => throw _privateConstructorUsedError;
  String? get forceUpdateMessage => throw _privateConstructorUsedError;
  bool get hasUpdate => throw _privateConstructorUsedError;
  bool get hasForceUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppInformationModelCopyWith<AppInformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInformationModelCopyWith<$Res> {
  factory $AppInformationModelCopyWith(
          AppInformationModel value, $Res Function(AppInformationModel) then) =
      _$AppInformationModelCopyWithImpl<$Res, AppInformationModel>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: versionFromJson, toJson: versionToJson)
      Version latestVersion,
      @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
      Version? minimumVersion,
      @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
      Uri? downloadUrl,
      String? forceUpdateMessage,
      bool hasUpdate,
      bool hasForceUpdate});
}

/// @nodoc
class _$AppInformationModelCopyWithImpl<$Res, $Val extends AppInformationModel>
    implements $AppInformationModelCopyWith<$Res> {
  _$AppInformationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latestVersion = null,
    Object? minimumVersion = freezed,
    Object? downloadUrl = freezed,
    Object? forceUpdateMessage = freezed,
    Object? hasUpdate = null,
    Object? hasForceUpdate = null,
  }) {
    return _then(_value.copyWith(
      latestVersion: null == latestVersion
          ? _value.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      minimumVersion: freezed == minimumVersion
          ? _value.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as Version?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
      forceUpdateMessage: freezed == forceUpdateMessage
          ? _value.forceUpdateMessage
          : forceUpdateMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasUpdate: null == hasUpdate
          ? _value.hasUpdate
          : hasUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      hasForceUpdate: null == hasForceUpdate
          ? _value.hasForceUpdate
          : hasForceUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInformationModelImplCopyWith<$Res>
    implements $AppInformationModelCopyWith<$Res> {
  factory _$$AppInformationModelImplCopyWith(_$AppInformationModelImpl value,
          $Res Function(_$AppInformationModelImpl) then) =
      __$$AppInformationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: versionFromJson, toJson: versionToJson)
      Version latestVersion,
      @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
      Version? minimumVersion,
      @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
      Uri? downloadUrl,
      String? forceUpdateMessage,
      bool hasUpdate,
      bool hasForceUpdate});
}

/// @nodoc
class __$$AppInformationModelImplCopyWithImpl<$Res>
    extends _$AppInformationModelCopyWithImpl<$Res, _$AppInformationModelImpl>
    implements _$$AppInformationModelImplCopyWith<$Res> {
  __$$AppInformationModelImplCopyWithImpl(_$AppInformationModelImpl _value,
      $Res Function(_$AppInformationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latestVersion = null,
    Object? minimumVersion = freezed,
    Object? downloadUrl = freezed,
    Object? forceUpdateMessage = freezed,
    Object? hasUpdate = null,
    Object? hasForceUpdate = null,
  }) {
    return _then(_$AppInformationModelImpl(
      latestVersion: null == latestVersion
          ? _value.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      minimumVersion: freezed == minimumVersion
          ? _value.minimumVersion
          : minimumVersion // ignore: cast_nullable_to_non_nullable
              as Version?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as Uri?,
      forceUpdateMessage: freezed == forceUpdateMessage
          ? _value.forceUpdateMessage
          : forceUpdateMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      hasUpdate: null == hasUpdate
          ? _value.hasUpdate
          : hasUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      hasForceUpdate: null == hasForceUpdate
          ? _value.hasForceUpdate
          : hasForceUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppInformationModelImpl implements _AppInformationModel {
  const _$AppInformationModelImpl(
      {@JsonKey(fromJson: versionFromJson, toJson: versionToJson)
      required this.latestVersion,
      @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
      required this.minimumVersion,
      @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
      required this.downloadUrl,
      required this.forceUpdateMessage,
      required this.hasUpdate,
      required this.hasForceUpdate});

  factory _$AppInformationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppInformationModelImplFromJson(json);

  @override
  @JsonKey(fromJson: versionFromJson, toJson: versionToJson)
  final Version latestVersion;
  @override
  @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
  final Version? minimumVersion;
  @override
  @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
  final Uri? downloadUrl;
  @override
  final String? forceUpdateMessage;
  @override
  final bool hasUpdate;
  @override
  final bool hasForceUpdate;

  @override
  String toString() {
    return 'AppInformationModel(latestVersion: $latestVersion, minimumVersion: $minimumVersion, downloadUrl: $downloadUrl, forceUpdateMessage: $forceUpdateMessage, hasUpdate: $hasUpdate, hasForceUpdate: $hasForceUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInformationModelImpl &&
            (identical(other.latestVersion, latestVersion) ||
                other.latestVersion == latestVersion) &&
            (identical(other.minimumVersion, minimumVersion) ||
                other.minimumVersion == minimumVersion) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.forceUpdateMessage, forceUpdateMessage) ||
                other.forceUpdateMessage == forceUpdateMessage) &&
            (identical(other.hasUpdate, hasUpdate) ||
                other.hasUpdate == hasUpdate) &&
            (identical(other.hasForceUpdate, hasForceUpdate) ||
                other.hasForceUpdate == hasForceUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latestVersion, minimumVersion,
      downloadUrl, forceUpdateMessage, hasUpdate, hasForceUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInformationModelImplCopyWith<_$AppInformationModelImpl> get copyWith =>
      __$$AppInformationModelImplCopyWithImpl<_$AppInformationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppInformationModelImplToJson(
      this,
    );
  }
}

abstract class _AppInformationModel implements AppInformationModel {
  const factory _AppInformationModel(
      {@JsonKey(fromJson: versionFromJson, toJson: versionToJson)
      required final Version latestVersion,
      @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
      required final Version? minimumVersion,
      @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
      required final Uri? downloadUrl,
      required final String? forceUpdateMessage,
      required final bool hasUpdate,
      required final bool hasForceUpdate}) = _$AppInformationModelImpl;

  factory _AppInformationModel.fromJson(Map<String, dynamic> json) =
      _$AppInformationModelImpl.fromJson;

  @override
  @JsonKey(fromJson: versionFromJson, toJson: versionToJson)
  Version get latestVersion;
  @override
  @JsonKey(fromJson: versionFromJsonNullable, toJson: versionToJsonNullable)
  Version? get minimumVersion;
  @override
  @JsonKey(fromJson: uriFromJsonNullable, toJson: uriToJsonNullable)
  Uri? get downloadUrl;
  @override
  String? get forceUpdateMessage;
  @override
  bool get hasUpdate;
  @override
  bool get hasForceUpdate;
  @override
  @JsonKey(ignore: true)
  _$$AppInformationModelImplCopyWith<_$AppInformationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
