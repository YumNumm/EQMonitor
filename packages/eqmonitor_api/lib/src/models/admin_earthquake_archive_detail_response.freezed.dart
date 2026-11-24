// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_earthquake_archive_detail_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminEarthquakeArchiveDetailResponse {

 EarthquakeArchive get item;
/// Create a copy of AdminEarthquakeArchiveDetailResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminEarthquakeArchiveDetailResponseCopyWith<AdminEarthquakeArchiveDetailResponse> get copyWith => _$AdminEarthquakeArchiveDetailResponseCopyWithImpl<AdminEarthquakeArchiveDetailResponse>(this as AdminEarthquakeArchiveDetailResponse, _$identity);

  /// Serializes this AdminEarthquakeArchiveDetailResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminEarthquakeArchiveDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'AdminEarthquakeArchiveDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class $AdminEarthquakeArchiveDetailResponseCopyWith<$Res>  {
  factory $AdminEarthquakeArchiveDetailResponseCopyWith(AdminEarthquakeArchiveDetailResponse value, $Res Function(AdminEarthquakeArchiveDetailResponse) _then) = _$AdminEarthquakeArchiveDetailResponseCopyWithImpl;
@useResult
$Res call({
 EarthquakeArchive item
});


$EarthquakeArchiveCopyWith<$Res> get item;

}
/// @nodoc
class _$AdminEarthquakeArchiveDetailResponseCopyWithImpl<$Res>
    implements $AdminEarthquakeArchiveDetailResponseCopyWith<$Res> {
  _$AdminEarthquakeArchiveDetailResponseCopyWithImpl(this._self, this._then);

  final AdminEarthquakeArchiveDetailResponse _self;
  final $Res Function(AdminEarthquakeArchiveDetailResponse) _then;

/// Create a copy of AdminEarthquakeArchiveDetailResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,}) {
  return _then(AdminEarthquakeArchiveDetailResponse(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as EarthquakeArchive,
  ));
}
/// Create a copy of AdminEarthquakeArchiveDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeArchiveCopyWith<$Res> get item {
  
  return $EarthquakeArchiveCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminEarthquakeArchiveDetailResponse].
extension AdminEarthquakeArchiveDetailResponsePatterns on AdminEarthquakeArchiveDetailResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminEarthquakeArchiveDetailResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDetailResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminEarthquakeArchiveDetailResponse value)  $default,){
final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDetailResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminEarthquakeArchiveDetailResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDetailResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeArchive item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDetailResponse() when $default != null:
return $default(_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeArchive item)  $default,) {final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDetailResponse():
return $default(_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeArchive item)?  $default,) {final _that = this;
switch (_that) {
case _AdminEarthquakeArchiveDetailResponse() when $default != null:
return $default(_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminEarthquakeArchiveDetailResponse implements AdminEarthquakeArchiveDetailResponse {
  const _AdminEarthquakeArchiveDetailResponse({required this.item});
  factory _AdminEarthquakeArchiveDetailResponse.fromJson(Map<String, dynamic> json) => _$AdminEarthquakeArchiveDetailResponseFromJson(json);

@override final  EarthquakeArchive item;

/// Create a copy of AdminEarthquakeArchiveDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminEarthquakeArchiveDetailResponseCopyWith<_AdminEarthquakeArchiveDetailResponse> get copyWith => __$AdminEarthquakeArchiveDetailResponseCopyWithImpl<_AdminEarthquakeArchiveDetailResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminEarthquakeArchiveDetailResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminEarthquakeArchiveDetailResponse&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,item);

@override
String toString() {
  return 'AdminEarthquakeArchiveDetailResponse(item: $item)';
}


}

/// @nodoc
abstract mixin class _$AdminEarthquakeArchiveDetailResponseCopyWith<$Res> implements $AdminEarthquakeArchiveDetailResponseCopyWith<$Res> {
  factory _$AdminEarthquakeArchiveDetailResponseCopyWith(_AdminEarthquakeArchiveDetailResponse value, $Res Function(_AdminEarthquakeArchiveDetailResponse) _then) = __$AdminEarthquakeArchiveDetailResponseCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeArchive item
});


@override $EarthquakeArchiveCopyWith<$Res> get item;

}
/// @nodoc
class __$AdminEarthquakeArchiveDetailResponseCopyWithImpl<$Res>
    implements _$AdminEarthquakeArchiveDetailResponseCopyWith<$Res> {
  __$AdminEarthquakeArchiveDetailResponseCopyWithImpl(this._self, this._then);

  final _AdminEarthquakeArchiveDetailResponse _self;
  final $Res Function(_AdminEarthquakeArchiveDetailResponse) _then;

/// Create a copy of AdminEarthquakeArchiveDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_AdminEarthquakeArchiveDetailResponse(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as EarthquakeArchive,
  ));
}

/// Create a copy of AdminEarthquakeArchiveDetailResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeArchiveCopyWith<$Res> get item {
  
  return $EarthquakeArchiveCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

// dart format on
