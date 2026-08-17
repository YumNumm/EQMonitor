// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earthquake_body_diff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntensityRegionDiffEntry {

 String get code; String get name; JmaIntensity get intensity; IntensityDiffType get diffType; JmaIntensity? get previousIntensity;
/// Create a copy of IntensityRegionDiffEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionDiffEntryCopyWith<IntensityRegionDiffEntry> get copyWith => _$IntensityRegionDiffEntryCopyWithImpl<IntensityRegionDiffEntry>(this as IntensityRegionDiffEntry, _$identity);

  /// Serializes this IntensityRegionDiffEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegionDiffEntry&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.diffType, diffType) || other.diffType == diffType)&&(identical(other.previousIntensity, previousIntensity) || other.previousIntensity == previousIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,diffType,previousIntensity);

@override
String toString() {
  return 'IntensityRegionDiffEntry(code: $code, name: $name, intensity: $intensity, diffType: $diffType, previousIntensity: $previousIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionDiffEntryCopyWith<$Res>  {
  factory $IntensityRegionDiffEntryCopyWith(IntensityRegionDiffEntry value, $Res Function(IntensityRegionDiffEntry) _then) = _$IntensityRegionDiffEntryCopyWithImpl;
@useResult
$Res call({
 String code, String name, JmaIntensity intensity, IntensityDiffType diffType, JmaIntensity? previousIntensity
});




}
/// @nodoc
class _$IntensityRegionDiffEntryCopyWithImpl<$Res>
    implements $IntensityRegionDiffEntryCopyWith<$Res> {
  _$IntensityRegionDiffEntryCopyWithImpl(this._self, this._then);

  final IntensityRegionDiffEntry _self;
  final $Res Function(IntensityRegionDiffEntry) _then;

/// Create a copy of IntensityRegionDiffEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? diffType = null,Object? previousIntensity = freezed,}) {
  return _then(IntensityRegionDiffEntry(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,diffType: null == diffType ? _self.diffType : diffType // ignore: cast_nullable_to_non_nullable
as IntensityDiffType,previousIntensity: freezed == previousIntensity ? _self.previousIntensity : previousIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityRegionDiffEntry].
extension IntensityRegionDiffEntryPatterns on IntensityRegionDiffEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegionDiffEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegionDiffEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegionDiffEntry value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionDiffEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegionDiffEntry value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionDiffEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity intensity,  IntensityDiffType diffType,  JmaIntensity? previousIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegionDiffEntry() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.diffType,_that.previousIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  JmaIntensity intensity,  IntensityDiffType diffType,  JmaIntensity? previousIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionDiffEntry():
return $default(_that.code,_that.name,_that.intensity,_that.diffType,_that.previousIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  JmaIntensity intensity,  IntensityDiffType diffType,  JmaIntensity? previousIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionDiffEntry() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.diffType,_that.previousIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegionDiffEntry implements IntensityRegionDiffEntry {
  const _IntensityRegionDiffEntry({required this.code, required this.name, required this.intensity, required this.diffType, this.previousIntensity});
  factory _IntensityRegionDiffEntry.fromJson(Map<String, dynamic> json) => _$IntensityRegionDiffEntryFromJson(json);

@override final  String code;
@override final  String name;
@override final  JmaIntensity intensity;
@override final  IntensityDiffType diffType;
@override final  JmaIntensity? previousIntensity;

/// Create a copy of IntensityRegionDiffEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionDiffEntryCopyWith<_IntensityRegionDiffEntry> get copyWith => __$IntensityRegionDiffEntryCopyWithImpl<_IntensityRegionDiffEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionDiffEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegionDiffEntry&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.diffType, diffType) || other.diffType == diffType)&&(identical(other.previousIntensity, previousIntensity) || other.previousIntensity == previousIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,diffType,previousIntensity);

@override
String toString() {
  return 'IntensityRegionDiffEntry(code: $code, name: $name, intensity: $intensity, diffType: $diffType, previousIntensity: $previousIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionDiffEntryCopyWith<$Res> implements $IntensityRegionDiffEntryCopyWith<$Res> {
  factory _$IntensityRegionDiffEntryCopyWith(_IntensityRegionDiffEntry value, $Res Function(_IntensityRegionDiffEntry) _then) = __$IntensityRegionDiffEntryCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, JmaIntensity intensity, IntensityDiffType diffType, JmaIntensity? previousIntensity
});




}
/// @nodoc
class __$IntensityRegionDiffEntryCopyWithImpl<$Res>
    implements _$IntensityRegionDiffEntryCopyWith<$Res> {
  __$IntensityRegionDiffEntryCopyWithImpl(this._self, this._then);

  final _IntensityRegionDiffEntry _self;
  final $Res Function(_IntensityRegionDiffEntry) _then;

/// Create a copy of IntensityRegionDiffEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = null,Object? diffType = null,Object? previousIntensity = freezed,}) {
  return _then(_IntensityRegionDiffEntry(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: null == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity,diffType: null == diffType ? _self.diffType : diffType // ignore: cast_nullable_to_non_nullable
as IntensityDiffType,previousIntensity: freezed == previousIntensity ? _self.previousIntensity : previousIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}


/// @nodoc
mixin _$HypocenterDiff {

 String? get oldMagnitude; String? get newMagnitude; num? get oldDepth; num? get newDepth; String? get oldEpicenterName; String? get newEpicenterName; JmaIntensity? get oldMaxIntensity; JmaIntensity? get newMaxIntensity;
/// Create a copy of HypocenterDiff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HypocenterDiffCopyWith<HypocenterDiff> get copyWith => _$HypocenterDiffCopyWithImpl<HypocenterDiff>(this as HypocenterDiff, _$identity);

  /// Serializes this HypocenterDiff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HypocenterDiff&&(identical(other.oldMagnitude, oldMagnitude) || other.oldMagnitude == oldMagnitude)&&(identical(other.newMagnitude, newMagnitude) || other.newMagnitude == newMagnitude)&&(identical(other.oldDepth, oldDepth) || other.oldDepth == oldDepth)&&(identical(other.newDepth, newDepth) || other.newDepth == newDepth)&&(identical(other.oldEpicenterName, oldEpicenterName) || other.oldEpicenterName == oldEpicenterName)&&(identical(other.newEpicenterName, newEpicenterName) || other.newEpicenterName == newEpicenterName)&&(identical(other.oldMaxIntensity, oldMaxIntensity) || other.oldMaxIntensity == oldMaxIntensity)&&(identical(other.newMaxIntensity, newMaxIntensity) || other.newMaxIntensity == newMaxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldMagnitude,newMagnitude,oldDepth,newDepth,oldEpicenterName,newEpicenterName,oldMaxIntensity,newMaxIntensity);

@override
String toString() {
  return 'HypocenterDiff(oldMagnitude: $oldMagnitude, newMagnitude: $newMagnitude, oldDepth: $oldDepth, newDepth: $newDepth, oldEpicenterName: $oldEpicenterName, newEpicenterName: $newEpicenterName, oldMaxIntensity: $oldMaxIntensity, newMaxIntensity: $newMaxIntensity)';
}


}

/// @nodoc
abstract mixin class $HypocenterDiffCopyWith<$Res>  {
  factory $HypocenterDiffCopyWith(HypocenterDiff value, $Res Function(HypocenterDiff) _then) = _$HypocenterDiffCopyWithImpl;
@useResult
$Res call({
 String? oldMagnitude, String? newMagnitude, num? oldDepth, num? newDepth, String? oldEpicenterName, String? newEpicenterName, JmaIntensity? oldMaxIntensity, JmaIntensity? newMaxIntensity
});




}
/// @nodoc
class _$HypocenterDiffCopyWithImpl<$Res>
    implements $HypocenterDiffCopyWith<$Res> {
  _$HypocenterDiffCopyWithImpl(this._self, this._then);

  final HypocenterDiff _self;
  final $Res Function(HypocenterDiff) _then;

/// Create a copy of HypocenterDiff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oldMagnitude = freezed,Object? newMagnitude = freezed,Object? oldDepth = freezed,Object? newDepth = freezed,Object? oldEpicenterName = freezed,Object? newEpicenterName = freezed,Object? oldMaxIntensity = freezed,Object? newMaxIntensity = freezed,}) {
  return _then(HypocenterDiff(
oldMagnitude: freezed == oldMagnitude ? _self.oldMagnitude : oldMagnitude // ignore: cast_nullable_to_non_nullable
as String?,newMagnitude: freezed == newMagnitude ? _self.newMagnitude : newMagnitude // ignore: cast_nullable_to_non_nullable
as String?,oldDepth: freezed == oldDepth ? _self.oldDepth : oldDepth // ignore: cast_nullable_to_non_nullable
as num?,newDepth: freezed == newDepth ? _self.newDepth : newDepth // ignore: cast_nullable_to_non_nullable
as num?,oldEpicenterName: freezed == oldEpicenterName ? _self.oldEpicenterName : oldEpicenterName // ignore: cast_nullable_to_non_nullable
as String?,newEpicenterName: freezed == newEpicenterName ? _self.newEpicenterName : newEpicenterName // ignore: cast_nullable_to_non_nullable
as String?,oldMaxIntensity: freezed == oldMaxIntensity ? _self.oldMaxIntensity : oldMaxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,newMaxIntensity: freezed == newMaxIntensity ? _self.newMaxIntensity : newMaxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}

}


/// Adds pattern-matching-related methods to [HypocenterDiff].
extension HypocenterDiffPatterns on HypocenterDiff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HypocenterDiff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HypocenterDiff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HypocenterDiff value)  $default,){
final _that = this;
switch (_that) {
case _HypocenterDiff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HypocenterDiff value)?  $default,){
final _that = this;
switch (_that) {
case _HypocenterDiff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? oldMagnitude,  String? newMagnitude,  num? oldDepth,  num? newDepth,  String? oldEpicenterName,  String? newEpicenterName,  JmaIntensity? oldMaxIntensity,  JmaIntensity? newMaxIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HypocenterDiff() when $default != null:
return $default(_that.oldMagnitude,_that.newMagnitude,_that.oldDepth,_that.newDepth,_that.oldEpicenterName,_that.newEpicenterName,_that.oldMaxIntensity,_that.newMaxIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? oldMagnitude,  String? newMagnitude,  num? oldDepth,  num? newDepth,  String? oldEpicenterName,  String? newEpicenterName,  JmaIntensity? oldMaxIntensity,  JmaIntensity? newMaxIntensity)  $default,) {final _that = this;
switch (_that) {
case _HypocenterDiff():
return $default(_that.oldMagnitude,_that.newMagnitude,_that.oldDepth,_that.newDepth,_that.oldEpicenterName,_that.newEpicenterName,_that.oldMaxIntensity,_that.newMaxIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? oldMagnitude,  String? newMagnitude,  num? oldDepth,  num? newDepth,  String? oldEpicenterName,  String? newEpicenterName,  JmaIntensity? oldMaxIntensity,  JmaIntensity? newMaxIntensity)?  $default,) {final _that = this;
switch (_that) {
case _HypocenterDiff() when $default != null:
return $default(_that.oldMagnitude,_that.newMagnitude,_that.oldDepth,_that.newDepth,_that.oldEpicenterName,_that.newEpicenterName,_that.oldMaxIntensity,_that.newMaxIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HypocenterDiff extends HypocenterDiff {
  const _HypocenterDiff({this.oldMagnitude, this.newMagnitude, this.oldDepth, this.newDepth, this.oldEpicenterName, this.newEpicenterName, this.oldMaxIntensity, this.newMaxIntensity}): super._();
  factory _HypocenterDiff.fromJson(Map<String, dynamic> json) => _$HypocenterDiffFromJson(json);

@override final  String? oldMagnitude;
@override final  String? newMagnitude;
@override final  num? oldDepth;
@override final  num? newDepth;
@override final  String? oldEpicenterName;
@override final  String? newEpicenterName;
@override final  JmaIntensity? oldMaxIntensity;
@override final  JmaIntensity? newMaxIntensity;

/// Create a copy of HypocenterDiff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HypocenterDiffCopyWith<_HypocenterDiff> get copyWith => __$HypocenterDiffCopyWithImpl<_HypocenterDiff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HypocenterDiffToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HypocenterDiff&&(identical(other.oldMagnitude, oldMagnitude) || other.oldMagnitude == oldMagnitude)&&(identical(other.newMagnitude, newMagnitude) || other.newMagnitude == newMagnitude)&&(identical(other.oldDepth, oldDepth) || other.oldDepth == oldDepth)&&(identical(other.newDepth, newDepth) || other.newDepth == newDepth)&&(identical(other.oldEpicenterName, oldEpicenterName) || other.oldEpicenterName == oldEpicenterName)&&(identical(other.newEpicenterName, newEpicenterName) || other.newEpicenterName == newEpicenterName)&&(identical(other.oldMaxIntensity, oldMaxIntensity) || other.oldMaxIntensity == oldMaxIntensity)&&(identical(other.newMaxIntensity, newMaxIntensity) || other.newMaxIntensity == newMaxIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oldMagnitude,newMagnitude,oldDepth,newDepth,oldEpicenterName,newEpicenterName,oldMaxIntensity,newMaxIntensity);

@override
String toString() {
  return 'HypocenterDiff(oldMagnitude: $oldMagnitude, newMagnitude: $newMagnitude, oldDepth: $oldDepth, newDepth: $newDepth, oldEpicenterName: $oldEpicenterName, newEpicenterName: $newEpicenterName, oldMaxIntensity: $oldMaxIntensity, newMaxIntensity: $newMaxIntensity)';
}


}

/// @nodoc
abstract mixin class _$HypocenterDiffCopyWith<$Res> implements $HypocenterDiffCopyWith<$Res> {
  factory _$HypocenterDiffCopyWith(_HypocenterDiff value, $Res Function(_HypocenterDiff) _then) = __$HypocenterDiffCopyWithImpl;
@override @useResult
$Res call({
 String? oldMagnitude, String? newMagnitude, num? oldDepth, num? newDepth, String? oldEpicenterName, String? newEpicenterName, JmaIntensity? oldMaxIntensity, JmaIntensity? newMaxIntensity
});




}
/// @nodoc
class __$HypocenterDiffCopyWithImpl<$Res>
    implements _$HypocenterDiffCopyWith<$Res> {
  __$HypocenterDiffCopyWithImpl(this._self, this._then);

  final _HypocenterDiff _self;
  final $Res Function(_HypocenterDiff) _then;

/// Create a copy of HypocenterDiff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oldMagnitude = freezed,Object? newMagnitude = freezed,Object? oldDepth = freezed,Object? newDepth = freezed,Object? oldEpicenterName = freezed,Object? newEpicenterName = freezed,Object? oldMaxIntensity = freezed,Object? newMaxIntensity = freezed,}) {
  return _then(_HypocenterDiff(
oldMagnitude: freezed == oldMagnitude ? _self.oldMagnitude : oldMagnitude // ignore: cast_nullable_to_non_nullable
as String?,newMagnitude: freezed == newMagnitude ? _self.newMagnitude : newMagnitude // ignore: cast_nullable_to_non_nullable
as String?,oldDepth: freezed == oldDepth ? _self.oldDepth : oldDepth // ignore: cast_nullable_to_non_nullable
as num?,newDepth: freezed == newDepth ? _self.newDepth : newDepth // ignore: cast_nullable_to_non_nullable
as num?,oldEpicenterName: freezed == oldEpicenterName ? _self.oldEpicenterName : oldEpicenterName // ignore: cast_nullable_to_non_nullable
as String?,newEpicenterName: freezed == newEpicenterName ? _self.newEpicenterName : newEpicenterName // ignore: cast_nullable_to_non_nullable
as String?,oldMaxIntensity: freezed == oldMaxIntensity ? _self.oldMaxIntensity : oldMaxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,newMaxIntensity: freezed == newMaxIntensity ? _self.newMaxIntensity : newMaxIntensity // ignore: cast_nullable_to_non_nullable
as JmaIntensity?,
  ));
}


}

// dart format on
