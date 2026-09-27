// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_code_table_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaCodeTableItem {

 String get code; LocalizedName get name;
/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableItemCopyWith<JmaCodeTableItem> get copyWith => _$JmaCodeTableItemCopyWithImpl<JmaCodeTableItem>(this as JmaCodeTableItem, _$identity);

  /// Serializes this JmaCodeTableItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'JmaCodeTableItem(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableItemCopyWith<$Res>  {
  factory $JmaCodeTableItemCopyWith(JmaCodeTableItem value, $Res Function(JmaCodeTableItem) _then) = _$JmaCodeTableItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$JmaCodeTableItemCopyWithImpl<$Res>
    implements $JmaCodeTableItemCopyWith<$Res> {
  _$JmaCodeTableItemCopyWithImpl(this._self, this._then);

  final JmaCodeTableItem _self;
  final $Res Function(JmaCodeTableItem) _then;

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(JmaCodeTableItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,
  ));
}
/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableItem].
extension JmaCodeTableItemPatterns on JmaCodeTableItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableItem value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableItem value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableItem():
return $default(_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableItem() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableItem implements JmaCodeTableItem {
  const _JmaCodeTableItem({required this.code, required this.name});
  factory _JmaCodeTableItem.fromJson(Map<String, dynamic> json) => _$JmaCodeTableItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableItemCopyWith<_JmaCodeTableItem> get copyWith => __$JmaCodeTableItemCopyWithImpl<_JmaCodeTableItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'JmaCodeTableItem(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableItemCopyWith<$Res> implements $JmaCodeTableItemCopyWith<$Res> {
  factory _$JmaCodeTableItemCopyWith(_JmaCodeTableItem value, $Res Function(_JmaCodeTableItem) _then) = __$JmaCodeTableItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$JmaCodeTableItemCopyWithImpl<$Res>
    implements _$JmaCodeTableItemCopyWith<$Res> {
  __$JmaCodeTableItemCopyWithImpl(this._self, this._then);

  final _JmaCodeTableItem _self;
  final $Res Function(_JmaCodeTableItem) _then;

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_JmaCodeTableItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,
  ));
}

/// Create a copy of JmaCodeTableItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {
  
  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}

// dart format on
