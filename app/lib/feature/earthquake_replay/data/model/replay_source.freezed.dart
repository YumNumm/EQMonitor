// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplaySource {

 DateTime? get originTime;
/// Create a copy of ReplaySource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplaySourceCopyWith<ReplaySource> get copyWith => _$ReplaySourceCopyWithImpl<ReplaySource>(this as ReplaySource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplaySource&&(identical(other.originTime, originTime) || other.originTime == originTime));
}


@override
int get hashCode => Object.hash(runtimeType,originTime);

@override
String toString() {
  return 'ReplaySource(originTime: $originTime)';
}


}

/// @nodoc
abstract mixin class $ReplaySourceCopyWith<$Res>  {
  factory $ReplaySourceCopyWith(ReplaySource value, $Res Function(ReplaySource) _then) = _$ReplaySourceCopyWithImpl;
@useResult
$Res call({
 DateTime? originTime
});




}
/// @nodoc
class _$ReplaySourceCopyWithImpl<$Res>
    implements $ReplaySourceCopyWith<$Res> {
  _$ReplaySourceCopyWithImpl(this._self, this._then);

  final ReplaySource _self;
  final $Res Function(ReplaySource) _then;

/// Create a copy of ReplaySource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originTime = freezed,}) {
  return _then(_self.copyWith(
originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplaySource].
extension ReplaySourcePatterns on ReplaySource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReplayEqrpSource value)?  eqrp,TResult Function( ReplayKyoshinArchiveSource value)?  kyoshinArchive,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReplayEqrpSource() when eqrp != null:
return eqrp(_that);case ReplayKyoshinArchiveSource() when kyoshinArchive != null:
return kyoshinArchive(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReplayEqrpSource value)  eqrp,required TResult Function( ReplayKyoshinArchiveSource value)  kyoshinArchive,}){
final _that = this;
switch (_that) {
case ReplayEqrpSource():
return eqrp(_that);case ReplayKyoshinArchiveSource():
return kyoshinArchive(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReplayEqrpSource value)?  eqrp,TResult? Function( ReplayKyoshinArchiveSource value)?  kyoshinArchive,}){
final _that = this;
switch (_that) {
case ReplayEqrpSource() when eqrp != null:
return eqrp(_that);case ReplayKyoshinArchiveSource() when kyoshinArchive != null:
return kyoshinArchive(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ReplayFile file,  String name,  DateTime? originTime)?  eqrp,TResult Function( String label,  DateTime windowStart,  DateTime windowEnd,  DateTime? originTime,  bool isOriginTimeApproximate,  List<ReplayData> eewFrames,  KyoshinMonitorSource monitorSource)?  kyoshinArchive,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReplayEqrpSource() when eqrp != null:
return eqrp(_that.file,_that.name,_that.originTime);case ReplayKyoshinArchiveSource() when kyoshinArchive != null:
return kyoshinArchive(_that.label,_that.windowStart,_that.windowEnd,_that.originTime,_that.isOriginTimeApproximate,_that.eewFrames,_that.monitorSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ReplayFile file,  String name,  DateTime? originTime)  eqrp,required TResult Function( String label,  DateTime windowStart,  DateTime windowEnd,  DateTime? originTime,  bool isOriginTimeApproximate,  List<ReplayData> eewFrames,  KyoshinMonitorSource monitorSource)  kyoshinArchive,}) {final _that = this;
switch (_that) {
case ReplayEqrpSource():
return eqrp(_that.file,_that.name,_that.originTime);case ReplayKyoshinArchiveSource():
return kyoshinArchive(_that.label,_that.windowStart,_that.windowEnd,_that.originTime,_that.isOriginTimeApproximate,_that.eewFrames,_that.monitorSource);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ReplayFile file,  String name,  DateTime? originTime)?  eqrp,TResult? Function( String label,  DateTime windowStart,  DateTime windowEnd,  DateTime? originTime,  bool isOriginTimeApproximate,  List<ReplayData> eewFrames,  KyoshinMonitorSource monitorSource)?  kyoshinArchive,}) {final _that = this;
switch (_that) {
case ReplayEqrpSource() when eqrp != null:
return eqrp(_that.file,_that.name,_that.originTime);case ReplayKyoshinArchiveSource() when kyoshinArchive != null:
return kyoshinArchive(_that.label,_that.windowStart,_that.windowEnd,_that.originTime,_that.isOriginTimeApproximate,_that.eewFrames,_that.monitorSource);case _:
  return null;

}
}

}

/// @nodoc


class ReplayEqrpSource extends ReplaySource {
  const ReplayEqrpSource({required this.file, required this.name, required this.originTime}): super._();
  

 final  ReplayFile file;
 final  String name;
@override final  DateTime? originTime;

/// Create a copy of ReplaySource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayEqrpSourceCopyWith<ReplayEqrpSource> get copyWith => _$ReplayEqrpSourceCopyWithImpl<ReplayEqrpSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayEqrpSource&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name)&&(identical(other.originTime, originTime) || other.originTime == originTime));
}


@override
int get hashCode => Object.hash(runtimeType,file,name,originTime);

@override
String toString() {
  return 'ReplaySource.eqrp(file: $file, name: $name, originTime: $originTime)';
}


}

/// @nodoc
abstract mixin class $ReplayEqrpSourceCopyWith<$Res> implements $ReplaySourceCopyWith<$Res> {
  factory $ReplayEqrpSourceCopyWith(ReplayEqrpSource value, $Res Function(ReplayEqrpSource) _then) = _$ReplayEqrpSourceCopyWithImpl;
@override @useResult
$Res call({
 ReplayFile file, String name, DateTime? originTime
});




}
/// @nodoc
class _$ReplayEqrpSourceCopyWithImpl<$Res>
    implements $ReplayEqrpSourceCopyWith<$Res> {
  _$ReplayEqrpSourceCopyWithImpl(this._self, this._then);

  final ReplayEqrpSource _self;
  final $Res Function(ReplayEqrpSource) _then;

/// Create a copy of ReplaySource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? name = null,Object? originTime = freezed,}) {
  return _then(ReplayEqrpSource(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as ReplayFile,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class ReplayKyoshinArchiveSource extends ReplaySource {
  const ReplayKyoshinArchiveSource({required this.label, required this.windowStart, required this.windowEnd, required this.originTime, required this.isOriginTimeApproximate, required  List<ReplayData> eewFrames, required this.monitorSource}): _eewFrames = eewFrames,super._();
  

 final  String label;
 final  DateTime windowStart;
 final  DateTime windowEnd;
@override final  DateTime? originTime;
 final  bool isOriginTimeApproximate;
 final  List<ReplayData> _eewFrames;
 List<ReplayData> get eewFrames {
  if (_eewFrames is EqualUnmodifiableListView) return _eewFrames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eewFrames);
}

 final  KyoshinMonitorSource monitorSource;

/// Create a copy of ReplaySource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayKyoshinArchiveSourceCopyWith<ReplayKyoshinArchiveSource> get copyWith => _$ReplayKyoshinArchiveSourceCopyWithImpl<ReplayKyoshinArchiveSource>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayKyoshinArchiveSource&&(identical(other.label, label) || other.label == label)&&(identical(other.windowStart, windowStart) || other.windowStart == windowStart)&&(identical(other.windowEnd, windowEnd) || other.windowEnd == windowEnd)&&(identical(other.originTime, originTime) || other.originTime == originTime)&&(identical(other.isOriginTimeApproximate, isOriginTimeApproximate) || other.isOriginTimeApproximate == isOriginTimeApproximate)&&const DeepCollectionEquality().equals(other._eewFrames, _eewFrames)&&(identical(other.monitorSource, monitorSource) || other.monitorSource == monitorSource));
}


@override
int get hashCode => Object.hash(runtimeType,label,windowStart,windowEnd,originTime,isOriginTimeApproximate,const DeepCollectionEquality().hash(_eewFrames),monitorSource);

@override
String toString() {
  return 'ReplaySource.kyoshinArchive(label: $label, windowStart: $windowStart, windowEnd: $windowEnd, originTime: $originTime, isOriginTimeApproximate: $isOriginTimeApproximate, eewFrames: $eewFrames, monitorSource: $monitorSource)';
}


}

/// @nodoc
abstract mixin class $ReplayKyoshinArchiveSourceCopyWith<$Res> implements $ReplaySourceCopyWith<$Res> {
  factory $ReplayKyoshinArchiveSourceCopyWith(ReplayKyoshinArchiveSource value, $Res Function(ReplayKyoshinArchiveSource) _then) = _$ReplayKyoshinArchiveSourceCopyWithImpl;
@override @useResult
$Res call({
 String label, DateTime windowStart, DateTime windowEnd, DateTime? originTime, bool isOriginTimeApproximate, List<ReplayData> eewFrames, KyoshinMonitorSource monitorSource
});




}
/// @nodoc
class _$ReplayKyoshinArchiveSourceCopyWithImpl<$Res>
    implements $ReplayKyoshinArchiveSourceCopyWith<$Res> {
  _$ReplayKyoshinArchiveSourceCopyWithImpl(this._self, this._then);

  final ReplayKyoshinArchiveSource _self;
  final $Res Function(ReplayKyoshinArchiveSource) _then;

/// Create a copy of ReplaySource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? windowStart = null,Object? windowEnd = null,Object? originTime = freezed,Object? isOriginTimeApproximate = null,Object? eewFrames = null,Object? monitorSource = null,}) {
  return _then(ReplayKyoshinArchiveSource(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,windowStart: null == windowStart ? _self.windowStart : windowStart // ignore: cast_nullable_to_non_nullable
as DateTime,windowEnd: null == windowEnd ? _self.windowEnd : windowEnd // ignore: cast_nullable_to_non_nullable
as DateTime,originTime: freezed == originTime ? _self.originTime : originTime // ignore: cast_nullable_to_non_nullable
as DateTime?,isOriginTimeApproximate: null == isOriginTimeApproximate ? _self.isOriginTimeApproximate : isOriginTimeApproximate // ignore: cast_nullable_to_non_nullable
as bool,eewFrames: null == eewFrames ? _self._eewFrames : eewFrames // ignore: cast_nullable_to_non_nullable
as List<ReplayData>,monitorSource: null == monitorSource ? _self.monitorSource : monitorSource // ignore: cast_nullable_to_non_nullable
as KyoshinMonitorSource,
  ));
}


}

// dart format on
