// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiDetail {

 String get id;@JsonKey(name: 'event_ids') List<String> get eventIds; List<TsunamiTelegramHeaderOnlyItem> get telegrams;
/// Create a copy of TsunamiDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiDetailCopyWith<TsunamiDetail> get copyWith => _$TsunamiDetailCopyWithImpl<TsunamiDetail>(this as TsunamiDetail, _$identity);

  /// Serializes this TsunamiDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiDetail&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&const DeepCollectionEquality().equals(other.telegrams, telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(eventIds),const DeepCollectionEquality().hash(telegrams));

@override
String toString() {
  return 'TsunamiDetail(id: $id, eventIds: $eventIds, telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class $TsunamiDetailCopyWith<$Res>  {
  factory $TsunamiDetailCopyWith(TsunamiDetail value, $Res Function(TsunamiDetail) _then) = _$TsunamiDetailCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds, List<TsunamiTelegramHeaderOnlyItem> telegrams
});




}
/// @nodoc
class _$TsunamiDetailCopyWithImpl<$Res>
    implements $TsunamiDetailCopyWith<$Res> {
  _$TsunamiDetailCopyWithImpl(this._self, this._then);

  final TsunamiDetail _self;
  final $Res Function(TsunamiDetail) _then;

/// Create a copy of TsunamiDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventIds = null,Object? telegrams = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramHeaderOnlyItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TsunamiDetail].
extension TsunamiDetailPatterns on TsunamiDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiDetail value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds,  List<TsunamiTelegramHeaderOnlyItem> telegrams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiDetail() when $default != null:
return $default(_that.id,_that.eventIds,_that.telegrams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds,  List<TsunamiTelegramHeaderOnlyItem> telegrams)  $default,) {final _that = this;
switch (_that) {
case _TsunamiDetail():
return $default(_that.id,_that.eventIds,_that.telegrams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds,  List<TsunamiTelegramHeaderOnlyItem> telegrams)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiDetail() when $default != null:
return $default(_that.id,_that.eventIds,_that.telegrams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiDetail implements TsunamiDetail {
  const _TsunamiDetail({required this.id, @JsonKey(name: 'event_ids') required final  List<String> eventIds, required final  List<TsunamiTelegramHeaderOnlyItem> telegrams}): _eventIds = eventIds,_telegrams = telegrams;
  factory _TsunamiDetail.fromJson(Map<String, dynamic> json) => _$TsunamiDetailFromJson(json);

@override final  String id;
 final  List<String> _eventIds;
@override@JsonKey(name: 'event_ids') List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}

 final  List<TsunamiTelegramHeaderOnlyItem> _telegrams;
@override List<TsunamiTelegramHeaderOnlyItem> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}


/// Create a copy of TsunamiDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiDetailCopyWith<_TsunamiDetail> get copyWith => __$TsunamiDetailCopyWithImpl<_TsunamiDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiDetail&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&const DeepCollectionEquality().equals(other._telegrams, _telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_eventIds),const DeepCollectionEquality().hash(_telegrams));

@override
String toString() {
  return 'TsunamiDetail(id: $id, eventIds: $eventIds, telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class _$TsunamiDetailCopyWith<$Res> implements $TsunamiDetailCopyWith<$Res> {
  factory _$TsunamiDetailCopyWith(_TsunamiDetail value, $Res Function(_TsunamiDetail) _then) = __$TsunamiDetailCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds, List<TsunamiTelegramHeaderOnlyItem> telegrams
});




}
/// @nodoc
class __$TsunamiDetailCopyWithImpl<$Res>
    implements _$TsunamiDetailCopyWith<$Res> {
  __$TsunamiDetailCopyWithImpl(this._self, this._then);

  final _TsunamiDetail _self;
  final $Res Function(_TsunamiDetail) _then;

/// Create a copy of TsunamiDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventIds = null,Object? telegrams = null,}) {
  return _then(_TsunamiDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramHeaderOnlyItem>,
  ));
}


}

// dart format on
