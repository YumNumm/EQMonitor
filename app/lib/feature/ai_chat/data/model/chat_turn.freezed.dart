// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_turn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatTurn {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatTurn()';
}


}

/// @nodoc
class $ChatTurnCopyWith<$Res>  {
$ChatTurnCopyWith(ChatTurn _, $Res Function(ChatTurn) __);
}


/// Adds pattern-matching-related methods to [ChatTurn].
extension ChatTurnPatterns on ChatTurn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatTurnUser value)?  user,TResult Function( ChatTurnAssistantText value)?  assistantText,TResult Function( ChatTurnAssistantSurface value)?  assistantSurface,TResult Function( ChatTurnThinking value)?  thinking,TResult Function( ChatTurnError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatTurnUser() when user != null:
return user(_that);case ChatTurnAssistantText() when assistantText != null:
return assistantText(_that);case ChatTurnAssistantSurface() when assistantSurface != null:
return assistantSurface(_that);case ChatTurnThinking() when thinking != null:
return thinking(_that);case ChatTurnError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatTurnUser value)  user,required TResult Function( ChatTurnAssistantText value)  assistantText,required TResult Function( ChatTurnAssistantSurface value)  assistantSurface,required TResult Function( ChatTurnThinking value)  thinking,required TResult Function( ChatTurnError value)  error,}){
final _that = this;
switch (_that) {
case ChatTurnUser():
return user(_that);case ChatTurnAssistantText():
return assistantText(_that);case ChatTurnAssistantSurface():
return assistantSurface(_that);case ChatTurnThinking():
return thinking(_that);case ChatTurnError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatTurnUser value)?  user,TResult? Function( ChatTurnAssistantText value)?  assistantText,TResult? Function( ChatTurnAssistantSurface value)?  assistantSurface,TResult? Function( ChatTurnThinking value)?  thinking,TResult? Function( ChatTurnError value)?  error,}){
final _that = this;
switch (_that) {
case ChatTurnUser() when user != null:
return user(_that);case ChatTurnAssistantText() when assistantText != null:
return assistantText(_that);case ChatTurnAssistantSurface() when assistantSurface != null:
return assistantSurface(_that);case ChatTurnThinking() when thinking != null:
return thinking(_that);case ChatTurnError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  user,TResult Function( String text)?  assistantText,TResult Function( String surfaceId)?  assistantSurface,TResult Function()?  thinking,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatTurnUser() when user != null:
return user(_that.text);case ChatTurnAssistantText() when assistantText != null:
return assistantText(_that.text);case ChatTurnAssistantSurface() when assistantSurface != null:
return assistantSurface(_that.surfaceId);case ChatTurnThinking() when thinking != null:
return thinking();case ChatTurnError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  user,required TResult Function( String text)  assistantText,required TResult Function( String surfaceId)  assistantSurface,required TResult Function()  thinking,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ChatTurnUser():
return user(_that.text);case ChatTurnAssistantText():
return assistantText(_that.text);case ChatTurnAssistantSurface():
return assistantSurface(_that.surfaceId);case ChatTurnThinking():
return thinking();case ChatTurnError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  user,TResult? Function( String text)?  assistantText,TResult? Function( String surfaceId)?  assistantSurface,TResult? Function()?  thinking,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ChatTurnUser() when user != null:
return user(_that.text);case ChatTurnAssistantText() when assistantText != null:
return assistantText(_that.text);case ChatTurnAssistantSurface() when assistantSurface != null:
return assistantSurface(_that.surfaceId);case ChatTurnThinking() when thinking != null:
return thinking();case ChatTurnError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChatTurnUser implements ChatTurn {
  const ChatTurnUser(this.text);
  

 final  String text;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTurnUserCopyWith<ChatTurnUser> get copyWith => _$ChatTurnUserCopyWithImpl<ChatTurnUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurnUser&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ChatTurn.user(text: $text)';
}


}

/// @nodoc
abstract mixin class $ChatTurnUserCopyWith<$Res> implements $ChatTurnCopyWith<$Res> {
  factory $ChatTurnUserCopyWith(ChatTurnUser value, $Res Function(ChatTurnUser) _then) = _$ChatTurnUserCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$ChatTurnUserCopyWithImpl<$Res>
    implements $ChatTurnUserCopyWith<$Res> {
  _$ChatTurnUserCopyWithImpl(this._self, this._then);

  final ChatTurnUser _self;
  final $Res Function(ChatTurnUser) _then;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(ChatTurnUser(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatTurnAssistantText implements ChatTurn {
  const ChatTurnAssistantText(this.text);
  

 final  String text;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTurnAssistantTextCopyWith<ChatTurnAssistantText> get copyWith => _$ChatTurnAssistantTextCopyWithImpl<ChatTurnAssistantText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurnAssistantText&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ChatTurn.assistantText(text: $text)';
}


}

/// @nodoc
abstract mixin class $ChatTurnAssistantTextCopyWith<$Res> implements $ChatTurnCopyWith<$Res> {
  factory $ChatTurnAssistantTextCopyWith(ChatTurnAssistantText value, $Res Function(ChatTurnAssistantText) _then) = _$ChatTurnAssistantTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$ChatTurnAssistantTextCopyWithImpl<$Res>
    implements $ChatTurnAssistantTextCopyWith<$Res> {
  _$ChatTurnAssistantTextCopyWithImpl(this._self, this._then);

  final ChatTurnAssistantText _self;
  final $Res Function(ChatTurnAssistantText) _then;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(ChatTurnAssistantText(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatTurnAssistantSurface implements ChatTurn {
  const ChatTurnAssistantSurface(this.surfaceId);
  

 final  String surfaceId;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTurnAssistantSurfaceCopyWith<ChatTurnAssistantSurface> get copyWith => _$ChatTurnAssistantSurfaceCopyWithImpl<ChatTurnAssistantSurface>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurnAssistantSurface&&(identical(other.surfaceId, surfaceId) || other.surfaceId == surfaceId));
}


@override
int get hashCode => Object.hash(runtimeType,surfaceId);

@override
String toString() {
  return 'ChatTurn.assistantSurface(surfaceId: $surfaceId)';
}


}

/// @nodoc
abstract mixin class $ChatTurnAssistantSurfaceCopyWith<$Res> implements $ChatTurnCopyWith<$Res> {
  factory $ChatTurnAssistantSurfaceCopyWith(ChatTurnAssistantSurface value, $Res Function(ChatTurnAssistantSurface) _then) = _$ChatTurnAssistantSurfaceCopyWithImpl;
@useResult
$Res call({
 String surfaceId
});




}
/// @nodoc
class _$ChatTurnAssistantSurfaceCopyWithImpl<$Res>
    implements $ChatTurnAssistantSurfaceCopyWith<$Res> {
  _$ChatTurnAssistantSurfaceCopyWithImpl(this._self, this._then);

  final ChatTurnAssistantSurface _self;
  final $Res Function(ChatTurnAssistantSurface) _then;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? surfaceId = null,}) {
  return _then(ChatTurnAssistantSurface(
null == surfaceId ? _self.surfaceId : surfaceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatTurnThinking implements ChatTurn {
  const ChatTurnThinking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurnThinking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatTurn.thinking()';
}


}




/// @nodoc


class ChatTurnError implements ChatTurn {
  const ChatTurnError(this.message);
  

 final  String message;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatTurnErrorCopyWith<ChatTurnError> get copyWith => _$ChatTurnErrorCopyWithImpl<ChatTurnError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTurnError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatTurn.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatTurnErrorCopyWith<$Res> implements $ChatTurnCopyWith<$Res> {
  factory $ChatTurnErrorCopyWith(ChatTurnError value, $Res Function(ChatTurnError) _then) = _$ChatTurnErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatTurnErrorCopyWithImpl<$Res>
    implements $ChatTurnErrorCopyWith<$Res> {
  _$ChatTurnErrorCopyWithImpl(this._self, this._then);

  final ChatTurnError _self;
  final $Res Function(ChatTurnError) _then;

/// Create a copy of ChatTurn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatTurnError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
