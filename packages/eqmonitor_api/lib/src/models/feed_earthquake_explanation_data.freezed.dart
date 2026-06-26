// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_explanation_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeExplanationData {

/// const: "EARTHQUAKE_EXPLANATION"
 String get type; InfoType get infoType; String get text;@JsonKey(includeIfNull: false) FeedNaming? get naming;@JsonKey(includeIfNull: false) FeedComments? get comments;
/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeExplanationDataCopyWith<FeedEarthquakeExplanationData> get copyWith => _$FeedEarthquakeExplanationDataCopyWithImpl<FeedEarthquakeExplanationData>(this as FeedEarthquakeExplanationData, _$identity);

  /// Serializes this FeedEarthquakeExplanationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeExplanationData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.text, text) || other.text == text)&&(identical(other.naming, naming) || other.naming == naming)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,text,naming,comments);

@override
String toString() {
  return 'FeedEarthquakeExplanationData(type: $type, infoType: $infoType, text: $text, naming: $naming, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeExplanationDataCopyWith<$Res>  {
  factory $FeedEarthquakeExplanationDataCopyWith(FeedEarthquakeExplanationData value, $Res Function(FeedEarthquakeExplanationData) _then) = _$FeedEarthquakeExplanationDataCopyWithImpl;
@useResult
$Res call({
 String type, InfoType infoType, String text,@JsonKey(includeIfNull: false) FeedNaming? naming,@JsonKey(includeIfNull: false) FeedComments? comments
});


$FeedNamingCopyWith<$Res>? get naming;$FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedEarthquakeExplanationDataCopyWithImpl<$Res>
    implements $FeedEarthquakeExplanationDataCopyWith<$Res> {
  _$FeedEarthquakeExplanationDataCopyWithImpl(this._self, this._then);

  final FeedEarthquakeExplanationData _self;
  final $Res Function(FeedEarthquakeExplanationData) _then;

/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? infoType = null,Object? text = null,Object? naming = freezed,Object? comments = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,naming: freezed == naming ? _self.naming : naming // ignore: cast_nullable_to_non_nullable
as FeedNaming?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}
/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNamingCopyWith<$Res>? get naming {
    if (_self.naming == null) {
    return null;
  }

  return $FeedNamingCopyWith<$Res>(_self.naming!, (value) {
    return _then(_self.copyWith(naming: value));
  });
}/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $FeedCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedEarthquakeExplanationData].
extension FeedEarthquakeExplanationDataPatterns on FeedEarthquakeExplanationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeExplanationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeExplanationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeExplanationData value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeExplanationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeExplanationData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeExplanationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  InfoType infoType,  String text, @JsonKey(includeIfNull: false)  FeedNaming? naming, @JsonKey(includeIfNull: false)  FeedComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeExplanationData() when $default != null:
return $default(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  InfoType infoType,  String text, @JsonKey(includeIfNull: false)  FeedNaming? naming, @JsonKey(includeIfNull: false)  FeedComments? comments)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeExplanationData():
return $default(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  InfoType infoType,  String text, @JsonKey(includeIfNull: false)  FeedNaming? naming, @JsonKey(includeIfNull: false)  FeedComments? comments)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeExplanationData() when $default != null:
return $default(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeExplanationData implements FeedEarthquakeExplanationData {
  const _FeedEarthquakeExplanationData({required this.type, required this.infoType, required this.text, @JsonKey(includeIfNull: false) this.naming, @JsonKey(includeIfNull: false) this.comments});
  factory _FeedEarthquakeExplanationData.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeExplanationDataFromJson(json);

/// const: "EARTHQUAKE_EXPLANATION"
@override final  String type;
@override final  InfoType infoType;
@override final  String text;
@override@JsonKey(includeIfNull: false) final  FeedNaming? naming;
@override@JsonKey(includeIfNull: false) final  FeedComments? comments;

/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeExplanationDataCopyWith<_FeedEarthquakeExplanationData> get copyWith => __$FeedEarthquakeExplanationDataCopyWithImpl<_FeedEarthquakeExplanationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeExplanationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeExplanationData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.text, text) || other.text == text)&&(identical(other.naming, naming) || other.naming == naming)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,text,naming,comments);

@override
String toString() {
  return 'FeedEarthquakeExplanationData(type: $type, infoType: $infoType, text: $text, naming: $naming, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeExplanationDataCopyWith<$Res> implements $FeedEarthquakeExplanationDataCopyWith<$Res> {
  factory _$FeedEarthquakeExplanationDataCopyWith(_FeedEarthquakeExplanationData value, $Res Function(_FeedEarthquakeExplanationData) _then) = __$FeedEarthquakeExplanationDataCopyWithImpl;
@override @useResult
$Res call({
 String type, InfoType infoType, String text,@JsonKey(includeIfNull: false) FeedNaming? naming,@JsonKey(includeIfNull: false) FeedComments? comments
});


@override $FeedNamingCopyWith<$Res>? get naming;@override $FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$FeedEarthquakeExplanationDataCopyWithImpl<$Res>
    implements _$FeedEarthquakeExplanationDataCopyWith<$Res> {
  __$FeedEarthquakeExplanationDataCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeExplanationData _self;
  final $Res Function(_FeedEarthquakeExplanationData) _then;

/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? infoType = null,Object? text = null,Object? naming = freezed,Object? comments = freezed,}) {
  return _then(_FeedEarthquakeExplanationData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,naming: freezed == naming ? _self.naming : naming // ignore: cast_nullable_to_non_nullable
as FeedNaming?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}

/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNamingCopyWith<$Res>? get naming {
    if (_self.naming == null) {
    return null;
  }

  return $FeedNamingCopyWith<$Res>(_self.naming!, (value) {
    return _then(_self.copyWith(naming: value));
  });
}/// Create a copy of FeedEarthquakeExplanationData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $FeedCommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
