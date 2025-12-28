// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayState {

 ReplayFile get file; String get fileName; int get currentIndex; bool get isPlaying; double get playbackSpeed; bool get showDataOverlay; List<KyoshinMonitorImageParseObservationPoint>? get currentPoints;
/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayStateCopyWith<ReplayState> get copyWith => _$ReplayStateCopyWithImpl<ReplayState>(this as ReplayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayState&&(identical(other.file, file) || other.file == file)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&(identical(other.showDataOverlay, showDataOverlay) || other.showDataOverlay == showDataOverlay)&&const DeepCollectionEquality().equals(other.currentPoints, currentPoints));
}


@override
int get hashCode => Object.hash(runtimeType,file,fileName,currentIndex,isPlaying,playbackSpeed,showDataOverlay,const DeepCollectionEquality().hash(currentPoints));

@override
String toString() {
  return 'ReplayState(file: $file, fileName: $fileName, currentIndex: $currentIndex, isPlaying: $isPlaying, playbackSpeed: $playbackSpeed, showDataOverlay: $showDataOverlay, currentPoints: $currentPoints)';
}


}

/// @nodoc
abstract mixin class $ReplayStateCopyWith<$Res>  {
  factory $ReplayStateCopyWith(ReplayState value, $Res Function(ReplayState) _then) = _$ReplayStateCopyWithImpl;
@useResult
$Res call({
 ReplayFile file, String fileName, int currentIndex, bool isPlaying, double playbackSpeed, bool showDataOverlay, List<KyoshinMonitorImageParseObservationPoint>? currentPoints
});




}
/// @nodoc
class _$ReplayStateCopyWithImpl<$Res>
    implements $ReplayStateCopyWith<$Res> {
  _$ReplayStateCopyWithImpl(this._self, this._then);

  final ReplayState _self;
  final $Res Function(ReplayState) _then;

/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? file = null,Object? fileName = null,Object? currentIndex = null,Object? isPlaying = null,Object? playbackSpeed = null,Object? showDataOverlay = null,Object? currentPoints = freezed,}) {
  return _then(_self.copyWith(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as ReplayFile,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,showDataOverlay: null == showDataOverlay ? _self.showDataOverlay : showDataOverlay // ignore: cast_nullable_to_non_nullable
as bool,currentPoints: freezed == currentPoints ? _self.currentPoints : currentPoints // ignore: cast_nullable_to_non_nullable
as List<KyoshinMonitorImageParseObservationPoint>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplayState].
extension ReplayStatePatterns on ReplayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplayState value)  $default,){
final _that = this;
switch (_that) {
case _ReplayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplayState value)?  $default,){
final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReplayFile file,  String fileName,  int currentIndex,  bool isPlaying,  double playbackSpeed,  bool showDataOverlay,  List<KyoshinMonitorImageParseObservationPoint>? currentPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
return $default(_that.file,_that.fileName,_that.currentIndex,_that.isPlaying,_that.playbackSpeed,_that.showDataOverlay,_that.currentPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReplayFile file,  String fileName,  int currentIndex,  bool isPlaying,  double playbackSpeed,  bool showDataOverlay,  List<KyoshinMonitorImageParseObservationPoint>? currentPoints)  $default,) {final _that = this;
switch (_that) {
case _ReplayState():
return $default(_that.file,_that.fileName,_that.currentIndex,_that.isPlaying,_that.playbackSpeed,_that.showDataOverlay,_that.currentPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReplayFile file,  String fileName,  int currentIndex,  bool isPlaying,  double playbackSpeed,  bool showDataOverlay,  List<KyoshinMonitorImageParseObservationPoint>? currentPoints)?  $default,) {final _that = this;
switch (_that) {
case _ReplayState() when $default != null:
return $default(_that.file,_that.fileName,_that.currentIndex,_that.isPlaying,_that.playbackSpeed,_that.showDataOverlay,_that.currentPoints);case _:
  return null;

}
}

}

/// @nodoc


class _ReplayState extends ReplayState {
  const _ReplayState({required this.file, required this.fileName, required this.currentIndex, required this.isPlaying, required this.playbackSpeed, this.showDataOverlay = false, final  List<KyoshinMonitorImageParseObservationPoint>? currentPoints}): _currentPoints = currentPoints,super._();
  

@override final  ReplayFile file;
@override final  String fileName;
@override final  int currentIndex;
@override final  bool isPlaying;
@override final  double playbackSpeed;
@override@JsonKey() final  bool showDataOverlay;
 final  List<KyoshinMonitorImageParseObservationPoint>? _currentPoints;
@override List<KyoshinMonitorImageParseObservationPoint>? get currentPoints {
  final value = _currentPoints;
  if (value == null) return null;
  if (_currentPoints is EqualUnmodifiableListView) return _currentPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplayStateCopyWith<_ReplayState> get copyWith => __$ReplayStateCopyWithImpl<_ReplayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplayState&&(identical(other.file, file) || other.file == file)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.playbackSpeed, playbackSpeed) || other.playbackSpeed == playbackSpeed)&&(identical(other.showDataOverlay, showDataOverlay) || other.showDataOverlay == showDataOverlay)&&const DeepCollectionEquality().equals(other._currentPoints, _currentPoints));
}


@override
int get hashCode => Object.hash(runtimeType,file,fileName,currentIndex,isPlaying,playbackSpeed,showDataOverlay,const DeepCollectionEquality().hash(_currentPoints));

@override
String toString() {
  return 'ReplayState(file: $file, fileName: $fileName, currentIndex: $currentIndex, isPlaying: $isPlaying, playbackSpeed: $playbackSpeed, showDataOverlay: $showDataOverlay, currentPoints: $currentPoints)';
}


}

/// @nodoc
abstract mixin class _$ReplayStateCopyWith<$Res> implements $ReplayStateCopyWith<$Res> {
  factory _$ReplayStateCopyWith(_ReplayState value, $Res Function(_ReplayState) _then) = __$ReplayStateCopyWithImpl;
@override @useResult
$Res call({
 ReplayFile file, String fileName, int currentIndex, bool isPlaying, double playbackSpeed, bool showDataOverlay, List<KyoshinMonitorImageParseObservationPoint>? currentPoints
});




}
/// @nodoc
class __$ReplayStateCopyWithImpl<$Res>
    implements _$ReplayStateCopyWith<$Res> {
  __$ReplayStateCopyWithImpl(this._self, this._then);

  final _ReplayState _self;
  final $Res Function(_ReplayState) _then;

/// Create a copy of ReplayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? file = null,Object? fileName = null,Object? currentIndex = null,Object? isPlaying = null,Object? playbackSpeed = null,Object? showDataOverlay = null,Object? currentPoints = freezed,}) {
  return _then(_ReplayState(
file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as ReplayFile,fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,playbackSpeed: null == playbackSpeed ? _self.playbackSpeed : playbackSpeed // ignore: cast_nullable_to_non_nullable
as double,showDataOverlay: null == showDataOverlay ? _self.showDataOverlay : showDataOverlay // ignore: cast_nullable_to_non_nullable
as bool,currentPoints: freezed == currentPoints ? _self._currentPoints : currentPoints // ignore: cast_nullable_to_non_nullable
as List<KyoshinMonitorImageParseObservationPoint>?,
  ));
}


}

// dart format on
