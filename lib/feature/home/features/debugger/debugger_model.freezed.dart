// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debugger_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DebuggerModel _$DebuggerModelFromJson(Map<String, dynamic> json) {
  return _DebuggerModel.fromJson(json);
}

/// @nodoc
mixin _$DebuggerModel {
  bool get isDebugger => throw _privateConstructorUsedError;
  bool get isDeveloper => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DebuggerModelCopyWith<DebuggerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DebuggerModelCopyWith<$Res> {
  factory $DebuggerModelCopyWith(
          DebuggerModel value, $Res Function(DebuggerModel) then) =
      _$DebuggerModelCopyWithImpl<$Res, DebuggerModel>;
  @useResult
  $Res call({bool isDebugger, bool isDeveloper});
}

/// @nodoc
class _$DebuggerModelCopyWithImpl<$Res, $Val extends DebuggerModel>
    implements $DebuggerModelCopyWith<$Res> {
  _$DebuggerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDebugger = null,
    Object? isDeveloper = null,
  }) {
    return _then(_value.copyWith(
      isDebugger: null == isDebugger
          ? _value.isDebugger
          : isDebugger // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeveloper: null == isDeveloper
          ? _value.isDeveloper
          : isDeveloper // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DebuggerModelCopyWith<$Res>
    implements $DebuggerModelCopyWith<$Res> {
  factory _$$_DebuggerModelCopyWith(
          _$_DebuggerModel value, $Res Function(_$_DebuggerModel) then) =
      __$$_DebuggerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isDebugger, bool isDeveloper});
}

/// @nodoc
class __$$_DebuggerModelCopyWithImpl<$Res>
    extends _$DebuggerModelCopyWithImpl<$Res, _$_DebuggerModel>
    implements _$$_DebuggerModelCopyWith<$Res> {
  __$$_DebuggerModelCopyWithImpl(
      _$_DebuggerModel _value, $Res Function(_$_DebuggerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDebugger = null,
    Object? isDeveloper = null,
  }) {
    return _then(_$_DebuggerModel(
      isDebugger: null == isDebugger
          ? _value.isDebugger
          : isDebugger // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeveloper: null == isDeveloper
          ? _value.isDeveloper
          : isDeveloper // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DebuggerModel implements _DebuggerModel {
  const _$_DebuggerModel({this.isDebugger = false, this.isDeveloper = false});

  factory _$_DebuggerModel.fromJson(Map<String, dynamic> json) =>
      _$$_DebuggerModelFromJson(json);

  @override
  @JsonKey()
  final bool isDebugger;
  @override
  @JsonKey()
  final bool isDeveloper;

  @override
  String toString() {
    return 'DebuggerModel(isDebugger: $isDebugger, isDeveloper: $isDeveloper)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DebuggerModel &&
            (identical(other.isDebugger, isDebugger) ||
                other.isDebugger == isDebugger) &&
            (identical(other.isDeveloper, isDeveloper) ||
                other.isDeveloper == isDeveloper));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isDebugger, isDeveloper);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DebuggerModelCopyWith<_$_DebuggerModel> get copyWith =>
      __$$_DebuggerModelCopyWithImpl<_$_DebuggerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DebuggerModelToJson(
      this,
    );
  }
}

abstract class _DebuggerModel implements DebuggerModel {
  const factory _DebuggerModel(
      {final bool isDebugger, final bool isDeveloper}) = _$_DebuggerModel;

  factory _DebuggerModel.fromJson(Map<String, dynamic> json) =
      _$_DebuggerModel.fromJson;

  @override
  bool get isDebugger;
  @override
  bool get isDeveloper;
  @override
  @JsonKey(ignore: true)
  _$$_DebuggerModelCopyWith<_$_DebuggerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
