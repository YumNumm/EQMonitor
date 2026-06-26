// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_earthquake_counts_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedEarthquakeCountsData {

/// const: "EARTHQUAKE_COUNTS"
 String get type; InfoType get infoType;@JsonKey(includeIfNull: false) List<FeedEarthquakeCount>? get earthquakeCounts;@JsonKey(includeIfNull: false) String? get nextAdvisory;@JsonKey(includeIfNull: false) String? get text;@JsonKey(includeIfNull: false) FeedComments? get comments;
/// Create a copy of FeedEarthquakeCountsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEarthquakeCountsDataCopyWith<FeedEarthquakeCountsData> get copyWith => _$FeedEarthquakeCountsDataCopyWithImpl<FeedEarthquakeCountsData>(this as FeedEarthquakeCountsData, _$identity);

  /// Serializes this FeedEarthquakeCountsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEarthquakeCountsData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&const DeepCollectionEquality().equals(other.earthquakeCounts, earthquakeCounts)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,const DeepCollectionEquality().hash(earthquakeCounts),nextAdvisory,text,comments);

@override
String toString() {
  return 'FeedEarthquakeCountsData(type: $type, infoType: $infoType, earthquakeCounts: $earthquakeCounts, nextAdvisory: $nextAdvisory, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedEarthquakeCountsDataCopyWith<$Res>  {
  factory $FeedEarthquakeCountsDataCopyWith(FeedEarthquakeCountsData value, $Res Function(FeedEarthquakeCountsData) _then) = _$FeedEarthquakeCountsDataCopyWithImpl;
@useResult
$Res call({
 String type, InfoType infoType,@JsonKey(includeIfNull: false) List<FeedEarthquakeCount>? earthquakeCounts,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) FeedComments? comments
});


$FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedEarthquakeCountsDataCopyWithImpl<$Res>
    implements $FeedEarthquakeCountsDataCopyWith<$Res> {
  _$FeedEarthquakeCountsDataCopyWithImpl(this._self, this._then);

  final FeedEarthquakeCountsData _self;
  final $Res Function(FeedEarthquakeCountsData) _then;

/// Create a copy of FeedEarthquakeCountsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? infoType = null,Object? earthquakeCounts = freezed,Object? nextAdvisory = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,earthquakeCounts: freezed == earthquakeCounts ? _self.earthquakeCounts : earthquakeCounts // ignore: cast_nullable_to_non_nullable
as List<FeedEarthquakeCount>?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}
/// Create a copy of FeedEarthquakeCountsData
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


/// Adds pattern-matching-related methods to [FeedEarthquakeCountsData].
extension FeedEarthquakeCountsDataPatterns on FeedEarthquakeCountsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEarthquakeCountsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEarthquakeCountsData value)  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEarthquakeCountsData value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEarthquakeCountsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  InfoType infoType, @JsonKey(includeIfNull: false)  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  FeedComments? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountsData() when $default != null:
return $default(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  InfoType infoType, @JsonKey(includeIfNull: false)  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  FeedComments? comments)  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountsData():
return $default(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  InfoType infoType, @JsonKey(includeIfNull: false)  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  FeedComments? comments)?  $default,) {final _that = this;
switch (_that) {
case _FeedEarthquakeCountsData() when $default != null:
return $default(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedEarthquakeCountsData implements FeedEarthquakeCountsData {
  const _FeedEarthquakeCountsData({required this.type, required this.infoType, @JsonKey(includeIfNull: false) final  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false) this.nextAdvisory, @JsonKey(includeIfNull: false) this.text, @JsonKey(includeIfNull: false) this.comments}): _earthquakeCounts = earthquakeCounts;
  factory _FeedEarthquakeCountsData.fromJson(Map<String, dynamic> json) => _$FeedEarthquakeCountsDataFromJson(json);

/// const: "EARTHQUAKE_COUNTS"
@override final  String type;
@override final  InfoType infoType;
 final  List<FeedEarthquakeCount>? _earthquakeCounts;
@override@JsonKey(includeIfNull: false) List<FeedEarthquakeCount>? get earthquakeCounts {
  final value = _earthquakeCounts;
  if (value == null) return null;
  if (_earthquakeCounts is EqualUnmodifiableListView) return _earthquakeCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false) final  String? nextAdvisory;
@override@JsonKey(includeIfNull: false) final  String? text;
@override@JsonKey(includeIfNull: false) final  FeedComments? comments;

/// Create a copy of FeedEarthquakeCountsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEarthquakeCountsDataCopyWith<_FeedEarthquakeCountsData> get copyWith => __$FeedEarthquakeCountsDataCopyWithImpl<_FeedEarthquakeCountsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedEarthquakeCountsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEarthquakeCountsData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&const DeepCollectionEquality().equals(other._earthquakeCounts, _earthquakeCounts)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,const DeepCollectionEquality().hash(_earthquakeCounts),nextAdvisory,text,comments);

@override
String toString() {
  return 'FeedEarthquakeCountsData(type: $type, infoType: $infoType, earthquakeCounts: $earthquakeCounts, nextAdvisory: $nextAdvisory, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$FeedEarthquakeCountsDataCopyWith<$Res> implements $FeedEarthquakeCountsDataCopyWith<$Res> {
  factory _$FeedEarthquakeCountsDataCopyWith(_FeedEarthquakeCountsData value, $Res Function(_FeedEarthquakeCountsData) _then) = __$FeedEarthquakeCountsDataCopyWithImpl;
@override @useResult
$Res call({
 String type, InfoType infoType,@JsonKey(includeIfNull: false) List<FeedEarthquakeCount>? earthquakeCounts,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) FeedComments? comments
});


@override $FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class __$FeedEarthquakeCountsDataCopyWithImpl<$Res>
    implements _$FeedEarthquakeCountsDataCopyWith<$Res> {
  __$FeedEarthquakeCountsDataCopyWithImpl(this._self, this._then);

  final _FeedEarthquakeCountsData _self;
  final $Res Function(_FeedEarthquakeCountsData) _then;

/// Create a copy of FeedEarthquakeCountsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? infoType = null,Object? earthquakeCounts = freezed,Object? nextAdvisory = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(_FeedEarthquakeCountsData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,earthquakeCounts: freezed == earthquakeCounts ? _self._earthquakeCounts : earthquakeCounts // ignore: cast_nullable_to_non_nullable
as List<FeedEarthquakeCount>?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}

/// Create a copy of FeedEarthquakeCountsData
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
