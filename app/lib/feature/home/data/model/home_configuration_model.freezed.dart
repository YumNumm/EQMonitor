// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_configuration_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeConfigurationModel _$HomeConfigurationModelFromJson(
  Map<String, dynamic> json,
) {
  return _HomeConfigurationModel.fromJson(json);
}

/// @nodoc
mixin _$HomeConfigurationModel {
  /// 位置情報を表示するかどうか
  bool get showLocation =>
      throw _privateConstructorUsedError;

  /// Serializes this HomeConfigurationModel to a JSON map.
  Map<String, dynamic> toJson() =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomeConfigurationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeConfigurationModelCopyWith<HomeConfigurationModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeConfigurationModelCopyWith<$Res> {
  factory $HomeConfigurationModelCopyWith(
    HomeConfigurationModel value,
    $Res Function(HomeConfigurationModel) then,
  ) =
      _$HomeConfigurationModelCopyWithImpl<
        $Res,
        HomeConfigurationModel
      >;
  @useResult
  $Res call({bool showLocation});
}

/// @nodoc
class _$HomeConfigurationModelCopyWithImpl<
  $Res,
  $Val extends HomeConfigurationModel
>
    implements $HomeConfigurationModelCopyWith<$Res> {
  _$HomeConfigurationModelCopyWithImpl(
    this._value,
    this._then,
  );

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeConfigurationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? showLocation = null}) {
    return _then(
      _value.copyWith(
            showLocation:
                null == showLocation
                    ? _value.showLocation
                    : showLocation // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeConfigurationModelImplCopyWith<$Res>
    implements $HomeConfigurationModelCopyWith<$Res> {
  factory _$$HomeConfigurationModelImplCopyWith(
    _$HomeConfigurationModelImpl value,
    $Res Function(_$HomeConfigurationModelImpl) then,
  ) = __$$HomeConfigurationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool showLocation});
}

/// @nodoc
class __$$HomeConfigurationModelImplCopyWithImpl<$Res>
    extends
        _$HomeConfigurationModelCopyWithImpl<
          $Res,
          _$HomeConfigurationModelImpl
        >
    implements _$$HomeConfigurationModelImplCopyWith<$Res> {
  __$$HomeConfigurationModelImplCopyWithImpl(
    _$HomeConfigurationModelImpl _value,
    $Res Function(_$HomeConfigurationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeConfigurationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? showLocation = null}) {
    return _then(
      _$HomeConfigurationModelImpl(
        showLocation:
            null == showLocation
                ? _value.showLocation
                : showLocation // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeConfigurationModelImpl
    implements _HomeConfigurationModel {
  const _$HomeConfigurationModelImpl({
    this.showLocation = false,
  });

  factory _$HomeConfigurationModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$HomeConfigurationModelImplFromJson(json);

  /// 位置情報を表示するかどうか
  @override
  @JsonKey()
  final bool showLocation;

  @override
  String toString() {
    return 'HomeConfigurationModel(showLocation: $showLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeConfigurationModelImpl &&
            (identical(other.showLocation, showLocation) ||
                other.showLocation == showLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, showLocation);

  /// Create a copy of HomeConfigurationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeConfigurationModelImplCopyWith<
    _$HomeConfigurationModelImpl
  >
  get copyWith =>
      __$$HomeConfigurationModelImplCopyWithImpl<
        _$HomeConfigurationModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeConfigurationModelImplToJson(this);
  }
}

abstract class _HomeConfigurationModel
    implements HomeConfigurationModel {
  const factory _HomeConfigurationModel({
    final bool showLocation,
  }) = _$HomeConfigurationModelImpl;

  factory _HomeConfigurationModel.fromJson(
    Map<String, dynamic> json,
  ) = _$HomeConfigurationModelImpl.fromJson;

  /// 位置情報を表示するかどうか
  @override
  bool get showLocation;

  /// Create a copy of HomeConfigurationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeConfigurationModelImplCopyWith<
    _$HomeConfigurationModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
