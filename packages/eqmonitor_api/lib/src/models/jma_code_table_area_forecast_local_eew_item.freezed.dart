// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_code_table_area_forecast_local_eew_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JmaCodeTableAreaForecastLocalEewItem {

 String get code; LocalizedName get name;@JsonKey(includeIfNull: true) String? get kana;@JsonKey(includeIfNull: true) String? get description;
/// Create a copy of JmaCodeTableAreaForecastLocalEewItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaCodeTableAreaForecastLocalEewItemCopyWith<JmaCodeTableAreaForecastLocalEewItem> get copyWith => _$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl<JmaCodeTableAreaForecastLocalEewItem>(this as JmaCodeTableAreaForecastLocalEewItem, _$identity);

  /// Serializes this JmaCodeTableAreaForecastLocalEewItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaCodeTableAreaForecastLocalEewItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,description);

@override
String toString() {
  return 'JmaCodeTableAreaForecastLocalEewItem(code: $code, name: $name, kana: $kana, description: $description)';
}


}

/// @nodoc
abstract mixin class $JmaCodeTableAreaForecastLocalEewItemCopyWith<$Res>  {
  factory $JmaCodeTableAreaForecastLocalEewItemCopyWith(JmaCodeTableAreaForecastLocalEewItem value, $Res Function(JmaCodeTableAreaForecastLocalEewItem) _then) = _$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl;
@useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana,@JsonKey(includeIfNull: true) String? description
});


$LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class _$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl<$Res>
    implements $JmaCodeTableAreaForecastLocalEewItemCopyWith<$Res> {
  _$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl(this._self, this._then);

  final JmaCodeTableAreaForecastLocalEewItem _self;
  final $Res Function(JmaCodeTableAreaForecastLocalEewItem) _then;

/// Create a copy of JmaCodeTableAreaForecastLocalEewItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? description = freezed,}) {
  return _then(JmaCodeTableAreaForecastLocalEewItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of JmaCodeTableAreaForecastLocalEewItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<$Res> get name {

  return $LocalizedNameCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaCodeTableAreaForecastLocalEewItem].
extension JmaCodeTableAreaForecastLocalEewItemPatterns on JmaCodeTableAreaForecastLocalEewItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaCodeTableAreaForecastLocalEewItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaCodeTableAreaForecastLocalEewItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaCodeTableAreaForecastLocalEewItem value)  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableAreaForecastLocalEewItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaCodeTableAreaForecastLocalEewItem value)?  $default,){
final _that = this;
switch (_that) {
case _JmaCodeTableAreaForecastLocalEewItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana, @JsonKey(includeIfNull: true)  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaCodeTableAreaForecastLocalEewItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana, @JsonKey(includeIfNull: true)  String? description)  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableAreaForecastLocalEewItem():
return $default(_that.code,_that.name,_that.kana,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  LocalizedName name, @JsonKey(includeIfNull: true)  String? kana, @JsonKey(includeIfNull: true)  String? description)?  $default,) {final _that = this;
switch (_that) {
case _JmaCodeTableAreaForecastLocalEewItem() when $default != null:
return $default(_that.code,_that.name,_that.kana,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JmaCodeTableAreaForecastLocalEewItem implements JmaCodeTableAreaForecastLocalEewItem {
  const _JmaCodeTableAreaForecastLocalEewItem({required this.code, required this.name, @JsonKey(includeIfNull: true) required this.kana, @JsonKey(includeIfNull: true) required this.description});
  factory _JmaCodeTableAreaForecastLocalEewItem.fromJson(Map<String, dynamic> json) => _$JmaCodeTableAreaForecastLocalEewItemFromJson(json);

@override final  String code;
@override final  LocalizedName name;
@override@JsonKey(includeIfNull: true) final  String? kana;
@override@JsonKey(includeIfNull: true) final  String? description;

/// Create a copy of JmaCodeTableAreaForecastLocalEewItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaCodeTableAreaForecastLocalEewItemCopyWith<_JmaCodeTableAreaForecastLocalEewItem> get copyWith => __$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl<_JmaCodeTableAreaForecastLocalEewItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JmaCodeTableAreaForecastLocalEewItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaCodeTableAreaForecastLocalEewItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.kana, kana) || other.kana == kana)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,kana,description);

@override
String toString() {
  return 'JmaCodeTableAreaForecastLocalEewItem(code: $code, name: $name, kana: $kana, description: $description)';
}


}

/// @nodoc
abstract mixin class _$JmaCodeTableAreaForecastLocalEewItemCopyWith<$Res> implements $JmaCodeTableAreaForecastLocalEewItemCopyWith<$Res> {
  factory _$JmaCodeTableAreaForecastLocalEewItemCopyWith(_JmaCodeTableAreaForecastLocalEewItem value, $Res Function(_JmaCodeTableAreaForecastLocalEewItem) _then) = __$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl;
@override @useResult
$Res call({
 String code, LocalizedName name,@JsonKey(includeIfNull: true) String? kana,@JsonKey(includeIfNull: true) String? description
});


@override $LocalizedNameCopyWith<$Res> get name;

}
/// @nodoc
class __$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl<$Res>
    implements _$JmaCodeTableAreaForecastLocalEewItemCopyWith<$Res> {
  __$JmaCodeTableAreaForecastLocalEewItemCopyWithImpl(this._self, this._then);

  final _JmaCodeTableAreaForecastLocalEewItem _self;
  final $Res Function(_JmaCodeTableAreaForecastLocalEewItem) _then;

/// Create a copy of JmaCodeTableAreaForecastLocalEewItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? kana = freezed,Object? description = freezed,}) {
  return _then(_JmaCodeTableAreaForecastLocalEewItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedName,kana: freezed == kana ? _self.kana : kana // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of JmaCodeTableAreaForecastLocalEewItem
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
