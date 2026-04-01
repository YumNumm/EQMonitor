// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramItem {

 TsunamiTelegramHeader get telegram; TsunamiTelegramBody get body;
/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramItemCopyWith<TsunamiTelegramItem> get copyWith => _$TsunamiTelegramItemCopyWithImpl<TsunamiTelegramItem>(this as TsunamiTelegramItem, _$identity);

  /// Serializes this TsunamiTelegramItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramItem&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,body);

@override
String toString() {
  return 'TsunamiTelegramItem(telegram: $telegram, body: $body)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramItemCopyWith<$Res>  {
  factory $TsunamiTelegramItemCopyWith(TsunamiTelegramItem value, $Res Function(TsunamiTelegramItem) _then) = _$TsunamiTelegramItemCopyWithImpl;
@useResult
$Res call({
 TsunamiTelegramHeader telegram, TsunamiTelegramBody body
});


$TsunamiTelegramHeaderCopyWith<$Res> get telegram;$TsunamiTelegramBodyCopyWith<$Res> get body;

}
/// @nodoc
class _$TsunamiTelegramItemCopyWithImpl<$Res>
    implements $TsunamiTelegramItemCopyWith<$Res> {
  _$TsunamiTelegramItemCopyWithImpl(this._self, this._then);

  final TsunamiTelegramItem _self;
  final $Res Function(TsunamiTelegramItem) _then;

/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegram = null,Object? body = null,}) {
  return _then(_self.copyWith(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramHeader,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramBody,
  ));
}
/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramHeaderCopyWith<$Res> get telegram {
  
  return $TsunamiTelegramHeaderCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramBodyCopyWith<$Res> get body {
  
  return $TsunamiTelegramBodyCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiTelegramItem].
extension TsunamiTelegramItemPatterns on TsunamiTelegramItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramItem value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramItem value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiTelegramHeader telegram,  TsunamiTelegramBody body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramItem() when $default != null:
return $default(_that.telegram,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiTelegramHeader telegram,  TsunamiTelegramBody body)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramItem():
return $default(_that.telegram,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiTelegramHeader telegram,  TsunamiTelegramBody body)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramItem() when $default != null:
return $default(_that.telegram,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramItem implements TsunamiTelegramItem {
  const _TsunamiTelegramItem({required this.telegram, required this.body});
  factory _TsunamiTelegramItem.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramItemFromJson(json);

@override final  TsunamiTelegramHeader telegram;
@override final  TsunamiTelegramBody body;

/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramItemCopyWith<_TsunamiTelegramItem> get copyWith => __$TsunamiTelegramItemCopyWithImpl<_TsunamiTelegramItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramItem&&(identical(other.telegram, telegram) || other.telegram == telegram)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram,body);

@override
String toString() {
  return 'TsunamiTelegramItem(telegram: $telegram, body: $body)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramItemCopyWith<$Res> implements $TsunamiTelegramItemCopyWith<$Res> {
  factory _$TsunamiTelegramItemCopyWith(_TsunamiTelegramItem value, $Res Function(_TsunamiTelegramItem) _then) = __$TsunamiTelegramItemCopyWithImpl;
@override @useResult
$Res call({
 TsunamiTelegramHeader telegram, TsunamiTelegramBody body
});


@override $TsunamiTelegramHeaderCopyWith<$Res> get telegram;@override $TsunamiTelegramBodyCopyWith<$Res> get body;

}
/// @nodoc
class __$TsunamiTelegramItemCopyWithImpl<$Res>
    implements _$TsunamiTelegramItemCopyWith<$Res> {
  __$TsunamiTelegramItemCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramItem _self;
  final $Res Function(_TsunamiTelegramItem) _then;

/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegram = null,Object? body = null,}) {
  return _then(_TsunamiTelegramItem(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramHeader,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramBody,
  ));
}

/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramHeaderCopyWith<$Res> get telegram {
  
  return $TsunamiTelegramHeaderCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}/// Create a copy of TsunamiTelegramItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramBodyCopyWith<$Res> get body {
  
  return $TsunamiTelegramBodyCopyWith<$Res>(_self.body, (value) {
    return _then(_self.copyWith(body: value));
  });
}
}

// dart format on
