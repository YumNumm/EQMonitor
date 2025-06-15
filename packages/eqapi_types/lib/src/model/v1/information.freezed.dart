// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InformationV1 {

@JsonKey(unknownEnumValue: InformationAuthor.unknown, defaultValue: InformationAuthor.unknown) InformationAuthor get author; Map<String, dynamic> get body;@JsonKey(name: 'created_at') DateTime get createdAt; int get id;@JsonKey(unknownEnumValue: InformationLevel.info, defaultValue: InformationLevel.info) InformationLevel get level; String get title; String get type;
/// Create a copy of InformationV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InformationV1CopyWith<InformationV1> get copyWith => _$InformationV1CopyWithImpl<InformationV1>(this as InformationV1, _$identity);

  /// Serializes this InformationV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InformationV1&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.body, body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,const DeepCollectionEquality().hash(body),createdAt,id,level,title,type);

@override
String toString() {
  return 'InformationV1(author: $author, body: $body, createdAt: $createdAt, id: $id, level: $level, title: $title, type: $type)';
}


}

/// @nodoc
abstract mixin class $InformationV1CopyWith<$Res>  {
  factory $InformationV1CopyWith(InformationV1 value, $Res Function(InformationV1) _then) = _$InformationV1CopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: InformationAuthor.unknown, defaultValue: InformationAuthor.unknown) InformationAuthor author, Map<String, dynamic> body,@JsonKey(name: 'created_at') DateTime createdAt, int id,@JsonKey(unknownEnumValue: InformationLevel.info, defaultValue: InformationLevel.info) InformationLevel level, String title, String type
});




}
/// @nodoc
class _$InformationV1CopyWithImpl<$Res>
    implements $InformationV1CopyWith<$Res> {
  _$InformationV1CopyWithImpl(this._self, this._then);

  final InformationV1 _self;
  final $Res Function(InformationV1) _then;

/// Create a copy of InformationV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? author = null,Object? body = null,Object? createdAt = null,Object? id = null,Object? level = null,Object? title = null,Object? type = null,}) {
  return _then(_self.copyWith(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as InformationAuthor,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as InformationLevel,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _InformationV1 implements InformationV1 {
  const _InformationV1({@JsonKey(unknownEnumValue: InformationAuthor.unknown, defaultValue: InformationAuthor.unknown) required this.author, required final  Map<String, dynamic> body, @JsonKey(name: 'created_at') required this.createdAt, required this.id, @JsonKey(unknownEnumValue: InformationLevel.info, defaultValue: InformationLevel.info) required this.level, required this.title, required this.type}): _body = body;
  factory _InformationV1.fromJson(Map<String, dynamic> json) => _$InformationV1FromJson(json);

@override@JsonKey(unknownEnumValue: InformationAuthor.unknown, defaultValue: InformationAuthor.unknown) final  InformationAuthor author;
 final  Map<String, dynamic> _body;
@override Map<String, dynamic> get body {
  if (_body is EqualUnmodifiableMapView) return _body;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_body);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override final  int id;
@override@JsonKey(unknownEnumValue: InformationLevel.info, defaultValue: InformationLevel.info) final  InformationLevel level;
@override final  String title;
@override final  String type;

/// Create a copy of InformationV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InformationV1CopyWith<_InformationV1> get copyWith => __$InformationV1CopyWithImpl<_InformationV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InformationV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InformationV1&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._body, _body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.level, level) || other.level == level)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,const DeepCollectionEquality().hash(_body),createdAt,id,level,title,type);

@override
String toString() {
  return 'InformationV1(author: $author, body: $body, createdAt: $createdAt, id: $id, level: $level, title: $title, type: $type)';
}


}

/// @nodoc
abstract mixin class _$InformationV1CopyWith<$Res> implements $InformationV1CopyWith<$Res> {
  factory _$InformationV1CopyWith(_InformationV1 value, $Res Function(_InformationV1) _then) = __$InformationV1CopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: InformationAuthor.unknown, defaultValue: InformationAuthor.unknown) InformationAuthor author, Map<String, dynamic> body,@JsonKey(name: 'created_at') DateTime createdAt, int id,@JsonKey(unknownEnumValue: InformationLevel.info, defaultValue: InformationLevel.info) InformationLevel level, String title, String type
});




}
/// @nodoc
class __$InformationV1CopyWithImpl<$Res>
    implements _$InformationV1CopyWith<$Res> {
  __$InformationV1CopyWithImpl(this._self, this._then);

  final _InformationV1 _self;
  final $Res Function(_InformationV1) _then;

/// Create a copy of InformationV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? author = null,Object? body = null,Object? createdAt = null,Object? id = null,Object? level = null,Object? title = null,Object? type = null,}) {
  return _then(_InformationV1(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as InformationAuthor,body: null == body ? _self._body : body // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as InformationLevel,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
