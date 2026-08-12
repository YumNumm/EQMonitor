// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_pmtiles_load_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityPmTilesLoadState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesLoadState()';
}


}

/// @nodoc
class $SeismicityPmTilesLoadStateCopyWith<$Res>  {
$SeismicityPmTilesLoadStateCopyWith(SeismicityPmTilesLoadState _, $Res Function(SeismicityPmTilesLoadState) __);
}


/// Adds pattern-matching-related methods to [SeismicityPmTilesLoadState].
extension SeismicityPmTilesLoadStatePatterns on SeismicityPmTilesLoadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SeismicityPmTilesLoadIdle value)?  idle,TResult Function( SeismicityPmTilesLoadOpeningSource value)?  openingSource,TResult Function( SeismicityPmTilesLoadReadingDirectory value)?  readingDirectory,TResult Function( SeismicityPmTilesLoadCompleted value)?  completed,TResult Function( SeismicityPmTilesLoadFailed value)?  failed,TResult Function( SeismicityPmTilesLoadCancelled value)?  cancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SeismicityPmTilesLoadIdle() when idle != null:
return idle(_that);case SeismicityPmTilesLoadOpeningSource() when openingSource != null:
return openingSource(_that);case SeismicityPmTilesLoadReadingDirectory() when readingDirectory != null:
return readingDirectory(_that);case SeismicityPmTilesLoadCompleted() when completed != null:
return completed(_that);case SeismicityPmTilesLoadFailed() when failed != null:
return failed(_that);case SeismicityPmTilesLoadCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SeismicityPmTilesLoadIdle value)  idle,required TResult Function( SeismicityPmTilesLoadOpeningSource value)  openingSource,required TResult Function( SeismicityPmTilesLoadReadingDirectory value)  readingDirectory,required TResult Function( SeismicityPmTilesLoadCompleted value)  completed,required TResult Function( SeismicityPmTilesLoadFailed value)  failed,required TResult Function( SeismicityPmTilesLoadCancelled value)  cancelled,}){
final _that = this;
switch (_that) {
case SeismicityPmTilesLoadIdle():
return idle(_that);case SeismicityPmTilesLoadOpeningSource():
return openingSource(_that);case SeismicityPmTilesLoadReadingDirectory():
return readingDirectory(_that);case SeismicityPmTilesLoadCompleted():
return completed(_that);case SeismicityPmTilesLoadFailed():
return failed(_that);case SeismicityPmTilesLoadCancelled():
return cancelled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SeismicityPmTilesLoadIdle value)?  idle,TResult? Function( SeismicityPmTilesLoadOpeningSource value)?  openingSource,TResult? Function( SeismicityPmTilesLoadReadingDirectory value)?  readingDirectory,TResult? Function( SeismicityPmTilesLoadCompleted value)?  completed,TResult? Function( SeismicityPmTilesLoadFailed value)?  failed,TResult? Function( SeismicityPmTilesLoadCancelled value)?  cancelled,}){
final _that = this;
switch (_that) {
case SeismicityPmTilesLoadIdle() when idle != null:
return idle(_that);case SeismicityPmTilesLoadOpeningSource() when openingSource != null:
return openingSource(_that);case SeismicityPmTilesLoadReadingDirectory() when readingDirectory != null:
return readingDirectory(_that);case SeismicityPmTilesLoadCompleted() when completed != null:
return completed(_that);case SeismicityPmTilesLoadFailed() when failed != null:
return failed(_that);case SeismicityPmTilesLoadCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  openingSource,TResult Function()?  readingDirectory,TResult Function()?  completed,TResult Function( SeismicityPmTilesException exception)?  failed,TResult Function()?  cancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SeismicityPmTilesLoadIdle() when idle != null:
return idle();case SeismicityPmTilesLoadOpeningSource() when openingSource != null:
return openingSource();case SeismicityPmTilesLoadReadingDirectory() when readingDirectory != null:
return readingDirectory();case SeismicityPmTilesLoadCompleted() when completed != null:
return completed();case SeismicityPmTilesLoadFailed() when failed != null:
return failed(_that.exception);case SeismicityPmTilesLoadCancelled() when cancelled != null:
return cancelled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  openingSource,required TResult Function()  readingDirectory,required TResult Function()  completed,required TResult Function( SeismicityPmTilesException exception)  failed,required TResult Function()  cancelled,}) {final _that = this;
switch (_that) {
case SeismicityPmTilesLoadIdle():
return idle();case SeismicityPmTilesLoadOpeningSource():
return openingSource();case SeismicityPmTilesLoadReadingDirectory():
return readingDirectory();case SeismicityPmTilesLoadCompleted():
return completed();case SeismicityPmTilesLoadFailed():
return failed(_that.exception);case SeismicityPmTilesLoadCancelled():
return cancelled();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  openingSource,TResult? Function()?  readingDirectory,TResult? Function()?  completed,TResult? Function( SeismicityPmTilesException exception)?  failed,TResult? Function()?  cancelled,}) {final _that = this;
switch (_that) {
case SeismicityPmTilesLoadIdle() when idle != null:
return idle();case SeismicityPmTilesLoadOpeningSource() when openingSource != null:
return openingSource();case SeismicityPmTilesLoadReadingDirectory() when readingDirectory != null:
return readingDirectory();case SeismicityPmTilesLoadCompleted() when completed != null:
return completed();case SeismicityPmTilesLoadFailed() when failed != null:
return failed(_that.exception);case SeismicityPmTilesLoadCancelled() when cancelled != null:
return cancelled();case _:
  return null;

}
}

}

/// @nodoc


class SeismicityPmTilesLoadIdle implements SeismicityPmTilesLoadState {
  const SeismicityPmTilesLoadIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesLoadState.idle()';
}


}




/// @nodoc


class SeismicityPmTilesLoadOpeningSource implements SeismicityPmTilesLoadState {
  const SeismicityPmTilesLoadOpeningSource();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadOpeningSource);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesLoadState.openingSource()';
}


}




/// @nodoc


class SeismicityPmTilesLoadReadingDirectory implements SeismicityPmTilesLoadState {
  const SeismicityPmTilesLoadReadingDirectory();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadReadingDirectory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesLoadState.readingDirectory()';
}


}




/// @nodoc


class SeismicityPmTilesLoadCompleted implements SeismicityPmTilesLoadState {
  const SeismicityPmTilesLoadCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesLoadState.completed()';
}


}




/// @nodoc


class SeismicityPmTilesLoadFailed implements SeismicityPmTilesLoadState {
  const SeismicityPmTilesLoadFailed({required this.exception});
  

 final  SeismicityPmTilesException exception;

/// Create a copy of SeismicityPmTilesLoadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityPmTilesLoadFailedCopyWith<SeismicityPmTilesLoadFailed> get copyWith => _$SeismicityPmTilesLoadFailedCopyWithImpl<SeismicityPmTilesLoadFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadFailed&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'SeismicityPmTilesLoadState.failed(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $SeismicityPmTilesLoadFailedCopyWith<$Res> implements $SeismicityPmTilesLoadStateCopyWith<$Res> {
  factory $SeismicityPmTilesLoadFailedCopyWith(SeismicityPmTilesLoadFailed value, $Res Function(SeismicityPmTilesLoadFailed) _then) = _$SeismicityPmTilesLoadFailedCopyWithImpl;
@useResult
$Res call({
 SeismicityPmTilesException exception
});


$SeismicityPmTilesExceptionCopyWith<$Res> get exception;

}
/// @nodoc
class _$SeismicityPmTilesLoadFailedCopyWithImpl<$Res>
    implements $SeismicityPmTilesLoadFailedCopyWith<$Res> {
  _$SeismicityPmTilesLoadFailedCopyWithImpl(this._self, this._then);

  final SeismicityPmTilesLoadFailed _self;
  final $Res Function(SeismicityPmTilesLoadFailed) _then;

/// Create a copy of SeismicityPmTilesLoadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(SeismicityPmTilesLoadFailed(
exception: null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as SeismicityPmTilesException,
  ));
}

/// Create a copy of SeismicityPmTilesLoadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeismicityPmTilesExceptionCopyWith<$Res> get exception {
  
  return $SeismicityPmTilesExceptionCopyWith<$Res>(_self.exception, (value) {
    return _then(_self.copyWith(exception: value));
  });
}
}

/// @nodoc


class SeismicityPmTilesLoadCancelled implements SeismicityPmTilesLoadState {
  const SeismicityPmTilesLoadCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityPmTilesLoadCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SeismicityPmTilesLoadState.cancelled()';
}


}




// dart format on
