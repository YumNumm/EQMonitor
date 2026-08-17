// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_region_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WidgetRegionSelection {

 RegionSearchType get searchType; String get code; String get name;
/// Create a copy of WidgetRegionSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetRegionSelectionCopyWith<WidgetRegionSelection> get copyWith => _$WidgetRegionSelectionCopyWithImpl<WidgetRegionSelection>(this as WidgetRegionSelection, _$identity);

  /// Serializes this WidgetRegionSelection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetRegionSelection&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchType,code,name);

@override
String toString() {
  return 'WidgetRegionSelection(searchType: $searchType, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $WidgetRegionSelectionCopyWith<$Res>  {
  factory $WidgetRegionSelectionCopyWith(WidgetRegionSelection value, $Res Function(WidgetRegionSelection) _then) = _$WidgetRegionSelectionCopyWithImpl;
@useResult
$Res call({
 RegionSearchType searchType, String code, String name
});




}
/// @nodoc
class _$WidgetRegionSelectionCopyWithImpl<$Res>
    implements $WidgetRegionSelectionCopyWith<$Res> {
  _$WidgetRegionSelectionCopyWithImpl(this._self, this._then);

  final WidgetRegionSelection _self;
  final $Res Function(WidgetRegionSelection) _then;

/// Create a copy of WidgetRegionSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchType = null,Object? code = null,Object? name = null,}) {
  return _then(WidgetRegionSelection(
searchType: null == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetRegionSelection].
extension WidgetRegionSelectionPatterns on WidgetRegionSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetRegionSelection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetRegionSelection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetRegionSelection value)  $default,){
final _that = this;
switch (_that) {
case _WidgetRegionSelection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetRegionSelection value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetRegionSelection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RegionSearchType searchType,  String code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetRegionSelection() when $default != null:
return $default(_that.searchType,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RegionSearchType searchType,  String code,  String name)  $default,) {final _that = this;
switch (_that) {
case _WidgetRegionSelection():
return $default(_that.searchType,_that.code,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RegionSearchType searchType,  String code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _WidgetRegionSelection() when $default != null:
return $default(_that.searchType,_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WidgetRegionSelection implements WidgetRegionSelection {
  const _WidgetRegionSelection({required this.searchType, required this.code, required this.name});
  factory _WidgetRegionSelection.fromJson(Map<String, dynamic> json) => _$WidgetRegionSelectionFromJson(json);

@override final  RegionSearchType searchType;
@override final  String code;
@override final  String name;

/// Create a copy of WidgetRegionSelection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetRegionSelectionCopyWith<_WidgetRegionSelection> get copyWith => __$WidgetRegionSelectionCopyWithImpl<_WidgetRegionSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WidgetRegionSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetRegionSelection&&(identical(other.searchType, searchType) || other.searchType == searchType)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,searchType,code,name);

@override
String toString() {
  return 'WidgetRegionSelection(searchType: $searchType, code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$WidgetRegionSelectionCopyWith<$Res> implements $WidgetRegionSelectionCopyWith<$Res> {
  factory _$WidgetRegionSelectionCopyWith(_WidgetRegionSelection value, $Res Function(_WidgetRegionSelection) _then) = __$WidgetRegionSelectionCopyWithImpl;
@override @useResult
$Res call({
 RegionSearchType searchType, String code, String name
});




}
/// @nodoc
class __$WidgetRegionSelectionCopyWithImpl<$Res>
    implements _$WidgetRegionSelectionCopyWith<$Res> {
  __$WidgetRegionSelectionCopyWithImpl(this._self, this._then);

  final _WidgetRegionSelection _self;
  final $Res Function(_WidgetRegionSelection) _then;

/// Create a copy of WidgetRegionSelection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchType = null,Object? code = null,Object? name = null,}) {
  return _then(_WidgetRegionSelection(
searchType: null == searchType ? _self.searchType : searchType // ignore: cast_nullable_to_non_nullable
as RegionSearchType,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
