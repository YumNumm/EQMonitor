// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_revision.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapFullRevision {

 MapSourceInstanceId get source; int get revision; MapContentDigest get digest;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapFullRevision&&(identical(other.source, source) || other.source == source)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.digest, digest) || other.digest == digest));
}


@override
int get hashCode => Object.hash(runtimeType,source,revision,digest);

@override
String toString() {
  return 'MapFullRevision(source: $source, revision: $revision, digest: $digest)';
}


}





/// @nodoc


class _MapFullRevision implements MapFullRevision {
  const _MapFullRevision({required this.source, required this.revision, required this.digest});
  

@override final  MapSourceInstanceId source;
@override final  int revision;
@override final  MapContentDigest digest;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapFullRevision&&(identical(other.source, source) || other.source == source)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.digest, digest) || other.digest == digest));
}


@override
int get hashCode => Object.hash(runtimeType,source,revision,digest);

@override
String toString() {
  return 'MapFullRevision._(source: $source, revision: $revision, digest: $digest)';
}


}




/// @nodoc
mixin _$MapDeltaRevision {

 MapSourceInstanceId get source; int get baseRevision; int get targetRevision; MapContentDigest get targetDigest;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapDeltaRevision&&(identical(other.source, source) || other.source == source)&&(identical(other.baseRevision, baseRevision) || other.baseRevision == baseRevision)&&(identical(other.targetRevision, targetRevision) || other.targetRevision == targetRevision)&&(identical(other.targetDigest, targetDigest) || other.targetDigest == targetDigest));
}


@override
int get hashCode => Object.hash(runtimeType,source,baseRevision,targetRevision,targetDigest);

@override
String toString() {
  return 'MapDeltaRevision(source: $source, baseRevision: $baseRevision, targetRevision: $targetRevision, targetDigest: $targetDigest)';
}


}





/// @nodoc


class _MapDeltaRevision implements MapDeltaRevision {
  const _MapDeltaRevision({required this.source, required this.baseRevision, required this.targetRevision, required this.targetDigest});
  

@override final  MapSourceInstanceId source;
@override final  int baseRevision;
@override final  int targetRevision;
@override final  MapContentDigest targetDigest;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapDeltaRevision&&(identical(other.source, source) || other.source == source)&&(identical(other.baseRevision, baseRevision) || other.baseRevision == baseRevision)&&(identical(other.targetRevision, targetRevision) || other.targetRevision == targetRevision)&&(identical(other.targetDigest, targetDigest) || other.targetDigest == targetDigest));
}


@override
int get hashCode => Object.hash(runtimeType,source,baseRevision,targetRevision,targetDigest);

@override
String toString() {
  return 'MapDeltaRevision._(source: $source, baseRevision: $baseRevision, targetRevision: $targetRevision, targetDigest: $targetDigest)';
}


}




/// @nodoc
mixin _$MapCommittedRevision<TState> {

 MapSourceInstanceId get source; int get revision; MapContentDigest get digest; TState get state;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapCommittedRevision<TState>&&(identical(other.source, source) || other.source == source)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.digest, digest) || other.digest == digest)&&const DeepCollectionEquality().equals(other.state, state));
}


@override
int get hashCode => Object.hash(runtimeType,source,revision,digest,const DeepCollectionEquality().hash(state));

@override
String toString() {
  return 'MapCommittedRevision<$TState>(source: $source, revision: $revision, digest: $digest, state: $state)';
}


}





/// @nodoc


class _MapCommittedRevision<TState> implements MapCommittedRevision<TState> {
  const _MapCommittedRevision({required this.source, required this.revision, required this.digest, required this.state});
  

@override final  MapSourceInstanceId source;
@override final  int revision;
@override final  MapContentDigest digest;
@override final  TState state;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapCommittedRevision<TState>&&(identical(other.source, source) || other.source == source)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.digest, digest) || other.digest == digest)&&const DeepCollectionEquality().equals(other.state, state));
}


@override
int get hashCode => Object.hash(runtimeType,source,revision,digest,const DeepCollectionEquality().hash(state));

@override
String toString() {
  return 'MapCommittedRevision<$TState>._(source: $source, revision: $revision, digest: $digest, state: $state)';
}


}




/// @nodoc
mixin _$MapFullResyncRequest {

 MapSourceInstanceId get source; int? get afterRevision;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapFullResyncRequest&&(identical(other.source, source) || other.source == source)&&(identical(other.afterRevision, afterRevision) || other.afterRevision == afterRevision));
}


@override
int get hashCode => Object.hash(runtimeType,source,afterRevision);

@override
String toString() {
  return 'MapFullResyncRequest(source: $source, afterRevision: $afterRevision)';
}


}





/// @nodoc


class _MapFullResyncRequest implements MapFullResyncRequest {
  const _MapFullResyncRequest({required this.source, required this.afterRevision});
  

@override final  MapSourceInstanceId source;
@override final  int? afterRevision;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapFullResyncRequest&&(identical(other.source, source) || other.source == source)&&(identical(other.afterRevision, afterRevision) || other.afterRevision == afterRevision));
}


@override
int get hashCode => Object.hash(runtimeType,source,afterRevision);

@override
String toString() {
  return 'MapFullResyncRequest._(source: $source, afterRevision: $afterRevision)';
}


}




/// @nodoc
mixin _$MapRevisionApplyResult<TState> {

 MapCommittedRevision<TState>? get current; MapRevisionRejectReason? get reason; MapFullResyncRequest? get fullResyncRequest;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapRevisionApplyResult<TState>&&(identical(other.current, current) || other.current == current)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.fullResyncRequest, fullResyncRequest) || other.fullResyncRequest == fullResyncRequest));
}


@override
int get hashCode => Object.hash(runtimeType,current,reason,fullResyncRequest);

@override
String toString() {
  return 'MapRevisionApplyResult<$TState>(current: $current, reason: $reason, fullResyncRequest: $fullResyncRequest)';
}


}





/// @nodoc


class _MapRevisionApplyResultCommitted<TState> implements MapRevisionApplyResult<TState> {
  const _MapRevisionApplyResultCommitted({required this.current, this.reason, this.fullResyncRequest});
  

@override final  MapCommittedRevision<TState> current;
@override final  MapRevisionRejectReason? reason;
@override final  MapFullResyncRequest? fullResyncRequest;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapRevisionApplyResultCommitted<TState>&&(identical(other.current, current) || other.current == current)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.fullResyncRequest, fullResyncRequest) || other.fullResyncRequest == fullResyncRequest));
}


@override
int get hashCode => Object.hash(runtimeType,current,reason,fullResyncRequest);

@override
String toString() {
  return 'MapRevisionApplyResult<$TState>._committed(current: $current, reason: $reason, fullResyncRequest: $fullResyncRequest)';
}


}




/// @nodoc


class _MapRevisionApplyResultIdempotentNoOp<TState> implements MapRevisionApplyResult<TState> {
  const _MapRevisionApplyResultIdempotentNoOp({required this.current, this.reason, this.fullResyncRequest});
  

@override final  MapCommittedRevision<TState> current;
@override final  MapRevisionRejectReason? reason;
@override final  MapFullResyncRequest? fullResyncRequest;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapRevisionApplyResultIdempotentNoOp<TState>&&(identical(other.current, current) || other.current == current)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.fullResyncRequest, fullResyncRequest) || other.fullResyncRequest == fullResyncRequest));
}


@override
int get hashCode => Object.hash(runtimeType,current,reason,fullResyncRequest);

@override
String toString() {
  return 'MapRevisionApplyResult<$TState>._idempotentNoOp(current: $current, reason: $reason, fullResyncRequest: $fullResyncRequest)';
}


}




/// @nodoc


class _MapRevisionApplyResultRejected<TState> implements MapRevisionApplyResult<TState> {
  const _MapRevisionApplyResultRejected({required this.current, required this.reason, this.fullResyncRequest});
  

@override final  MapCommittedRevision<TState>? current;
@override final  MapRevisionRejectReason reason;
@override final  MapFullResyncRequest? fullResyncRequest;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapRevisionApplyResultRejected<TState>&&(identical(other.current, current) || other.current == current)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.fullResyncRequest, fullResyncRequest) || other.fullResyncRequest == fullResyncRequest));
}


@override
int get hashCode => Object.hash(runtimeType,current,reason,fullResyncRequest);

@override
String toString() {
  return 'MapRevisionApplyResult<$TState>._rejected(current: $current, reason: $reason, fullResyncRequest: $fullResyncRequest)';
}


}




// dart format on
