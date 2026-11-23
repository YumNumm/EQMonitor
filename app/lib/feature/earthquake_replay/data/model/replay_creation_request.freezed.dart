// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_creation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayCreationRequest {

 DateTime get startTime; Duration get duration; Set<ReplayCreationImageKind> get imageKinds; bool get includeEew; bool get includePreRoll; String get name; String get directory;
/// Create a copy of ReplayCreationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayCreationRequestCopyWith<ReplayCreationRequest> get copyWith => _$ReplayCreationRequestCopyWithImpl<ReplayCreationRequest>(this as ReplayCreationRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayCreationRequest&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.imageKinds, imageKinds)&&(identical(other.includeEew, includeEew) || other.includeEew == includeEew)&&(identical(other.includePreRoll, includePreRoll) || other.includePreRoll == includePreRoll)&&(identical(other.name, name) || other.name == name)&&(identical(other.directory, directory) || other.directory == directory));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,duration,const DeepCollectionEquality().hash(imageKinds),includeEew,includePreRoll,name,directory);

@override
String toString() {
  return 'ReplayCreationRequest(startTime: $startTime, duration: $duration, imageKinds: $imageKinds, includeEew: $includeEew, includePreRoll: $includePreRoll, name: $name, directory: $directory)';
}


}

/// @nodoc
abstract mixin class $ReplayCreationRequestCopyWith<$Res>  {
  factory $ReplayCreationRequestCopyWith(ReplayCreationRequest value, $Res Function(ReplayCreationRequest) _then) = _$ReplayCreationRequestCopyWithImpl;
@useResult
$Res call({
 DateTime startTime, Duration duration, Set<ReplayCreationImageKind> imageKinds, bool includeEew, bool includePreRoll, String name, String directory
});




}
/// @nodoc
class _$ReplayCreationRequestCopyWithImpl<$Res>
    implements $ReplayCreationRequestCopyWith<$Res> {
  _$ReplayCreationRequestCopyWithImpl(this._self, this._then);

  final ReplayCreationRequest _self;
  final $Res Function(ReplayCreationRequest) _then;

/// Create a copy of ReplayCreationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTime = null,Object? duration = null,Object? imageKinds = null,Object? includeEew = null,Object? includePreRoll = null,Object? name = null,Object? directory = null,}) {
  return _then(ReplayCreationRequest(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,imageKinds: null == imageKinds ? _self.imageKinds : imageKinds // ignore: cast_nullable_to_non_nullable
as Set<ReplayCreationImageKind>,includeEew: null == includeEew ? _self.includeEew : includeEew // ignore: cast_nullable_to_non_nullable
as bool,includePreRoll: null == includePreRoll ? _self.includePreRoll : includePreRoll // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayCreationRequest].
extension ReplayCreationRequestPatterns on ReplayCreationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayCreationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayCreationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayCreationRequest value)  $default,){
final _that = this;
switch (_that) {
case _ReplayCreationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayCreationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayCreationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startTime,  Duration duration,  Set<ReplayCreationImageKind> imageKinds,  bool includeEew,  bool includePreRoll,  String name,  String directory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayCreationRequest() when $default != null:
return $default(_that.startTime,_that.duration,_that.imageKinds,_that.includeEew,_that.includePreRoll,_that.name,_that.directory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startTime,  Duration duration,  Set<ReplayCreationImageKind> imageKinds,  bool includeEew,  bool includePreRoll,  String name,  String directory)  $default,) {final _that = this;
switch (_that) {
case _ReplayCreationRequest():
return $default(_that.startTime,_that.duration,_that.imageKinds,_that.includeEew,_that.includePreRoll,_that.name,_that.directory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startTime,  Duration duration,  Set<ReplayCreationImageKind> imageKinds,  bool includeEew,  bool includePreRoll,  String name,  String directory)?  $default,) {final _that = this;
switch (_that) {
case _ReplayCreationRequest() when $default != null:
return $default(_that.startTime,_that.duration,_that.imageKinds,_that.includeEew,_that.includePreRoll,_that.name,_that.directory);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayCreationRequest extends ReplayCreationRequest {
  const _ReplayCreationRequest({required this.startTime, required this.duration, required  Set<ReplayCreationImageKind> imageKinds, required this.includeEew, required this.includePreRoll, this.name = '', this.directory = ''}): _imageKinds = imageKinds,super._();
  

@override final  DateTime startTime;
@override final  Duration duration;
 final  Set<ReplayCreationImageKind> _imageKinds;
@override Set<ReplayCreationImageKind> get imageKinds {
  if (_imageKinds is EqualUnmodifiableSetView) return _imageKinds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_imageKinds);
}

@override final  bool includeEew;
@override final  bool includePreRoll;
@override@JsonKey() final  String name;
@override@JsonKey() final  String directory;

/// Create a copy of ReplayCreationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayCreationRequestCopyWith<_ReplayCreationRequest> get copyWith => __$ReplayCreationRequestCopyWithImpl<_ReplayCreationRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayCreationRequest&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._imageKinds, _imageKinds)&&(identical(other.includeEew, includeEew) || other.includeEew == includeEew)&&(identical(other.includePreRoll, includePreRoll) || other.includePreRoll == includePreRoll)&&(identical(other.name, name) || other.name == name)&&(identical(other.directory, directory) || other.directory == directory));
}


@override
int get hashCode => Object.hash(runtimeType,startTime,duration,const DeepCollectionEquality().hash(_imageKinds),includeEew,includePreRoll,name,directory);

@override
String toString() {
  return 'ReplayCreationRequest(startTime: $startTime, duration: $duration, imageKinds: $imageKinds, includeEew: $includeEew, includePreRoll: $includePreRoll, name: $name, directory: $directory)';
}


}

/// @nodoc
abstract mixin class _$ReplayCreationRequestCopyWith<$Res> implements $ReplayCreationRequestCopyWith<$Res> {
  factory _$ReplayCreationRequestCopyWith(_ReplayCreationRequest value, $Res Function(_ReplayCreationRequest) _then) = __$ReplayCreationRequestCopyWithImpl;
@override @useResult
$Res call({
 DateTime startTime, Duration duration, Set<ReplayCreationImageKind> imageKinds, bool includeEew, bool includePreRoll, String name, String directory
});




}
/// @nodoc
class __$ReplayCreationRequestCopyWithImpl<$Res>
    implements _$ReplayCreationRequestCopyWith<$Res> {
  __$ReplayCreationRequestCopyWithImpl(this._self, this._then);

  final _ReplayCreationRequest _self;
  final $Res Function(_ReplayCreationRequest) _then;

/// Create a copy of ReplayCreationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? duration = null,Object? imageKinds = null,Object? includeEew = null,Object? includePreRoll = null,Object? name = null,Object? directory = null,}) {
  return _then(_ReplayCreationRequest(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,imageKinds: null == imageKinds ? _self._imageKinds : imageKinds // ignore: cast_nullable_to_non_nullable
as Set<ReplayCreationImageKind>,includeEew: null == includeEew ? _self.includeEew : includeEew // ignore: cast_nullable_to_non_nullable
as bool,includePreRoll: null == includePreRoll ? _self.includePreRoll : includePreRoll // ignore: cast_nullable_to_non_nullable
as bool,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ReplayCreationProgress {

 int get completed; int get total;
/// Create a copy of ReplayCreationProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayCreationProgressCopyWith<ReplayCreationProgress> get copyWith => _$ReplayCreationProgressCopyWithImpl<ReplayCreationProgress>(this as ReplayCreationProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayCreationProgress&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,completed,total);

@override
String toString() {
  return 'ReplayCreationProgress(completed: $completed, total: $total)';
}


}

/// @nodoc
abstract mixin class $ReplayCreationProgressCopyWith<$Res>  {
  factory $ReplayCreationProgressCopyWith(ReplayCreationProgress value, $Res Function(ReplayCreationProgress) _then) = _$ReplayCreationProgressCopyWithImpl;
@useResult
$Res call({
 int completed, int total
});




}
/// @nodoc
class _$ReplayCreationProgressCopyWithImpl<$Res>
    implements $ReplayCreationProgressCopyWith<$Res> {
  _$ReplayCreationProgressCopyWithImpl(this._self, this._then);

  final ReplayCreationProgress _self;
  final $Res Function(ReplayCreationProgress) _then;

/// Create a copy of ReplayCreationProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completed = null,Object? total = null,}) {
  return _then(ReplayCreationProgress(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayCreationProgress].
extension ReplayCreationProgressPatterns on ReplayCreationProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayCreationProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayCreationProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayCreationProgress value)  $default,){
final _that = this;
switch (_that) {
case _ReplayCreationProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayCreationProgress value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayCreationProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int completed,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayCreationProgress() when $default != null:
return $default(_that.completed,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int completed,  int total)  $default,) {final _that = this;
switch (_that) {
case _ReplayCreationProgress():
return $default(_that.completed,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int completed,  int total)?  $default,) {final _that = this;
switch (_that) {
case _ReplayCreationProgress() when $default != null:
return $default(_that.completed,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayCreationProgress implements ReplayCreationProgress {
  const _ReplayCreationProgress({required this.completed, required this.total});
  

@override final  int completed;
@override final  int total;

/// Create a copy of ReplayCreationProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayCreationProgressCopyWith<_ReplayCreationProgress> get copyWith => __$ReplayCreationProgressCopyWithImpl<_ReplayCreationProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayCreationProgress&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,completed,total);

@override
String toString() {
  return 'ReplayCreationProgress(completed: $completed, total: $total)';
}


}

/// @nodoc
abstract mixin class _$ReplayCreationProgressCopyWith<$Res> implements $ReplayCreationProgressCopyWith<$Res> {
  factory _$ReplayCreationProgressCopyWith(_ReplayCreationProgress value, $Res Function(_ReplayCreationProgress) _then) = __$ReplayCreationProgressCopyWithImpl;
@override @useResult
$Res call({
 int completed, int total
});




}
/// @nodoc
class __$ReplayCreationProgressCopyWithImpl<$Res>
    implements _$ReplayCreationProgressCopyWith<$Res> {
  __$ReplayCreationProgressCopyWithImpl(this._self, this._then);

  final _ReplayCreationProgress _self;
  final $Res Function(_ReplayCreationProgress) _then;

/// Create a copy of ReplayCreationProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completed = null,Object? total = null,}) {
  return _then(_ReplayCreationProgress(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
