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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$DebuggerModelImplCopyWith<$Res>
    implements $DebuggerModelCopyWith<$Res> {
  factory _$$DebuggerModelImplCopyWith(
          _$DebuggerModelImpl value, $Res Function(_$DebuggerModelImpl) then) =
      __$$DebuggerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isDebugger, bool isDeveloper});
}

/// @nodoc
class __$$DebuggerModelImplCopyWithImpl<$Res>
    extends _$DebuggerModelCopyWithImpl<$Res, _$DebuggerModelImpl>
    implements _$$DebuggerModelImplCopyWith<$Res> {
  __$$DebuggerModelImplCopyWithImpl(
      _$DebuggerModelImpl _value, $Res Function(_$DebuggerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDebugger = null,
    Object? isDeveloper = null,
  }) {
    return _then(_$DebuggerModelImpl(
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
class _$DebuggerModelImpl implements _DebuggerModel {
  const _$DebuggerModelImpl(
      {this.isDebugger = false, this.isDeveloper = false});

  factory _$DebuggerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DebuggerModelImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DebuggerModelImpl &&
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
  _$$DebuggerModelImplCopyWith<_$DebuggerModelImpl> get copyWith =>
      __$$DebuggerModelImplCopyWithImpl<_$DebuggerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DebuggerModelImplToJson(
      this,
    );
  }
}

abstract class _DebuggerModel implements DebuggerModel {
  const factory _DebuggerModel(
      {final bool isDebugger, final bool isDeveloper}) = _$DebuggerModelImpl;

  factory _DebuggerModel.fromJson(Map<String, dynamic> json) =
      _$DebuggerModelImpl.fromJson;

  @override
  bool get isDebugger;
  @override
  bool get isDeveloper;
  @override
  @JsonKey(ignore: true)
  _$$DebuggerModelImplCopyWith<_$DebuggerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
