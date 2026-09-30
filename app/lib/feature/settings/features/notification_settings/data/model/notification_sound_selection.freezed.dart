// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_sound_selection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationSoundSelection {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSoundSelection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationSoundSelection()';
}


}

/// @nodoc
class $NotificationSoundSelectionCopyWith<$Res>  {
$NotificationSoundSelectionCopyWith(NotificationSoundSelection _, $Res Function(NotificationSoundSelection) __);
}


/// Adds pattern-matching-related methods to [NotificationSoundSelection].
extension NotificationSoundSelectionPatterns on NotificationSoundSelection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BuiltinNotificationSoundSelection value)?  builtin,TResult Function( CustomNotificationSoundSelection value)?  custom,TResult Function( UnavailableNotificationSoundSelection value)?  unavailable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BuiltinNotificationSoundSelection() when builtin != null:
return builtin(_that);case CustomNotificationSoundSelection() when custom != null:
return custom(_that);case UnavailableNotificationSoundSelection() when unavailable != null:
return unavailable(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BuiltinNotificationSoundSelection value)  builtin,required TResult Function( CustomNotificationSoundSelection value)  custom,required TResult Function( UnavailableNotificationSoundSelection value)  unavailable,}){
final _that = this;
switch (_that) {
case BuiltinNotificationSoundSelection():
return builtin(_that);case CustomNotificationSoundSelection():
return custom(_that);case UnavailableNotificationSoundSelection():
return unavailable(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BuiltinNotificationSoundSelection value)?  builtin,TResult? Function( CustomNotificationSoundSelection value)?  custom,TResult? Function( UnavailableNotificationSoundSelection value)?  unavailable,}){
final _that = this;
switch (_that) {
case BuiltinNotificationSoundSelection() when builtin != null:
return builtin(_that);case CustomNotificationSoundSelection() when custom != null:
return custom(_that);case UnavailableNotificationSoundSelection() when unavailable != null:
return unavailable(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( NotificationSound sound)?  builtin,TResult Function( CustomNotificationSound sound)?  custom,TResult Function( String apiValue)?  unavailable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BuiltinNotificationSoundSelection() when builtin != null:
return builtin(_that.sound);case CustomNotificationSoundSelection() when custom != null:
return custom(_that.sound);case UnavailableNotificationSoundSelection() when unavailable != null:
return unavailable(_that.apiValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( NotificationSound sound)  builtin,required TResult Function( CustomNotificationSound sound)  custom,required TResult Function( String apiValue)  unavailable,}) {final _that = this;
switch (_that) {
case BuiltinNotificationSoundSelection():
return builtin(_that.sound);case CustomNotificationSoundSelection():
return custom(_that.sound);case UnavailableNotificationSoundSelection():
return unavailable(_that.apiValue);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( NotificationSound sound)?  builtin,TResult? Function( CustomNotificationSound sound)?  custom,TResult? Function( String apiValue)?  unavailable,}) {final _that = this;
switch (_that) {
case BuiltinNotificationSoundSelection() when builtin != null:
return builtin(_that.sound);case CustomNotificationSoundSelection() when custom != null:
return custom(_that.sound);case UnavailableNotificationSoundSelection() when unavailable != null:
return unavailable(_that.apiValue);case _:
  return null;

}
}

}

/// @nodoc


class BuiltinNotificationSoundSelection implements NotificationSoundSelection {
  const BuiltinNotificationSoundSelection(this.sound);
  

 final  NotificationSound sound;

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuiltinNotificationSoundSelectionCopyWith<BuiltinNotificationSoundSelection> get copyWith => _$BuiltinNotificationSoundSelectionCopyWithImpl<BuiltinNotificationSoundSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuiltinNotificationSoundSelection&&(identical(other.sound, sound) || other.sound == sound));
}


@override
int get hashCode => Object.hash(runtimeType,sound);

@override
String toString() {
  return 'NotificationSoundSelection.builtin(sound: $sound)';
}


}

/// @nodoc
abstract mixin class $BuiltinNotificationSoundSelectionCopyWith<$Res> implements $NotificationSoundSelectionCopyWith<$Res> {
  factory $BuiltinNotificationSoundSelectionCopyWith(BuiltinNotificationSoundSelection value, $Res Function(BuiltinNotificationSoundSelection) _then) = _$BuiltinNotificationSoundSelectionCopyWithImpl;
@useResult
$Res call({
 NotificationSound sound
});




}
/// @nodoc
class _$BuiltinNotificationSoundSelectionCopyWithImpl<$Res>
    implements $BuiltinNotificationSoundSelectionCopyWith<$Res> {
  _$BuiltinNotificationSoundSelectionCopyWithImpl(this._self, this._then);

  final BuiltinNotificationSoundSelection _self;
  final $Res Function(BuiltinNotificationSoundSelection) _then;

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sound = null,}) {
  return _then(BuiltinNotificationSoundSelection(
null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as NotificationSound,
  ));
}


}

/// @nodoc


class CustomNotificationSoundSelection implements NotificationSoundSelection {
  const CustomNotificationSoundSelection(this.sound);
  

 final  CustomNotificationSound sound;

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomNotificationSoundSelectionCopyWith<CustomNotificationSoundSelection> get copyWith => _$CustomNotificationSoundSelectionCopyWithImpl<CustomNotificationSoundSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomNotificationSoundSelection&&(identical(other.sound, sound) || other.sound == sound));
}


@override
int get hashCode => Object.hash(runtimeType,sound);

@override
String toString() {
  return 'NotificationSoundSelection.custom(sound: $sound)';
}


}

/// @nodoc
abstract mixin class $CustomNotificationSoundSelectionCopyWith<$Res> implements $NotificationSoundSelectionCopyWith<$Res> {
  factory $CustomNotificationSoundSelectionCopyWith(CustomNotificationSoundSelection value, $Res Function(CustomNotificationSoundSelection) _then) = _$CustomNotificationSoundSelectionCopyWithImpl;
@useResult
$Res call({
 CustomNotificationSound sound
});


$CustomNotificationSoundCopyWith<$Res> get sound;

}
/// @nodoc
class _$CustomNotificationSoundSelectionCopyWithImpl<$Res>
    implements $CustomNotificationSoundSelectionCopyWith<$Res> {
  _$CustomNotificationSoundSelectionCopyWithImpl(this._self, this._then);

  final CustomNotificationSoundSelection _self;
  final $Res Function(CustomNotificationSoundSelection) _then;

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sound = null,}) {
  return _then(CustomNotificationSoundSelection(
null == sound ? _self.sound : sound // ignore: cast_nullable_to_non_nullable
as CustomNotificationSound,
  ));
}

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomNotificationSoundCopyWith<$Res> get sound {
  
  return $CustomNotificationSoundCopyWith<$Res>(_self.sound, (value) {
    return _then(_self.copyWith(sound: value));
  });
}
}

/// @nodoc


class UnavailableNotificationSoundSelection implements NotificationSoundSelection {
  const UnavailableNotificationSoundSelection(this.apiValue);
  

 final  String apiValue;

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnavailableNotificationSoundSelectionCopyWith<UnavailableNotificationSoundSelection> get copyWith => _$UnavailableNotificationSoundSelectionCopyWithImpl<UnavailableNotificationSoundSelection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnavailableNotificationSoundSelection&&(identical(other.apiValue, apiValue) || other.apiValue == apiValue));
}


@override
int get hashCode => Object.hash(runtimeType,apiValue);

@override
String toString() {
  return 'NotificationSoundSelection.unavailable(apiValue: $apiValue)';
}


}

/// @nodoc
abstract mixin class $UnavailableNotificationSoundSelectionCopyWith<$Res> implements $NotificationSoundSelectionCopyWith<$Res> {
  factory $UnavailableNotificationSoundSelectionCopyWith(UnavailableNotificationSoundSelection value, $Res Function(UnavailableNotificationSoundSelection) _then) = _$UnavailableNotificationSoundSelectionCopyWithImpl;
@useResult
$Res call({
 String apiValue
});




}
/// @nodoc
class _$UnavailableNotificationSoundSelectionCopyWithImpl<$Res>
    implements $UnavailableNotificationSoundSelectionCopyWith<$Res> {
  _$UnavailableNotificationSoundSelectionCopyWithImpl(this._self, this._then);

  final UnavailableNotificationSoundSelection _self;
  final $Res Function(UnavailableNotificationSoundSelection) _then;

/// Create a copy of NotificationSoundSelection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiValue = null,}) {
  return _then(UnavailableNotificationSoundSelection(
null == apiValue ? _self.apiValue : apiValue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
