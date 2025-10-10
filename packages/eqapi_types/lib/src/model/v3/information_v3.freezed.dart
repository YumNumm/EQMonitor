// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InformationV3Result {

 List<InformationV3> get items;
/// Create a copy of InformationV3Result
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InformationV3ResultCopyWith<InformationV3Result> get copyWith => _$InformationV3ResultCopyWithImpl<InformationV3Result>(this as InformationV3Result, _$identity);

  /// Serializes this InformationV3Result to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InformationV3Result&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'InformationV3Result(items: $items)';
}


}

/// @nodoc
abstract mixin class $InformationV3ResultCopyWith<$Res>  {
  factory $InformationV3ResultCopyWith(InformationV3Result value, $Res Function(InformationV3Result) _then) = _$InformationV3ResultCopyWithImpl;
@useResult
$Res call({
 List<InformationV3> items
});




}
/// @nodoc
class _$InformationV3ResultCopyWithImpl<$Res>
    implements $InformationV3ResultCopyWith<$Res> {
  _$InformationV3ResultCopyWithImpl(this._self, this._then);

  final InformationV3Result _self;
  final $Res Function(InformationV3Result) _then;

/// Create a copy of InformationV3Result
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<InformationV3>,
  ));
}

}


/// Adds pattern-matching-related methods to [InformationV3Result].
extension InformationV3ResultPatterns on InformationV3Result {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InformationV3Result value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InformationV3Result() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InformationV3Result value)  $default,){
final _that = this;
switch (_that) {
case _InformationV3Result():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InformationV3Result value)?  $default,){
final _that = this;
switch (_that) {
case _InformationV3Result() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InformationV3> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InformationV3Result() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InformationV3> items)  $default,) {final _that = this;
switch (_that) {
case _InformationV3Result():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InformationV3> items)?  $default,) {final _that = this;
switch (_that) {
case _InformationV3Result() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InformationV3Result implements InformationV3Result {
  const _InformationV3Result({required final  List<InformationV3> items}): _items = items;
  factory _InformationV3Result.fromJson(Map<String, dynamic> json) => _$InformationV3ResultFromJson(json);

 final  List<InformationV3> _items;
@override List<InformationV3> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of InformationV3Result
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InformationV3ResultCopyWith<_InformationV3Result> get copyWith => __$InformationV3ResultCopyWithImpl<_InformationV3Result>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InformationV3ResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InformationV3Result&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'InformationV3Result(items: $items)';
}


}

/// @nodoc
abstract mixin class _$InformationV3ResultCopyWith<$Res> implements $InformationV3ResultCopyWith<$Res> {
  factory _$InformationV3ResultCopyWith(_InformationV3Result value, $Res Function(_InformationV3Result) _then) = __$InformationV3ResultCopyWithImpl;
@override @useResult
$Res call({
 List<InformationV3> items
});




}
/// @nodoc
class __$InformationV3ResultCopyWithImpl<$Res>
    implements _$InformationV3ResultCopyWith<$Res> {
  __$InformationV3ResultCopyWithImpl(this._self, this._then);

  final _InformationV3Result _self;
  final $Res Function(_InformationV3Result) _then;

/// Create a copy of InformationV3Result
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_InformationV3Result(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InformationV3>,
  ));
}


}


/// @nodoc
mixin _$InformationV3 {

 int get id; String get title; String get body;@JsonKey(unknownEnumValue: Author.unknown) Author get author;@JsonKey(name: 'createdAt') DateTime get createdAt;@JsonKey(unknownEnumValue: Level.info) Level get level; int? get eventId;
/// Create a copy of InformationV3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InformationV3CopyWith<InformationV3> get copyWith => _$InformationV3CopyWithImpl<InformationV3>(this as InformationV3, _$identity);

  /// Serializes this InformationV3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InformationV3&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,author,createdAt,level,eventId);

@override
String toString() {
  return 'InformationV3(id: $id, title: $title, body: $body, author: $author, createdAt: $createdAt, level: $level, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $InformationV3CopyWith<$Res>  {
  factory $InformationV3CopyWith(InformationV3 value, $Res Function(InformationV3) _then) = _$InformationV3CopyWithImpl;
@useResult
$Res call({
 int id, String title, String body,@JsonKey(unknownEnumValue: Author.unknown) Author author,@JsonKey(name: 'createdAt') DateTime createdAt,@JsonKey(unknownEnumValue: Level.info) Level level, int? eventId
});




}
/// @nodoc
class _$InformationV3CopyWithImpl<$Res>
    implements $InformationV3CopyWith<$Res> {
  _$InformationV3CopyWithImpl(this._self, this._then);

  final InformationV3 _self;
  final $Res Function(InformationV3) _then;

/// Create a copy of InformationV3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? author = null,Object? createdAt = null,Object? level = null,Object? eventId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [InformationV3].
extension InformationV3Patterns on InformationV3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InformationV3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InformationV3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InformationV3 value)  $default,){
final _that = this;
switch (_that) {
case _InformationV3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InformationV3 value)?  $default,){
final _that = this;
switch (_that) {
case _InformationV3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String body, @JsonKey(unknownEnumValue: Author.unknown)  Author author, @JsonKey(name: 'createdAt')  DateTime createdAt, @JsonKey(unknownEnumValue: Level.info)  Level level,  int? eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InformationV3() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.author,_that.createdAt,_that.level,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String body, @JsonKey(unknownEnumValue: Author.unknown)  Author author, @JsonKey(name: 'createdAt')  DateTime createdAt, @JsonKey(unknownEnumValue: Level.info)  Level level,  int? eventId)  $default,) {final _that = this;
switch (_that) {
case _InformationV3():
return $default(_that.id,_that.title,_that.body,_that.author,_that.createdAt,_that.level,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String body, @JsonKey(unknownEnumValue: Author.unknown)  Author author, @JsonKey(name: 'createdAt')  DateTime createdAt, @JsonKey(unknownEnumValue: Level.info)  Level level,  int? eventId)?  $default,) {final _that = this;
switch (_that) {
case _InformationV3() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.author,_that.createdAt,_that.level,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InformationV3 implements InformationV3 {
  const _InformationV3({required this.id, required this.title, required this.body, @JsonKey(unknownEnumValue: Author.unknown) required this.author, @JsonKey(name: 'createdAt') required this.createdAt, @JsonKey(unknownEnumValue: Level.info) required this.level, required this.eventId});
  factory _InformationV3.fromJson(Map<String, dynamic> json) => _$InformationV3FromJson(json);

@override final  int id;
@override final  String title;
@override final  String body;
@override@JsonKey(unknownEnumValue: Author.unknown) final  Author author;
@override@JsonKey(name: 'createdAt') final  DateTime createdAt;
@override@JsonKey(unknownEnumValue: Level.info) final  Level level;
@override final  int? eventId;

/// Create a copy of InformationV3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InformationV3CopyWith<_InformationV3> get copyWith => __$InformationV3CopyWithImpl<_InformationV3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InformationV3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InformationV3&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.level, level) || other.level == level)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,author,createdAt,level,eventId);

@override
String toString() {
  return 'InformationV3(id: $id, title: $title, body: $body, author: $author, createdAt: $createdAt, level: $level, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$InformationV3CopyWith<$Res> implements $InformationV3CopyWith<$Res> {
  factory _$InformationV3CopyWith(_InformationV3 value, $Res Function(_InformationV3) _then) = __$InformationV3CopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String body,@JsonKey(unknownEnumValue: Author.unknown) Author author,@JsonKey(name: 'createdAt') DateTime createdAt,@JsonKey(unknownEnumValue: Level.info) Level level, int? eventId
});




}
/// @nodoc
class __$InformationV3CopyWithImpl<$Res>
    implements _$InformationV3CopyWith<$Res> {
  __$InformationV3CopyWithImpl(this._self, this._then);

  final _InformationV3 _self;
  final $Res Function(_InformationV3) _then;

/// Create a copy of InformationV3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? author = null,Object? createdAt = null,Object? level = null,Object? eventId = freezed,}) {
  return _then(_InformationV3(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as Level,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
