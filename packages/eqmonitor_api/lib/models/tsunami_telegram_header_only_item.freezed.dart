// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_telegram_header_only_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TsunamiTelegramHeaderOnlyItem {

 TsunamiTelegramHeader get telegram;
/// Create a copy of TsunamiTelegramHeaderOnlyItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiTelegramHeaderOnlyItemCopyWith<TsunamiTelegramHeaderOnlyItem> get copyWith => _$TsunamiTelegramHeaderOnlyItemCopyWithImpl<TsunamiTelegramHeaderOnlyItem>(this as TsunamiTelegramHeaderOnlyItem, _$identity);

  /// Serializes this TsunamiTelegramHeaderOnlyItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiTelegramHeaderOnlyItem&&(identical(other.telegram, telegram) || other.telegram == telegram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram);

@override
String toString() {
  return 'TsunamiTelegramHeaderOnlyItem(telegram: $telegram)';
}


}

/// @nodoc
abstract mixin class $TsunamiTelegramHeaderOnlyItemCopyWith<$Res>  {
  factory $TsunamiTelegramHeaderOnlyItemCopyWith(TsunamiTelegramHeaderOnlyItem value, $Res Function(TsunamiTelegramHeaderOnlyItem) _then) = _$TsunamiTelegramHeaderOnlyItemCopyWithImpl;
@useResult
$Res call({
 TsunamiTelegramHeader telegram
});


$TsunamiTelegramHeaderCopyWith<$Res> get telegram;

}
/// @nodoc
class _$TsunamiTelegramHeaderOnlyItemCopyWithImpl<$Res>
    implements $TsunamiTelegramHeaderOnlyItemCopyWith<$Res> {
  _$TsunamiTelegramHeaderOnlyItemCopyWithImpl(this._self, this._then);

  final TsunamiTelegramHeaderOnlyItem _self;
  final $Res Function(TsunamiTelegramHeaderOnlyItem) _then;

/// Create a copy of TsunamiTelegramHeaderOnlyItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? telegram = null,}) {
  return _then(_self.copyWith(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramHeader,
  ));
}
/// Create a copy of TsunamiTelegramHeaderOnlyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramHeaderCopyWith<$Res> get telegram {
  
  return $TsunamiTelegramHeaderCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}
}


/// Adds pattern-matching-related methods to [TsunamiTelegramHeaderOnlyItem].
extension TsunamiTelegramHeaderOnlyItemPatterns on TsunamiTelegramHeaderOnlyItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TsunamiTelegramHeaderOnlyItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TsunamiTelegramHeaderOnlyItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TsunamiTelegramHeaderOnlyItem value)  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramHeaderOnlyItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TsunamiTelegramHeaderOnlyItem value)?  $default,){
final _that = this;
switch (_that) {
case _TsunamiTelegramHeaderOnlyItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TsunamiTelegramHeader telegram)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TsunamiTelegramHeaderOnlyItem() when $default != null:
return $default(_that.telegram);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TsunamiTelegramHeader telegram)  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramHeaderOnlyItem():
return $default(_that.telegram);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TsunamiTelegramHeader telegram)?  $default,) {final _that = this;
switch (_that) {
case _TsunamiTelegramHeaderOnlyItem() when $default != null:
return $default(_that.telegram);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TsunamiTelegramHeaderOnlyItem implements TsunamiTelegramHeaderOnlyItem {
  const _TsunamiTelegramHeaderOnlyItem({required this.telegram});
  factory _TsunamiTelegramHeaderOnlyItem.fromJson(Map<String, dynamic> json) => _$TsunamiTelegramHeaderOnlyItemFromJson(json);

@override final  TsunamiTelegramHeader telegram;

/// Create a copy of TsunamiTelegramHeaderOnlyItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiTelegramHeaderOnlyItemCopyWith<_TsunamiTelegramHeaderOnlyItem> get copyWith => __$TsunamiTelegramHeaderOnlyItemCopyWithImpl<_TsunamiTelegramHeaderOnlyItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TsunamiTelegramHeaderOnlyItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiTelegramHeaderOnlyItem&&(identical(other.telegram, telegram) || other.telegram == telegram));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,telegram);

@override
String toString() {
  return 'TsunamiTelegramHeaderOnlyItem(telegram: $telegram)';
}


}

/// @nodoc
abstract mixin class _$TsunamiTelegramHeaderOnlyItemCopyWith<$Res> implements $TsunamiTelegramHeaderOnlyItemCopyWith<$Res> {
  factory _$TsunamiTelegramHeaderOnlyItemCopyWith(_TsunamiTelegramHeaderOnlyItem value, $Res Function(_TsunamiTelegramHeaderOnlyItem) _then) = __$TsunamiTelegramHeaderOnlyItemCopyWithImpl;
@override @useResult
$Res call({
 TsunamiTelegramHeader telegram
});


@override $TsunamiTelegramHeaderCopyWith<$Res> get telegram;

}
/// @nodoc
class __$TsunamiTelegramHeaderOnlyItemCopyWithImpl<$Res>
    implements _$TsunamiTelegramHeaderOnlyItemCopyWith<$Res> {
  __$TsunamiTelegramHeaderOnlyItemCopyWithImpl(this._self, this._then);

  final _TsunamiTelegramHeaderOnlyItem _self;
  final $Res Function(_TsunamiTelegramHeaderOnlyItem) _then;

/// Create a copy of TsunamiTelegramHeaderOnlyItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? telegram = null,}) {
  return _then(_TsunamiTelegramHeaderOnlyItem(
telegram: null == telegram ? _self.telegram : telegram // ignore: cast_nullable_to_non_nullable
as TsunamiTelegramHeader,
  ));
}

/// Create a copy of TsunamiTelegramHeaderOnlyItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiTelegramHeaderCopyWith<$Res> get telegram {
  
  return $TsunamiTelegramHeaderCopyWith<$Res>(_self.telegram, (value) {
    return _then(_self.copyWith(telegram: value));
  });
}
}

// dart format on
