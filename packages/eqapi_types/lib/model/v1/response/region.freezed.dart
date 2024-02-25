// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegionItem _$RegionItemFromJson(Map<String, dynamic> json) {
  return _RegionItem.fromJson(json);
}

/// @nodoc
mixin _$RegionItem {
  int get id => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  String get areaCode => throw _privateConstructorUsedError;
  JmaIntensity get maxIntensity => throw _privateConstructorUsedError;
  JmaLgIntensity? get maxLpgmIntensity => throw _privateConstructorUsedError;
  EarthquakeV1Base get earthquake => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegionItemCopyWith<RegionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionItemCopyWith<$Res> {
  factory $RegionItemCopyWith(
          RegionItem value, $Res Function(RegionItem) then) =
      _$RegionItemCopyWithImpl<$Res, RegionItem>;
  @useResult
  $Res call(
      {int id,
      int eventId,
      String areaCode,
      JmaIntensity maxIntensity,
      JmaLgIntensity? maxLpgmIntensity,
      EarthquakeV1Base earthquake});

  $EarthquakeV1BaseCopyWith<$Res> get earthquake;
}

/// @nodoc
class _$RegionItemCopyWithImpl<$Res, $Val extends RegionItem>
    implements $RegionItemCopyWith<$Res> {
  _$RegionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? areaCode = null,
    Object? maxIntensity = null,
    Object? maxLpgmIntensity = freezed,
    Object? earthquake = null,
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
      areaCode: null == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String,
      maxIntensity: null == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeV1Base,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeV1BaseCopyWith<$Res> get earthquake {
    return $EarthquakeV1BaseCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RegionItemImplCopyWith<$Res>
    implements $RegionItemCopyWith<$Res> {
  factory _$$RegionItemImplCopyWith(
          _$RegionItemImpl value, $Res Function(_$RegionItemImpl) then) =
      __$$RegionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int eventId,
      String areaCode,
      JmaIntensity maxIntensity,
      JmaLgIntensity? maxLpgmIntensity,
      EarthquakeV1Base earthquake});

  @override
  $EarthquakeV1BaseCopyWith<$Res> get earthquake;
}

/// @nodoc
class __$$RegionItemImplCopyWithImpl<$Res>
    extends _$RegionItemCopyWithImpl<$Res, _$RegionItemImpl>
    implements _$$RegionItemImplCopyWith<$Res> {
  __$$RegionItemImplCopyWithImpl(
      _$RegionItemImpl _value, $Res Function(_$RegionItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? areaCode = null,
    Object? maxIntensity = null,
    Object? maxLpgmIntensity = freezed,
    Object? earthquake = null,
  }) {
    return _then(_$RegionItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      areaCode: null == areaCode
          ? _value.areaCode
          : areaCode // ignore: cast_nullable_to_non_nullable
              as String,
      maxIntensity: null == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as JmaIntensity,
      maxLpgmIntensity: freezed == maxLpgmIntensity
          ? _value.maxLpgmIntensity
          : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
              as JmaLgIntensity?,
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeV1Base,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionItemImpl implements _RegionItem {
  const _$RegionItemImpl(
      {required this.id,
      required this.eventId,
      required this.areaCode,
      required this.maxIntensity,
      required this.maxLpgmIntensity,
      required this.earthquake});

  factory _$RegionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionItemImplFromJson(json);

  @override
  final int id;
  @override
  final int eventId;
  @override
  final String areaCode;
  @override
  final JmaIntensity maxIntensity;
  @override
  final JmaLgIntensity? maxLpgmIntensity;
  @override
  final EarthquakeV1Base earthquake;

  @override
  String toString() {
    return 'RegionItem(id: $id, eventId: $eventId, areaCode: $areaCode, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, earthquake: $earthquake)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.areaCode, areaCode) ||
                other.areaCode == areaCode) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            (identical(other.maxLpgmIntensity, maxLpgmIntensity) ||
                other.maxLpgmIntensity == maxLpgmIntensity) &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, eventId, areaCode,
      maxIntensity, maxLpgmIntensity, earthquake);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionItemImplCopyWith<_$RegionItemImpl> get copyWith =>
      __$$RegionItemImplCopyWithImpl<_$RegionItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionItemImplToJson(
      this,
    );
  }
}

abstract class _RegionItem implements RegionItem {
  const factory _RegionItem(
      {required final int id,
      required final int eventId,
      required final String areaCode,
      required final JmaIntensity maxIntensity,
      required final JmaLgIntensity? maxLpgmIntensity,
      required final EarthquakeV1Base earthquake}) = _$RegionItemImpl;

  factory _RegionItem.fromJson(Map<String, dynamic> json) =
      _$RegionItemImpl.fromJson;

  @override
  int get id;
  @override
  int get eventId;
  @override
  String get areaCode;
  @override
  JmaIntensity get maxIntensity;
  @override
  JmaLgIntensity? get maxLpgmIntensity;
  @override
  EarthquakeV1Base get earthquake;
  @override
  @JsonKey(ignore: true)
  _$$RegionItemImplCopyWith<_$RegionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
