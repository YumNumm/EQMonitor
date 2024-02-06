// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EarthquakeHistoryItem _$EarthquakeHistoryItemFromJson(
    Map<String, dynamic> json) {
  return _EarthquakeHistoryItem.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeHistoryItem {
  EarthquakeData get earthquake => throw _privateConstructorUsedError;
  TsunamiData? get tsunami => throw _privateConstructorUsedError;
  List<TelegramV3> get telegrams => throw _privateConstructorUsedError;
  int get eventId => throw _privateConstructorUsedError;
  Vxse45? get latestEew => throw _privateConstructorUsedError;
  TelegramV3? get latestEewTelegram => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeHistoryItemCopyWith<EarthquakeHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeHistoryItemCopyWith<$Res> {
  factory $EarthquakeHistoryItemCopyWith(EarthquakeHistoryItem value,
          $Res Function(EarthquakeHistoryItem) then) =
      _$EarthquakeHistoryItemCopyWithImpl<$Res, EarthquakeHistoryItem>;
  @useResult
  $Res call(
      {EarthquakeData earthquake,
      TsunamiData? tsunami,
      List<TelegramV3> telegrams,
      int eventId,
      Vxse45? latestEew,
      TelegramV3? latestEewTelegram});

  $EarthquakeDataCopyWith<$Res> get earthquake;
  $TsunamiDataCopyWith<$Res>? get tsunami;
}

/// @nodoc
class _$EarthquakeHistoryItemCopyWithImpl<$Res,
        $Val extends EarthquakeHistoryItem>
    implements $EarthquakeHistoryItemCopyWith<$Res> {
  _$EarthquakeHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? tsunami = freezed,
    Object? telegrams = null,
    Object? eventId = null,
    Object? latestEew = freezed,
    Object? latestEewTelegram = freezed,
  }) {
    return _then(_value.copyWith(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeData,
      tsunami: freezed == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as TsunamiData?,
      telegrams: null == telegrams
          ? _value.telegrams
          : telegrams // ignore: cast_nullable_to_non_nullable
              as List<TelegramV3>,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      latestEew: freezed == latestEew
          ? _value.latestEew
          : latestEew // ignore: cast_nullable_to_non_nullable
              as Vxse45?,
      latestEewTelegram: freezed == latestEewTelegram
          ? _value.latestEewTelegram
          : latestEewTelegram // ignore: cast_nullable_to_non_nullable
              as TelegramV3?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeDataCopyWith<$Res> get earthquake {
    return $EarthquakeDataCopyWith<$Res>(_value.earthquake, (value) {
      return _then(_value.copyWith(earthquake: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TsunamiDataCopyWith<$Res>? get tsunami {
    if (_value.tsunami == null) {
      return null;
    }

    return $TsunamiDataCopyWith<$Res>(_value.tsunami!, (value) {
      return _then(_value.copyWith(tsunami: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeHistoryItemImplCopyWith<$Res>
    implements $EarthquakeHistoryItemCopyWith<$Res> {
  factory _$$EarthquakeHistoryItemImplCopyWith(
          _$EarthquakeHistoryItemImpl value,
          $Res Function(_$EarthquakeHistoryItemImpl) then) =
      __$$EarthquakeHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EarthquakeData earthquake,
      TsunamiData? tsunami,
      List<TelegramV3> telegrams,
      int eventId,
      Vxse45? latestEew,
      TelegramV3? latestEewTelegram});

  @override
  $EarthquakeDataCopyWith<$Res> get earthquake;
  @override
  $TsunamiDataCopyWith<$Res>? get tsunami;
}

/// @nodoc
class __$$EarthquakeHistoryItemImplCopyWithImpl<$Res>
    extends _$EarthquakeHistoryItemCopyWithImpl<$Res,
        _$EarthquakeHistoryItemImpl>
    implements _$$EarthquakeHistoryItemImplCopyWith<$Res> {
  __$$EarthquakeHistoryItemImplCopyWithImpl(_$EarthquakeHistoryItemImpl _value,
      $Res Function(_$EarthquakeHistoryItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = null,
    Object? tsunami = freezed,
    Object? telegrams = null,
    Object? eventId = null,
    Object? latestEew = freezed,
    Object? latestEewTelegram = freezed,
  }) {
    return _then(_$EarthquakeHistoryItemImpl(
      earthquake: null == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as EarthquakeData,
      tsunami: freezed == tsunami
          ? _value.tsunami
          : tsunami // ignore: cast_nullable_to_non_nullable
              as TsunamiData?,
      telegrams: null == telegrams
          ? _value._telegrams
          : telegrams // ignore: cast_nullable_to_non_nullable
              as List<TelegramV3>,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int,
      latestEew: freezed == latestEew
          ? _value.latestEew
          : latestEew // ignore: cast_nullable_to_non_nullable
              as Vxse45?,
      latestEewTelegram: freezed == latestEewTelegram
          ? _value.latestEewTelegram
          : latestEewTelegram // ignore: cast_nullable_to_non_nullable
              as TelegramV3?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeHistoryItemImpl implements _EarthquakeHistoryItem {
  const _$EarthquakeHistoryItemImpl(
      {required this.earthquake,
      required this.tsunami,
      required final List<TelegramV3> telegrams,
      required this.eventId,
      required this.latestEew,
      required this.latestEewTelegram})
      : _telegrams = telegrams;

  factory _$EarthquakeHistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeHistoryItemImplFromJson(json);

  @override
  final EarthquakeData earthquake;
  @override
  final TsunamiData? tsunami;
  final List<TelegramV3> _telegrams;
  @override
  List<TelegramV3> get telegrams {
    if (_telegrams is EqualUnmodifiableListView) return _telegrams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_telegrams);
  }

  @override
  final int eventId;
  @override
  final Vxse45? latestEew;
  @override
  final TelegramV3? latestEewTelegram;

  @override
  String toString() {
    return 'EarthquakeHistoryItem(earthquake: $earthquake, tsunami: $tsunami, telegrams: $telegrams, eventId: $eventId, latestEew: $latestEew, latestEewTelegram: $latestEewTelegram)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeHistoryItemImpl &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.tsunami, tsunami) || other.tsunami == tsunami) &&
            const DeepCollectionEquality()
                .equals(other._telegrams, _telegrams) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.latestEew, latestEew) ||
                other.latestEew == latestEew) &&
            (identical(other.latestEewTelegram, latestEewTelegram) ||
                other.latestEewTelegram == latestEewTelegram));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      earthquake,
      tsunami,
      const DeepCollectionEquality().hash(_telegrams),
      eventId,
      latestEew,
      latestEewTelegram);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeHistoryItemImplCopyWith<_$EarthquakeHistoryItemImpl>
      get copyWith => __$$EarthquakeHistoryItemImplCopyWithImpl<
          _$EarthquakeHistoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeHistoryItemImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeHistoryItem implements EarthquakeHistoryItem {
  const factory _EarthquakeHistoryItem(
          {required final EarthquakeData earthquake,
          required final TsunamiData? tsunami,
          required final List<TelegramV3> telegrams,
          required final int eventId,
          required final Vxse45? latestEew,
          required final TelegramV3? latestEewTelegram}) =
      _$EarthquakeHistoryItemImpl;

  factory _EarthquakeHistoryItem.fromJson(Map<String, dynamic> json) =
      _$EarthquakeHistoryItemImpl.fromJson;

  @override
  EarthquakeData get earthquake;
  @override
  TsunamiData? get tsunami;
  @override
  List<TelegramV3> get telegrams;
  @override
  int get eventId;
  @override
  Vxse45? get latestEew;
  @override
  TelegramV3? get latestEewTelegram;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeHistoryItemImplCopyWith<_$EarthquakeHistoryItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EarthquakeData _$EarthquakeDataFromJson(Map<String, dynamic> json) {
  return _EarthquakeData.fromJson(json);
}

/// @nodoc
mixin _$EarthquakeData {
  Earthquake? get earthquake => throw _privateConstructorUsedError;
  Intensity? get intensity => throw _privateConstructorUsedError;
  Intensity? get lgIntensity => throw _privateConstructorUsedError;
  CommentsOmitVar? get comment => throw _privateConstructorUsedError;
  bool get isVolcano => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EarthquakeDataCopyWith<EarthquakeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EarthquakeDataCopyWith<$Res> {
  factory $EarthquakeDataCopyWith(
          EarthquakeData value, $Res Function(EarthquakeData) then) =
      _$EarthquakeDataCopyWithImpl<$Res, EarthquakeData>;
  @useResult
  $Res call(
      {Earthquake? earthquake,
      Intensity? intensity,
      Intensity? lgIntensity,
      CommentsOmitVar? comment,
      bool isVolcano});

  $EarthquakeCopyWith<$Res>? get earthquake;
  $IntensityCopyWith<$Res>? get intensity;
  $IntensityCopyWith<$Res>? get lgIntensity;
  $CommentsOmitVarCopyWith<$Res>? get comment;
}

/// @nodoc
class _$EarthquakeDataCopyWithImpl<$Res, $Val extends EarthquakeData>
    implements $EarthquakeDataCopyWith<$Res> {
  _$EarthquakeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = freezed,
    Object? intensity = freezed,
    Object? lgIntensity = freezed,
    Object? comment = freezed,
    Object? isVolcano = null,
  }) {
    return _then(_value.copyWith(
      earthquake: freezed == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      lgIntensity: freezed == lgIntensity
          ? _value.lgIntensity
          : lgIntensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar?,
      isVolcano: null == isVolcano
          ? _value.isVolcano
          : isVolcano // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EarthquakeCopyWith<$Res>? get earthquake {
    if (_value.earthquake == null) {
      return null;
    }

    return $EarthquakeCopyWith<$Res>(_value.earthquake!, (value) {
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
  $IntensityCopyWith<$Res>? get lgIntensity {
    if (_value.lgIntensity == null) {
      return null;
    }

    return $IntensityCopyWith<$Res>(_value.lgIntensity!, (value) {
      return _then(_value.copyWith(lgIntensity: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CommentsOmitVarCopyWith<$Res>? get comment {
    if (_value.comment == null) {
      return null;
    }

    return $CommentsOmitVarCopyWith<$Res>(_value.comment!, (value) {
      return _then(_value.copyWith(comment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EarthquakeDataImplCopyWith<$Res>
    implements $EarthquakeDataCopyWith<$Res> {
  factory _$$EarthquakeDataImplCopyWith(_$EarthquakeDataImpl value,
          $Res Function(_$EarthquakeDataImpl) then) =
      __$$EarthquakeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Earthquake? earthquake,
      Intensity? intensity,
      Intensity? lgIntensity,
      CommentsOmitVar? comment,
      bool isVolcano});

  @override
  $EarthquakeCopyWith<$Res>? get earthquake;
  @override
  $IntensityCopyWith<$Res>? get intensity;
  @override
  $IntensityCopyWith<$Res>? get lgIntensity;
  @override
  $CommentsOmitVarCopyWith<$Res>? get comment;
}

/// @nodoc
class __$$EarthquakeDataImplCopyWithImpl<$Res>
    extends _$EarthquakeDataCopyWithImpl<$Res, _$EarthquakeDataImpl>
    implements _$$EarthquakeDataImplCopyWith<$Res> {
  __$$EarthquakeDataImplCopyWithImpl(
      _$EarthquakeDataImpl _value, $Res Function(_$EarthquakeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? earthquake = freezed,
    Object? intensity = freezed,
    Object? lgIntensity = freezed,
    Object? comment = freezed,
    Object? isVolcano = null,
  }) {
    return _then(_$EarthquakeDataImpl(
      earthquake: freezed == earthquake
          ? _value.earthquake
          : earthquake // ignore: cast_nullable_to_non_nullable
              as Earthquake?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      lgIntensity: freezed == lgIntensity
          ? _value.lgIntensity
          : lgIntensity // ignore: cast_nullable_to_non_nullable
              as Intensity?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as CommentsOmitVar?,
      isVolcano: null == isVolcano
          ? _value.isVolcano
          : isVolcano // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EarthquakeDataImpl implements _EarthquakeData {
  const _$EarthquakeDataImpl(
      {required this.earthquake,
      required this.intensity,
      required this.lgIntensity,
      required this.comment,
      required this.isVolcano});

  factory _$EarthquakeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$EarthquakeDataImplFromJson(json);

  @override
  final Earthquake? earthquake;
  @override
  final Intensity? intensity;
  @override
  final Intensity? lgIntensity;
  @override
  final CommentsOmitVar? comment;
  @override
  final bool isVolcano;

  @override
  String toString() {
    return 'EarthquakeData(earthquake: $earthquake, intensity: $intensity, lgIntensity: $lgIntensity, comment: $comment, isVolcano: $isVolcano)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EarthquakeDataImpl &&
            (identical(other.earthquake, earthquake) ||
                other.earthquake == earthquake) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.lgIntensity, lgIntensity) ||
                other.lgIntensity == lgIntensity) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isVolcano, isVolcano) ||
                other.isVolcano == isVolcano));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, earthquake, intensity, lgIntensity, comment, isVolcano);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EarthquakeDataImplCopyWith<_$EarthquakeDataImpl> get copyWith =>
      __$$EarthquakeDataImplCopyWithImpl<_$EarthquakeDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EarthquakeDataImplToJson(
      this,
    );
  }
}

abstract class _EarthquakeData implements EarthquakeData {
  const factory _EarthquakeData(
      {required final Earthquake? earthquake,
      required final Intensity? intensity,
      required final Intensity? lgIntensity,
      required final CommentsOmitVar? comment,
      required final bool isVolcano}) = _$EarthquakeDataImpl;

  factory _EarthquakeData.fromJson(Map<String, dynamic> json) =
      _$EarthquakeDataImpl.fromJson;

  @override
  Earthquake? get earthquake;
  @override
  Intensity? get intensity;
  @override
  Intensity? get lgIntensity;
  @override
  CommentsOmitVar? get comment;
  @override
  bool get isVolcano;
  @override
  @JsonKey(ignore: true)
  _$$EarthquakeDataImplCopyWith<_$EarthquakeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TsunamiData _$TsunamiDataFromJson(Map<String, dynamic> json) {
  return _TsunamiData.fromJson(json);
}

/// @nodoc
mixin _$TsunamiData {
  List<TsunamiForecast>? get forecasts => throw _privateConstructorUsedError;
  List<TsunamiEstimation>? get estimations =>
      throw _privateConstructorUsedError;
  List<TsunamiObservation>? get observations =>
      throw _privateConstructorUsedError;
  TsunamiComments? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TsunamiDataCopyWith<TsunamiData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TsunamiDataCopyWith<$Res> {
  factory $TsunamiDataCopyWith(
          TsunamiData value, $Res Function(TsunamiData) then) =
      _$TsunamiDataCopyWithImpl<$Res, TsunamiData>;
  @useResult
  $Res call(
      {List<TsunamiForecast>? forecasts,
      List<TsunamiEstimation>? estimations,
      List<TsunamiObservation>? observations,
      TsunamiComments? comments});

  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class _$TsunamiDataCopyWithImpl<$Res, $Val extends TsunamiData>
    implements $TsunamiDataCopyWith<$Res> {
  _$TsunamiDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = freezed,
    Object? estimations = freezed,
    Object? observations = freezed,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      forecasts: freezed == forecasts
          ? _value.forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>?,
      estimations: freezed == estimations
          ? _value.estimations
          : estimations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiEstimation>?,
      observations: freezed == observations
          ? _value.observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservation>?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ) as $Val);
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
abstract class _$$TsunamiDataImplCopyWith<$Res>
    implements $TsunamiDataCopyWith<$Res> {
  factory _$$TsunamiDataImplCopyWith(
          _$TsunamiDataImpl value, $Res Function(_$TsunamiDataImpl) then) =
      __$$TsunamiDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TsunamiForecast>? forecasts,
      List<TsunamiEstimation>? estimations,
      List<TsunamiObservation>? observations,
      TsunamiComments? comments});

  @override
  $TsunamiCommentsCopyWith<$Res>? get comments;
}

/// @nodoc
class __$$TsunamiDataImplCopyWithImpl<$Res>
    extends _$TsunamiDataCopyWithImpl<$Res, _$TsunamiDataImpl>
    implements _$$TsunamiDataImplCopyWith<$Res> {
  __$$TsunamiDataImplCopyWithImpl(
      _$TsunamiDataImpl _value, $Res Function(_$TsunamiDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? forecasts = freezed,
    Object? estimations = freezed,
    Object? observations = freezed,
    Object? comments = freezed,
  }) {
    return _then(_$TsunamiDataImpl(
      forecasts: freezed == forecasts
          ? _value._forecasts
          : forecasts // ignore: cast_nullable_to_non_nullable
              as List<TsunamiForecast>?,
      estimations: freezed == estimations
          ? _value._estimations
          : estimations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiEstimation>?,
      observations: freezed == observations
          ? _value._observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<TsunamiObservation>?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as TsunamiComments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TsunamiDataImpl implements _TsunamiData {
  const _$TsunamiDataImpl(
      {required final List<TsunamiForecast>? forecasts,
      required final List<TsunamiEstimation>? estimations,
      required final List<TsunamiObservation>? observations,
      required this.comments})
      : _forecasts = forecasts,
        _estimations = estimations,
        _observations = observations;

  factory _$TsunamiDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TsunamiDataImplFromJson(json);

  final List<TsunamiForecast>? _forecasts;
  @override
  List<TsunamiForecast>? get forecasts {
    final value = _forecasts;
    if (value == null) return null;
    if (_forecasts is EqualUnmodifiableListView) return _forecasts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TsunamiEstimation>? _estimations;
  @override
  List<TsunamiEstimation>? get estimations {
    final value = _estimations;
    if (value == null) return null;
    if (_estimations is EqualUnmodifiableListView) return _estimations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TsunamiObservation>? _observations;
  @override
  List<TsunamiObservation>? get observations {
    final value = _observations;
    if (value == null) return null;
    if (_observations is EqualUnmodifiableListView) return _observations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final TsunamiComments? comments;

  @override
  String toString() {
    return 'TsunamiData(forecasts: $forecasts, estimations: $estimations, observations: $observations, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TsunamiDataImpl &&
            const DeepCollectionEquality()
                .equals(other._forecasts, _forecasts) &&
            const DeepCollectionEquality()
                .equals(other._estimations, _estimations) &&
            const DeepCollectionEquality()
                .equals(other._observations, _observations) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_forecasts),
      const DeepCollectionEquality().hash(_estimations),
      const DeepCollectionEquality().hash(_observations),
      comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TsunamiDataImplCopyWith<_$TsunamiDataImpl> get copyWith =>
      __$$TsunamiDataImplCopyWithImpl<_$TsunamiDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TsunamiDataImplToJson(
      this,
    );
  }
}

abstract class _TsunamiData implements TsunamiData {
  const factory _TsunamiData(
      {required final List<TsunamiForecast>? forecasts,
      required final List<TsunamiEstimation>? estimations,
      required final List<TsunamiObservation>? observations,
      required final TsunamiComments? comments}) = _$TsunamiDataImpl;

  factory _TsunamiData.fromJson(Map<String, dynamic> json) =
      _$TsunamiDataImpl.fromJson;

  @override
  List<TsunamiForecast>? get forecasts;
  @override
  List<TsunamiEstimation>? get estimations;
  @override
  List<TsunamiObservation>? get observations;
  @override
  TsunamiComments? get comments;
  @override
  @JsonKey(ignore: true)
  _$$TsunamiDataImplCopyWith<_$TsunamiDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
