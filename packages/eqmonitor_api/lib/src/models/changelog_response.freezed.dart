// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangelogResponse {

 List<ChangelogEntry> get entries;
/// Create a copy of ChangelogResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogResponseCopyWith<ChangelogResponse> get copyWith => _$ChangelogResponseCopyWithImpl<ChangelogResponse>(this as ChangelogResponse, _$identity);

  /// Serializes this ChangelogResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogResponse&&const DeepCollectionEquality().equals(other.entries, entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'ChangelogResponse(entries: $entries)';
}


}

/// @nodoc
abstract mixin class $ChangelogResponseCopyWith<$Res>  {
  factory $ChangelogResponseCopyWith(ChangelogResponse value, $Res Function(ChangelogResponse) _then) = _$ChangelogResponseCopyWithImpl;
@useResult
$Res call({
 List<ChangelogEntry> entries
});




}
/// @nodoc
class _$ChangelogResponseCopyWithImpl<$Res>
    implements $ChangelogResponseCopyWith<$Res> {
  _$ChangelogResponseCopyWithImpl(this._self, this._then);

  final ChangelogResponse _self;
  final $Res Function(ChangelogResponse) _then;

/// Create a copy of ChangelogResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,}) {
  return _then(_self.copyWith(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<ChangelogEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogResponse].
extension ChangelogResponsePatterns on ChangelogResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogResponse value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChangelogEntry> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangelogResponse() when $default != null:
return $default(_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChangelogEntry> entries)  $default,) {final _that = this;
switch (_that) {
case _ChangelogResponse():
return $default(_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChangelogEntry> entries)?  $default,) {final _that = this;
switch (_that) {
case _ChangelogResponse() when $default != null:
return $default(_that.entries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangelogResponse implements ChangelogResponse {
  const _ChangelogResponse({required final  List<ChangelogEntry> entries}): _entries = entries;
  factory _ChangelogResponse.fromJson(Map<String, dynamic> json) => _$ChangelogResponseFromJson(json);

 final  List<ChangelogEntry> _entries;
@override List<ChangelogEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of ChangelogResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogResponseCopyWith<_ChangelogResponse> get copyWith => __$ChangelogResponseCopyWithImpl<_ChangelogResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangelogResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogResponse&&const DeepCollectionEquality().equals(other._entries, _entries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'ChangelogResponse(entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$ChangelogResponseCopyWith<$Res> implements $ChangelogResponseCopyWith<$Res> {
  factory _$ChangelogResponseCopyWith(_ChangelogResponse value, $Res Function(_ChangelogResponse) _then) = __$ChangelogResponseCopyWithImpl;
@override @useResult
$Res call({
 List<ChangelogEntry> entries
});




}
/// @nodoc
class __$ChangelogResponseCopyWithImpl<$Res>
    implements _$ChangelogResponseCopyWith<$Res> {
  __$ChangelogResponseCopyWithImpl(this._self, this._then);

  final _ChangelogResponse _self;
  final $Res Function(_ChangelogResponse) _then;

/// Create a copy of ChangelogResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,}) {
  return _then(_ChangelogResponse(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<ChangelogEntry>,
  ));
}


}

// dart format on
