// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_hypocenters_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
EarthquakeHypocentersUnion _$EarthquakeHypocentersUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'variant1':
          return EarthquakeHypocentersUnionVariant1.fromJson(
            json
          );
                case 'variant2':
          return EarthquakeHypocentersUnionVariant2.fromJson(
            json
          );

          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'EarthquakeHypocentersUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }

}

/// @nodoc
mixin _$EarthquakeHypocentersUnion {

/// const: "JMA_DISASTER_INFORMATION_XML"
 String get datasource; Hypocenter get hypocenter;
/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocentersUnionCopyWith<EarthquakeHypocentersUnion> get copyWith => _$EarthquakeHypocentersUnionCopyWithImpl<EarthquakeHypocentersUnion>(this as EarthquakeHypocentersUnion, _$identity);

  /// Serializes this EarthquakeHypocentersUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocentersUnion&&(identical(other.datasource, datasource) || other.datasource == datasource)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datasource,hypocenter);

@override
String toString() {
  return 'EarthquakeHypocentersUnion(datasource: $datasource, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocentersUnionCopyWith<$Res>  {
  factory $EarthquakeHypocentersUnionCopyWith(EarthquakeHypocentersUnion value, $Res Function(EarthquakeHypocentersUnion) _then) = _$EarthquakeHypocentersUnionCopyWithImpl;
@useResult
$Res call({
 String datasource, Hypocenter hypocenter
});


$HypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$EarthquakeHypocentersUnionCopyWithImpl<$Res>
    implements $EarthquakeHypocentersUnionCopyWith<$Res> {
  _$EarthquakeHypocentersUnionCopyWithImpl(this._self, this._then);

  final EarthquakeHypocentersUnion _self;
  final $Res Function(EarthquakeHypocentersUnion) _then;

/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? datasource = null,Object? hypocenter = null,}) {
  return _then(_self.copyWith(
datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as String,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter,
  ));
}
/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res> get hypocenter {

  return $HypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeHypocentersUnion].
extension EarthquakeHypocentersUnionPatterns on EarthquakeHypocentersUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EarthquakeHypocentersUnionVariant1 value)?  variant1,TResult Function( EarthquakeHypocentersUnionVariant2 value)?  variant2,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EarthquakeHypocentersUnionVariant1() when variant1 != null:
return variant1(_that);case EarthquakeHypocentersUnionVariant2() when variant2 != null:
return variant2(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EarthquakeHypocentersUnionVariant1 value)  variant1,required TResult Function( EarthquakeHypocentersUnionVariant2 value)  variant2,}){
final _that = this;
switch (_that) {
case EarthquakeHypocentersUnionVariant1():
return variant1(_that);case EarthquakeHypocentersUnionVariant2():
return variant2(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EarthquakeHypocentersUnionVariant1 value)?  variant1,TResult? Function( EarthquakeHypocentersUnionVariant2 value)?  variant2,}){
final _that = this;
switch (_that) {
case EarthquakeHypocentersUnionVariant1() when variant1 != null:
return variant1(_that);case EarthquakeHypocentersUnionVariant2() when variant2 != null:
return variant2(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String datasource, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(includeIfNull: true, name: 'source_telegram_id')  String? sourceTelegramId,  Hypocenter hypocenter)?  variant1,TResult Function( String datasource,  int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType,  Hypocenter hypocenter,  CatalogHypocenter catalog)?  variant2,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EarthquakeHypocentersUnionVariant1() when variant1 != null:
return variant1(_that.datasource,_that.reportedAt,_that.sourceTelegramId,_that.hypocenter);case EarthquakeHypocentersUnionVariant2() when variant2 != null:
return variant2(_that.datasource,_that.seq,_that.recordType,_that.hypocenter,_that.catalog);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String datasource, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(includeIfNull: true, name: 'source_telegram_id')  String? sourceTelegramId,  Hypocenter hypocenter)  variant1,required TResult Function( String datasource,  int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType,  Hypocenter hypocenter,  CatalogHypocenter catalog)  variant2,}) {final _that = this;
switch (_that) {
case EarthquakeHypocentersUnionVariant1():
return variant1(_that.datasource,_that.reportedAt,_that.sourceTelegramId,_that.hypocenter);case EarthquakeHypocentersUnionVariant2():
return variant2(_that.datasource,_that.seq,_that.recordType,_that.hypocenter,_that.catalog);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String datasource, @JsonKey(name: 'reported_at')  DateTime reportedAt, @JsonKey(includeIfNull: true, name: 'source_telegram_id')  String? sourceTelegramId,  Hypocenter hypocenter)?  variant1,TResult? Function( String datasource,  int seq, @JsonKey(name: 'record_type')  CatalogHypocenterRecordType recordType,  Hypocenter hypocenter,  CatalogHypocenter catalog)?  variant2,}) {final _that = this;
switch (_that) {
case EarthquakeHypocentersUnionVariant1() when variant1 != null:
return variant1(_that.datasource,_that.reportedAt,_that.sourceTelegramId,_that.hypocenter);case EarthquakeHypocentersUnionVariant2() when variant2 != null:
return variant2(_that.datasource,_that.seq,_that.recordType,_that.hypocenter,_that.catalog);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class EarthquakeHypocentersUnionVariant1 implements EarthquakeHypocentersUnion {
  const EarthquakeHypocentersUnionVariant1({required this.datasource, @JsonKey(name: 'reported_at') required this.reportedAt, @JsonKey(includeIfNull: true, name: 'source_telegram_id') required this.sourceTelegramId, required this.hypocenter,  String? $type}): $type = $type ?? 'variant1';
  factory EarthquakeHypocentersUnionVariant1.fromJson(Map<String, dynamic> json) => _$EarthquakeHypocentersUnionVariant1FromJson(json);

/// const: "JMA_DISASTER_INFORMATION_XML"
@override final  String datasource;
@JsonKey(name: 'reported_at') final  DateTime reportedAt;
@JsonKey(includeIfNull: true, name: 'source_telegram_id') final  String? sourceTelegramId;
@override final  Hypocenter hypocenter;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocentersUnionVariant1CopyWith<EarthquakeHypocentersUnionVariant1> get copyWith => _$EarthquakeHypocentersUnionVariant1CopyWithImpl<EarthquakeHypocentersUnionVariant1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHypocentersUnionVariant1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocentersUnionVariant1&&(identical(other.datasource, datasource) || other.datasource == datasource)&&(identical(other.reportedAt, reportedAt) || other.reportedAt == reportedAt)&&(identical(other.sourceTelegramId, sourceTelegramId) || other.sourceTelegramId == sourceTelegramId)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datasource,reportedAt,sourceTelegramId,hypocenter);

@override
String toString() {
  return 'EarthquakeHypocentersUnion.variant1(datasource: $datasource, reportedAt: $reportedAt, sourceTelegramId: $sourceTelegramId, hypocenter: $hypocenter)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocentersUnionVariant1CopyWith<$Res> implements $EarthquakeHypocentersUnionCopyWith<$Res> {
  factory $EarthquakeHypocentersUnionVariant1CopyWith(EarthquakeHypocentersUnionVariant1 value, $Res Function(EarthquakeHypocentersUnionVariant1) _then) = _$EarthquakeHypocentersUnionVariant1CopyWithImpl;
@override @useResult
$Res call({
 String datasource,@JsonKey(name: 'reported_at') DateTime reportedAt,@JsonKey(includeIfNull: true, name: 'source_telegram_id') String? sourceTelegramId, Hypocenter hypocenter
});


@override $HypocenterCopyWith<$Res> get hypocenter;

}
/// @nodoc
class _$EarthquakeHypocentersUnionVariant1CopyWithImpl<$Res>
    implements $EarthquakeHypocentersUnionVariant1CopyWith<$Res> {
  _$EarthquakeHypocentersUnionVariant1CopyWithImpl(this._self, this._then);

  final EarthquakeHypocentersUnionVariant1 _self;
  final $Res Function(EarthquakeHypocentersUnionVariant1) _then;

/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? datasource = null,Object? reportedAt = null,Object? sourceTelegramId = freezed,Object? hypocenter = null,}) {
  return _then(EarthquakeHypocentersUnionVariant1(
datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as String,reportedAt: null == reportedAt ? _self.reportedAt : reportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sourceTelegramId: freezed == sourceTelegramId ? _self.sourceTelegramId : sourceTelegramId // ignore: cast_nullable_to_non_nullable
as String?,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter,
  ));
}

/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res> get hypocenter {

  return $HypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class EarthquakeHypocentersUnionVariant2 implements EarthquakeHypocentersUnion {
  const EarthquakeHypocentersUnionVariant2({required this.datasource, required this.seq, @JsonKey(name: 'record_type') required this.recordType, required this.hypocenter, required this.catalog,  String? $type}): $type = $type ?? 'variant2';
  factory EarthquakeHypocentersUnionVariant2.fromJson(Map<String, dynamic> json) => _$EarthquakeHypocentersUnionVariant2FromJson(json);

/// const: "JMA_INTENSITY_DATABASE"
@override final  String datasource;
 final  int seq;
@JsonKey(name: 'record_type') final  CatalogHypocenterRecordType recordType;
@override final  Hypocenter hypocenter;
 final  CatalogHypocenter catalog;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeHypocentersUnionVariant2CopyWith<EarthquakeHypocentersUnionVariant2> get copyWith => _$EarthquakeHypocentersUnionVariant2CopyWithImpl<EarthquakeHypocentersUnionVariant2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeHypocentersUnionVariant2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeHypocentersUnionVariant2&&(identical(other.datasource, datasource) || other.datasource == datasource)&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.recordType, recordType) || other.recordType == recordType)&&(identical(other.hypocenter, hypocenter) || other.hypocenter == hypocenter)&&(identical(other.catalog, catalog) || other.catalog == catalog));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,datasource,seq,recordType,hypocenter,catalog);

@override
String toString() {
  return 'EarthquakeHypocentersUnion.variant2(datasource: $datasource, seq: $seq, recordType: $recordType, hypocenter: $hypocenter, catalog: $catalog)';
}


}

/// @nodoc
abstract mixin class $EarthquakeHypocentersUnionVariant2CopyWith<$Res> implements $EarthquakeHypocentersUnionCopyWith<$Res> {
  factory $EarthquakeHypocentersUnionVariant2CopyWith(EarthquakeHypocentersUnionVariant2 value, $Res Function(EarthquakeHypocentersUnionVariant2) _then) = _$EarthquakeHypocentersUnionVariant2CopyWithImpl;
@override @useResult
$Res call({
 String datasource, int seq,@JsonKey(name: 'record_type') CatalogHypocenterRecordType recordType, Hypocenter hypocenter, CatalogHypocenter catalog
});


@override $HypocenterCopyWith<$Res> get hypocenter;$CatalogHypocenterCopyWith<$Res> get catalog;

}
/// @nodoc
class _$EarthquakeHypocentersUnionVariant2CopyWithImpl<$Res>
    implements $EarthquakeHypocentersUnionVariant2CopyWith<$Res> {
  _$EarthquakeHypocentersUnionVariant2CopyWithImpl(this._self, this._then);

  final EarthquakeHypocentersUnionVariant2 _self;
  final $Res Function(EarthquakeHypocentersUnionVariant2) _then;

/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? datasource = null,Object? seq = null,Object? recordType = null,Object? hypocenter = null,Object? catalog = null,}) {
  return _then(EarthquakeHypocentersUnionVariant2(
datasource: null == datasource ? _self.datasource : datasource // ignore: cast_nullable_to_non_nullable
as String,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,recordType: null == recordType ? _self.recordType : recordType // ignore: cast_nullable_to_non_nullable
as CatalogHypocenterRecordType,hypocenter: null == hypocenter ? _self.hypocenter : hypocenter // ignore: cast_nullable_to_non_nullable
as Hypocenter,catalog: null == catalog ? _self.catalog : catalog // ignore: cast_nullable_to_non_nullable
as CatalogHypocenter,
  ));
}

/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HypocenterCopyWith<$Res> get hypocenter {

  return $HypocenterCopyWith<$Res>(_self.hypocenter, (value) {
    return _then(_self.copyWith(hypocenter: value));
  });
}/// Create a copy of EarthquakeHypocentersUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CatalogHypocenterCopyWith<$Res> get catalog {

  return $CatalogHypocenterCopyWith<$Res>(_self.catalog, (value) {
    return _then(_self.copyWith(catalog: value));
  });
}
}

// dart format on
