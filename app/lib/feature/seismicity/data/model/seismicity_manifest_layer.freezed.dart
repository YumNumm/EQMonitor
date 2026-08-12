// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_manifest_layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeismicityManifestLayer {

 String get type; SeismicitySpan get span; String get url;@JsonKey(name: 'generated_at') DateTime get generatedAt; int get count;
/// Create a copy of SeismicityManifestLayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityManifestLayerCopyWith<SeismicityManifestLayer> get copyWith => _$SeismicityManifestLayerCopyWithImpl<SeismicityManifestLayer>(this as SeismicityManifestLayer, _$identity);

  /// Serializes this SeismicityManifestLayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityManifestLayer&&(identical(other.type, type) || other.type == type)&&(identical(other.span, span) || other.span == span)&&(identical(other.url, url) || other.url == url)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,span,url,generatedAt,count);

@override
String toString() {
  return 'SeismicityManifestLayer(type: $type, span: $span, url: $url, generatedAt: $generatedAt, count: $count)';
}


}

/// @nodoc
abstract mixin class $SeismicityManifestLayerCopyWith<$Res>  {
  factory $SeismicityManifestLayerCopyWith(SeismicityManifestLayer value, $Res Function(SeismicityManifestLayer) _then) = _$SeismicityManifestLayerCopyWithImpl;
@useResult
$Res call({
 String type, SeismicitySpan span, String url,@JsonKey(name: 'generated_at') DateTime generatedAt, int count
});




}
/// @nodoc
class _$SeismicityManifestLayerCopyWithImpl<$Res>
    implements $SeismicityManifestLayerCopyWith<$Res> {
  _$SeismicityManifestLayerCopyWithImpl(this._self, this._then);

  final SeismicityManifestLayer _self;
  final $Res Function(SeismicityManifestLayer) _then;

/// Create a copy of SeismicityManifestLayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? span = null,Object? url = null,Object? generatedAt = null,Object? count = null,}) {
  return _then(SeismicityManifestLayer(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as SeismicitySpan,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityManifestLayer].
extension SeismicityManifestLayerPatterns on SeismicityManifestLayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityManifestLayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityManifestLayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityManifestLayer value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityManifestLayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityManifestLayer value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityManifestLayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  SeismicitySpan span,  String url, @JsonKey(name: 'generated_at')  DateTime generatedAt,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityManifestLayer() when $default != null:
return $default(_that.type,_that.span,_that.url,_that.generatedAt,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  SeismicitySpan span,  String url, @JsonKey(name: 'generated_at')  DateTime generatedAt,  int count)  $default,) {final _that = this;
switch (_that) {
case _SeismicityManifestLayer():
return $default(_that.type,_that.span,_that.url,_that.generatedAt,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  SeismicitySpan span,  String url, @JsonKey(name: 'generated_at')  DateTime generatedAt,  int count)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityManifestLayer() when $default != null:
return $default(_that.type,_that.span,_that.url,_that.generatedAt,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeismicityManifestLayer implements SeismicityManifestLayer {
  const _SeismicityManifestLayer({required this.type, required this.span, required this.url, @JsonKey(name: 'generated_at') required this.generatedAt, required this.count});
  factory _SeismicityManifestLayer.fromJson(Map<String, dynamic> json) => _$SeismicityManifestLayerFromJson(json);

@override final  String type;
@override final  SeismicitySpan span;
@override final  String url;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;
@override final  int count;

/// Create a copy of SeismicityManifestLayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityManifestLayerCopyWith<_SeismicityManifestLayer> get copyWith => __$SeismicityManifestLayerCopyWithImpl<_SeismicityManifestLayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeismicityManifestLayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityManifestLayer&&(identical(other.type, type) || other.type == type)&&(identical(other.span, span) || other.span == span)&&(identical(other.url, url) || other.url == url)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,span,url,generatedAt,count);

@override
String toString() {
  return 'SeismicityManifestLayer(type: $type, span: $span, url: $url, generatedAt: $generatedAt, count: $count)';
}


}

/// @nodoc
abstract mixin class _$SeismicityManifestLayerCopyWith<$Res> implements $SeismicityManifestLayerCopyWith<$Res> {
  factory _$SeismicityManifestLayerCopyWith(_SeismicityManifestLayer value, $Res Function(_SeismicityManifestLayer) _then) = __$SeismicityManifestLayerCopyWithImpl;
@override @useResult
$Res call({
 String type, SeismicitySpan span, String url,@JsonKey(name: 'generated_at') DateTime generatedAt, int count
});




}
/// @nodoc
class __$SeismicityManifestLayerCopyWithImpl<$Res>
    implements _$SeismicityManifestLayerCopyWith<$Res> {
  __$SeismicityManifestLayerCopyWithImpl(this._self, this._then);

  final _SeismicityManifestLayer _self;
  final $Res Function(_SeismicityManifestLayer) _then;

/// Create a copy of SeismicityManifestLayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? span = null,Object? url = null,Object? generatedAt = null,Object? count = null,}) {
  return _then(_SeismicityManifestLayer(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,span: null == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as SeismicitySpan,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
