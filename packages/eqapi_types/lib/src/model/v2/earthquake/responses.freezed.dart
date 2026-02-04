// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarthquakeListResponse {

 List<EarthquakePartial> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of EarthquakeListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeListResponseCopyWith<EarthquakeListResponse> get copyWith => _$EarthquakeListResponseCopyWithImpl<EarthquakeListResponse>(this as EarthquakeListResponse, _$identity);

  /// Serializes this EarthquakeListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeListResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'EarthquakeListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $EarthquakeListResponseCopyWith<$Res>  {
  factory $EarthquakeListResponseCopyWith(EarthquakeListResponse value, $Res Function(EarthquakeListResponse) _then) = _$EarthquakeListResponseCopyWithImpl;
@useResult
$Res call({
 List<EarthquakePartial> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$EarthquakeListResponseCopyWithImpl<$Res>
    implements $EarthquakeListResponseCopyWith<$Res> {
  _$EarthquakeListResponseCopyWithImpl(this._self, this._then);

  final EarthquakeListResponse _self;
  final $Res Function(EarthquakeListResponse) _then;

/// Create a copy of EarthquakeListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarthquakeListResponse].
extension EarthquakeListResponsePatterns on EarthquakeListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeListResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EarthquakePartial> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EarthquakePartial> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeListResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EarthquakePartial> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeListResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeListResponse implements EarthquakeListResponse {
  const _EarthquakeListResponse({required final  List<EarthquakePartial> items, this.nextToken, this.nextPooling}): _items = items;
  factory _EarthquakeListResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeListResponseFromJson(json);

 final  List<EarthquakePartial> _items;
@override List<EarthquakePartial> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of EarthquakeListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeListResponseCopyWith<_EarthquakeListResponse> get copyWith => __$EarthquakeListResponseCopyWithImpl<_EarthquakeListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeListResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'EarthquakeListResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeListResponseCopyWith<$Res> implements $EarthquakeListResponseCopyWith<$Res> {
  factory _$EarthquakeListResponseCopyWith(_EarthquakeListResponse value, $Res Function(_EarthquakeListResponse) _then) = __$EarthquakeListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EarthquakePartial> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$EarthquakeListResponseCopyWithImpl<$Res>
    implements _$EarthquakeListResponseCopyWith<$Res> {
  __$EarthquakeListResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeListResponse _self;
  final $Res Function(_EarthquakeListResponse) _then;

/// Create a copy of EarthquakeListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_EarthquakeListResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EarthquakePartial>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EarthquakeDetailResponse {

 Earthquake get earthquake;
/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarthquakeDetailResponseCopyWith<EarthquakeDetailResponse> get copyWith => _$EarthquakeDetailResponseCopyWithImpl<EarthquakeDetailResponse>(this as EarthquakeDetailResponse, _$identity);

  /// Serializes this EarthquakeDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarthquakeDetailResponse&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquake);

@override
String toString() {
  return 'EarthquakeDetailResponse(earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EarthquakeDetailResponseCopyWith<$Res>  {
  factory $EarthquakeDetailResponseCopyWith(EarthquakeDetailResponse value, $Res Function(EarthquakeDetailResponse) _then) = _$EarthquakeDetailResponseCopyWithImpl;
@useResult
$Res call({
 Earthquake earthquake
});


$EarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EarthquakeDetailResponseCopyWithImpl<$Res>
    implements $EarthquakeDetailResponseCopyWith<$Res> {
  _$EarthquakeDetailResponseCopyWithImpl(this._self, this._then);

  final EarthquakeDetailResponse _self;
  final $Res Function(EarthquakeDetailResponse) _then;

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquake = null,}) {
  return _then(_self.copyWith(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}
/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get earthquake {
  
  return $EarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarthquakeDetailResponse].
extension EarthquakeDetailResponsePatterns on EarthquakeDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarthquakeDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarthquakeDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _EarthquakeDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarthquakeDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Earthquake earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
return $default(_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Earthquake earthquake)  $default,) {final _that = this;
switch (_that) {
case _EarthquakeDetailResponse():
return $default(_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Earthquake earthquake)?  $default,) {final _that = this;
switch (_that) {
case _EarthquakeDetailResponse() when $default != null:
return $default(_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarthquakeDetailResponse implements EarthquakeDetailResponse {
  const _EarthquakeDetailResponse({required this.earthquake});
  factory _EarthquakeDetailResponse.fromJson(Map<String, dynamic> json) => _$EarthquakeDetailResponseFromJson(json);

@override final  Earthquake earthquake;

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarthquakeDetailResponseCopyWith<_EarthquakeDetailResponse> get copyWith => __$EarthquakeDetailResponseCopyWithImpl<_EarthquakeDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarthquakeDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarthquakeDetailResponse&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,earthquake);

@override
String toString() {
  return 'EarthquakeDetailResponse(earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$EarthquakeDetailResponseCopyWith<$Res> implements $EarthquakeDetailResponseCopyWith<$Res> {
  factory _$EarthquakeDetailResponseCopyWith(_EarthquakeDetailResponse value, $Res Function(_EarthquakeDetailResponse) _then) = __$EarthquakeDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 Earthquake earthquake
});


@override $EarthquakeCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$EarthquakeDetailResponseCopyWithImpl<$Res>
    implements _$EarthquakeDetailResponseCopyWith<$Res> {
  __$EarthquakeDetailResponseCopyWithImpl(this._self, this._then);

  final _EarthquakeDetailResponse _self;
  final $Res Function(_EarthquakeDetailResponse) _then;

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquake = null,}) {
  return _then(_EarthquakeDetailResponse(
earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as Earthquake,
  ));
}

/// Create a copy of EarthquakeDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeCopyWith<$Res> get earthquake {
  
  return $EarthquakeCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$IntensityRegionInfo {

 String get code; String get name; IntensityValue? get intensity; LpgmIntensityValue? get lpgmIntensity;
/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<IntensityRegionInfo> get copyWith => _$IntensityRegionInfoCopyWithImpl<IntensityRegionInfo>(this as IntensityRegionInfo, _$identity);

  /// Serializes this IntensityRegionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegionInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityRegionInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionInfoCopyWith<$Res>  {
  factory $IntensityRegionInfoCopyWith(IntensityRegionInfo value, $Res Function(IntensityRegionInfo) _then) = _$IntensityRegionInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, IntensityValue? intensity, LpgmIntensityValue? lpgmIntensity
});




}
/// @nodoc
class _$IntensityRegionInfoCopyWithImpl<$Res>
    implements $IntensityRegionInfoCopyWith<$Res> {
  _$IntensityRegionInfoCopyWithImpl(this._self, this._then);

  final IntensityRegionInfo _self;
  final $Res Function(IntensityRegionInfo) _then;

/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityRegionInfo].
extension IntensityRegionInfoPatterns on IntensityRegionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegionInfo value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  IntensityValue? intensity,  LpgmIntensityValue? lpgmIntensity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  IntensityValue? intensity,  LpgmIntensityValue? lpgmIntensity)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  IntensityValue? intensity,  LpgmIntensityValue? lpgmIntensity)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegionInfo implements IntensityRegionInfo {
  const _IntensityRegionInfo({required this.code, required this.name, this.intensity, this.lpgmIntensity});
  factory _IntensityRegionInfo.fromJson(Map<String, dynamic> json) => _$IntensityRegionInfoFromJson(json);

@override final  String code;
@override final  String name;
@override final  IntensityValue? intensity;
@override final  LpgmIntensityValue? lpgmIntensity;

/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionInfoCopyWith<_IntensityRegionInfo> get copyWith => __$IntensityRegionInfoCopyWithImpl<_IntensityRegionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegionInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity);

@override
String toString() {
  return 'IntensityRegionInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionInfoCopyWith<$Res> implements $IntensityRegionInfoCopyWith<$Res> {
  factory _$IntensityRegionInfoCopyWith(_IntensityRegionInfo value, $Res Function(_IntensityRegionInfo) _then) = __$IntensityRegionInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, IntensityValue? intensity, LpgmIntensityValue? lpgmIntensity
});




}
/// @nodoc
class __$IntensityRegionInfoCopyWithImpl<$Res>
    implements _$IntensityRegionInfoCopyWith<$Res> {
  __$IntensityRegionInfoCopyWithImpl(this._self, this._then);

  final _IntensityRegionInfo _self;
  final $Res Function(_IntensityRegionInfo) _then;

/// Create a copy of IntensityRegionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,}) {
  return _then(_IntensityRegionInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,
  ));
}


}


/// @nodoc
mixin _$IntensityStationInfo {

 String get code; String get name; IntensityValue? get intensity; LpgmIntensityValue? get lpgmIntensity; double? get sva; List<IntensityStationPrePeriod>? get prePeriods;
/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationInfoCopyWith<IntensityStationInfo> get copyWith => _$IntensityStationInfoCopyWithImpl<IntensityStationInfo>(this as IntensityStationInfo, _$identity);

  /// Serializes this IntensityStationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other.prePeriods, prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(prePeriods));

@override
String toString() {
  return 'IntensityStationInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class $IntensityStationInfoCopyWith<$Res>  {
  factory $IntensityStationInfoCopyWith(IntensityStationInfo value, $Res Function(IntensityStationInfo) _then) = _$IntensityStationInfoCopyWithImpl;
@useResult
$Res call({
 String code, String name, IntensityValue? intensity, LpgmIntensityValue? lpgmIntensity, double? sva, List<IntensityStationPrePeriod>? prePeriods
});




}
/// @nodoc
class _$IntensityStationInfoCopyWithImpl<$Res>
    implements $IntensityStationInfoCopyWith<$Res> {
  _$IntensityStationInfoCopyWithImpl(this._self, this._then);

  final IntensityStationInfo _self;
  final $Res Function(IntensityStationInfo) _then;

/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self.prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<IntensityStationPrePeriod>?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityStationInfo].
extension IntensityStationInfoPatterns on IntensityStationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationInfo value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  IntensityValue? intensity,  LpgmIntensityValue? lpgmIntensity,  double? sva,  List<IntensityStationPrePeriod>? prePeriods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  IntensityValue? intensity,  LpgmIntensityValue? lpgmIntensity,  double? sva,  List<IntensityStationPrePeriod>? prePeriods)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationInfo():
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  IntensityValue? intensity,  LpgmIntensityValue? lpgmIntensity,  double? sva,  List<IntensityStationPrePeriod>? prePeriods)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationInfo() when $default != null:
return $default(_that.code,_that.name,_that.intensity,_that.lpgmIntensity,_that.sva,_that.prePeriods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationInfo implements IntensityStationInfo {
  const _IntensityStationInfo({required this.code, required this.name, this.intensity, this.lpgmIntensity, this.sva, final  List<IntensityStationPrePeriod>? prePeriods}): _prePeriods = prePeriods;
  factory _IntensityStationInfo.fromJson(Map<String, dynamic> json) => _$IntensityStationInfoFromJson(json);

@override final  String code;
@override final  String name;
@override final  IntensityValue? intensity;
@override final  LpgmIntensityValue? lpgmIntensity;
@override final  double? sva;
 final  List<IntensityStationPrePeriod>? _prePeriods;
@override List<IntensityStationPrePeriod>? get prePeriods {
  final value = _prePeriods;
  if (value == null) return null;
  if (_prePeriods is EqualUnmodifiableListView) return _prePeriods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationInfoCopyWith<_IntensityStationInfo> get copyWith => __$IntensityStationInfoCopyWithImpl<_IntensityStationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva)&&const DeepCollectionEquality().equals(other._prePeriods, _prePeriods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name,intensity,lpgmIntensity,sva,const DeepCollectionEquality().hash(_prePeriods));

@override
String toString() {
  return 'IntensityStationInfo(code: $code, name: $name, intensity: $intensity, lpgmIntensity: $lpgmIntensity, sva: $sva, prePeriods: $prePeriods)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationInfoCopyWith<$Res> implements $IntensityStationInfoCopyWith<$Res> {
  factory _$IntensityStationInfoCopyWith(_IntensityStationInfo value, $Res Function(_IntensityStationInfo) _then) = __$IntensityStationInfoCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, IntensityValue? intensity, LpgmIntensityValue? lpgmIntensity, double? sva, List<IntensityStationPrePeriod>? prePeriods
});




}
/// @nodoc
class __$IntensityStationInfoCopyWithImpl<$Res>
    implements _$IntensityStationInfoCopyWith<$Res> {
  __$IntensityStationInfoCopyWithImpl(this._self, this._then);

  final _IntensityStationInfo _self;
  final $Res Function(_IntensityStationInfo) _then;

/// Create a copy of IntensityStationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? intensity = freezed,Object? lpgmIntensity = freezed,Object? sva = freezed,Object? prePeriods = freezed,}) {
  return _then(_IntensityStationInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as IntensityValue?,lpgmIntensity: freezed == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as LpgmIntensityValue?,sva: freezed == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double?,prePeriods: freezed == prePeriods ? _self._prePeriods : prePeriods // ignore: cast_nullable_to_non_nullable
as List<IntensityStationPrePeriod>?,
  ));
}


}


/// @nodoc
mixin _$IntensityStationPrePeriod {

 int get band; String get lpgmIntensity; double get sva;
/// Create a copy of IntensityStationPrePeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationPrePeriodCopyWith<IntensityStationPrePeriod> get copyWith => _$IntensityStationPrePeriodCopyWithImpl<IntensityStationPrePeriod>(this as IntensityStationPrePeriod, _$identity);

  /// Serializes this IntensityStationPrePeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationPrePeriod&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'IntensityStationPrePeriod(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class $IntensityStationPrePeriodCopyWith<$Res>  {
  factory $IntensityStationPrePeriodCopyWith(IntensityStationPrePeriod value, $Res Function(IntensityStationPrePeriod) _then) = _$IntensityStationPrePeriodCopyWithImpl;
@useResult
$Res call({
 int band, String lpgmIntensity, double sva
});




}
/// @nodoc
class _$IntensityStationPrePeriodCopyWithImpl<$Res>
    implements $IntensityStationPrePeriodCopyWith<$Res> {
  _$IntensityStationPrePeriodCopyWithImpl(this._self, this._then);

  final IntensityStationPrePeriod _self;
  final $Res Function(IntensityStationPrePeriod) _then;

/// Create a copy of IntensityStationPrePeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_self.copyWith(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as int,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as String,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityStationPrePeriod].
extension IntensityStationPrePeriodPatterns on IntensityStationPrePeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationPrePeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationPrePeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationPrePeriod value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationPrePeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationPrePeriod value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationPrePeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int band,  String lpgmIntensity,  double sva)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationPrePeriod() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int band,  String lpgmIntensity,  double sva)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationPrePeriod():
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int band,  String lpgmIntensity,  double sva)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationPrePeriod() when $default != null:
return $default(_that.band,_that.lpgmIntensity,_that.sva);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationPrePeriod implements IntensityStationPrePeriod {
  const _IntensityStationPrePeriod({required this.band, required this.lpgmIntensity, required this.sva});
  factory _IntensityStationPrePeriod.fromJson(Map<String, dynamic> json) => _$IntensityStationPrePeriodFromJson(json);

@override final  int band;
@override final  String lpgmIntensity;
@override final  double sva;

/// Create a copy of IntensityStationPrePeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationPrePeriodCopyWith<_IntensityStationPrePeriod> get copyWith => __$IntensityStationPrePeriodCopyWithImpl<_IntensityStationPrePeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationPrePeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationPrePeriod&&(identical(other.band, band) || other.band == band)&&(identical(other.lpgmIntensity, lpgmIntensity) || other.lpgmIntensity == lpgmIntensity)&&(identical(other.sva, sva) || other.sva == sva));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,band,lpgmIntensity,sva);

@override
String toString() {
  return 'IntensityStationPrePeriod(band: $band, lpgmIntensity: $lpgmIntensity, sva: $sva)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationPrePeriodCopyWith<$Res> implements $IntensityStationPrePeriodCopyWith<$Res> {
  factory _$IntensityStationPrePeriodCopyWith(_IntensityStationPrePeriod value, $Res Function(_IntensityStationPrePeriod) _then) = __$IntensityStationPrePeriodCopyWithImpl;
@override @useResult
$Res call({
 int band, String lpgmIntensity, double sva
});




}
/// @nodoc
class __$IntensityStationPrePeriodCopyWithImpl<$Res>
    implements _$IntensityStationPrePeriodCopyWith<$Res> {
  __$IntensityStationPrePeriodCopyWithImpl(this._self, this._then);

  final _IntensityStationPrePeriod _self;
  final $Res Function(_IntensityStationPrePeriod) _then;

/// Create a copy of IntensityStationPrePeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? band = null,Object? lpgmIntensity = null,Object? sva = null,}) {
  return _then(_IntensityStationPrePeriod(
band: null == band ? _self.band : band // ignore: cast_nullable_to_non_nullable
as int,lpgmIntensity: null == lpgmIntensity ? _self.lpgmIntensity : lpgmIntensity // ignore: cast_nullable_to_non_nullable
as String,sva: null == sva ? _self.sva : sva // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$IntensityRegionSearchItem {

 String get eventId; IntensityRegionInfo get region; EarthquakePartial get earthquake;
/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionSearchItemCopyWith<IntensityRegionSearchItem> get copyWith => _$IntensityRegionSearchItemCopyWithImpl<IntensityRegionSearchItem>(this as IntensityRegionSearchItem, _$identity);

  /// Serializes this IntensityRegionSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegionSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.region, region) || other.region == region)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,region,earthquake);

@override
String toString() {
  return 'IntensityRegionSearchItem(eventId: $eventId, region: $region, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionSearchItemCopyWith<$Res>  {
  factory $IntensityRegionSearchItemCopyWith(IntensityRegionSearchItem value, $Res Function(IntensityRegionSearchItem) _then) = _$IntensityRegionSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, IntensityRegionInfo region, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get region;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityRegionSearchItemCopyWithImpl<$Res>
    implements $IntensityRegionSearchItemCopyWith<$Res> {
  _$IntensityRegionSearchItemCopyWithImpl(this._self, this._then);

  final IntensityRegionSearchItem _self;
  final $Res Function(IntensityRegionSearchItem) _then;

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? region = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get region {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityRegionSearchItem].
extension IntensityRegionSearchItemPatterns on IntensityRegionSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegionSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegionSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegionSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
return $default(_that.eventId,_that.region,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionSearchItem():
return $default(_that.eventId,_that.region,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  IntensityRegionInfo region,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionSearchItem() when $default != null:
return $default(_that.eventId,_that.region,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegionSearchItem implements IntensityRegionSearchItem {
  const _IntensityRegionSearchItem({required this.eventId, required this.region, required this.earthquake});
  factory _IntensityRegionSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityRegionSearchItemFromJson(json);

@override final  String eventId;
@override final  IntensityRegionInfo region;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionSearchItemCopyWith<_IntensityRegionSearchItem> get copyWith => __$IntensityRegionSearchItemCopyWithImpl<_IntensityRegionSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegionSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.region, region) || other.region == region)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,region,earthquake);

@override
String toString() {
  return 'IntensityRegionSearchItem(eventId: $eventId, region: $region, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionSearchItemCopyWith<$Res> implements $IntensityRegionSearchItemCopyWith<$Res> {
  factory _$IntensityRegionSearchItemCopyWith(_IntensityRegionSearchItem value, $Res Function(_IntensityRegionSearchItem) _then) = __$IntensityRegionSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityRegionInfo region, EarthquakePartial earthquake
});


@override $IntensityRegionInfoCopyWith<$Res> get region;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityRegionSearchItemCopyWithImpl<$Res>
    implements _$IntensityRegionSearchItemCopyWith<$Res> {
  __$IntensityRegionSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityRegionSearchItem _self;
  final $Res Function(_IntensityRegionSearchItem) _then;

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? region = null,Object? earthquake = null,}) {
  return _then(_IntensityRegionSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get region {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.region, (value) {
    return _then(_self.copyWith(region: value));
  });
}/// Create a copy of IntensityRegionSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$IntensityPrefectureSearchItem {

 String get eventId; IntensityRegionInfo get prefecture; EarthquakePartial get earthquake;
/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPrefectureSearchItemCopyWith<IntensityPrefectureSearchItem> get copyWith => _$IntensityPrefectureSearchItemCopyWithImpl<IntensityPrefectureSearchItem>(this as IntensityPrefectureSearchItem, _$identity);

  /// Serializes this IntensityPrefectureSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPrefectureSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,prefecture,earthquake);

@override
String toString() {
  return 'IntensityPrefectureSearchItem(eventId: $eventId, prefecture: $prefecture, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityPrefectureSearchItemCopyWith<$Res>  {
  factory $IntensityPrefectureSearchItemCopyWith(IntensityPrefectureSearchItem value, $Res Function(IntensityPrefectureSearchItem) _then) = _$IntensityPrefectureSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, IntensityRegionInfo prefecture, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get prefecture;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityPrefectureSearchItemCopyWithImpl<$Res>
    implements $IntensityPrefectureSearchItemCopyWith<$Res> {
  _$IntensityPrefectureSearchItemCopyWithImpl(this._self, this._then);

  final IntensityPrefectureSearchItem _self;
  final $Res Function(IntensityPrefectureSearchItem) _then;

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? prefecture = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get prefecture {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityPrefectureSearchItem].
extension IntensityPrefectureSearchItemPatterns on IntensityPrefectureSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPrefectureSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  IntensityRegionInfo prefecture,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
return $default(_that.eventId,_that.prefecture,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  IntensityRegionInfo prefecture,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem():
return $default(_that.eventId,_that.prefecture,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  IntensityRegionInfo prefecture,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchItem() when $default != null:
return $default(_that.eventId,_that.prefecture,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPrefectureSearchItem implements IntensityPrefectureSearchItem {
  const _IntensityPrefectureSearchItem({required this.eventId, required this.prefecture, required this.earthquake});
  factory _IntensityPrefectureSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityPrefectureSearchItemFromJson(json);

@override final  String eventId;
@override final  IntensityRegionInfo prefecture;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPrefectureSearchItemCopyWith<_IntensityPrefectureSearchItem> get copyWith => __$IntensityPrefectureSearchItemCopyWithImpl<_IntensityPrefectureSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPrefectureSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPrefectureSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.prefecture, prefecture) || other.prefecture == prefecture)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,prefecture,earthquake);

@override
String toString() {
  return 'IntensityPrefectureSearchItem(eventId: $eventId, prefecture: $prefecture, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityPrefectureSearchItemCopyWith<$Res> implements $IntensityPrefectureSearchItemCopyWith<$Res> {
  factory _$IntensityPrefectureSearchItemCopyWith(_IntensityPrefectureSearchItem value, $Res Function(_IntensityPrefectureSearchItem) _then) = __$IntensityPrefectureSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityRegionInfo prefecture, EarthquakePartial earthquake
});


@override $IntensityRegionInfoCopyWith<$Res> get prefecture;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityPrefectureSearchItemCopyWithImpl<$Res>
    implements _$IntensityPrefectureSearchItemCopyWith<$Res> {
  __$IntensityPrefectureSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityPrefectureSearchItem _self;
  final $Res Function(_IntensityPrefectureSearchItem) _then;

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? prefecture = null,Object? earthquake = null,}) {
  return _then(_IntensityPrefectureSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,prefecture: null == prefecture ? _self.prefecture : prefecture // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get prefecture {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.prefecture, (value) {
    return _then(_self.copyWith(prefecture: value));
  });
}/// Create a copy of IntensityPrefectureSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$IntensityCitySearchItem {

 String get eventId; IntensityRegionInfo get city; EarthquakePartial get earthquake;
/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCitySearchItemCopyWith<IntensityCitySearchItem> get copyWith => _$IntensityCitySearchItemCopyWithImpl<IntensityCitySearchItem>(this as IntensityCitySearchItem, _$identity);

  /// Serializes this IntensityCitySearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityCitySearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.city, city) || other.city == city)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,city,earthquake);

@override
String toString() {
  return 'IntensityCitySearchItem(eventId: $eventId, city: $city, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityCitySearchItemCopyWith<$Res>  {
  factory $IntensityCitySearchItemCopyWith(IntensityCitySearchItem value, $Res Function(IntensityCitySearchItem) _then) = _$IntensityCitySearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, IntensityRegionInfo city, EarthquakePartial earthquake
});


$IntensityRegionInfoCopyWith<$Res> get city;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityCitySearchItemCopyWithImpl<$Res>
    implements $IntensityCitySearchItemCopyWith<$Res> {
  _$IntensityCitySearchItemCopyWithImpl(this._self, this._then);

  final IntensityCitySearchItem _self;
  final $Res Function(IntensityCitySearchItem) _then;

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? city = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get city {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityCitySearchItem].
extension IntensityCitySearchItemPatterns on IntensityCitySearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityCitySearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityCitySearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityCitySearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityCitySearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  IntensityRegionInfo city,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityCitySearchItem() when $default != null:
return $default(_that.eventId,_that.city,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  IntensityRegionInfo city,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityCitySearchItem():
return $default(_that.eventId,_that.city,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  IntensityRegionInfo city,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityCitySearchItem() when $default != null:
return $default(_that.eventId,_that.city,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityCitySearchItem implements IntensityCitySearchItem {
  const _IntensityCitySearchItem({required this.eventId, required this.city, required this.earthquake});
  factory _IntensityCitySearchItem.fromJson(Map<String, dynamic> json) => _$IntensityCitySearchItemFromJson(json);

@override final  String eventId;
@override final  IntensityRegionInfo city;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCitySearchItemCopyWith<_IntensityCitySearchItem> get copyWith => __$IntensityCitySearchItemCopyWithImpl<_IntensityCitySearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityCitySearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityCitySearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.city, city) || other.city == city)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,city,earthquake);

@override
String toString() {
  return 'IntensityCitySearchItem(eventId: $eventId, city: $city, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityCitySearchItemCopyWith<$Res> implements $IntensityCitySearchItemCopyWith<$Res> {
  factory _$IntensityCitySearchItemCopyWith(_IntensityCitySearchItem value, $Res Function(_IntensityCitySearchItem) _then) = __$IntensityCitySearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityRegionInfo city, EarthquakePartial earthquake
});


@override $IntensityRegionInfoCopyWith<$Res> get city;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityCitySearchItemCopyWithImpl<$Res>
    implements _$IntensityCitySearchItemCopyWith<$Res> {
  __$IntensityCitySearchItemCopyWithImpl(this._self, this._then);

  final _IntensityCitySearchItem _self;
  final $Res Function(_IntensityCitySearchItem) _then;

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? city = null,Object? earthquake = null,}) {
  return _then(_IntensityCitySearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as IntensityRegionInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityRegionInfoCopyWith<$Res> get city {
  
  return $IntensityRegionInfoCopyWith<$Res>(_self.city, (value) {
    return _then(_self.copyWith(city: value));
  });
}/// Create a copy of IntensityCitySearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$IntensityStationSearchItem {

 String get eventId; IntensityStationInfo get station; EarthquakePartial get earthquake;
/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationSearchItemCopyWith<IntensityStationSearchItem> get copyWith => _$IntensityStationSearchItemCopyWithImpl<IntensityStationSearchItem>(this as IntensityStationSearchItem, _$identity);

  /// Serializes this IntensityStationSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.station, station) || other.station == station)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,station,earthquake);

@override
String toString() {
  return 'IntensityStationSearchItem(eventId: $eventId, station: $station, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $IntensityStationSearchItemCopyWith<$Res>  {
  factory $IntensityStationSearchItemCopyWith(IntensityStationSearchItem value, $Res Function(IntensityStationSearchItem) _then) = _$IntensityStationSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, IntensityStationInfo station, EarthquakePartial earthquake
});


$IntensityStationInfoCopyWith<$Res> get station;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$IntensityStationSearchItemCopyWithImpl<$Res>
    implements $IntensityStationSearchItemCopyWith<$Res> {
  _$IntensityStationSearchItemCopyWithImpl(this._self, this._then);

  final IntensityStationSearchItem _self;
  final $Res Function(IntensityStationSearchItem) _then;

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? station = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as IntensityStationInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationInfoCopyWith<$Res> get station {
  
  return $IntensityStationInfoCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [IntensityStationSearchItem].
extension IntensityStationSearchItemPatterns on IntensityStationSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  IntensityStationInfo station,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
return $default(_that.eventId,_that.station,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  IntensityStationInfo station,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationSearchItem():
return $default(_that.eventId,_that.station,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  IntensityStationInfo station,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationSearchItem() when $default != null:
return $default(_that.eventId,_that.station,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationSearchItem implements IntensityStationSearchItem {
  const _IntensityStationSearchItem({required this.eventId, required this.station, required this.earthquake});
  factory _IntensityStationSearchItem.fromJson(Map<String, dynamic> json) => _$IntensityStationSearchItemFromJson(json);

@override final  String eventId;
@override final  IntensityStationInfo station;
@override final  EarthquakePartial earthquake;

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationSearchItemCopyWith<_IntensityStationSearchItem> get copyWith => __$IntensityStationSearchItemCopyWithImpl<_IntensityStationSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.station, station) || other.station == station)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,station,earthquake);

@override
String toString() {
  return 'IntensityStationSearchItem(eventId: $eventId, station: $station, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationSearchItemCopyWith<$Res> implements $IntensityStationSearchItemCopyWith<$Res> {
  factory _$IntensityStationSearchItemCopyWith(_IntensityStationSearchItem value, $Res Function(_IntensityStationSearchItem) _then) = __$IntensityStationSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, IntensityStationInfo station, EarthquakePartial earthquake
});


@override $IntensityStationInfoCopyWith<$Res> get station;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$IntensityStationSearchItemCopyWithImpl<$Res>
    implements _$IntensityStationSearchItemCopyWith<$Res> {
  __$IntensityStationSearchItemCopyWithImpl(this._self, this._then);

  final _IntensityStationSearchItem _self;
  final $Res Function(_IntensityStationSearchItem) _then;

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? station = null,Object? earthquake = null,}) {
  return _then(_IntensityStationSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,station: null == station ? _self.station : station // ignore: cast_nullable_to_non_nullable
as IntensityStationInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IntensityStationInfoCopyWith<$Res> get station {
  
  return $IntensityStationInfoCopyWith<$Res>(_self.station, (value) {
    return _then(_self.copyWith(station: value));
  });
}/// Create a copy of IntensityStationSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$IntensityRegionSearchResponse {

 List<IntensityRegionSearchItem> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of IntensityRegionSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityRegionSearchResponseCopyWith<IntensityRegionSearchResponse> get copyWith => _$IntensityRegionSearchResponseCopyWithImpl<IntensityRegionSearchResponse>(this as IntensityRegionSearchResponse, _$identity);

  /// Serializes this IntensityRegionSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityRegionSearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityRegionSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $IntensityRegionSearchResponseCopyWith<$Res>  {
  factory $IntensityRegionSearchResponseCopyWith(IntensityRegionSearchResponse value, $Res Function(IntensityRegionSearchResponse) _then) = _$IntensityRegionSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<IntensityRegionSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$IntensityRegionSearchResponseCopyWithImpl<$Res>
    implements $IntensityRegionSearchResponseCopyWith<$Res> {
  _$IntensityRegionSearchResponseCopyWithImpl(this._self, this._then);

  final IntensityRegionSearchResponse _self;
  final $Res Function(IntensityRegionSearchResponse) _then;

/// Create a copy of IntensityRegionSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityRegionSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityRegionSearchResponse].
extension IntensityRegionSearchResponsePatterns on IntensityRegionSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityRegionSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityRegionSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityRegionSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityRegionSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityRegionSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityRegionSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityRegionSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityRegionSearchItem> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionSearchResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityRegionSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _IntensityRegionSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityRegionSearchResponse implements IntensityRegionSearchResponse {
  const _IntensityRegionSearchResponse({required final  List<IntensityRegionSearchItem> items, this.nextToken, this.nextPooling}): _items = items;
  factory _IntensityRegionSearchResponse.fromJson(Map<String, dynamic> json) => _$IntensityRegionSearchResponseFromJson(json);

 final  List<IntensityRegionSearchItem> _items;
@override List<IntensityRegionSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of IntensityRegionSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityRegionSearchResponseCopyWith<_IntensityRegionSearchResponse> get copyWith => __$IntensityRegionSearchResponseCopyWithImpl<_IntensityRegionSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityRegionSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityRegionSearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityRegionSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$IntensityRegionSearchResponseCopyWith<$Res> implements $IntensityRegionSearchResponseCopyWith<$Res> {
  factory _$IntensityRegionSearchResponseCopyWith(_IntensityRegionSearchResponse value, $Res Function(_IntensityRegionSearchResponse) _then) = __$IntensityRegionSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityRegionSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$IntensityRegionSearchResponseCopyWithImpl<$Res>
    implements _$IntensityRegionSearchResponseCopyWith<$Res> {
  __$IntensityRegionSearchResponseCopyWithImpl(this._self, this._then);

  final _IntensityRegionSearchResponse _self;
  final $Res Function(_IntensityRegionSearchResponse) _then;

/// Create a copy of IntensityRegionSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_IntensityRegionSearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityRegionSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IntensityPrefectureSearchResponse {

 List<IntensityPrefectureSearchItem> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityPrefectureSearchResponseCopyWith<IntensityPrefectureSearchResponse> get copyWith => _$IntensityPrefectureSearchResponseCopyWithImpl<IntensityPrefectureSearchResponse>(this as IntensityPrefectureSearchResponse, _$identity);

  /// Serializes this IntensityPrefectureSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityPrefectureSearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityPrefectureSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $IntensityPrefectureSearchResponseCopyWith<$Res>  {
  factory $IntensityPrefectureSearchResponseCopyWith(IntensityPrefectureSearchResponse value, $Res Function(IntensityPrefectureSearchResponse) _then) = _$IntensityPrefectureSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<IntensityPrefectureSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$IntensityPrefectureSearchResponseCopyWithImpl<$Res>
    implements $IntensityPrefectureSearchResponseCopyWith<$Res> {
  _$IntensityPrefectureSearchResponseCopyWithImpl(this._self, this._then);

  final IntensityPrefectureSearchResponse _self;
  final $Res Function(IntensityPrefectureSearchResponse) _then;

/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityPrefectureSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityPrefectureSearchResponse].
extension IntensityPrefectureSearchResponsePatterns on IntensityPrefectureSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityPrefectureSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityPrefectureSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityPrefectureSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityPrefectureSearchItem> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityPrefectureSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _IntensityPrefectureSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityPrefectureSearchResponse implements IntensityPrefectureSearchResponse {
  const _IntensityPrefectureSearchResponse({required final  List<IntensityPrefectureSearchItem> items, this.nextToken, this.nextPooling}): _items = items;
  factory _IntensityPrefectureSearchResponse.fromJson(Map<String, dynamic> json) => _$IntensityPrefectureSearchResponseFromJson(json);

 final  List<IntensityPrefectureSearchItem> _items;
@override List<IntensityPrefectureSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityPrefectureSearchResponseCopyWith<_IntensityPrefectureSearchResponse> get copyWith => __$IntensityPrefectureSearchResponseCopyWithImpl<_IntensityPrefectureSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityPrefectureSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityPrefectureSearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityPrefectureSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$IntensityPrefectureSearchResponseCopyWith<$Res> implements $IntensityPrefectureSearchResponseCopyWith<$Res> {
  factory _$IntensityPrefectureSearchResponseCopyWith(_IntensityPrefectureSearchResponse value, $Res Function(_IntensityPrefectureSearchResponse) _then) = __$IntensityPrefectureSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityPrefectureSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$IntensityPrefectureSearchResponseCopyWithImpl<$Res>
    implements _$IntensityPrefectureSearchResponseCopyWith<$Res> {
  __$IntensityPrefectureSearchResponseCopyWithImpl(this._self, this._then);

  final _IntensityPrefectureSearchResponse _self;
  final $Res Function(_IntensityPrefectureSearchResponse) _then;

/// Create a copy of IntensityPrefectureSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_IntensityPrefectureSearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityPrefectureSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IntensityCitySearchResponse {

 List<IntensityCitySearchItem> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityCitySearchResponseCopyWith<IntensityCitySearchResponse> get copyWith => _$IntensityCitySearchResponseCopyWithImpl<IntensityCitySearchResponse>(this as IntensityCitySearchResponse, _$identity);

  /// Serializes this IntensityCitySearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityCitySearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityCitySearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $IntensityCitySearchResponseCopyWith<$Res>  {
  factory $IntensityCitySearchResponseCopyWith(IntensityCitySearchResponse value, $Res Function(IntensityCitySearchResponse) _then) = _$IntensityCitySearchResponseCopyWithImpl;
@useResult
$Res call({
 List<IntensityCitySearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$IntensityCitySearchResponseCopyWithImpl<$Res>
    implements $IntensityCitySearchResponseCopyWith<$Res> {
  _$IntensityCitySearchResponseCopyWithImpl(this._self, this._then);

  final IntensityCitySearchResponse _self;
  final $Res Function(IntensityCitySearchResponse) _then;

/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityCitySearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityCitySearchResponse].
extension IntensityCitySearchResponsePatterns on IntensityCitySearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityCitySearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityCitySearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityCitySearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityCitySearchItem> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityCitySearchItem> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _IntensityCitySearchResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityCitySearchItem> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _IntensityCitySearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityCitySearchResponse implements IntensityCitySearchResponse {
  const _IntensityCitySearchResponse({required final  List<IntensityCitySearchItem> items, this.nextToken, this.nextPooling}): _items = items;
  factory _IntensityCitySearchResponse.fromJson(Map<String, dynamic> json) => _$IntensityCitySearchResponseFromJson(json);

 final  List<IntensityCitySearchItem> _items;
@override List<IntensityCitySearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityCitySearchResponseCopyWith<_IntensityCitySearchResponse> get copyWith => __$IntensityCitySearchResponseCopyWithImpl<_IntensityCitySearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityCitySearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityCitySearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityCitySearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$IntensityCitySearchResponseCopyWith<$Res> implements $IntensityCitySearchResponseCopyWith<$Res> {
  factory _$IntensityCitySearchResponseCopyWith(_IntensityCitySearchResponse value, $Res Function(_IntensityCitySearchResponse) _then) = __$IntensityCitySearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityCitySearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$IntensityCitySearchResponseCopyWithImpl<$Res>
    implements _$IntensityCitySearchResponseCopyWith<$Res> {
  __$IntensityCitySearchResponseCopyWithImpl(this._self, this._then);

  final _IntensityCitySearchResponse _self;
  final $Res Function(_IntensityCitySearchResponse) _then;

/// Create a copy of IntensityCitySearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_IntensityCitySearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityCitySearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IntensityStationSearchResponse {

 List<IntensityStationSearchItem> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of IntensityStationSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityStationSearchResponseCopyWith<IntensityStationSearchResponse> get copyWith => _$IntensityStationSearchResponseCopyWithImpl<IntensityStationSearchResponse>(this as IntensityStationSearchResponse, _$identity);

  /// Serializes this IntensityStationSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityStationSearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityStationSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $IntensityStationSearchResponseCopyWith<$Res>  {
  factory $IntensityStationSearchResponseCopyWith(IntensityStationSearchResponse value, $Res Function(IntensityStationSearchResponse) _then) = _$IntensityStationSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<IntensityStationSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$IntensityStationSearchResponseCopyWithImpl<$Res>
    implements $IntensityStationSearchResponseCopyWith<$Res> {
  _$IntensityStationSearchResponseCopyWithImpl(this._self, this._then);

  final IntensityStationSearchResponse _self;
  final $Res Function(IntensityStationSearchResponse) _then;

/// Create a copy of IntensityStationSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityStationSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntensityStationSearchResponse].
extension IntensityStationSearchResponsePatterns on IntensityStationSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntensityStationSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntensityStationSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntensityStationSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _IntensityStationSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntensityStationSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IntensityStationSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<IntensityStationSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntensityStationSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<IntensityStationSearchItem> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _IntensityStationSearchResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<IntensityStationSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _IntensityStationSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntensityStationSearchResponse implements IntensityStationSearchResponse {
  const _IntensityStationSearchResponse({required final  List<IntensityStationSearchItem> items, this.nextToken, this.nextPooling}): _items = items;
  factory _IntensityStationSearchResponse.fromJson(Map<String, dynamic> json) => _$IntensityStationSearchResponseFromJson(json);

 final  List<IntensityStationSearchItem> _items;
@override List<IntensityStationSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of IntensityStationSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntensityStationSearchResponseCopyWith<_IntensityStationSearchResponse> get copyWith => __$IntensityStationSearchResponseCopyWithImpl<_IntensityStationSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityStationSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntensityStationSearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'IntensityStationSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$IntensityStationSearchResponseCopyWith<$Res> implements $IntensityStationSearchResponseCopyWith<$Res> {
  factory _$IntensityStationSearchResponseCopyWith(_IntensityStationSearchResponse value, $Res Function(_IntensityStationSearchResponse) _then) = __$IntensityStationSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<IntensityStationSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$IntensityStationSearchResponseCopyWithImpl<$Res>
    implements _$IntensityStationSearchResponseCopyWith<$Res> {
  __$IntensityStationSearchResponseCopyWithImpl(this._self, this._then);

  final _IntensityStationSearchResponse _self;
  final $Res Function(_IntensityStationSearchResponse) _then;

/// Create a copy of IntensityStationSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_IntensityStationSearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<IntensityStationSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EpicenterInfo {

 int get code; String get name;
/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpicenterInfoCopyWith<EpicenterInfo> get copyWith => _$EpicenterInfoCopyWithImpl<EpicenterInfo>(this as EpicenterInfo, _$identity);

  /// Serializes this EpicenterInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpicenterInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'EpicenterInfo(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $EpicenterInfoCopyWith<$Res>  {
  factory $EpicenterInfoCopyWith(EpicenterInfo value, $Res Function(EpicenterInfo) _then) = _$EpicenterInfoCopyWithImpl;
@useResult
$Res call({
 int code, String name
});




}
/// @nodoc
class _$EpicenterInfoCopyWithImpl<$Res>
    implements $EpicenterInfoCopyWith<$Res> {
  _$EpicenterInfoCopyWithImpl(this._self, this._then);

  final EpicenterInfo _self;
  final $Res Function(EpicenterInfo) _then;

/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EpicenterInfo].
extension EpicenterInfoPatterns on EpicenterInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpicenterInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpicenterInfo value)  $default,){
final _that = this;
switch (_that) {
case _EpicenterInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpicenterInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String name)  $default,) {final _that = this;
switch (_that) {
case _EpicenterInfo():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String name)?  $default,) {final _that = this;
switch (_that) {
case _EpicenterInfo() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpicenterInfo implements EpicenterInfo {
  const _EpicenterInfo({required this.code, required this.name});
  factory _EpicenterInfo.fromJson(Map<String, dynamic> json) => _$EpicenterInfoFromJson(json);

@override final  int code;
@override final  String name;

/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpicenterInfoCopyWith<_EpicenterInfo> get copyWith => __$EpicenterInfoCopyWithImpl<_EpicenterInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpicenterInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpicenterInfo&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'EpicenterInfo(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$EpicenterInfoCopyWith<$Res> implements $EpicenterInfoCopyWith<$Res> {
  factory _$EpicenterInfoCopyWith(_EpicenterInfo value, $Res Function(_EpicenterInfo) _then) = __$EpicenterInfoCopyWithImpl;
@override @useResult
$Res call({
 int code, String name
});




}
/// @nodoc
class __$EpicenterInfoCopyWithImpl<$Res>
    implements _$EpicenterInfoCopyWith<$Res> {
  __$EpicenterInfoCopyWithImpl(this._self, this._then);

  final _EpicenterInfo _self;
  final $Res Function(_EpicenterInfo) _then;

/// Create a copy of EpicenterInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_EpicenterInfo(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EpicenterSearchItem {

 String get eventId; EpicenterInfo get epicenter; EarthquakePartial get earthquake;
/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpicenterSearchItemCopyWith<EpicenterSearchItem> get copyWith => _$EpicenterSearchItemCopyWithImpl<EpicenterSearchItem>(this as EpicenterSearchItem, _$identity);

  /// Serializes this EpicenterSearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpicenterSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,epicenter,earthquake);

@override
String toString() {
  return 'EpicenterSearchItem(eventId: $eventId, epicenter: $epicenter, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $EpicenterSearchItemCopyWith<$Res>  {
  factory $EpicenterSearchItemCopyWith(EpicenterSearchItem value, $Res Function(EpicenterSearchItem) _then) = _$EpicenterSearchItemCopyWithImpl;
@useResult
$Res call({
 String eventId, EpicenterInfo epicenter, EarthquakePartial earthquake
});


$EpicenterInfoCopyWith<$Res> get epicenter;$EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class _$EpicenterSearchItemCopyWithImpl<$Res>
    implements $EpicenterSearchItemCopyWith<$Res> {
  _$EpicenterSearchItemCopyWithImpl(this._self, this._then);

  final EpicenterSearchItem _self;
  final $Res Function(EpicenterSearchItem) _then;

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? epicenter = null,Object? earthquake = null,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as EpicenterInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}
/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterInfoCopyWith<$Res> get epicenter {
  
  return $EpicenterInfoCopyWith<$Res>(_self.epicenter, (value) {
    return _then(_self.copyWith(epicenter: value));
  });
}/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [EpicenterSearchItem].
extension EpicenterSearchItemPatterns on EpicenterSearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpicenterSearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpicenterSearchItem value)  $default,){
final _that = this;
switch (_that) {
case _EpicenterSearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpicenterSearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  EpicenterInfo epicenter,  EarthquakePartial earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
return $default(_that.eventId,_that.epicenter,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  EpicenterInfo epicenter,  EarthquakePartial earthquake)  $default,) {final _that = this;
switch (_that) {
case _EpicenterSearchItem():
return $default(_that.eventId,_that.epicenter,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  EpicenterInfo epicenter,  EarthquakePartial earthquake)?  $default,) {final _that = this;
switch (_that) {
case _EpicenterSearchItem() when $default != null:
return $default(_that.eventId,_that.epicenter,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpicenterSearchItem implements EpicenterSearchItem {
  const _EpicenterSearchItem({required this.eventId, required this.epicenter, required this.earthquake});
  factory _EpicenterSearchItem.fromJson(Map<String, dynamic> json) => _$EpicenterSearchItemFromJson(json);

@override final  String eventId;
@override final  EpicenterInfo epicenter;
@override final  EarthquakePartial earthquake;

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpicenterSearchItemCopyWith<_EpicenterSearchItem> get copyWith => __$EpicenterSearchItemCopyWithImpl<_EpicenterSearchItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpicenterSearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpicenterSearchItem&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.epicenter, epicenter) || other.epicenter == epicenter)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,epicenter,earthquake);

@override
String toString() {
  return 'EpicenterSearchItem(eventId: $eventId, epicenter: $epicenter, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$EpicenterSearchItemCopyWith<$Res> implements $EpicenterSearchItemCopyWith<$Res> {
  factory _$EpicenterSearchItemCopyWith(_EpicenterSearchItem value, $Res Function(_EpicenterSearchItem) _then) = __$EpicenterSearchItemCopyWithImpl;
@override @useResult
$Res call({
 String eventId, EpicenterInfo epicenter, EarthquakePartial earthquake
});


@override $EpicenterInfoCopyWith<$Res> get epicenter;@override $EarthquakePartialCopyWith<$Res> get earthquake;

}
/// @nodoc
class __$EpicenterSearchItemCopyWithImpl<$Res>
    implements _$EpicenterSearchItemCopyWith<$Res> {
  __$EpicenterSearchItemCopyWithImpl(this._self, this._then);

  final _EpicenterSearchItem _self;
  final $Res Function(_EpicenterSearchItem) _then;

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? epicenter = null,Object? earthquake = null,}) {
  return _then(_EpicenterSearchItem(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,epicenter: null == epicenter ? _self.epicenter : epicenter // ignore: cast_nullable_to_non_nullable
as EpicenterInfo,earthquake: null == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as EarthquakePartial,
  ));
}

/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EpicenterInfoCopyWith<$Res> get epicenter {
  
  return $EpicenterInfoCopyWith<$Res>(_self.epicenter, (value) {
    return _then(_self.copyWith(epicenter: value));
  });
}/// Create a copy of EpicenterSearchItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakePartialCopyWith<$Res> get earthquake {
  
  return $EarthquakePartialCopyWith<$Res>(_self.earthquake, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// @nodoc
mixin _$EpicenterSearchResponse {

 List<EpicenterSearchItem> get items; String? get nextToken; String? get nextPooling;
/// Create a copy of EpicenterSearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpicenterSearchResponseCopyWith<EpicenterSearchResponse> get copyWith => _$EpicenterSearchResponseCopyWithImpl<EpicenterSearchResponse>(this as EpicenterSearchResponse, _$identity);

  /// Serializes this EpicenterSearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpicenterSearchResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),nextToken,nextPooling);

@override
String toString() {
  return 'EpicenterSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class $EpicenterSearchResponseCopyWith<$Res>  {
  factory $EpicenterSearchResponseCopyWith(EpicenterSearchResponse value, $Res Function(EpicenterSearchResponse) _then) = _$EpicenterSearchResponseCopyWithImpl;
@useResult
$Res call({
 List<EpicenterSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class _$EpicenterSearchResponseCopyWithImpl<$Res>
    implements $EpicenterSearchResponseCopyWith<$Res> {
  _$EpicenterSearchResponseCopyWithImpl(this._self, this._then);

  final EpicenterSearchResponse _self;
  final $Res Function(EpicenterSearchResponse) _then;

/// Create a copy of EpicenterSearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<EpicenterSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EpicenterSearchResponse].
extension EpicenterSearchResponsePatterns on EpicenterSearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EpicenterSearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EpicenterSearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EpicenterSearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _EpicenterSearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EpicenterSearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EpicenterSearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EpicenterSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EpicenterSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EpicenterSearchItem> items,  String? nextToken,  String? nextPooling)  $default,) {final _that = this;
switch (_that) {
case _EpicenterSearchResponse():
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EpicenterSearchItem> items,  String? nextToken,  String? nextPooling)?  $default,) {final _that = this;
switch (_that) {
case _EpicenterSearchResponse() when $default != null:
return $default(_that.items,_that.nextToken,_that.nextPooling);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EpicenterSearchResponse implements EpicenterSearchResponse {
  const _EpicenterSearchResponse({required final  List<EpicenterSearchItem> items, this.nextToken, this.nextPooling}): _items = items;
  factory _EpicenterSearchResponse.fromJson(Map<String, dynamic> json) => _$EpicenterSearchResponseFromJson(json);

 final  List<EpicenterSearchItem> _items;
@override List<EpicenterSearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextToken;
@override final  String? nextPooling;

/// Create a copy of EpicenterSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpicenterSearchResponseCopyWith<_EpicenterSearchResponse> get copyWith => __$EpicenterSearchResponseCopyWithImpl<_EpicenterSearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EpicenterSearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpicenterSearchResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.nextToken, nextToken) || other.nextToken == nextToken)&&(identical(other.nextPooling, nextPooling) || other.nextPooling == nextPooling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),nextToken,nextPooling);

@override
String toString() {
  return 'EpicenterSearchResponse(items: $items, nextToken: $nextToken, nextPooling: $nextPooling)';
}


}

/// @nodoc
abstract mixin class _$EpicenterSearchResponseCopyWith<$Res> implements $EpicenterSearchResponseCopyWith<$Res> {
  factory _$EpicenterSearchResponseCopyWith(_EpicenterSearchResponse value, $Res Function(_EpicenterSearchResponse) _then) = __$EpicenterSearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<EpicenterSearchItem> items, String? nextToken, String? nextPooling
});




}
/// @nodoc
class __$EpicenterSearchResponseCopyWithImpl<$Res>
    implements _$EpicenterSearchResponseCopyWith<$Res> {
  __$EpicenterSearchResponseCopyWithImpl(this._self, this._then);

  final _EpicenterSearchResponse _self;
  final $Res Function(_EpicenterSearchResponse) _then;

/// Create a copy of EpicenterSearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? nextToken = freezed,Object? nextPooling = freezed,}) {
  return _then(_EpicenterSearchResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<EpicenterSearchItem>,nextToken: freezed == nextToken ? _self.nextToken : nextToken // ignore: cast_nullable_to_non_nullable
as String?,nextPooling: freezed == nextPooling ? _self.nextPooling : nextPooling // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
