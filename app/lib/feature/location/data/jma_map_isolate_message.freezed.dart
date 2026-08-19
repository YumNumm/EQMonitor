// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jma_map_isolate_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JmaMapCalculateMessage {

 int get id; JmaMapType get type; double get lat; double get lng;
/// Create a copy of JmaMapCalculateMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaMapCalculateMessageCopyWith<JmaMapCalculateMessage> get copyWith => _$JmaMapCalculateMessageCopyWithImpl<JmaMapCalculateMessage>(this as JmaMapCalculateMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaMapCalculateMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,lat,lng);

@override
String toString() {
  return 'JmaMapCalculateMessage(id: $id, type: $type, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $JmaMapCalculateMessageCopyWith<$Res>  {
  factory $JmaMapCalculateMessageCopyWith(JmaMapCalculateMessage value, $Res Function(JmaMapCalculateMessage) _then) = _$JmaMapCalculateMessageCopyWithImpl;
@useResult
$Res call({
 int id, JmaMapType type, double lat, double lng
});




}
/// @nodoc
class _$JmaMapCalculateMessageCopyWithImpl<$Res>
    implements $JmaMapCalculateMessageCopyWith<$Res> {
  _$JmaMapCalculateMessageCopyWithImpl(this._self, this._then);

  final JmaMapCalculateMessage _self;
  final $Res Function(JmaMapCalculateMessage) _then;

/// Create a copy of JmaMapCalculateMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? lat = null,Object? lng = null,}) {
  return _then(JmaMapCalculateMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as JmaMapType,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [JmaMapCalculateMessage].
extension JmaMapCalculateMessagePatterns on JmaMapCalculateMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaMapCalculateMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaMapCalculateMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaMapCalculateMessage value)  $default,){
final _that = this;
switch (_that) {
case _JmaMapCalculateMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaMapCalculateMessage value)?  $default,){
final _that = this;
switch (_that) {
case _JmaMapCalculateMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  JmaMapType type,  double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaMapCalculateMessage() when $default != null:
return $default(_that.id,_that.type,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  JmaMapType type,  double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _JmaMapCalculateMessage():
return $default(_that.id,_that.type,_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  JmaMapType type,  double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _JmaMapCalculateMessage() when $default != null:
return $default(_that.id,_that.type,_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc


class _JmaMapCalculateMessage implements JmaMapCalculateMessage {
  const _JmaMapCalculateMessage({required this.id, required this.type, required this.lat, required this.lng});
  

@override final  int id;
@override final  JmaMapType type;
@override final  double lat;
@override final  double lng;

/// Create a copy of JmaMapCalculateMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaMapCalculateMessageCopyWith<_JmaMapCalculateMessage> get copyWith => __$JmaMapCalculateMessageCopyWithImpl<_JmaMapCalculateMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaMapCalculateMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,lat,lng);

@override
String toString() {
  return 'JmaMapCalculateMessage(id: $id, type: $type, lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$JmaMapCalculateMessageCopyWith<$Res> implements $JmaMapCalculateMessageCopyWith<$Res> {
  factory _$JmaMapCalculateMessageCopyWith(_JmaMapCalculateMessage value, $Res Function(_JmaMapCalculateMessage) _then) = __$JmaMapCalculateMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, JmaMapType type, double lat, double lng
});




}
/// @nodoc
class __$JmaMapCalculateMessageCopyWithImpl<$Res>
    implements _$JmaMapCalculateMessageCopyWith<$Res> {
  __$JmaMapCalculateMessageCopyWithImpl(this._self, this._then);

  final _JmaMapCalculateMessage _self;
  final $Res Function(_JmaMapCalculateMessage) _then;

/// Create a copy of JmaMapCalculateMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? lat = null,Object? lng = null,}) {
  return _then(_JmaMapCalculateMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as JmaMapType,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$JmaMapShutdownMessage {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaMapShutdownMessage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JmaMapShutdownMessage()';
}


}

/// @nodoc
class $JmaMapShutdownMessageCopyWith<$Res>  {
$JmaMapShutdownMessageCopyWith(JmaMapShutdownMessage _, $Res Function(JmaMapShutdownMessage) __);
}


/// Adds pattern-matching-related methods to [JmaMapShutdownMessage].
extension JmaMapShutdownMessagePatterns on JmaMapShutdownMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaMapShutdownMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaMapShutdownMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaMapShutdownMessage value)  $default,){
final _that = this;
switch (_that) {
case _JmaMapShutdownMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaMapShutdownMessage value)?  $default,){
final _that = this;
switch (_that) {
case _JmaMapShutdownMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaMapShutdownMessage() when $default != null:
return $default();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,) {final _that = this;
switch (_that) {
case _JmaMapShutdownMessage():
return $default();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,) {final _that = this;
switch (_that) {
case _JmaMapShutdownMessage() when $default != null:
return $default();case _:
  return null;

}
}

}

/// @nodoc


class _JmaMapShutdownMessage implements JmaMapShutdownMessage {
  const _JmaMapShutdownMessage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaMapShutdownMessage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JmaMapShutdownMessage()';
}


}




/// @nodoc
mixin _$JmaMapResponseMessage {

 int get id; MapDataItem? get result; String? get errorMessage; String? get errorStack;
/// Create a copy of JmaMapResponseMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JmaMapResponseMessageCopyWith<JmaMapResponseMessage> get copyWith => _$JmaMapResponseMessageCopyWithImpl<JmaMapResponseMessage>(this as JmaMapResponseMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JmaMapResponseMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.result, result) || other.result == result)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorStack, errorStack) || other.errorStack == errorStack));
}


@override
int get hashCode => Object.hash(runtimeType,id,result,errorMessage,errorStack);

@override
String toString() {
  return 'JmaMapResponseMessage(id: $id, result: $result, errorMessage: $errorMessage, errorStack: $errorStack)';
}


}

/// @nodoc
abstract mixin class $JmaMapResponseMessageCopyWith<$Res>  {
  factory $JmaMapResponseMessageCopyWith(JmaMapResponseMessage value, $Res Function(JmaMapResponseMessage) _then) = _$JmaMapResponseMessageCopyWithImpl;
@useResult
$Res call({
 int id, MapDataItem? result, String? errorMessage, String? errorStack
});


$MapDataItemCopyWith<$Res>? get result;

}
/// @nodoc
class _$JmaMapResponseMessageCopyWithImpl<$Res>
    implements $JmaMapResponseMessageCopyWith<$Res> {
  _$JmaMapResponseMessageCopyWithImpl(this._self, this._then);

  final JmaMapResponseMessage _self;
  final $Res Function(JmaMapResponseMessage) _then;

/// Create a copy of JmaMapResponseMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? result = freezed,Object? errorMessage = freezed,Object? errorStack = freezed,}) {
  return _then(JmaMapResponseMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MapDataItem?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorStack: freezed == errorStack ? _self.errorStack : errorStack // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of JmaMapResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataItemCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $MapDataItemCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [JmaMapResponseMessage].
extension JmaMapResponseMessagePatterns on JmaMapResponseMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JmaMapResponseMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JmaMapResponseMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JmaMapResponseMessage value)  $default,){
final _that = this;
switch (_that) {
case _JmaMapResponseMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JmaMapResponseMessage value)?  $default,){
final _that = this;
switch (_that) {
case _JmaMapResponseMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  MapDataItem? result,  String? errorMessage,  String? errorStack)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JmaMapResponseMessage() when $default != null:
return $default(_that.id,_that.result,_that.errorMessage,_that.errorStack);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  MapDataItem? result,  String? errorMessage,  String? errorStack)  $default,) {final _that = this;
switch (_that) {
case _JmaMapResponseMessage():
return $default(_that.id,_that.result,_that.errorMessage,_that.errorStack);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  MapDataItem? result,  String? errorMessage,  String? errorStack)?  $default,) {final _that = this;
switch (_that) {
case _JmaMapResponseMessage() when $default != null:
return $default(_that.id,_that.result,_that.errorMessage,_that.errorStack);case _:
  return null;

}
}

}

/// @nodoc


class _JmaMapResponseMessage implements JmaMapResponseMessage {
  const _JmaMapResponseMessage({required this.id, this.result, this.errorMessage, this.errorStack});
  

@override final  int id;
@override final  MapDataItem? result;
@override final  String? errorMessage;
@override final  String? errorStack;

/// Create a copy of JmaMapResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JmaMapResponseMessageCopyWith<_JmaMapResponseMessage> get copyWith => __$JmaMapResponseMessageCopyWithImpl<_JmaMapResponseMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JmaMapResponseMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.result, result) || other.result == result)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorStack, errorStack) || other.errorStack == errorStack));
}


@override
int get hashCode => Object.hash(runtimeType,id,result,errorMessage,errorStack);

@override
String toString() {
  return 'JmaMapResponseMessage(id: $id, result: $result, errorMessage: $errorMessage, errorStack: $errorStack)';
}


}

/// @nodoc
abstract mixin class _$JmaMapResponseMessageCopyWith<$Res> implements $JmaMapResponseMessageCopyWith<$Res> {
  factory _$JmaMapResponseMessageCopyWith(_JmaMapResponseMessage value, $Res Function(_JmaMapResponseMessage) _then) = __$JmaMapResponseMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, MapDataItem? result, String? errorMessage, String? errorStack
});


@override $MapDataItemCopyWith<$Res>? get result;

}
/// @nodoc
class __$JmaMapResponseMessageCopyWithImpl<$Res>
    implements _$JmaMapResponseMessageCopyWith<$Res> {
  __$JmaMapResponseMessageCopyWithImpl(this._self, this._then);

  final _JmaMapResponseMessage _self;
  final $Res Function(_JmaMapResponseMessage) _then;

/// Create a copy of JmaMapResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? result = freezed,Object? errorMessage = freezed,Object? errorStack = freezed,}) {
  return _then(_JmaMapResponseMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MapDataItem?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorStack: freezed == errorStack ? _self.errorStack : errorStack // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of JmaMapResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MapDataItemCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $MapDataItemCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

// dart format on
