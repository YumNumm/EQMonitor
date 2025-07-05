// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_file_header.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplayFileHeader {

 int get version; String get softwareName; DateTime get startTime; DateTime get endTime; ReplayFileCompressionMode get compressionMode;
/// Create a copy of ReplayFileHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayFileHeaderCopyWith<ReplayFileHeader> get copyWith => _$ReplayFileHeaderCopyWithImpl<ReplayFileHeader>(this as ReplayFileHeader, _$identity);

  /// Serializes this ReplayFileHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayFileHeader&&(identical(other.version, version) || other.version == version)&&(identical(other.softwareName, softwareName) || other.softwareName == softwareName)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.compressionMode, compressionMode) || other.compressionMode == compressionMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,softwareName,startTime,endTime,compressionMode);

@override
String toString() {
  return 'ReplayFileHeader(version: $version, softwareName: $softwareName, startTime: $startTime, endTime: $endTime, compressionMode: $compressionMode)';
}


}

/// @nodoc
abstract mixin class $ReplayFileHeaderCopyWith<$Res>  {
  factory $ReplayFileHeaderCopyWith(ReplayFileHeader value, $Res Function(ReplayFileHeader) _then) = _$ReplayFileHeaderCopyWithImpl;
@useResult
$Res call({
 int version, String softwareName, DateTime startTime, DateTime endTime, ReplayFileCompressionMode compressionMode
});




}
/// @nodoc
class _$ReplayFileHeaderCopyWithImpl<$Res>
    implements $ReplayFileHeaderCopyWith<$Res> {
  _$ReplayFileHeaderCopyWithImpl(this._self, this._then);

  final ReplayFileHeader _self;
  final $Res Function(ReplayFileHeader) _then;

/// Create a copy of ReplayFileHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? softwareName = null,Object? startTime = null,Object? endTime = null,Object? compressionMode = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,softwareName: null == softwareName ? _self.softwareName : softwareName // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,compressionMode: null == compressionMode ? _self.compressionMode : compressionMode // ignore: cast_nullable_to_non_nullable
as ReplayFileCompressionMode,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ReplayFileHeader implements ReplayFileHeader {
  const _ReplayFileHeader({required this.version, required this.softwareName, required this.startTime, required this.endTime, required this.compressionMode});
  factory _ReplayFileHeader.fromJson(Map<String, dynamic> json) => _$ReplayFileHeaderFromJson(json);

@override final  int version;
@override final  String softwareName;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  ReplayFileCompressionMode compressionMode;

/// Create a copy of ReplayFileHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayFileHeaderCopyWith<_ReplayFileHeader> get copyWith => __$ReplayFileHeaderCopyWithImpl<_ReplayFileHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplayFileHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayFileHeader&&(identical(other.version, version) || other.version == version)&&(identical(other.softwareName, softwareName) || other.softwareName == softwareName)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.compressionMode, compressionMode) || other.compressionMode == compressionMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,softwareName,startTime,endTime,compressionMode);

@override
String toString() {
  return 'ReplayFileHeader(version: $version, softwareName: $softwareName, startTime: $startTime, endTime: $endTime, compressionMode: $compressionMode)';
}


}

/// @nodoc
abstract mixin class _$ReplayFileHeaderCopyWith<$Res> implements $ReplayFileHeaderCopyWith<$Res> {
  factory _$ReplayFileHeaderCopyWith(_ReplayFileHeader value, $Res Function(_ReplayFileHeader) _then) = __$ReplayFileHeaderCopyWithImpl;
@override @useResult
$Res call({
 int version, String softwareName, DateTime startTime, DateTime endTime, ReplayFileCompressionMode compressionMode
});




}
/// @nodoc
class __$ReplayFileHeaderCopyWithImpl<$Res>
    implements _$ReplayFileHeaderCopyWith<$Res> {
  __$ReplayFileHeaderCopyWithImpl(this._self, this._then);

  final _ReplayFileHeader _self;
  final $Res Function(_ReplayFileHeader) _then;

/// Create a copy of ReplayFileHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? softwareName = null,Object? startTime = null,Object? endTime = null,Object? compressionMode = null,}) {
  return _then(_ReplayFileHeader(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,softwareName: null == softwareName ? _self.softwareName : softwareName // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,compressionMode: null == compressionMode ? _self.compressionMode : compressionMode // ignore: cast_nullable_to_non_nullable
as ReplayFileCompressionMode,
  ));
}


}

// dart format on
