// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_replay_file_detail_response_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminReplayFileDetailResponseItem {

 String get id; String get startTime; String get endTime; String get objectKey;@JsonKey(includeIfNull: true) num? get fileSizeBytes; String get createdAt;@JsonKey(includeIfNull: true) String? get downloadUrl; List<ReplayFileTrigger> get triggers;
/// Create a copy of AdminReplayFileDetailResponseItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminReplayFileDetailResponseItemCopyWith<AdminReplayFileDetailResponseItem> get copyWith => _$AdminReplayFileDetailResponseItemCopyWithImpl<AdminReplayFileDetailResponseItem>(this as AdminReplayFileDetailResponseItem, _$identity);

  /// Serializes this AdminReplayFileDetailResponseItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminReplayFileDetailResponseItem&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&const DeepCollectionEquality().equals(other.triggers, triggers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,objectKey,fileSizeBytes,createdAt,downloadUrl,const DeepCollectionEquality().hash(triggers));

@override
String toString() {
  return 'AdminReplayFileDetailResponseItem(id: $id, startTime: $startTime, endTime: $endTime, objectKey: $objectKey, fileSizeBytes: $fileSizeBytes, createdAt: $createdAt, downloadUrl: $downloadUrl, triggers: $triggers)';
}


}

/// @nodoc
abstract mixin class $AdminReplayFileDetailResponseItemCopyWith<$Res>  {
  factory $AdminReplayFileDetailResponseItemCopyWith(AdminReplayFileDetailResponseItem value, $Res Function(AdminReplayFileDetailResponseItem) _then) = _$AdminReplayFileDetailResponseItemCopyWithImpl;
@useResult
$Res call({
 String id, String startTime, String endTime, String objectKey,@JsonKey(includeIfNull: true) num? fileSizeBytes, String createdAt,@JsonKey(includeIfNull: true) String? downloadUrl, List<ReplayFileTrigger> triggers
});




}
/// @nodoc
class _$AdminReplayFileDetailResponseItemCopyWithImpl<$Res>
    implements $AdminReplayFileDetailResponseItemCopyWith<$Res> {
  _$AdminReplayFileDetailResponseItemCopyWithImpl(this._self, this._then);

  final AdminReplayFileDetailResponseItem _self;
  final $Res Function(AdminReplayFileDetailResponseItem) _then;

/// Create a copy of AdminReplayFileDetailResponseItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? objectKey = null,Object? fileSizeBytes = freezed,Object? createdAt = null,Object? downloadUrl = freezed,Object? triggers = null,}) {
  return _then(AdminReplayFileDetailResponseItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: freezed == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as num?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,triggers: null == triggers ? _self.triggers : triggers // ignore: cast_nullable_to_non_nullable
as List<ReplayFileTrigger>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminReplayFileDetailResponseItem].
extension AdminReplayFileDetailResponseItemPatterns on AdminReplayFileDetailResponseItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminReplayFileDetailResponseItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponseItem() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminReplayFileDetailResponseItem value)  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponseItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminReplayFileDetailResponseItem value)?  $default,){
final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponseItem() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String startTime,  String endTime,  String objectKey, @JsonKey(includeIfNull: true)  num? fileSizeBytes,  String createdAt, @JsonKey(includeIfNull: true)  String? downloadUrl,  List<ReplayFileTrigger> triggers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponseItem() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl,_that.triggers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String startTime,  String endTime,  String objectKey, @JsonKey(includeIfNull: true)  num? fileSizeBytes,  String createdAt, @JsonKey(includeIfNull: true)  String? downloadUrl,  List<ReplayFileTrigger> triggers)  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponseItem():
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl,_that.triggers);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String startTime,  String endTime,  String objectKey, @JsonKey(includeIfNull: true)  num? fileSizeBytes,  String createdAt, @JsonKey(includeIfNull: true)  String? downloadUrl,  List<ReplayFileTrigger> triggers)?  $default,) {final _that = this;
switch (_that) {
case _AdminReplayFileDetailResponseItem() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.objectKey,_that.fileSizeBytes,_that.createdAt,_that.downloadUrl,_that.triggers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminReplayFileDetailResponseItem implements AdminReplayFileDetailResponseItem {
  const _AdminReplayFileDetailResponseItem({required this.id, required this.startTime, required this.endTime, required this.objectKey, @JsonKey(includeIfNull: true) required this.fileSizeBytes, required this.createdAt, @JsonKey(includeIfNull: true) required this.downloadUrl, required  List<ReplayFileTrigger> triggers}): _triggers = triggers;
  factory _AdminReplayFileDetailResponseItem.fromJson(Map<String, dynamic> json) => _$AdminReplayFileDetailResponseItemFromJson(json);

@override final  String id;
@override final  String startTime;
@override final  String endTime;
@override final  String objectKey;
@override@JsonKey(includeIfNull: true) final  num? fileSizeBytes;
@override final  String createdAt;
@override@JsonKey(includeIfNull: true) final  String? downloadUrl;
 final  List<ReplayFileTrigger> _triggers;
@override List<ReplayFileTrigger> get triggers {
  if (_triggers is EqualUnmodifiableListView) return _triggers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_triggers);
}


/// Create a copy of AdminReplayFileDetailResponseItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminReplayFileDetailResponseItemCopyWith<_AdminReplayFileDetailResponseItem> get copyWith => __$AdminReplayFileDetailResponseItemCopyWithImpl<_AdminReplayFileDetailResponseItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminReplayFileDetailResponseItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminReplayFileDetailResponseItem&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.objectKey, objectKey) || other.objectKey == objectKey)&&(identical(other.fileSizeBytes, fileSizeBytes) || other.fileSizeBytes == fileSizeBytes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&const DeepCollectionEquality().equals(other._triggers, _triggers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,objectKey,fileSizeBytes,createdAt,downloadUrl,const DeepCollectionEquality().hash(_triggers));

@override
String toString() {
  return 'AdminReplayFileDetailResponseItem(id: $id, startTime: $startTime, endTime: $endTime, objectKey: $objectKey, fileSizeBytes: $fileSizeBytes, createdAt: $createdAt, downloadUrl: $downloadUrl, triggers: $triggers)';
}


}

/// @nodoc
abstract mixin class _$AdminReplayFileDetailResponseItemCopyWith<$Res> implements $AdminReplayFileDetailResponseItemCopyWith<$Res> {
  factory _$AdminReplayFileDetailResponseItemCopyWith(_AdminReplayFileDetailResponseItem value, $Res Function(_AdminReplayFileDetailResponseItem) _then) = __$AdminReplayFileDetailResponseItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String startTime, String endTime, String objectKey,@JsonKey(includeIfNull: true) num? fileSizeBytes, String createdAt,@JsonKey(includeIfNull: true) String? downloadUrl, List<ReplayFileTrigger> triggers
});




}
/// @nodoc
class __$AdminReplayFileDetailResponseItemCopyWithImpl<$Res>
    implements _$AdminReplayFileDetailResponseItemCopyWith<$Res> {
  __$AdminReplayFileDetailResponseItemCopyWithImpl(this._self, this._then);

  final _AdminReplayFileDetailResponseItem _self;
  final $Res Function(_AdminReplayFileDetailResponseItem) _then;

/// Create a copy of AdminReplayFileDetailResponseItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? objectKey = null,Object? fileSizeBytes = freezed,Object? createdAt = null,Object? downloadUrl = freezed,Object? triggers = null,}) {
  return _then(_AdminReplayFileDetailResponseItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,objectKey: null == objectKey ? _self.objectKey : objectKey // ignore: cast_nullable_to_non_nullable
as String,fileSizeBytes: freezed == fileSizeBytes ? _self.fileSizeBytes : fileSizeBytes // ignore: cast_nullable_to_non_nullable
as num?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,downloadUrl: freezed == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String?,triggers: null == triggers ? _self._triggers : triggers // ignore: cast_nullable_to_non_nullable
as List<ReplayFileTrigger>,
  ));
}


}

// dart format on
