// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_sub_division.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IntensitySubDivision _$IntensitySubDivisionFromJson(Map<String, dynamic> json) {
  return _IntensitySubDivision.fromJson(json);
}

/// @nodoc
mixin _$IntensitySubDivision {
  int get id => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  JmaIntensity get maxIntensity => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLpgmIntensity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntensitySubDivisionCopyWith<IntensitySubDivision> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntensitySubDivisionCopyWith<$Res> {
  factory $IntensitySubDivisionCopyWith(IntensitySubDivision value,
          $Res Function(IntensitySubDivision) then) =
      _$IntensitySubDivisionCopyWithImpl<$Res, IntensitySubDivision>;
  @useResult
  $Res call(
      {int id,
      int eventId,
      JmaIntensity maxIntensity,
      JmaLgIntensity? maxLpgmIntensity});
}

/// @nodoc
class _$IntensitySubDivisionCopyWithImpl<$Res,
        $Val extends IntensitySubDivision>
    implements $IntensitySubDivisionCopyWith<$Res> {
  _$IntensitySubDivisionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? maxIntensity = null,
    Object? maxLpgmIntensity = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      maxIntensity: null == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntensitySubDivisionImplCopyWith<$Res>
    implements $IntensitySubDivisionCopyWith<$Res> {
  factory _$$IntensitySubDivisionImplCopyWith(_$IntensitySubDivisionImpl value,
          $Res Function(_$IntensitySubDivisionImpl) then) =
      __$$IntensitySubDivisionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int eventId,
      JmaIntensity maxIntensity,
      JmaLgIntensity? maxLpgmIntensity});
}

/// @nodoc
class __$$IntensitySubDivisionImplCopyWithImpl<$Res>
    extends _$IntensitySubDivisionCopyWithImpl<$Res, _$IntensitySubDivisionImpl>
    implements _$$IntensitySubDivisionImplCopyWith<$Res> {
  __$$IntensitySubDivisionImplCopyWithImpl(_$IntensitySubDivisionImpl _value,
      $Res Function(_$IntensitySubDivisionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? maxIntensity = null,
    Object? maxLpgmIntensity = freezed,
  }) {
    return _then(_$IntensitySubDivisionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      maxIntensity: null == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntensitySubDivisionImpl implements _IntensitySubDivision {
  const _$IntensitySubDivisionImpl(
      {required this.id,
      required this.eventId,
      required this.maxIntensity,
      required this.maxLpgmIntensity});

  factory _$IntensitySubDivisionImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntensitySubDivisionImplFromJson(json);

  @override
  final int id;
  @override
  final int eventId;
  @override
  final JmaIntensity maxIntensity;
  @override
  final JmaLgIntensity? maxLpgmIntensity;

  @override
  String toString() {
    return 'IntensitySubDivision(id: $id, eventId: $eventId, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntensitySubDivisionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            (identical(other.maxLpgmIntensity, maxLpgmIntensity) ||
                other.maxLpgmIntensity == maxLpgmIntensity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, eventId, maxIntensity, maxLpgmIntensity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntensitySubDivisionImplCopyWith<_$IntensitySubDivisionImpl>
      get copyWith =>
          __$$IntensitySubDivisionImplCopyWithImpl<_$IntensitySubDivisionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntensitySubDivisionImplToJson(
      this,
    );
  }
}

abstract class _IntensitySubDivision implements IntensitySubDivision {
  const factory _IntensitySubDivision(
          {required final int id,
          required final int eventId,
          required final JmaIntensity maxIntensity,
          required final JmaLgIntensity? maxLpgmIntensity}) =
      _$IntensitySubDivisionImpl;

  factory _IntensitySubDivision.fromJson(Map<String, dynamic> json) =
      _$IntensitySubDivisionImpl.fromJson;

  @override
  int get id;
  @override
  int get eventId;
  @override
  JmaIntensity get maxIntensity;
  @override
  JmaLgIntensity? get maxLpgmIntensity;
  @override
  @JsonKey(ignore: true)
  _$$IntensitySubDivisionImplCopyWith<_$IntensitySubDivisionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
