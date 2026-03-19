// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tsunami {

 String get id;@JsonKey(name: 'event_ids') List<String> get eventIds; List<TsunamiTelegramItem> get telegrams;
/// Create a copy of Tsunami
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiCopyWith<Tsunami> get copyWith => _$TsunamiCopyWithImpl<Tsunami>(this as Tsunami, _$identity);

  /// Serializes this Tsunami to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tsunami&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&const DeepCollectionEquality().equals(other.telegrams, telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(eventIds),const DeepCollectionEquality().hash(telegrams));

@override
String toString() {
  return 'Tsunami(id: $id, eventIds: $eventIds, telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class $TsunamiCopyWith<$Res>  {
  factory $TsunamiCopyWith(Tsunami value, $Res Function(Tsunami) _then) = _$TsunamiCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds, List<TsunamiTelegramItem> telegrams
});




}
/// @nodoc
class _$TsunamiCopyWithImpl<$Res>
    implements $TsunamiCopyWith<$Res> {
  _$TsunamiCopyWithImpl(this._self, this._then);

  final Tsunami _self;
  final $Res Function(Tsunami) _then;

/// Create a copy of Tsunami
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventIds = null,Object? telegrams = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,telegrams: null == telegrams ? _self.telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [Tsunami].
extension TsunamiPatterns on Tsunami {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tsunami value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tsunami() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tsunami value)  $default,){
final _that = this;
switch (_that) {
case _Tsunami():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tsunami value)?  $default,){
final _that = this;
switch (_that) {
case _Tsunami() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds,  List<TsunamiTelegramItem> telegrams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tsunami() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds,  List<TsunamiTelegramItem> telegrams)  $default,) {final _that = this;
switch (_that) {
case _Tsunami():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'event_ids')  List<String> eventIds,  List<TsunamiTelegramItem> telegrams)?  $default,) {final _that = this;
switch (_that) {
case _Tsunami() when $default != null:
return $default(_that.id,_that.eventIds,_that.telegrams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tsunami implements Tsunami {
  const _Tsunami({required this.id, @JsonKey(name: 'event_ids') required final  List<String> eventIds, required final  List<TsunamiTelegramItem> telegrams}): _eventIds = eventIds,_telegrams = telegrams;
  factory _Tsunami.fromJson(Map<String, dynamic> json) => _$TsunamiFromJson(json);

@override final  String id;
 final  List<String> _eventIds;
@override@JsonKey(name: 'event_ids') List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}

 final  List<TsunamiTelegramItem> _telegrams;
@override List<TsunamiTelegramItem> get telegrams {
  if (_telegrams is EqualUnmodifiableListView) return _telegrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_telegrams);
}


/// Create a copy of Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiCopyWith<_Tsunami> get copyWith => __$TsunamiCopyWithImpl<_Tsunami>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tsunami&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&const DeepCollectionEquality().equals(other._telegrams, _telegrams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_eventIds),const DeepCollectionEquality().hash(_telegrams));

@override
String toString() {
  return 'Tsunami(id: $id, eventIds: $eventIds, telegrams: $telegrams)';
}


}

/// @nodoc
abstract mixin class _$TsunamiCopyWith<$Res> implements $TsunamiCopyWith<$Res> {
  factory _$TsunamiCopyWith(_Tsunami value, $Res Function(_Tsunami) _then) = __$TsunamiCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'event_ids') List<String> eventIds, List<TsunamiTelegramItem> telegrams
});




}
/// @nodoc
class __$TsunamiCopyWithImpl<$Res>
    implements _$TsunamiCopyWith<$Res> {
  __$TsunamiCopyWithImpl(this._self, this._then);

  final _Tsunami _self;
  final $Res Function(_Tsunami) _then;

/// Create a copy of Tsunami
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventIds = null,Object? telegrams = null,}) {
  return _then(_Tsunami(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,telegrams: null == telegrams ? _self._telegrams : telegrams // ignore: cast_nullable_to_non_nullable
as List<TsunamiTelegramItem>,
  ));
}


}

// dart format on
