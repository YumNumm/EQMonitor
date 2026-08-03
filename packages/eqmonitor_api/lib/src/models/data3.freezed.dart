// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Data3 {

 List<HypocenterResponseItem> get items;@JsonKey(includeIfNull: false, name: 'next_token') String? get nextToken;
/// Create a copy of Data3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Data3CopyWith<Data3> get copyWith => _$Data3CopyWithImpl<Data3>(this as Data3, _$identity);

  /// Serializes this Data3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data3&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken);

@override
String toString() {
  return 'Data3(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class $Data3CopyWith<$Res>  {
  factory $Data3CopyWith(Data3 value, $Res Function(Data3) _then) = _$Data3CopyWithImpl;
@useResult
$Res call({
 List<HypocenterResponseItem> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken
});




}
/// @nodoc
class _$Data3CopyWithImpl<$Res>
    implements $Data3CopyWith<$Res> {
  _$Data3CopyWithImpl(this._self, this._then);

  final Data3 _self;
  final $Res Function(Data3) _then;

/// Create a copy of Data3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<HypocenterResponseItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Data3].
extension Data3Patterns on Data3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data3 value)  $default,){
final _that = this;
switch (_that) {
case _Data3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data3 value)?  $default,){
final _that = this;
switch (_that) {
case _Data3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HypocenterResponseItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data3() when $default != null:
return $default(_that.items,_that.nextToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HypocenterResponseItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken)  $default,) {final _that = this;
switch (_that) {
case _Data3():
return $default(_that.items,_that.nextToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HypocenterResponseItem> items, @JsonKey(includeIfNull: false, name: 'next_token')  String? nextToken)?  $default,) {final _that = this;
switch (_that) {
case _Data3() when $default != null:
return $default(_that.items,_that.nextToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data3 implements Data3 {
  const _Data3({required final  List<HypocenterResponseItem> items, @JsonKey(includeIfNull: false, name: 'next_token') this.nextToken}): _items = items;
  factory _Data3.fromJson(Map<String, dynamic> json) => _$Data3FromJson(json);

 final  List<HypocenterResponseItem> _items;
@override List<HypocenterResponseItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(includeIfNull: false, name: 'next_token') final  String? nextToken;

/// Create a copy of Data3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Data3CopyWith<_Data3> get copyWith => __$Data3CopyWithImpl<_Data3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Data3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data3&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken);

@override
String toString() {
  return 'Data3(items: $items, nextToken: $nextToken)';
}


}

/// @nodoc
abstract mixin class _$Data3CopyWith<$Res> implements $Data3CopyWith<$Res> {
  factory _$Data3CopyWith(_Data3 value, $Res Function(_Data3) _then) = __$Data3CopyWithImpl;
@override @useResult
$Res call({
 List<HypocenterResponseItem> items,@JsonKey(includeIfNull: false, name: 'next_token') String? nextToken
});




}
/// @nodoc
class __$Data3CopyWithImpl<$Res>
    implements _$Data3CopyWith<$Res> {
  __$Data3CopyWithImpl(this._self, this._then);

  final _Data3 _self;
  final $Res Function(_Data3) _then;

/// Create a copy of Data3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,}) {
  return _then(_Data3(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<HypocenterResponseItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
