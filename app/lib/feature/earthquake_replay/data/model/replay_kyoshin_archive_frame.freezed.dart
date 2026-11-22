// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'replay_kyoshin_archive_frame.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReplayKyoshinArchiveFrame {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayKyoshinArchiveFrame);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReplayKyoshinArchiveFrame()';
}


}

/// @nodoc
class $ReplayKyoshinArchiveFrameCopyWith<$Res>  {
$ReplayKyoshinArchiveFrameCopyWith(ReplayKyoshinArchiveFrame _, $Res Function(ReplayKyoshinArchiveFrame) __);
}


/// Adds pattern-matching-related methods to [ReplayKyoshinArchiveFrame].
extension ReplayKyoshinArchiveFramePatterns on ReplayKyoshinArchiveFrame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReplayKyoshinArchiveFrameAvailable value)?  available,TResult Function( ReplayKyoshinArchiveFrameUnavailable value)?  unavailable,TResult Function( ReplayKyoshinArchiveFramePurged value)?  purged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReplayKyoshinArchiveFrameAvailable() when available != null:
return available(_that);case ReplayKyoshinArchiveFrameUnavailable() when unavailable != null:
return unavailable(_that);case ReplayKyoshinArchiveFramePurged() when purged != null:
return purged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReplayKyoshinArchiveFrameAvailable value)  available,required TResult Function( ReplayKyoshinArchiveFrameUnavailable value)  unavailable,required TResult Function( ReplayKyoshinArchiveFramePurged value)  purged,}){
final _that = this;
switch (_that) {
case ReplayKyoshinArchiveFrameAvailable():
return available(_that);case ReplayKyoshinArchiveFrameUnavailable():
return unavailable(_that);case ReplayKyoshinArchiveFramePurged():
return purged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReplayKyoshinArchiveFrameAvailable value)?  available,TResult? Function( ReplayKyoshinArchiveFrameUnavailable value)?  unavailable,TResult? Function( ReplayKyoshinArchiveFramePurged value)?  purged,}){
final _that = this;
switch (_that) {
case ReplayKyoshinArchiveFrameAvailable() when available != null:
return available(_that);case ReplayKyoshinArchiveFrameUnavailable() when unavailable != null:
return unavailable(_that);case ReplayKyoshinArchiveFramePurged() when purged != null:
return purged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Uint8List image,  Map<DateTime, Uint8List> baselineImages)?  available,TResult Function()?  unavailable,TResult Function()?  purged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReplayKyoshinArchiveFrameAvailable() when available != null:
return available(_that.image,_that.baselineImages);case ReplayKyoshinArchiveFrameUnavailable() when unavailable != null:
return unavailable();case ReplayKyoshinArchiveFramePurged() when purged != null:
return purged();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Uint8List image,  Map<DateTime, Uint8List> baselineImages)  available,required TResult Function()  unavailable,required TResult Function()  purged,}) {final _that = this;
switch (_that) {
case ReplayKyoshinArchiveFrameAvailable():
return available(_that.image,_that.baselineImages);case ReplayKyoshinArchiveFrameUnavailable():
return unavailable();case ReplayKyoshinArchiveFramePurged():
return purged();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Uint8List image,  Map<DateTime, Uint8List> baselineImages)?  available,TResult? Function()?  unavailable,TResult? Function()?  purged,}) {final _that = this;
switch (_that) {
case ReplayKyoshinArchiveFrameAvailable() when available != null:
return available(_that.image,_that.baselineImages);case ReplayKyoshinArchiveFrameUnavailable() when unavailable != null:
return unavailable();case ReplayKyoshinArchiveFramePurged() when purged != null:
return purged();case _:
  return null;

}
}

}

/// @nodoc


class ReplayKyoshinArchiveFrameAvailable implements ReplayKyoshinArchiveFrame {
  const ReplayKyoshinArchiveFrameAvailable({required this.image, required  Map<DateTime, Uint8List> baselineImages}): _baselineImages = baselineImages;
  

 final  Uint8List image;
 final  Map<DateTime, Uint8List> _baselineImages;
 Map<DateTime, Uint8List> get baselineImages {
  if (_baselineImages is EqualUnmodifiableMapView) return _baselineImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_baselineImages);
}


/// Create a copy of ReplayKyoshinArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplayKyoshinArchiveFrameAvailableCopyWith<ReplayKyoshinArchiveFrameAvailable> get copyWith => _$ReplayKyoshinArchiveFrameAvailableCopyWithImpl<ReplayKyoshinArchiveFrameAvailable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayKyoshinArchiveFrameAvailable&&const DeepCollectionEquality().equals(other.image, image)&&const DeepCollectionEquality().equals(other._baselineImages, _baselineImages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(image),const DeepCollectionEquality().hash(_baselineImages));

@override
String toString() {
  return 'ReplayKyoshinArchiveFrame.available(image: $image, baselineImages: $baselineImages)';
}


}

/// @nodoc
abstract mixin class $ReplayKyoshinArchiveFrameAvailableCopyWith<$Res> implements $ReplayKyoshinArchiveFrameCopyWith<$Res> {
  factory $ReplayKyoshinArchiveFrameAvailableCopyWith(ReplayKyoshinArchiveFrameAvailable value, $Res Function(ReplayKyoshinArchiveFrameAvailable) _then) = _$ReplayKyoshinArchiveFrameAvailableCopyWithImpl;
@useResult
$Res call({
 Uint8List image, Map<DateTime, Uint8List> baselineImages
});




}
/// @nodoc
class _$ReplayKyoshinArchiveFrameAvailableCopyWithImpl<$Res>
    implements $ReplayKyoshinArchiveFrameAvailableCopyWith<$Res> {
  _$ReplayKyoshinArchiveFrameAvailableCopyWithImpl(this._self, this._then);

  final ReplayKyoshinArchiveFrameAvailable _self;
  final $Res Function(ReplayKyoshinArchiveFrameAvailable) _then;

/// Create a copy of ReplayKyoshinArchiveFrame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? image = null,Object? baselineImages = null,}) {
  return _then(ReplayKyoshinArchiveFrameAvailable(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as Uint8List,baselineImages: null == baselineImages ? _self._baselineImages : baselineImages // ignore: cast_nullable_to_non_nullable
as Map<DateTime, Uint8List>,
  ));
}


}

/// @nodoc


class ReplayKyoshinArchiveFrameUnavailable implements ReplayKyoshinArchiveFrame {
  const ReplayKyoshinArchiveFrameUnavailable();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayKyoshinArchiveFrameUnavailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReplayKyoshinArchiveFrame.unavailable()';
}


}




/// @nodoc


class ReplayKyoshinArchiveFramePurged implements ReplayKyoshinArchiveFrame {
  const ReplayKyoshinArchiveFramePurged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplayKyoshinArchiveFramePurged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReplayKyoshinArchiveFrame.purged()';
}


}




// dart format on
