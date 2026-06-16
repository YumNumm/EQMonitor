// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangelogEntry {

 String get version; DateTime get date; String get url; List<ChangelogSection> get sections;
/// Create a copy of ChangelogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogEntryCopyWith<ChangelogEntry> get copyWith => _$ChangelogEntryCopyWithImpl<ChangelogEntry>(this as ChangelogEntry, _$identity);

  /// Serializes this ChangelogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogEntry&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.sections, sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,date,url,const DeepCollectionEquality().hash(sections));

@override
String toString() {
  return 'ChangelogEntry(version: $version, date: $date, url: $url, sections: $sections)';
}


}

/// @nodoc
abstract mixin class $ChangelogEntryCopyWith<$Res>  {
  factory $ChangelogEntryCopyWith(ChangelogEntry value, $Res Function(ChangelogEntry) _then) = _$ChangelogEntryCopyWithImpl;
@useResult
$Res call({
 String version, DateTime date, String url, List<ChangelogSection> sections
});




}
/// @nodoc
class _$ChangelogEntryCopyWithImpl<$Res>
    implements $ChangelogEntryCopyWith<$Res> {
  _$ChangelogEntryCopyWithImpl(this._self, this._then);

  final ChangelogEntry _self;
  final $Res Function(ChangelogEntry) _then;

/// Create a copy of ChangelogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? date = null,Object? url = null,Object? sections = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ChangelogSection>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogEntry].
extension ChangelogEntryPatterns on ChangelogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogEntry value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  DateTime date,  String url,  List<ChangelogSection> sections)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangelogEntry() when $default != null:
return $default(_that.version,_that.date,_that.url,_that.sections);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  DateTime date,  String url,  List<ChangelogSection> sections)  $default,) {final _that = this;
switch (_that) {
case _ChangelogEntry():
return $default(_that.version,_that.date,_that.url,_that.sections);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  DateTime date,  String url,  List<ChangelogSection> sections)?  $default,) {final _that = this;
switch (_that) {
case _ChangelogEntry() when $default != null:
return $default(_that.version,_that.date,_that.url,_that.sections);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangelogEntry implements ChangelogEntry {
  const _ChangelogEntry({required this.version, required this.date, required this.url, required final  List<ChangelogSection> sections}): _sections = sections;
  factory _ChangelogEntry.fromJson(Map<String, dynamic> json) => _$ChangelogEntryFromJson(json);

@override final  String version;
@override final  DateTime date;
@override final  String url;
 final  List<ChangelogSection> _sections;
@override List<ChangelogSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}


/// Create a copy of ChangelogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogEntryCopyWith<_ChangelogEntry> get copyWith => __$ChangelogEntryCopyWithImpl<_ChangelogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangelogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogEntry&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._sections, _sections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,date,url,const DeepCollectionEquality().hash(_sections));

@override
String toString() {
  return 'ChangelogEntry(version: $version, date: $date, url: $url, sections: $sections)';
}


}

/// @nodoc
abstract mixin class _$ChangelogEntryCopyWith<$Res> implements $ChangelogEntryCopyWith<$Res> {
  factory _$ChangelogEntryCopyWith(_ChangelogEntry value, $Res Function(_ChangelogEntry) _then) = __$ChangelogEntryCopyWithImpl;
@override @useResult
$Res call({
 String version, DateTime date, String url, List<ChangelogSection> sections
});




}
/// @nodoc
class __$ChangelogEntryCopyWithImpl<$Res>
    implements _$ChangelogEntryCopyWith<$Res> {
  __$ChangelogEntryCopyWithImpl(this._self, this._then);

  final _ChangelogEntry _self;
  final $Res Function(_ChangelogEntry) _then;

/// Create a copy of ChangelogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? date = null,Object? url = null,Object? sections = null,}) {
  return _then(_ChangelogEntry(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ChangelogSection>,
  ));
}


}

// dart format on
