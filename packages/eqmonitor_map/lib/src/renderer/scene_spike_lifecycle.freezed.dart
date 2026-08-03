// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene_spike_lifecycle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SceneSpikeLifecycleState {

 SceneSpikeLifecyclePhase get phase; int get appResourceGeneration; bool get mayTick; bool get mayUpload; bool get requiresResourceRebuild;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeLifecycleState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.appResourceGeneration, appResourceGeneration) || other.appResourceGeneration == appResourceGeneration)&&(identical(other.mayTick, mayTick) || other.mayTick == mayTick)&&(identical(other.mayUpload, mayUpload) || other.mayUpload == mayUpload)&&(identical(other.requiresResourceRebuild, requiresResourceRebuild) || other.requiresResourceRebuild == requiresResourceRebuild));
}


@override
int get hashCode => Object.hash(runtimeType,phase,appResourceGeneration,mayTick,mayUpload,requiresResourceRebuild);

@override
String toString() {
  return 'SceneSpikeLifecycleState(phase: $phase, appResourceGeneration: $appResourceGeneration, mayTick: $mayTick, mayUpload: $mayUpload, requiresResourceRebuild: $requiresResourceRebuild)';
}


}




/// Adds pattern-matching-related methods to [SceneSpikeLifecycleState].
extension SceneSpikeLifecycleStatePatterns on SceneSpikeLifecycleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SceneSpikeLifecycleState value)?  internal,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneSpikeLifecycleState() when internal != null:
return internal(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SceneSpikeLifecycleState value)  internal,}){
final _that = this;
switch (_that) {
case _SceneSpikeLifecycleState():
return internal(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SceneSpikeLifecycleState value)?  internal,}){
final _that = this;
switch (_that) {
case _SceneSpikeLifecycleState() when internal != null:
return internal(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SceneSpikeLifecyclePhase phase,  int appResourceGeneration,  bool mayTick,  bool mayUpload,  bool requiresResourceRebuild)?  internal,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneSpikeLifecycleState() when internal != null:
return internal(_that.phase,_that.appResourceGeneration,_that.mayTick,_that.mayUpload,_that.requiresResourceRebuild);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SceneSpikeLifecyclePhase phase,  int appResourceGeneration,  bool mayTick,  bool mayUpload,  bool requiresResourceRebuild)  internal,}) {final _that = this;
switch (_that) {
case _SceneSpikeLifecycleState():
return internal(_that.phase,_that.appResourceGeneration,_that.mayTick,_that.mayUpload,_that.requiresResourceRebuild);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SceneSpikeLifecyclePhase phase,  int appResourceGeneration,  bool mayTick,  bool mayUpload,  bool requiresResourceRebuild)?  internal,}) {final _that = this;
switch (_that) {
case _SceneSpikeLifecycleState() when internal != null:
return internal(_that.phase,_that.appResourceGeneration,_that.mayTick,_that.mayUpload,_that.requiresResourceRebuild);case _:
  return null;

}
}

}

/// @nodoc


class _SceneSpikeLifecycleState implements SceneSpikeLifecycleState {
  const _SceneSpikeLifecycleState({required this.phase, required this.appResourceGeneration, required this.mayTick, required this.mayUpload, required this.requiresResourceRebuild});
  

@override final  SceneSpikeLifecyclePhase phase;
@override final  int appResourceGeneration;
@override final  bool mayTick;
@override final  bool mayUpload;
@override final  bool requiresResourceRebuild;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneSpikeLifecycleState&&(identical(other.phase, phase) || other.phase == phase)&&(identical(other.appResourceGeneration, appResourceGeneration) || other.appResourceGeneration == appResourceGeneration)&&(identical(other.mayTick, mayTick) || other.mayTick == mayTick)&&(identical(other.mayUpload, mayUpload) || other.mayUpload == mayUpload)&&(identical(other.requiresResourceRebuild, requiresResourceRebuild) || other.requiresResourceRebuild == requiresResourceRebuild));
}


@override
int get hashCode => Object.hash(runtimeType,phase,appResourceGeneration,mayTick,mayUpload,requiresResourceRebuild);

@override
String toString() {
  return 'SceneSpikeLifecycleState.internal(phase: $phase, appResourceGeneration: $appResourceGeneration, mayTick: $mayTick, mayUpload: $mayUpload, requiresResourceRebuild: $requiresResourceRebuild)';
}


}




/// @nodoc
mixin _$SceneSpikeLifecycleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneSpikeLifecycleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent()';
}


}




/// Adds pattern-matching-related methods to [SceneSpikeLifecycleEvent].
extension SceneSpikeLifecycleEventPatterns on SceneSpikeLifecycleEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Attached value)?  attached,TResult Function( _Backgrounded value)?  backgrounded,TResult Function( _Foregrounded value)?  foregrounded,TResult Function( _SurfaceRecreated value)?  surfaceRecreated,TResult Function( _RebuildCompleted value)?  rebuildCompleted,TResult Function( _Detached value)?  detached,TResult Function( _Disposed value)?  disposed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Attached() when attached != null:
return attached(_that);case _Backgrounded() when backgrounded != null:
return backgrounded(_that);case _Foregrounded() when foregrounded != null:
return foregrounded(_that);case _SurfaceRecreated() when surfaceRecreated != null:
return surfaceRecreated(_that);case _RebuildCompleted() when rebuildCompleted != null:
return rebuildCompleted(_that);case _Detached() when detached != null:
return detached(_that);case _Disposed() when disposed != null:
return disposed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Attached value)  attached,required TResult Function( _Backgrounded value)  backgrounded,required TResult Function( _Foregrounded value)  foregrounded,required TResult Function( _SurfaceRecreated value)  surfaceRecreated,required TResult Function( _RebuildCompleted value)  rebuildCompleted,required TResult Function( _Detached value)  detached,required TResult Function( _Disposed value)  disposed,}){
final _that = this;
switch (_that) {
case _Attached():
return attached(_that);case _Backgrounded():
return backgrounded(_that);case _Foregrounded():
return foregrounded(_that);case _SurfaceRecreated():
return surfaceRecreated(_that);case _RebuildCompleted():
return rebuildCompleted(_that);case _Detached():
return detached(_that);case _Disposed():
return disposed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Attached value)?  attached,TResult? Function( _Backgrounded value)?  backgrounded,TResult? Function( _Foregrounded value)?  foregrounded,TResult? Function( _SurfaceRecreated value)?  surfaceRecreated,TResult? Function( _RebuildCompleted value)?  rebuildCompleted,TResult? Function( _Detached value)?  detached,TResult? Function( _Disposed value)?  disposed,}){
final _that = this;
switch (_that) {
case _Attached() when attached != null:
return attached(_that);case _Backgrounded() when backgrounded != null:
return backgrounded(_that);case _Foregrounded() when foregrounded != null:
return foregrounded(_that);case _SurfaceRecreated() when surfaceRecreated != null:
return surfaceRecreated(_that);case _RebuildCompleted() when rebuildCompleted != null:
return rebuildCompleted(_that);case _Detached() when detached != null:
return detached(_that);case _Disposed() when disposed != null:
return disposed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  attached,TResult Function()?  backgrounded,TResult Function()?  foregrounded,TResult Function()?  surfaceRecreated,TResult Function()?  rebuildCompleted,TResult Function()?  detached,TResult Function()?  disposed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Attached() when attached != null:
return attached();case _Backgrounded() when backgrounded != null:
return backgrounded();case _Foregrounded() when foregrounded != null:
return foregrounded();case _SurfaceRecreated() when surfaceRecreated != null:
return surfaceRecreated();case _RebuildCompleted() when rebuildCompleted != null:
return rebuildCompleted();case _Detached() when detached != null:
return detached();case _Disposed() when disposed != null:
return disposed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  attached,required TResult Function()  backgrounded,required TResult Function()  foregrounded,required TResult Function()  surfaceRecreated,required TResult Function()  rebuildCompleted,required TResult Function()  detached,required TResult Function()  disposed,}) {final _that = this;
switch (_that) {
case _Attached():
return attached();case _Backgrounded():
return backgrounded();case _Foregrounded():
return foregrounded();case _SurfaceRecreated():
return surfaceRecreated();case _RebuildCompleted():
return rebuildCompleted();case _Detached():
return detached();case _Disposed():
return disposed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  attached,TResult? Function()?  backgrounded,TResult? Function()?  foregrounded,TResult? Function()?  surfaceRecreated,TResult? Function()?  rebuildCompleted,TResult? Function()?  detached,TResult? Function()?  disposed,}) {final _that = this;
switch (_that) {
case _Attached() when attached != null:
return attached();case _Backgrounded() when backgrounded != null:
return backgrounded();case _Foregrounded() when foregrounded != null:
return foregrounded();case _SurfaceRecreated() when surfaceRecreated != null:
return surfaceRecreated();case _RebuildCompleted() when rebuildCompleted != null:
return rebuildCompleted();case _Detached() when detached != null:
return detached();case _Disposed() when disposed != null:
return disposed();case _:
  return null;

}
}

}

/// @nodoc


class _Attached implements SceneSpikeLifecycleEvent {
  const _Attached();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Attached);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.attached()';
}


}




/// @nodoc


class _Backgrounded implements SceneSpikeLifecycleEvent {
  const _Backgrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Backgrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.backgrounded()';
}


}




/// @nodoc


class _Foregrounded implements SceneSpikeLifecycleEvent {
  const _Foregrounded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Foregrounded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.foregrounded()';
}


}




/// @nodoc


class _SurfaceRecreated implements SceneSpikeLifecycleEvent {
  const _SurfaceRecreated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurfaceRecreated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.surfaceRecreated()';
}


}




/// @nodoc


class _RebuildCompleted implements SceneSpikeLifecycleEvent {
  const _RebuildCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RebuildCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.rebuildCompleted()';
}


}




/// @nodoc


class _Detached implements SceneSpikeLifecycleEvent {
  const _Detached();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Detached);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.detached()';
}


}




/// @nodoc


class _Disposed implements SceneSpikeLifecycleEvent {
  const _Disposed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Disposed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SceneSpikeLifecycleEvent.disposed()';
}


}




// dart format on
