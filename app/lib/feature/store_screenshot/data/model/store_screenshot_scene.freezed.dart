// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_screenshot_scene.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
StoreScreenshotScene _$StoreScreenshotSceneFromJson(
  Map<String, dynamic> json
) {
        switch (json['kind']) {
                  case 'replay':
          return StoreScreenshotReplayScene.fromJson(
            json
          );
                case 'route':
          return StoreScreenshotRouteScene.fromJson(
            json
          );
                case 'live_activity':
          return StoreScreenshotLiveActivityScene.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'kind',
  'StoreScreenshotScene',
  'Invalid union type "${json['kind']}"!'
);
        }
      
}

/// @nodoc
mixin _$StoreScreenshotScene {

 String get name; int get settleMilliseconds;
/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreScreenshotSceneCopyWith<StoreScreenshotScene> get copyWith => _$StoreScreenshotSceneCopyWithImpl<StoreScreenshotScene>(this as StoreScreenshotScene, _$identity);

  /// Serializes this StoreScreenshotScene to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreScreenshotScene&&(identical(other.name, name) || other.name == name)&&(identical(other.settleMilliseconds, settleMilliseconds) || other.settleMilliseconds == settleMilliseconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,settleMilliseconds);

@override
String toString() {
  return 'StoreScreenshotScene(name: $name, settleMilliseconds: $settleMilliseconds)';
}


}

/// @nodoc
abstract mixin class $StoreScreenshotSceneCopyWith<$Res>  {
  factory $StoreScreenshotSceneCopyWith(StoreScreenshotScene value, $Res Function(StoreScreenshotScene) _then) = _$StoreScreenshotSceneCopyWithImpl;
@useResult
$Res call({
 String name, int settleMilliseconds
});




}
/// @nodoc
class _$StoreScreenshotSceneCopyWithImpl<$Res>
    implements $StoreScreenshotSceneCopyWith<$Res> {
  _$StoreScreenshotSceneCopyWithImpl(this._self, this._then);

  final StoreScreenshotScene _self;
  final $Res Function(StoreScreenshotScene) _then;

/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? settleMilliseconds = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,settleMilliseconds: null == settleMilliseconds ? _self.settleMilliseconds : settleMilliseconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StoreScreenshotScene].
extension StoreScreenshotScenePatterns on StoreScreenshotScene {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StoreScreenshotReplayScene value)?  replay,TResult Function( StoreScreenshotRouteScene value)?  route,TResult Function( StoreScreenshotLiveActivityScene value)?  liveActivity,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StoreScreenshotReplayScene() when replay != null:
return replay(_that);case StoreScreenshotRouteScene() when route != null:
return route(_that);case StoreScreenshotLiveActivityScene() when liveActivity != null:
return liveActivity(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StoreScreenshotReplayScene value)  replay,required TResult Function( StoreScreenshotRouteScene value)  route,required TResult Function( StoreScreenshotLiveActivityScene value)  liveActivity,}){
final _that = this;
switch (_that) {
case StoreScreenshotReplayScene():
return replay(_that);case StoreScreenshotRouteScene():
return route(_that);case StoreScreenshotLiveActivityScene():
return liveActivity(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StoreScreenshotReplayScene value)?  replay,TResult? Function( StoreScreenshotRouteScene value)?  route,TResult? Function( StoreScreenshotLiveActivityScene value)?  liveActivity,}){
final _that = this;
switch (_that) {
case StoreScreenshotReplayScene() when replay != null:
return replay(_that);case StoreScreenshotRouteScene() when route != null:
return route(_that);case StoreScreenshotLiveActivityScene() when liveActivity != null:
return liveActivity(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  int settleMilliseconds,  String fixture,  DateTime time)?  replay,TResult Function( String name,  int settleMilliseconds,  String location)?  route,TResult Function( String name,  int settleMilliseconds,  DebugEewPreset preset)?  liveActivity,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StoreScreenshotReplayScene() when replay != null:
return replay(_that.name,_that.settleMilliseconds,_that.fixture,_that.time);case StoreScreenshotRouteScene() when route != null:
return route(_that.name,_that.settleMilliseconds,_that.location);case StoreScreenshotLiveActivityScene() when liveActivity != null:
return liveActivity(_that.name,_that.settleMilliseconds,_that.preset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  int settleMilliseconds,  String fixture,  DateTime time)  replay,required TResult Function( String name,  int settleMilliseconds,  String location)  route,required TResult Function( String name,  int settleMilliseconds,  DebugEewPreset preset)  liveActivity,}) {final _that = this;
switch (_that) {
case StoreScreenshotReplayScene():
return replay(_that.name,_that.settleMilliseconds,_that.fixture,_that.time);case StoreScreenshotRouteScene():
return route(_that.name,_that.settleMilliseconds,_that.location);case StoreScreenshotLiveActivityScene():
return liveActivity(_that.name,_that.settleMilliseconds,_that.preset);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  int settleMilliseconds,  String fixture,  DateTime time)?  replay,TResult? Function( String name,  int settleMilliseconds,  String location)?  route,TResult? Function( String name,  int settleMilliseconds,  DebugEewPreset preset)?  liveActivity,}) {final _that = this;
switch (_that) {
case StoreScreenshotReplayScene() when replay != null:
return replay(_that.name,_that.settleMilliseconds,_that.fixture,_that.time);case StoreScreenshotRouteScene() when route != null:
return route(_that.name,_that.settleMilliseconds,_that.location);case StoreScreenshotLiveActivityScene() when liveActivity != null:
return liveActivity(_that.name,_that.settleMilliseconds,_that.preset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class StoreScreenshotReplayScene implements StoreScreenshotScene {
  const StoreScreenshotReplayScene({required this.name, required this.settleMilliseconds, required this.fixture, required this.time,  String? $type}): $type = $type ?? 'replay';
  factory StoreScreenshotReplayScene.fromJson(Map<String, dynamic> json) => _$StoreScreenshotReplaySceneFromJson(json);

@override final  String name;
@override final  int settleMilliseconds;
 final  String fixture;
 final  DateTime time;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreScreenshotReplaySceneCopyWith<StoreScreenshotReplayScene> get copyWith => _$StoreScreenshotReplaySceneCopyWithImpl<StoreScreenshotReplayScene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreScreenshotReplaySceneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreScreenshotReplayScene&&(identical(other.name, name) || other.name == name)&&(identical(other.settleMilliseconds, settleMilliseconds) || other.settleMilliseconds == settleMilliseconds)&&(identical(other.fixture, fixture) || other.fixture == fixture)&&(identical(other.time, time) || other.time == time));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,settleMilliseconds,fixture,time);

@override
String toString() {
  return 'StoreScreenshotScene.replay(name: $name, settleMilliseconds: $settleMilliseconds, fixture: $fixture, time: $time)';
}


}

/// @nodoc
abstract mixin class $StoreScreenshotReplaySceneCopyWith<$Res> implements $StoreScreenshotSceneCopyWith<$Res> {
  factory $StoreScreenshotReplaySceneCopyWith(StoreScreenshotReplayScene value, $Res Function(StoreScreenshotReplayScene) _then) = _$StoreScreenshotReplaySceneCopyWithImpl;
@override @useResult
$Res call({
 String name, int settleMilliseconds, String fixture, DateTime time
});




}
/// @nodoc
class _$StoreScreenshotReplaySceneCopyWithImpl<$Res>
    implements $StoreScreenshotReplaySceneCopyWith<$Res> {
  _$StoreScreenshotReplaySceneCopyWithImpl(this._self, this._then);

  final StoreScreenshotReplayScene _self;
  final $Res Function(StoreScreenshotReplayScene) _then;

/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? settleMilliseconds = null,Object? fixture = null,Object? time = null,}) {
  return _then(StoreScreenshotReplayScene(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,settleMilliseconds: null == settleMilliseconds ? _self.settleMilliseconds : settleMilliseconds // ignore: cast_nullable_to_non_nullable
as int,fixture: null == fixture ? _self.fixture : fixture // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StoreScreenshotRouteScene implements StoreScreenshotScene {
  const StoreScreenshotRouteScene({required this.name, required this.settleMilliseconds, required this.location,  String? $type}): $type = $type ?? 'route';
  factory StoreScreenshotRouteScene.fromJson(Map<String, dynamic> json) => _$StoreScreenshotRouteSceneFromJson(json);

@override final  String name;
@override final  int settleMilliseconds;
 final  String location;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreScreenshotRouteSceneCopyWith<StoreScreenshotRouteScene> get copyWith => _$StoreScreenshotRouteSceneCopyWithImpl<StoreScreenshotRouteScene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreScreenshotRouteSceneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreScreenshotRouteScene&&(identical(other.name, name) || other.name == name)&&(identical(other.settleMilliseconds, settleMilliseconds) || other.settleMilliseconds == settleMilliseconds)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,settleMilliseconds,location);

@override
String toString() {
  return 'StoreScreenshotScene.route(name: $name, settleMilliseconds: $settleMilliseconds, location: $location)';
}


}

/// @nodoc
abstract mixin class $StoreScreenshotRouteSceneCopyWith<$Res> implements $StoreScreenshotSceneCopyWith<$Res> {
  factory $StoreScreenshotRouteSceneCopyWith(StoreScreenshotRouteScene value, $Res Function(StoreScreenshotRouteScene) _then) = _$StoreScreenshotRouteSceneCopyWithImpl;
@override @useResult
$Res call({
 String name, int settleMilliseconds, String location
});




}
/// @nodoc
class _$StoreScreenshotRouteSceneCopyWithImpl<$Res>
    implements $StoreScreenshotRouteSceneCopyWith<$Res> {
  _$StoreScreenshotRouteSceneCopyWithImpl(this._self, this._then);

  final StoreScreenshotRouteScene _self;
  final $Res Function(StoreScreenshotRouteScene) _then;

/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? settleMilliseconds = null,Object? location = null,}) {
  return _then(StoreScreenshotRouteScene(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,settleMilliseconds: null == settleMilliseconds ? _self.settleMilliseconds : settleMilliseconds // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StoreScreenshotLiveActivityScene implements StoreScreenshotScene {
  const StoreScreenshotLiveActivityScene({required this.name, required this.settleMilliseconds, required this.preset,  String? $type}): $type = $type ?? 'live_activity';
  factory StoreScreenshotLiveActivityScene.fromJson(Map<String, dynamic> json) => _$StoreScreenshotLiveActivitySceneFromJson(json);

@override final  String name;
@override final  int settleMilliseconds;
 final  DebugEewPreset preset;

@JsonKey(name: 'kind')
final String $type;


/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoreScreenshotLiveActivitySceneCopyWith<StoreScreenshotLiveActivityScene> get copyWith => _$StoreScreenshotLiveActivitySceneCopyWithImpl<StoreScreenshotLiveActivityScene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoreScreenshotLiveActivitySceneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoreScreenshotLiveActivityScene&&(identical(other.name, name) || other.name == name)&&(identical(other.settleMilliseconds, settleMilliseconds) || other.settleMilliseconds == settleMilliseconds)&&(identical(other.preset, preset) || other.preset == preset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,settleMilliseconds,preset);

@override
String toString() {
  return 'StoreScreenshotScene.liveActivity(name: $name, settleMilliseconds: $settleMilliseconds, preset: $preset)';
}


}

/// @nodoc
abstract mixin class $StoreScreenshotLiveActivitySceneCopyWith<$Res> implements $StoreScreenshotSceneCopyWith<$Res> {
  factory $StoreScreenshotLiveActivitySceneCopyWith(StoreScreenshotLiveActivityScene value, $Res Function(StoreScreenshotLiveActivityScene) _then) = _$StoreScreenshotLiveActivitySceneCopyWithImpl;
@override @useResult
$Res call({
 String name, int settleMilliseconds, DebugEewPreset preset
});




}
/// @nodoc
class _$StoreScreenshotLiveActivitySceneCopyWithImpl<$Res>
    implements $StoreScreenshotLiveActivitySceneCopyWith<$Res> {
  _$StoreScreenshotLiveActivitySceneCopyWithImpl(this._self, this._then);

  final StoreScreenshotLiveActivityScene _self;
  final $Res Function(StoreScreenshotLiveActivityScene) _then;

/// Create a copy of StoreScreenshotScene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? settleMilliseconds = null,Object? preset = null,}) {
  return _then(StoreScreenshotLiveActivityScene(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,settleMilliseconds: null == settleMilliseconds ? _self.settleMilliseconds : settleMilliseconds // ignore: cast_nullable_to_non_nullable
as int,preset: null == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as DebugEewPreset,
  ));
}


}

// dart format on
