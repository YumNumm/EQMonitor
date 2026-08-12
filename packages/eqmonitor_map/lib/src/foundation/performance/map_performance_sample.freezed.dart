// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_performance_sample.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapPerformanceSample {

 MapPerformanceSchemaVersion get schemaVersion; MapClockDomainId get clockDomain; MapPerformanceMetricKind get kind; Duration get monotonicAt; int get value;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapPerformanceSample&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.clockDomain, clockDomain) || other.clockDomain == clockDomain)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.monotonicAt, monotonicAt) || other.monotonicAt == monotonicAt)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,schemaVersion,clockDomain,kind,monotonicAt,value);

@override
String toString() {
  return 'MapPerformanceSample(schemaVersion: $schemaVersion, clockDomain: $clockDomain, kind: $kind, monotonicAt: $monotonicAt, value: $value)';
}


}





/// @nodoc


class _MapPerformanceSample implements MapPerformanceSample {
  const _MapPerformanceSample({required this.schemaVersion, required this.clockDomain, required this.kind, required this.monotonicAt, required this.value});


@override final  MapPerformanceSchemaVersion schemaVersion;
@override final  MapClockDomainId clockDomain;
@override final  MapPerformanceMetricKind kind;
@override final  Duration monotonicAt;
@override final  int value;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapPerformanceSample&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.clockDomain, clockDomain) || other.clockDomain == clockDomain)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.monotonicAt, monotonicAt) || other.monotonicAt == monotonicAt)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,schemaVersion,clockDomain,kind,monotonicAt,value);

@override
String toString() {
  return 'MapPerformanceSample._(schemaVersion: $schemaVersion, clockDomain: $clockDomain, kind: $kind, monotonicAt: $monotonicAt, value: $value)';
}


}




// dart format on
