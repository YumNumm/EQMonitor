// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ntp_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NtpStateModel {

 int? get offset; DateTime? get updatedAt;
/// Create a copy of NtpStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NtpStateModelCopyWith<NtpStateModel> get copyWith => _$NtpStateModelCopyWithImpl<NtpStateModel>(this as NtpStateModel, _$identity);

  /// Serializes this NtpStateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NtpStateModel&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,updatedAt);

@override
String toString() {
  return 'NtpStateModel(offset: $offset, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $NtpStateModelCopyWith<$Res>  {
  factory $NtpStateModelCopyWith(NtpStateModel value, $Res Function(NtpStateModel) _then) = _$NtpStateModelCopyWithImpl;
@useResult
$Res call({
 int? offset, DateTime? updatedAt
});




}
/// @nodoc
class _$NtpStateModelCopyWithImpl<$Res>
    implements $NtpStateModelCopyWith<$Res> {
  _$NtpStateModelCopyWithImpl(this._self, this._then);

  final NtpStateModel _self;
  final $Res Function(NtpStateModel) _then;

/// Create a copy of NtpStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offset = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NtpStateModel implements NtpStateModel {
  const _NtpStateModel({this.offset, this.updatedAt});
  factory _NtpStateModel.fromJson(Map<String, dynamic> json) => _$NtpStateModelFromJson(json);

@override final  int? offset;
@override final  DateTime? updatedAt;

/// Create a copy of NtpStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NtpStateModelCopyWith<_NtpStateModel> get copyWith => __$NtpStateModelCopyWithImpl<_NtpStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NtpStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NtpStateModel&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,updatedAt);

@override
String toString() {
  return 'NtpStateModel(offset: $offset, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$NtpStateModelCopyWith<$Res> implements $NtpStateModelCopyWith<$Res> {
  factory _$NtpStateModelCopyWith(_NtpStateModel value, $Res Function(_NtpStateModel) _then) = __$NtpStateModelCopyWithImpl;
@override @useResult
$Res call({
 int? offset, DateTime? updatedAt
});




}
/// @nodoc
class __$NtpStateModelCopyWithImpl<$Res>
    implements _$NtpStateModelCopyWith<$Res> {
  __$NtpStateModelCopyWithImpl(this._self, this._then);

  final _NtpStateModel _self;
  final $Res Function(_NtpStateModel) _then;

/// Create a copy of NtpStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offset = freezed,Object? updatedAt = freezed,}) {
  return _then(_NtpStateModel(
offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
