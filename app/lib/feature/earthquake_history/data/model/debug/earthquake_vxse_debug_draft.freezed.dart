// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_vxse_debug_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
EarthquakeVxseDebugDraft _$EarthquakeVxseDebugDraftFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'VXSE51':
          return EarthquakeVxse51DebugDraft.fromJson(
            json
          );
                case 'VXSE52':
          return EarthquakeVxse52DebugDraft.fromJson(
            json
          );
                case 'VXSE53':
          return EarthquakeVxse53DebugDraft.fromJson(
            json
          );
                case 'VXSE61':
          return EarthquakeVxse61DebugDraft.fromJson(
            json
          );
                case 'VXSE62':
          return EarthquakeVxse62DebugDraft.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'EarthquakeVxseDebugDraft',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$EarthquakeVxseDebugDraft {

 String get eventId; DateTime get reportedAt; TelegramStatus get status; List<EarthquakeTelegramComment> get comments;
/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeVxseDebugDraftCopyWith<EarthquakeVxseDebugDraft> get copyWith => _$EarthquakeVxseDebugDraftCopyWithImpl<EarthquakeVxseDebugDraft>(this as EarthquakeVxseDebugDraft, _$identity);

  /// Serializes this EarthquakeVxseDebugDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeVxseDebugDraft&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.comments, comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,reportedAt,status,const DeepCollectionEquality().hash(comments));

@override
String toString() {
  return 'EarthquakeVxseDebugDraft(eventId: $eventId, reportedAt: $reportedAt, status: $status, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeVxseDebugDraftCopyWith<$Res>  {
  factory $EarthquakeVxseDebugDraftCopyWith(EarthquakeVxseDebugDraft value, $Res Function(EarthquakeVxseDebugDraft) _then) = _$EarthquakeVxseDebugDraftCopyWithImpl;
@useResult
$Res call({
 String eventId, DateTime reportedAt, TelegramStatus status, List<EarthquakeTelegramComment> comments
});




}
/// @nodoc
class _$EarthquakeVxseDebugDraftCopyWithImpl<$Res>
    implements $EarthquakeVxseDebugDraftCopyWith<$Res> {
  _$EarthquakeVxseDebugDraftCopyWithImpl(this._self, this._then);

  final EarthquakeVxseDebugDraft _self;
  final $Res Function(EarthquakeVxseDebugDraft) _then;

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? reportedAt = null,Object? status = null,Object? comments = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeVxseDebugDraft].
extension EarthquakeVxseDebugDraftPatterns on EarthquakeVxseDebugDraft {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakeVxse51DebugDraft value)?  vxse51,TResult Function( EarthquakeVxse52DebugDraft value)?  vxse52,TResult Function( EarthquakeVxse53DebugDraft value)?  vxse53,TResult Function( EarthquakeVxse61DebugDraft value)?  vxse61,TResult Function( EarthquakeVxse62DebugDraft value)?  vxse62,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakeVxse51DebugDraft() when vxse51 != null:
return vxse51(_that);case EarthquakeVxse52DebugDraft() when vxse52 != null:
return vxse52(_that);case EarthquakeVxse53DebugDraft() when vxse53 != null:
return vxse53(_that);case EarthquakeVxse61DebugDraft() when vxse61 != null:
return vxse61(_that);case EarthquakeVxse62DebugDraft() when vxse62 != null:
return vxse62(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakeVxse51DebugDraft value)  vxse51,required TResult Function( EarthquakeVxse52DebugDraft value)  vxse52,required TResult Function( EarthquakeVxse53DebugDraft value)  vxse53,required TResult Function( EarthquakeVxse61DebugDraft value)  vxse61,required TResult Function( EarthquakeVxse62DebugDraft value)  vxse62,}){
final _that = this;
switch (_that) {
case EarthquakeVxse51DebugDraft():
return vxse51(_that);case EarthquakeVxse52DebugDraft():
return vxse52(_that);case EarthquakeVxse53DebugDraft():
return vxse53(_that);case EarthquakeVxse61DebugDraft():
return vxse61(_that);case EarthquakeVxse62DebugDraft():
return vxse62(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakeVxse51DebugDraft value)?  vxse51,TResult? Function( EarthquakeVxse52DebugDraft value)?  vxse52,TResult? Function( EarthquakeVxse53DebugDraft value)?  vxse53,TResult? Function( EarthquakeVxse61DebugDraft value)?  vxse61,TResult? Function( EarthquakeVxse62DebugDraft value)?  vxse62,}){
final _that = this;
switch (_that) {
case EarthquakeVxse51DebugDraft() when vxse51 != null:
return vxse51(_that);case EarthquakeVxse52DebugDraft() when vxse52 != null:
return vxse52(_that);case EarthquakeVxse53DebugDraft() when vxse53 != null:
return vxse53(_that);case EarthquakeVxse61DebugDraft() when vxse61 != null:
return vxse61(_that);case EarthquakeVxse62DebugDraft() when vxse62 != null:
return vxse62(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  JmaIntensity maxIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<IntensityPrefecture>> prefectures,  List<EarthquakeTelegramComment> comments)?  vxse51,TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  List<EarthquakeTelegramComment> comments)?  vxse52,TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  EarthquakeType earthquakeType,  JmaIntensity maxIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  List<EarthquakeTelegramComment> comments)?  vxse53,TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  List<EarthquakeTelegramComment> comments)?  vxse61,TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  JmaIntensity maxIntensity,  JmaLpgmIntensity maxLpgmIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions,  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree,  List<EarthquakeTelegramComment> comments)?  vxse62,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakeVxse51DebugDraft() when vxse51 != null:
return vxse51(_that.eventId,_that.reportedAt,_that.status,_that.maxIntensity,_that.regions,_that.prefectures,_that.comments);case EarthquakeVxse52DebugDraft() when vxse52 != null:
return vxse52(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.comments);case EarthquakeVxse53DebugDraft() when vxse53 != null:
return vxse53(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.earthquakeType,_that.maxIntensity,_that.regions,_that.intensityTree,_that.comments);case EarthquakeVxse61DebugDraft() when vxse61 != null:
return vxse61(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.comments);case EarthquakeVxse62DebugDraft() when vxse62 != null:
return vxse62(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.maxIntensity,_that.maxLpgmIntensity,_that.regions,_that.intensityTree,_that.lpgmRegions,_that.lpgmIntensityTree,_that.comments);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  JmaIntensity maxIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<IntensityPrefecture>> prefectures,  List<EarthquakeTelegramComment> comments)  vxse51,required TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  List<EarthquakeTelegramComment> comments)  vxse52,required TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  EarthquakeType earthquakeType,  JmaIntensity maxIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  List<EarthquakeTelegramComment> comments)  vxse53,required TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  List<EarthquakeTelegramComment> comments)  vxse61,required TResult Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  JmaIntensity maxIntensity,  JmaLpgmIntensity maxLpgmIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions,  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree,  List<EarthquakeTelegramComment> comments)  vxse62,}) {final _that = this;
switch (_that) {
case EarthquakeVxse51DebugDraft():
return vxse51(_that.eventId,_that.reportedAt,_that.status,_that.maxIntensity,_that.regions,_that.prefectures,_that.comments);case EarthquakeVxse52DebugDraft():
return vxse52(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.comments);case EarthquakeVxse53DebugDraft():
return vxse53(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.earthquakeType,_that.maxIntensity,_that.regions,_that.intensityTree,_that.comments);case EarthquakeVxse61DebugDraft():
return vxse61(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.comments);case EarthquakeVxse62DebugDraft():
return vxse62(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.maxIntensity,_that.maxLpgmIntensity,_that.regions,_that.intensityTree,_that.lpgmRegions,_that.lpgmIntensityTree,_that.comments);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  JmaIntensity maxIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<IntensityPrefecture>> prefectures,  List<EarthquakeTelegramComment> comments)?  vxse51,TResult? Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  List<EarthquakeTelegramComment> comments)?  vxse52,TResult? Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  EarthquakeType earthquakeType,  JmaIntensity maxIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  List<EarthquakeTelegramComment> comments)?  vxse53,TResult? Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  List<EarthquakeTelegramComment> comments)?  vxse61,TResult? Function( String eventId,  DateTime reportedAt,  TelegramStatus status,  DateTime? arrivalTime,  DateTime? originTime,  EarthquakeHypocenter hypocenter,  JmaIntensity maxIntensity,  JmaLpgmIntensity maxLpgmIntensity,  Map<JmaIntensity, List<IntensityRegion>> regions,  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions,  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree,  List<EarthquakeTelegramComment> comments)?  vxse62,}) {final _that = this;
switch (_that) {
case EarthquakeVxse51DebugDraft() when vxse51 != null:
return vxse51(_that.eventId,_that.reportedAt,_that.status,_that.maxIntensity,_that.regions,_that.prefectures,_that.comments);case EarthquakeVxse52DebugDraft() when vxse52 != null:
return vxse52(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.comments);case EarthquakeVxse53DebugDraft() when vxse53 != null:
return vxse53(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.earthquakeType,_that.maxIntensity,_that.regions,_that.intensityTree,_that.comments);case EarthquakeVxse61DebugDraft() when vxse61 != null:
return vxse61(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.comments);case EarthquakeVxse62DebugDraft() when vxse62 != null:
return vxse62(_that.eventId,_that.reportedAt,_that.status,_that.arrivalTime,_that.originTime,_that.hypocenter,_that.maxIntensity,_that.maxLpgmIntensity,_that.regions,_that.intensityTree,_that.lpgmRegions,_that.lpgmIntensityTree,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EarthquakeVxse51DebugDraft implements EarthquakeVxseDebugDraft {
  const EarthquakeVxse51DebugDraft({required this.eventId, required this.reportedAt, required this.status, required this.maxIntensity, required final  Map<JmaIntensity, List<IntensityRegion>> regions, required final  Map<JmaIntensity, List<IntensityPrefecture>> prefectures, required final  List<EarthquakeTelegramComment> comments, final  String? $type}): _regions = regions,_prefectures = prefectures,_comments = comments,$type = $type ?? 'VXSE51';
  factory EarthquakeVxse51DebugDraft.fromJson(Map<String, dynamic> json) => _$EarthquakeVxse51DebugDraftFromJson(json);

@override final  String eventId;
@override final  DateTime reportedAt;
@override final  TelegramStatus status;
 final  JmaIntensity maxIntensity;
 final  Map<JmaIntensity, List<IntensityRegion>> _regions;
 Map<JmaIntensity, List<IntensityRegion>> get regions {
  if (_regions is EqualUnmodifiableMapView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_regions);
}

 final  Map<JmaIntensity, List<IntensityPrefecture>> _prefectures;
 Map<JmaIntensity, List<IntensityPrefecture>> get prefectures {
  if (_prefectures is EqualUnmodifiableMapView) return _prefectures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_prefectures);
}

 final  List<EarthquakeTelegramComment> _comments;
@override List<EarthquakeTelegramComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeVxse51DebugDraftCopyWith<EarthquakeVxse51DebugDraft> get copyWith => _$EarthquakeVxse51DebugDraftCopyWithImpl<EarthquakeVxse51DebugDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeVxse51DebugDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeVxse51DebugDraft&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._prefectures, _prefectures)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,reportedAt,status,maxIntensity,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_prefectures),const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'EarthquakeVxseDebugDraft.vxse51(eventId: $eventId, reportedAt: $reportedAt, status: $status, maxIntensity: $maxIntensity, regions: $regions, prefectures: $prefectures, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeVxse51DebugDraftCopyWith<$Res> implements $EarthquakeVxseDebugDraftCopyWith<$Res> {
  factory $EarthquakeVxse51DebugDraftCopyWith(EarthquakeVxse51DebugDraft value, $Res Function(EarthquakeVxse51DebugDraft) _then) = _$EarthquakeVxse51DebugDraftCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime reportedAt, TelegramStatus status, JmaIntensity maxIntensity, Map<JmaIntensity, List<IntensityRegion>> regions, Map<JmaIntensity, List<IntensityPrefecture>> prefectures, List<EarthquakeTelegramComment> comments
});




}
/// @nodoc
class _$EarthquakeVxse51DebugDraftCopyWithImpl<$Res>
    implements $EarthquakeVxse51DebugDraftCopyWith<$Res> {
  _$EarthquakeVxse51DebugDraftCopyWithImpl(this._self, this._then);

  final EarthquakeVxse51DebugDraft _self;
  final $Res Function(EarthquakeVxse51DebugDraft) _then;

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? reportedAt = null,Object? status = null,Object? maxIntensity = null,Object? regions = null,Object? prefectures = null,Object? comments = null,}) {
  return _then(EarthquakeVxse51DebugDraft(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<IntensityRegion>>,prefectures: null == prefectures ? _self._prefectures : prefectures // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<IntensityPrefecture>>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EarthquakeVxse52DebugDraft implements EarthquakeVxseDebugDraft {
  const EarthquakeVxse52DebugDraft({required this.eventId, required this.reportedAt, required this.status, required this.arrivalTime, required this.originTime, required this.hypocenter, required final  List<EarthquakeTelegramComment> comments, final  String? $type}): _comments = comments,$type = $type ?? 'VXSE52';
  factory EarthquakeVxse52DebugDraft.fromJson(Map<String, dynamic> json) => _$EarthquakeVxse52DebugDraftFromJson(json);

@override final  String eventId;
@override final  DateTime reportedAt;
@override final  TelegramStatus status;
 final  DateTime? arrivalTime;
 final  DateTime? originTime;
 final  EarthquakeHypocenter hypocenter;
 final  List<EarthquakeTelegramComment> _comments;
@override List<EarthquakeTelegramComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeVxse52DebugDraftCopyWith<EarthquakeVxse52DebugDraft> get copyWith => _$EarthquakeVxse52DebugDraftCopyWithImpl<EarthquakeVxse52DebugDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeVxse52DebugDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeVxse52DebugDraft&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,reportedAt,status,arrivalTime,originTime,hypocenter,const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'EarthquakeVxseDebugDraft.vxse52(eventId: $eventId, reportedAt: $reportedAt, status: $status, arrivalTime: $arrivalTime, originTime: $originTime, hypocenter: $hypocenter, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeVxse52DebugDraftCopyWith<$Res> implements $EarthquakeVxseDebugDraftCopyWith<$Res> {
  factory $EarthquakeVxse52DebugDraftCopyWith(EarthquakeVxse52DebugDraft value, $Res Function(EarthquakeVxse52DebugDraft) _then) = _$EarthquakeVxse52DebugDraftCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime reportedAt, TelegramStatus status, DateTime? arrivalTime, DateTime? originTime, EarthquakeHypocenter hypocenter, List<EarthquakeTelegramComment> comments
});


$EarthquakeHypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$EarthquakeVxse52DebugDraftCopyWithImpl<$Res>
    implements $EarthquakeVxse52DebugDraftCopyWith<$Res> {
  _$EarthquakeVxse52DebugDraftCopyWithImpl(this._self, this._then);

  final EarthquakeVxse52DebugDraft _self;
  final $Res Function(EarthquakeVxse52DebugDraft) _then;

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? reportedAt = null,Object? status = null,Object? arrivalTime = freezed,Object? originTime = freezed,Object? hypocenter = null,Object? comments = null,}) {
  return _then(EarthquakeVxse52DebugDraft(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,
  ));
}

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeVxse53DebugDraft implements EarthquakeVxseDebugDraft {
  const EarthquakeVxse53DebugDraft({required this.eventId, required this.reportedAt, required this.status, required this.arrivalTime, required this.originTime, required this.hypocenter, required this.earthquakeType, required this.maxIntensity, required final  Map<JmaIntensity, List<IntensityRegion>> regions, required final  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, required final  List<EarthquakeTelegramComment> comments, final  String? $type}): _regions = regions,_intensityTree = intensityTree,_comments = comments,$type = $type ?? 'VXSE53';
  factory EarthquakeVxse53DebugDraft.fromJson(Map<String, dynamic> json) => _$EarthquakeVxse53DebugDraftFromJson(json);

@override final  String eventId;
@override final  DateTime reportedAt;
@override final  TelegramStatus status;
 final  DateTime? arrivalTime;
 final  DateTime? originTime;
 final  EarthquakeHypocenter hypocenter;
 final  EarthquakeType earthquakeType;
 final  JmaIntensity maxIntensity;
 final  Map<JmaIntensity, List<IntensityRegion>> _regions;
 Map<JmaIntensity, List<IntensityRegion>> get regions {
  if (_regions is EqualUnmodifiableMapView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_regions);
}

 final  Map<JmaIntensity, List<PrefectureIntensityNode>> _intensityTree;
 Map<JmaIntensity, List<PrefectureIntensityNode>> get intensityTree {
  if (_intensityTree is EqualUnmodifiableMapView) return _intensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_intensityTree);
}

 final  List<EarthquakeTelegramComment> _comments;
@override List<EarthquakeTelegramComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeVxse53DebugDraftCopyWith<EarthquakeVxse53DebugDraft> get copyWith => _$EarthquakeVxse53DebugDraftCopyWithImpl<EarthquakeVxse53DebugDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeVxse53DebugDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeVxse53DebugDraft&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.earthquakeType, earthquakeType) || other.earthquakeType == earthquakeType)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._intensityTree, _intensityTree)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,reportedAt,status,arrivalTime,originTime,hypocenter,earthquakeType,maxIntensity,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_intensityTree),const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'EarthquakeVxseDebugDraft.vxse53(eventId: $eventId, reportedAt: $reportedAt, status: $status, arrivalTime: $arrivalTime, originTime: $originTime, hypocenter: $hypocenter, earthquakeType: $earthquakeType, maxIntensity: $maxIntensity, regions: $regions, intensityTree: $intensityTree, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeVxse53DebugDraftCopyWith<$Res> implements $EarthquakeVxseDebugDraftCopyWith<$Res> {
  factory $EarthquakeVxse53DebugDraftCopyWith(EarthquakeVxse53DebugDraft value, $Res Function(EarthquakeVxse53DebugDraft) _then) = _$EarthquakeVxse53DebugDraftCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime reportedAt, TelegramStatus status, DateTime? arrivalTime, DateTime? originTime, EarthquakeHypocenter hypocenter, EarthquakeType earthquakeType, JmaIntensity maxIntensity, Map<JmaIntensity, List<IntensityRegion>> regions, Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, List<EarthquakeTelegramComment> comments
});


$EarthquakeHypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$EarthquakeVxse53DebugDraftCopyWithImpl<$Res>
    implements $EarthquakeVxse53DebugDraftCopyWith<$Res> {
  _$EarthquakeVxse53DebugDraftCopyWithImpl(this._self, this._then);

  final EarthquakeVxse53DebugDraft _self;
  final $Res Function(EarthquakeVxse53DebugDraft) _then;

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? reportedAt = null,Object? status = null,Object? arrivalTime = freezed,Object? originTime = freezed,Object? hypocenter = null,Object? earthquakeType = null,Object? maxIntensity = null,Object? regions = null,Object? intensityTree = null,Object? comments = null,}) {
  return _then(EarthquakeVxse53DebugDraft(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter,earthquakeType: null == earthquakeType ? _self.earthquakeType : earthquakeType // ignore: cast_nullable_to_non_nullable
as EarthquakeType,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<IntensityRegion>>,intensityTree: null == intensityTree ? _self._intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<PrefectureIntensityNode>>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,
  ));
}

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeVxse61DebugDraft implements EarthquakeVxseDebugDraft {
  const EarthquakeVxse61DebugDraft({required this.eventId, required this.reportedAt, required this.status, required this.arrivalTime, required this.originTime, required this.hypocenter, required final  List<EarthquakeTelegramComment> comments, final  String? $type}): _comments = comments,$type = $type ?? 'VXSE61';
  factory EarthquakeVxse61DebugDraft.fromJson(Map<String, dynamic> json) => _$EarthquakeVxse61DebugDraftFromJson(json);

@override final  String eventId;
@override final  DateTime reportedAt;
@override final  TelegramStatus status;
 final  DateTime? arrivalTime;
 final  DateTime? originTime;
 final  EarthquakeHypocenter hypocenter;
 final  List<EarthquakeTelegramComment> _comments;
@override List<EarthquakeTelegramComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeVxse61DebugDraftCopyWith<EarthquakeVxse61DebugDraft> get copyWith => _$EarthquakeVxse61DebugDraftCopyWithImpl<EarthquakeVxse61DebugDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeVxse61DebugDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeVxse61DebugDraft&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,reportedAt,status,arrivalTime,originTime,hypocenter,const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'EarthquakeVxseDebugDraft.vxse61(eventId: $eventId, reportedAt: $reportedAt, status: $status, arrivalTime: $arrivalTime, originTime: $originTime, hypocenter: $hypocenter, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeVxse61DebugDraftCopyWith<$Res> implements $EarthquakeVxseDebugDraftCopyWith<$Res> {
  factory $EarthquakeVxse61DebugDraftCopyWith(EarthquakeVxse61DebugDraft value, $Res Function(EarthquakeVxse61DebugDraft) _then) = _$EarthquakeVxse61DebugDraftCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime reportedAt, TelegramStatus status, DateTime? arrivalTime, DateTime? originTime, EarthquakeHypocenter hypocenter, List<EarthquakeTelegramComment> comments
});


$EarthquakeHypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$EarthquakeVxse61DebugDraftCopyWithImpl<$Res>
    implements $EarthquakeVxse61DebugDraftCopyWith<$Res> {
  _$EarthquakeVxse61DebugDraftCopyWithImpl(this._self, this._then);

  final EarthquakeVxse61DebugDraft _self;
  final $Res Function(EarthquakeVxse61DebugDraft) _then;

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? reportedAt = null,Object? status = null,Object? arrivalTime = freezed,Object? originTime = freezed,Object? hypocenter = null,Object? comments = null,}) {
  return _then(EarthquakeVxse61DebugDraft(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,
  ));
}

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class EarthquakeVxse62DebugDraft implements EarthquakeVxseDebugDraft {
  const EarthquakeVxse62DebugDraft({required this.eventId, required this.reportedAt, required this.status, required this.arrivalTime, required this.originTime, required this.hypocenter, required this.maxIntensity, required this.maxLpgmIntensity, required final  Map<JmaIntensity, List<IntensityRegion>> regions, required final  Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, required final  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions, required final  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree, required final  List<EarthquakeTelegramComment> comments, final  String? $type}): _regions = regions,_intensityTree = intensityTree,_lpgmRegions = lpgmRegions,_lpgmIntensityTree = lpgmIntensityTree,_comments = comments,$type = $type ?? 'VXSE62';
  factory EarthquakeVxse62DebugDraft.fromJson(Map<String, dynamic> json) => _$EarthquakeVxse62DebugDraftFromJson(json);

@override final  String eventId;
@override final  DateTime reportedAt;
@override final  TelegramStatus status;
 final  DateTime? arrivalTime;
 final  DateTime? originTime;
 final  EarthquakeHypocenter hypocenter;
 final  JmaIntensity maxIntensity;
 final  JmaLpgmIntensity maxLpgmIntensity;
 final  Map<JmaIntensity, List<IntensityRegion>> _regions;
 Map<JmaIntensity, List<IntensityRegion>> get regions {
  if (_regions is EqualUnmodifiableMapView) return _regions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_regions);
}

 final  Map<JmaIntensity, List<PrefectureIntensityNode>> _intensityTree;
 Map<JmaIntensity, List<PrefectureIntensityNode>> get intensityTree {
  if (_intensityTree is EqualUnmodifiableMapView) return _intensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_intensityTree);
}

 final  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> _lpgmRegions;
 Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> get lpgmRegions {
  if (_lpgmRegions is EqualUnmodifiableMapView) return _lpgmRegions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lpgmRegions);
}

 final  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> _lpgmIntensityTree;
 Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> get lpgmIntensityTree {
  if (_lpgmIntensityTree is EqualUnmodifiableMapView) return _lpgmIntensityTree;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lpgmIntensityTree);
}

 final  List<EarthquakeTelegramComment> _comments;
@override List<EarthquakeTelegramComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeVxse62DebugDraftCopyWith<EarthquakeVxse62DebugDraft> get copyWith => _$EarthquakeVxse62DebugDraftCopyWithImpl<EarthquakeVxse62DebugDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeVxse62DebugDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeVxse62DebugDraft&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.arrivalTime, arrivalTime) || other.arrivalTime == arrivalTime)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.maxIntensity, maxIntensity) || other.maxIntensity == maxIntensity)&&(identical(other.maxLpgmIntensity, maxLpgmIntensity) || other.maxLpgmIntensity == maxLpgmIntensity)&&const DeepCollectionEquality().equals(other._regions, _regions)&&const DeepCollectionEquality().equals(other._intensityTree, _intensityTree)&&const DeepCollectionEquality().equals(other._lpgmRegions, _lpgmRegions)&&const DeepCollectionEquality().equals(other._lpgmIntensityTree, _lpgmIntensityTree)&&const DeepCollectionEquality().equals(other._comments, _comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,reportedAt,status,arrivalTime,originTime,hypocenter,maxIntensity,maxLpgmIntensity,const DeepCollectionEquality().hash(_regions),const DeepCollectionEquality().hash(_intensityTree),const DeepCollectionEquality().hash(_lpgmRegions),const DeepCollectionEquality().hash(_lpgmIntensityTree),const DeepCollectionEquality().hash(_comments));

@override
String toString() {
  return 'EarthquakeVxseDebugDraft.vxse62(eventId: $eventId, reportedAt: $reportedAt, status: $status, arrivalTime: $arrivalTime, originTime: $originTime, hypocenter: $hypocenter, maxIntensity: $maxIntensity, maxLpgmIntensity: $maxLpgmIntensity, regions: $regions, intensityTree: $intensityTree, lpgmRegions: $lpgmRegions, lpgmIntensityTree: $lpgmIntensityTree, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $EarthquakeVxse62DebugDraftCopyWith<$Res> implements $EarthquakeVxseDebugDraftCopyWith<$Res> {
  factory $EarthquakeVxse62DebugDraftCopyWith(EarthquakeVxse62DebugDraft value, $Res Function(EarthquakeVxse62DebugDraft) _then) = _$EarthquakeVxse62DebugDraftCopyWithImpl;
@override @useResult
$Res call({
 String eventId, DateTime reportedAt, TelegramStatus status, DateTime? arrivalTime, DateTime? originTime, EarthquakeHypocenter hypocenter, JmaIntensity maxIntensity, JmaLpgmIntensity maxLpgmIntensity, Map<JmaIntensity, List<IntensityRegion>> regions, Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree, Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions, Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmIntensityTree, List<EarthquakeTelegramComment> comments
});


$EarthquakeHypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$EarthquakeVxse62DebugDraftCopyWithImpl<$Res>
    implements $EarthquakeVxse62DebugDraftCopyWith<$Res> {
  _$EarthquakeVxse62DebugDraftCopyWithImpl(this._self, this._then);

  final EarthquakeVxse62DebugDraft _self;
  final $Res Function(EarthquakeVxse62DebugDraft) _then;

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? reportedAt = null,Object? status = null,Object? arrivalTime = freezed,Object? originTime = freezed,Object? hypocenter = null,Object? maxIntensity = null,Object? maxLpgmIntensity = null,Object? regions = null,Object? intensityTree = null,Object? lpgmRegions = null,Object? lpgmIntensityTree = null,Object? comments = null,}) {
  return _then(EarthquakeVxse62DebugDraft(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TelegramStatus,arrivalTime: freezed == arrivalTime ? _self.arrivalTime : arrivalTime // ignore: cast_nullable_to_non_nullable
as DateTime?,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as EarthquakeHypocenter,maxIntensity: null == maxIntensity ? _self.maxIntensity : maxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,maxLpgmIntensity: null == maxLpgmIntensity ? _self.maxLpgmIntensity : maxLpgmIntensity // ignore: cast_nullable_to_non_nullable
as JmaLpgmIntensity,regions: null == regions ? _self._regions : regions // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<IntensityRegion>>,intensityTree: null == intensityTree ? _self._intensityTree : intensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaIntensity, List<PrefectureIntensityNode>>,lpgmRegions: null == lpgmRegions ? _self._lpgmRegions : lpgmRegions // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, List<LpgmIntensityRegion>>,lpgmIntensityTree: null == lpgmIntensityTree ? _self._lpgmIntensityTree : lpgmIntensityTree // ignore: cast_nullable_to_non_nullable
as Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<EarthquakeTelegramComment>,
  ));
}

/// Create a copy of EarthquakeVxseDebugDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeHypocenterCopyWith<$Res> get hypocenter {
  
  return $EarthquakeHypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

// dart format on
