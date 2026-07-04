// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seismicity_dataset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeismicityDataset {

 List<SeismicityEvent> get events; DateTime get generatedAt;/// 取得失敗によりローカルキャッシュへフォールバックした場合 true
 bool get isFromCache;
/// Create a copy of SeismicityDataset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeismicityDatasetCopyWith<SeismicityDataset> get copyWith => _$SeismicityDatasetCopyWithImpl<SeismicityDataset>(this as SeismicityDataset, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeismicityDataset&&const DeepCollectionEquality().equals(other.events, events)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.isFromCache, isFromCache) || other.isFromCache == isFromCache));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(events),generatedAt,isFromCache);

@override
String toString() {
  return 'SeismicityDataset(events: $events, generatedAt: $generatedAt, isFromCache: $isFromCache)';
}


}

/// @nodoc
abstract mixin class $SeismicityDatasetCopyWith<$Res>  {
  factory $SeismicityDatasetCopyWith(SeismicityDataset value, $Res Function(SeismicityDataset) _then) = _$SeismicityDatasetCopyWithImpl;
@useResult
$Res call({
 List<SeismicityEvent> events, DateTime generatedAt, bool isFromCache
});




}
/// @nodoc
class _$SeismicityDatasetCopyWithImpl<$Res>
    implements $SeismicityDatasetCopyWith<$Res> {
  _$SeismicityDatasetCopyWithImpl(this._self, this._then);

  final SeismicityDataset _self;
  final $Res Function(SeismicityDataset) _then;

/// Create a copy of SeismicityDataset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,Object? generatedAt = null,Object? isFromCache = null,}) {
  return _then(_self.copyWith(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<SeismicityEvent>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isFromCache: null == isFromCache ? _self.isFromCache : isFromCache // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SeismicityDataset].
extension SeismicityDatasetPatterns on SeismicityDataset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeismicityDataset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeismicityDataset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeismicityDataset value)  $default,){
final _that = this;
switch (_that) {
case _SeismicityDataset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeismicityDataset value)?  $default,){
final _that = this;
switch (_that) {
case _SeismicityDataset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SeismicityEvent> events,  DateTime generatedAt,  bool isFromCache)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeismicityDataset() when $default != null:
return $default(_that.events,_that.generatedAt,_that.isFromCache);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SeismicityEvent> events,  DateTime generatedAt,  bool isFromCache)  $default,) {final _that = this;
switch (_that) {
case _SeismicityDataset():
return $default(_that.events,_that.generatedAt,_that.isFromCache);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SeismicityEvent> events,  DateTime generatedAt,  bool isFromCache)?  $default,) {final _that = this;
switch (_that) {
case _SeismicityDataset() when $default != null:
return $default(_that.events,_that.generatedAt,_that.isFromCache);case _:
  return null;

}
}

}

/// @nodoc


class _SeismicityDataset implements SeismicityDataset {
  const _SeismicityDataset({required final  List<SeismicityEvent> events, required this.generatedAt, required this.isFromCache}): _events = events;
  

 final  List<SeismicityEvent> _events;
@override List<SeismicityEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  DateTime generatedAt;
/// 取得失敗によりローカルキャッシュへフォールバックした場合 true
@override final  bool isFromCache;

/// Create a copy of SeismicityDataset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeismicityDatasetCopyWith<_SeismicityDataset> get copyWith => __$SeismicityDatasetCopyWithImpl<_SeismicityDataset>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeismicityDataset&&const DeepCollectionEquality().equals(other._events, _events)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.isFromCache, isFromCache) || other.isFromCache == isFromCache));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),generatedAt,isFromCache);

@override
String toString() {
  return 'SeismicityDataset(events: $events, generatedAt: $generatedAt, isFromCache: $isFromCache)';
}


}

/// @nodoc
abstract mixin class _$SeismicityDatasetCopyWith<$Res> implements $SeismicityDatasetCopyWith<$Res> {
  factory _$SeismicityDatasetCopyWith(_SeismicityDataset value, $Res Function(_SeismicityDataset) _then) = __$SeismicityDatasetCopyWithImpl;
@override @useResult
$Res call({
 List<SeismicityEvent> events, DateTime generatedAt, bool isFromCache
});




}
/// @nodoc
class __$SeismicityDatasetCopyWithImpl<$Res>
    implements _$SeismicityDatasetCopyWith<$Res> {
  __$SeismicityDatasetCopyWithImpl(this._self, this._then);

  final _SeismicityDataset _self;
  final $Res Function(_SeismicityDataset) _then;

/// Create a copy of SeismicityDataset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,Object? generatedAt = null,Object? isFromCache = null,}) {
  return _then(_SeismicityDataset(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<SeismicityEvent>,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isFromCache: null == isFromCache ? _self.isFromCache : isFromCache // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
