// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_node_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapNodeIdentity {

 MapNodeKey get key; MapNodeTypeId get type;
/// Create a copy of MapNodeIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapNodeIdentityCopyWith<MapNodeIdentity> get copyWith => _$MapNodeIdentityCopyWithImpl<MapNodeIdentity>(this as MapNodeIdentity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapNodeIdentity&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,key,type);

@override
String toString() {
  return 'MapNodeIdentity(key: $key, type: $type)';
}


}

/// @nodoc
abstract mixin class $MapNodeIdentityCopyWith<$Res>  {
  factory $MapNodeIdentityCopyWith(MapNodeIdentity value, $Res Function(MapNodeIdentity) _then) = _$MapNodeIdentityCopyWithImpl;
@useResult
$Res call({
 MapNodeKey key, MapNodeTypeId type
});




}
/// @nodoc
class _$MapNodeIdentityCopyWithImpl<$Res>
    implements $MapNodeIdentityCopyWith<$Res> {
  _$MapNodeIdentityCopyWithImpl(this._self, this._then);

  final MapNodeIdentity _self;
  final $Res Function(MapNodeIdentity) _then;

/// Create a copy of MapNodeIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? type = null,}) {
  return _then(MapNodeIdentity._(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as MapNodeKey,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MapNodeTypeId,
  ));
}

}



/// @nodoc


class _MapNodeIdentity implements MapNodeIdentity {
  const _MapNodeIdentity({required this.key, required this.type});


@override final  MapNodeKey key;
@override final  MapNodeTypeId type;

/// Create a copy of MapNodeIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapNodeIdentityCopyWith<_MapNodeIdentity> get copyWith => __$MapNodeIdentityCopyWithImpl<_MapNodeIdentity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapNodeIdentity&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,key,type);

@override
String toString() {
  return 'MapNodeIdentity._(key: $key, type: $type)';
}


}

/// @nodoc
abstract mixin class _$MapNodeIdentityCopyWith<$Res> implements $MapNodeIdentityCopyWith<$Res> {
  factory _$MapNodeIdentityCopyWith(_MapNodeIdentity value, $Res Function(_MapNodeIdentity) _then) = __$MapNodeIdentityCopyWithImpl;
@override @useResult
$Res call({
 MapNodeKey key, MapNodeTypeId type
});




}
/// @nodoc
class __$MapNodeIdentityCopyWithImpl<$Res>
    implements _$MapNodeIdentityCopyWith<$Res> {
  __$MapNodeIdentityCopyWithImpl(this._self, this._then);

  final _MapNodeIdentity _self;
  final $Res Function(_MapNodeIdentity) _then;

/// Create a copy of MapNodeIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? type = null,}) {
  return _then(_MapNodeIdentity(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as MapNodeKey,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MapNodeTypeId,
  ));
}


}

// dart format on
