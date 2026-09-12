// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unified_live_activity_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnifiedLiveActivityAttributes {

 String get id;
/// Create a copy of UnifiedLiveActivityAttributes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedLiveActivityAttributesCopyWith<UnifiedLiveActivityAttributes> get copyWith => _$UnifiedLiveActivityAttributesCopyWithImpl<UnifiedLiveActivityAttributes>(this as UnifiedLiveActivityAttributes, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedLiveActivityAttributes&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UnifiedLiveActivityAttributes(id: $id)';
}


}

/// @nodoc
abstract mixin class $UnifiedLiveActivityAttributesCopyWith<$Res>  {
  factory $UnifiedLiveActivityAttributesCopyWith(UnifiedLiveActivityAttributes value, $Res Function(UnifiedLiveActivityAttributes) _then) = _$UnifiedLiveActivityAttributesCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$UnifiedLiveActivityAttributesCopyWithImpl<$Res>
    implements $UnifiedLiveActivityAttributesCopyWith<$Res> {
  _$UnifiedLiveActivityAttributesCopyWithImpl(this._self, this._then);

  final UnifiedLiveActivityAttributes _self;
  final $Res Function(UnifiedLiveActivityAttributes) _then;

/// Create a copy of UnifiedLiveActivityAttributes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(UnifiedLiveActivityAttributes(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UnifiedLiveActivityAttributes].
extension UnifiedLiveActivityAttributesPatterns on UnifiedLiveActivityAttributes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedLiveActivityAttributes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedLiveActivityAttributes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedLiveActivityAttributes value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedLiveActivityAttributes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedLiveActivityAttributes value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedLiveActivityAttributes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedLiveActivityAttributes() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _UnifiedLiveActivityAttributes():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedLiveActivityAttributes() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedLiveActivityAttributes extends UnifiedLiveActivityAttributes {
  const _UnifiedLiveActivityAttributes({required this.id}): super._();
  

@override final  String id;

/// Create a copy of UnifiedLiveActivityAttributes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedLiveActivityAttributesCopyWith<_UnifiedLiveActivityAttributes> get copyWith => __$UnifiedLiveActivityAttributesCopyWithImpl<_UnifiedLiveActivityAttributes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedLiveActivityAttributes&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UnifiedLiveActivityAttributes(id: $id)';
}


}

/// @nodoc
abstract mixin class _$UnifiedLiveActivityAttributesCopyWith<$Res> implements $UnifiedLiveActivityAttributesCopyWith<$Res> {
  factory _$UnifiedLiveActivityAttributesCopyWith(_UnifiedLiveActivityAttributes value, $Res Function(_UnifiedLiveActivityAttributes) _then) = __$UnifiedLiveActivityAttributesCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$UnifiedLiveActivityAttributesCopyWithImpl<$Res>
    implements _$UnifiedLiveActivityAttributesCopyWith<$Res> {
  __$UnifiedLiveActivityAttributesCopyWithImpl(this._self, this._then);

  final _UnifiedLiveActivityAttributes _self;
  final $Res Function(_UnifiedLiveActivityAttributes) _then;

/// Create a copy of UnifiedLiveActivityAttributes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_UnifiedLiveActivityAttributes(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$UnifiedLiveActivityContentState {

 int get schemaVersion; String get id; DateTime get updatedAt; UnifiedLiveActivityPrimary get primary; UnifiedShakeDetection? get shakeDetection; UnifiedEew? get eew; UnifiedEarthquake? get earthquake;
/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnifiedLiveActivityContentStateCopyWith<UnifiedLiveActivityContentState> get copyWith => _$UnifiedLiveActivityContentStateCopyWithImpl<UnifiedLiveActivityContentState>(this as UnifiedLiveActivityContentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnifiedLiveActivityContentState&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.shakeDetection, shakeDetection) || other.shakeDetection == shakeDetection)&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,updatedAt,primary,shakeDetection,eew,earthquake);

@override
String toString() {
  return 'UnifiedLiveActivityContentState(schemaVersion: $schemaVersion, id: $id, updatedAt: $updatedAt, primary: $primary, shakeDetection: $shakeDetection, eew: $eew, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class $UnifiedLiveActivityContentStateCopyWith<$Res>  {
  factory $UnifiedLiveActivityContentStateCopyWith(UnifiedLiveActivityContentState value, $Res Function(UnifiedLiveActivityContentState) _then) = _$UnifiedLiveActivityContentStateCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, DateTime updatedAt, UnifiedLiveActivityPrimary primary, UnifiedShakeDetection? shakeDetection, UnifiedEew? eew, UnifiedEarthquake? earthquake
});


$UnifiedShakeDetectionCopyWith<$Res>? get shakeDetection;$UnifiedEewCopyWith<$Res>? get eew;$UnifiedEarthquakeCopyWith<$Res>? get earthquake;

}
/// @nodoc
class _$UnifiedLiveActivityContentStateCopyWithImpl<$Res>
    implements $UnifiedLiveActivityContentStateCopyWith<$Res> {
  _$UnifiedLiveActivityContentStateCopyWithImpl(this._self, this._then);

  final UnifiedLiveActivityContentState _self;
  final $Res Function(UnifiedLiveActivityContentState) _then;

/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? updatedAt = null,Object? primary = null,Object? shakeDetection = freezed,Object? eew = freezed,Object? earthquake = freezed,}) {
  return _then(UnifiedLiveActivityContentState(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as UnifiedLiveActivityPrimary,shakeDetection: freezed == shakeDetection ? _self.shakeDetection : shakeDetection // ignore: cast_nullable_to_non_nullable
as UnifiedShakeDetection?,eew: freezed == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as UnifiedEew?,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as UnifiedEarthquake?,
  ));
}
/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedShakeDetectionCopyWith<$Res>? get shakeDetection {
    if (_self.shakeDetection == null) {
    return null;
  }

  return $UnifiedShakeDetectionCopyWith<$Res>(_self.shakeDetection!, (value) {
    return _then(_self.copyWith(shakeDetection: value));
  });
}/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEewCopyWith<$Res>? get eew {
    if (_self.eew == null) {
    return null;
  }

  return $UnifiedEewCopyWith<$Res>(_self.eew!, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEarthquakeCopyWith<$Res>? get earthquake {
    if (_self.earthquake == null) {
    return null;
  }

  return $UnifiedEarthquakeCopyWith<$Res>(_self.earthquake!, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}


/// Adds pattern-matching-related methods to [UnifiedLiveActivityContentState].
extension UnifiedLiveActivityContentStatePatterns on UnifiedLiveActivityContentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnifiedLiveActivityContentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnifiedLiveActivityContentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnifiedLiveActivityContentState value)  $default,){
final _that = this;
switch (_that) {
case _UnifiedLiveActivityContentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnifiedLiveActivityContentState value)?  $default,){
final _that = this;
switch (_that) {
case _UnifiedLiveActivityContentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  DateTime updatedAt,  UnifiedLiveActivityPrimary primary,  UnifiedShakeDetection? shakeDetection,  UnifiedEew? eew,  UnifiedEarthquake? earthquake)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UnifiedLiveActivityContentState() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.updatedAt,_that.primary,_that.shakeDetection,_that.eew,_that.earthquake);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  DateTime updatedAt,  UnifiedLiveActivityPrimary primary,  UnifiedShakeDetection? shakeDetection,  UnifiedEew? eew,  UnifiedEarthquake? earthquake)  $default,) {final _that = this;
switch (_that) {
case _UnifiedLiveActivityContentState():
return $default(_that.schemaVersion,_that.id,_that.updatedAt,_that.primary,_that.shakeDetection,_that.eew,_that.earthquake);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  DateTime updatedAt,  UnifiedLiveActivityPrimary primary,  UnifiedShakeDetection? shakeDetection,  UnifiedEew? eew,  UnifiedEarthquake? earthquake)?  $default,) {final _that = this;
switch (_that) {
case _UnifiedLiveActivityContentState() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.updatedAt,_that.primary,_that.shakeDetection,_that.eew,_that.earthquake);case _:
  return null;

}
}

}

/// @nodoc


class _UnifiedLiveActivityContentState extends UnifiedLiveActivityContentState {
  const _UnifiedLiveActivityContentState({required this.schemaVersion, required this.id, required this.updatedAt, required this.primary, required this.shakeDetection, required this.eew, required this.earthquake}): super._();
  

@override final  int schemaVersion;
@override final  String id;
@override final  DateTime updatedAt;
@override final  UnifiedLiveActivityPrimary primary;
@override final  UnifiedShakeDetection? shakeDetection;
@override final  UnifiedEew? eew;
@override final  UnifiedEarthquake? earthquake;

/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnifiedLiveActivityContentStateCopyWith<_UnifiedLiveActivityContentState> get copyWith => __$UnifiedLiveActivityContentStateCopyWithImpl<_UnifiedLiveActivityContentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnifiedLiveActivityContentState&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.shakeDetection, shakeDetection) || other.shakeDetection == shakeDetection)&&(identical(other.eew, eew) || other.eew == eew)&&(identical(other.earthquake, earthquake) || other.earthquake == earthquake));
}


@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,updatedAt,primary,shakeDetection,eew,earthquake);

@override
String toString() {
  return 'UnifiedLiveActivityContentState(schemaVersion: $schemaVersion, id: $id, updatedAt: $updatedAt, primary: $primary, shakeDetection: $shakeDetection, eew: $eew, earthquake: $earthquake)';
}


}

/// @nodoc
abstract mixin class _$UnifiedLiveActivityContentStateCopyWith<$Res> implements $UnifiedLiveActivityContentStateCopyWith<$Res> {
  factory _$UnifiedLiveActivityContentStateCopyWith(_UnifiedLiveActivityContentState value, $Res Function(_UnifiedLiveActivityContentState) _then) = __$UnifiedLiveActivityContentStateCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, DateTime updatedAt, UnifiedLiveActivityPrimary primary, UnifiedShakeDetection? shakeDetection, UnifiedEew? eew, UnifiedEarthquake? earthquake
});


@override $UnifiedShakeDetectionCopyWith<$Res>? get shakeDetection;@override $UnifiedEewCopyWith<$Res>? get eew;@override $UnifiedEarthquakeCopyWith<$Res>? get earthquake;

}
/// @nodoc
class __$UnifiedLiveActivityContentStateCopyWithImpl<$Res>
    implements _$UnifiedLiveActivityContentStateCopyWith<$Res> {
  __$UnifiedLiveActivityContentStateCopyWithImpl(this._self, this._then);

  final _UnifiedLiveActivityContentState _self;
  final $Res Function(_UnifiedLiveActivityContentState) _then;

/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? updatedAt = null,Object? primary = null,Object? shakeDetection = freezed,Object? eew = freezed,Object? earthquake = freezed,}) {
  return _then(_UnifiedLiveActivityContentState(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as UnifiedLiveActivityPrimary,shakeDetection: freezed == shakeDetection ? _self.shakeDetection : shakeDetection // ignore: cast_nullable_to_non_nullable
as UnifiedShakeDetection?,eew: freezed == eew ? _self.eew : eew // ignore: cast_nullable_to_non_nullable
as UnifiedEew?,earthquake: freezed == earthquake ? _self.earthquake : earthquake // ignore: cast_nullable_to_non_nullable
as UnifiedEarthquake?,
  ));
}

/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedShakeDetectionCopyWith<$Res>? get shakeDetection {
    if (_self.shakeDetection == null) {
    return null;
  }

  return $UnifiedShakeDetectionCopyWith<$Res>(_self.shakeDetection!, (value) {
    return _then(_self.copyWith(shakeDetection: value));
  });
}/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEewCopyWith<$Res>? get eew {
    if (_self.eew == null) {
    return null;
  }

  return $UnifiedEewCopyWith<$Res>(_self.eew!, (value) {
    return _then(_self.copyWith(eew: value));
  });
}/// Create a copy of UnifiedLiveActivityContentState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnifiedEarthquakeCopyWith<$Res>? get earthquake {
    if (_self.earthquake == null) {
    return null;
  }

  return $UnifiedEarthquakeCopyWith<$Res>(_self.earthquake!, (value) {
    return _then(_self.copyWith(earthquake: value));
  });
}
}

// dart format on
