// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'changelog_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChangelogEntryModel {

 String get version; DateTime get date; String get url; List<ChangelogSectionModel> get sections; String? get content;
/// Create a copy of ChangelogEntryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangelogEntryModelCopyWith<ChangelogEntryModel> get copyWith => _$ChangelogEntryModelCopyWithImpl<ChangelogEntryModel>(this as ChangelogEntryModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangelogEntryModel&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,version,date,url,const DeepCollectionEquality().hash(sections),content);

@override
String toString() {
  return 'ChangelogEntryModel(version: $version, date: $date, url: $url, sections: $sections, content: $content)';
}


}

/// @nodoc
abstract mixin class $ChangelogEntryModelCopyWith<$Res>  {
  factory $ChangelogEntryModelCopyWith(ChangelogEntryModel value, $Res Function(ChangelogEntryModel) _then) = _$ChangelogEntryModelCopyWithImpl;
@useResult
$Res call({
 String version, DateTime date, String url, List<ChangelogSectionModel> sections, String? content
});




}
/// @nodoc
class _$ChangelogEntryModelCopyWithImpl<$Res>
    implements $ChangelogEntryModelCopyWith<$Res> {
  _$ChangelogEntryModelCopyWithImpl(this._self, this._then);

  final ChangelogEntryModel _self;
  final $Res Function(ChangelogEntryModel) _then;

/// Create a copy of ChangelogEntryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? date = null,Object? url = null,Object? sections = null,Object? content = freezed,}) {
  return _then(ChangelogEntryModel(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ChangelogSectionModel>,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangelogEntryModel].
extension ChangelogEntryModelPatterns on ChangelogEntryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangelogEntryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangelogEntryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangelogEntryModel value)  $default,){
final _that = this;
switch (_that) {
case _ChangelogEntryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangelogEntryModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChangelogEntryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  DateTime date,  String url,  List<ChangelogSectionModel> sections,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangelogEntryModel() when $default != null:
return $default(_that.version,_that.date,_that.url,_that.sections,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  DateTime date,  String url,  List<ChangelogSectionModel> sections,  String? content)  $default,) {final _that = this;
switch (_that) {
case _ChangelogEntryModel():
return $default(_that.version,_that.date,_that.url,_that.sections,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  DateTime date,  String url,  List<ChangelogSectionModel> sections,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _ChangelogEntryModel() when $default != null:
return $default(_that.version,_that.date,_that.url,_that.sections,_that.content);case _:
  return null;

}
}

}

/// @nodoc


class _ChangelogEntryModel implements ChangelogEntryModel {
  const _ChangelogEntryModel({required this.version, required this.date, required this.url, required  List<ChangelogSectionModel> sections, this.content}): _sections = sections;
  

@override final  String version;
@override final  DateTime date;
@override final  String url;
 final  List<ChangelogSectionModel> _sections;
@override List<ChangelogSectionModel> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  String? content;

/// Create a copy of ChangelogEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangelogEntryModelCopyWith<_ChangelogEntryModel> get copyWith => __$ChangelogEntryModelCopyWithImpl<_ChangelogEntryModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangelogEntryModel&&(identical(other.version, version) || other.version == version)&&(identical(other.date, date) || other.date == date)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,version,date,url,const DeepCollectionEquality().hash(_sections),content);

@override
String toString() {
  return 'ChangelogEntryModel(version: $version, date: $date, url: $url, sections: $sections, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ChangelogEntryModelCopyWith<$Res> implements $ChangelogEntryModelCopyWith<$Res> {
  factory _$ChangelogEntryModelCopyWith(_ChangelogEntryModel value, $Res Function(_ChangelogEntryModel) _then) = __$ChangelogEntryModelCopyWithImpl;
@override @useResult
$Res call({
 String version, DateTime date, String url, List<ChangelogSectionModel> sections, String? content
});




}
/// @nodoc
class __$ChangelogEntryModelCopyWithImpl<$Res>
    implements _$ChangelogEntryModelCopyWith<$Res> {
  __$ChangelogEntryModelCopyWithImpl(this._self, this._then);

  final _ChangelogEntryModel _self;
  final $Res Function(_ChangelogEntryModel) _then;

/// Create a copy of ChangelogEntryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? date = null,Object? url = null,Object? sections = null,Object? content = freezed,}) {
  return _then(_ChangelogEntryModel(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ChangelogSectionModel>,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
