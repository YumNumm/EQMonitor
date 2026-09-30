// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_sound_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSoundCatalog {

 List<CustomNotificationSound> get sounds;
/// Create a copy of NotificationSoundCatalog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSoundCatalogCopyWith<NotificationSoundCatalog> get copyWith => _$NotificationSoundCatalogCopyWithImpl<NotificationSoundCatalog>(this as NotificationSoundCatalog, _$identity);

  /// Serializes this NotificationSoundCatalog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSoundCatalog&&const DeepCollectionEquality().equals(other.sounds, sounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sounds));

@override
String toString() {
  return 'NotificationSoundCatalog(sounds: $sounds)';
}


}

/// @nodoc
abstract mixin class $NotificationSoundCatalogCopyWith<$Res>  {
  factory $NotificationSoundCatalogCopyWith(NotificationSoundCatalog value, $Res Function(NotificationSoundCatalog) _then) = _$NotificationSoundCatalogCopyWithImpl;
@useResult
$Res call({
 List<CustomNotificationSound> sounds
});




}
/// @nodoc
class _$NotificationSoundCatalogCopyWithImpl<$Res>
    implements $NotificationSoundCatalogCopyWith<$Res> {
  _$NotificationSoundCatalogCopyWithImpl(this._self, this._then);

  final NotificationSoundCatalog _self;
  final $Res Function(NotificationSoundCatalog) _then;

/// Create a copy of NotificationSoundCatalog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sounds = null,}) {
  return _then(NotificationSoundCatalog(
sounds: null == sounds ? _self.sounds : sounds // ignore: cast_nullable_to_non_nullable
as List<CustomNotificationSound>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSoundCatalog].
extension NotificationSoundCatalogPatterns on NotificationSoundCatalog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSoundCatalog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSoundCatalog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSoundCatalog value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSoundCatalog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSoundCatalog value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSoundCatalog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CustomNotificationSound> sounds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSoundCatalog() when $default != null:
return $default(_that.sounds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CustomNotificationSound> sounds)  $default,) {final _that = this;
switch (_that) {
case _NotificationSoundCatalog():
return $default(_that.sounds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CustomNotificationSound> sounds)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSoundCatalog() when $default != null:
return $default(_that.sounds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSoundCatalog implements NotificationSoundCatalog {
  const _NotificationSoundCatalog({required  List<CustomNotificationSound> sounds}): _sounds = sounds;
  factory _NotificationSoundCatalog.fromJson(Map<String, dynamic> json) => _$NotificationSoundCatalogFromJson(json);

 final  List<CustomNotificationSound> _sounds;
@override List<CustomNotificationSound> get sounds {
  if (_sounds is EqualUnmodifiableListView) return _sounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sounds);
}


/// Create a copy of NotificationSoundCatalog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSoundCatalogCopyWith<_NotificationSoundCatalog> get copyWith => __$NotificationSoundCatalogCopyWithImpl<_NotificationSoundCatalog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSoundCatalogToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSoundCatalog&&const DeepCollectionEquality().equals(other._sounds, _sounds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sounds));

@override
String toString() {
  return 'NotificationSoundCatalog(sounds: $sounds)';
}


}

/// @nodoc
abstract mixin class _$NotificationSoundCatalogCopyWith<$Res> implements $NotificationSoundCatalogCopyWith<$Res> {
  factory _$NotificationSoundCatalogCopyWith(_NotificationSoundCatalog value, $Res Function(_NotificationSoundCatalog) _then) = __$NotificationSoundCatalogCopyWithImpl;
@override @useResult
$Res call({
 List<CustomNotificationSound> sounds
});




}
/// @nodoc
class __$NotificationSoundCatalogCopyWithImpl<$Res>
    implements _$NotificationSoundCatalogCopyWith<$Res> {
  __$NotificationSoundCatalogCopyWithImpl(this._self, this._then);

  final _NotificationSoundCatalog _self;
  final $Res Function(_NotificationSoundCatalog) _then;

/// Create a copy of NotificationSoundCatalog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sounds = null,}) {
  return _then(_NotificationSoundCatalog(
sounds: null == sounds ? _self._sounds : sounds // ignore: cast_nullable_to_non_nullable
as List<CustomNotificationSound>,
  ));
}


}

// dart format on
