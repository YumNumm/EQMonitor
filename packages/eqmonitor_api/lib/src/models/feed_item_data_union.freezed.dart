// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_item_data_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
FeedItemDataUnion _$FeedItemDataUnionFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'feedEarthquakeNoticeData':
          return FeedItemDataUnionFeedEarthquakeNoticeData.fromJson(
            json
          );
                case 'feedEarthquakeExplanationData':
          return FeedItemDataUnionFeedEarthquakeExplanationData.fromJson(
            json
          );
                case 'feedEarthquakeCountsData':
          return FeedItemDataUnionFeedEarthquakeCountsData.fromJson(
            json
          );
                case 'feedEarthquakeNankaiData':
          return FeedItemDataUnionFeedEarthquakeNankaiData.fromJson(
            json
          );
                case 'feedAppUpdateData':
          return FeedItemDataUnionFeedAppUpdateData.fromJson(
            json
          );
                case 'feedIncidentData':
          return FeedItemDataUnionFeedIncidentData.fromJson(
            json
          );
                case 'feedDeveloperMessageData':
          return FeedItemDataUnionFeedDeveloperMessageData.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'FeedItemDataUnion',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$FeedItemDataUnion {

/// const: "EARTHQUAKE_NOTICE"
 String get type;
/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionCopyWith<FeedItemDataUnion> get copyWith => _$FeedItemDataUnionCopyWithImpl<FeedItemDataUnion>(this as FeedItemDataUnion, _$identity);

  /// Serializes this FeedItemDataUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnion&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'FeedItemDataUnion(type: $type)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionCopyWith<$Res>  {
  factory $FeedItemDataUnionCopyWith(FeedItemDataUnion value, $Res Function(FeedItemDataUnion) _then) = _$FeedItemDataUnionCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$FeedItemDataUnionCopyWithImpl<$Res>
    implements $FeedItemDataUnionCopyWith<$Res> {
  _$FeedItemDataUnionCopyWithImpl(this._self, this._then);

  final FeedItemDataUnion _self;
  final $Res Function(FeedItemDataUnion) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedItemDataUnion].
extension FeedItemDataUnionPatterns on FeedItemDataUnion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedItemDataUnionFeedEarthquakeNoticeData value)?  feedEarthquakeNoticeData,TResult Function( FeedItemDataUnionFeedEarthquakeExplanationData value)?  feedEarthquakeExplanationData,TResult Function( FeedItemDataUnionFeedEarthquakeCountsData value)?  feedEarthquakeCountsData,TResult Function( FeedItemDataUnionFeedEarthquakeNankaiData value)?  feedEarthquakeNankaiData,TResult Function( FeedItemDataUnionFeedAppUpdateData value)?  feedAppUpdateData,TResult Function( FeedItemDataUnionFeedIncidentData value)?  feedIncidentData,TResult Function( FeedItemDataUnionFeedDeveloperMessageData value)?  feedDeveloperMessageData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedItemDataUnionFeedEarthquakeNoticeData() when feedEarthquakeNoticeData != null:
return feedEarthquakeNoticeData(_that);case FeedItemDataUnionFeedEarthquakeExplanationData() when feedEarthquakeExplanationData != null:
return feedEarthquakeExplanationData(_that);case FeedItemDataUnionFeedEarthquakeCountsData() when feedEarthquakeCountsData != null:
return feedEarthquakeCountsData(_that);case FeedItemDataUnionFeedEarthquakeNankaiData() when feedEarthquakeNankaiData != null:
return feedEarthquakeNankaiData(_that);case FeedItemDataUnionFeedAppUpdateData() when feedAppUpdateData != null:
return feedAppUpdateData(_that);case FeedItemDataUnionFeedIncidentData() when feedIncidentData != null:
return feedIncidentData(_that);case FeedItemDataUnionFeedDeveloperMessageData() when feedDeveloperMessageData != null:
return feedDeveloperMessageData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedItemDataUnionFeedEarthquakeNoticeData value)  feedEarthquakeNoticeData,required TResult Function( FeedItemDataUnionFeedEarthquakeExplanationData value)  feedEarthquakeExplanationData,required TResult Function( FeedItemDataUnionFeedEarthquakeCountsData value)  feedEarthquakeCountsData,required TResult Function( FeedItemDataUnionFeedEarthquakeNankaiData value)  feedEarthquakeNankaiData,required TResult Function( FeedItemDataUnionFeedAppUpdateData value)  feedAppUpdateData,required TResult Function( FeedItemDataUnionFeedIncidentData value)  feedIncidentData,required TResult Function( FeedItemDataUnionFeedDeveloperMessageData value)  feedDeveloperMessageData,}){
final _that = this;
switch (_that) {
case FeedItemDataUnionFeedEarthquakeNoticeData():
return feedEarthquakeNoticeData(_that);case FeedItemDataUnionFeedEarthquakeExplanationData():
return feedEarthquakeExplanationData(_that);case FeedItemDataUnionFeedEarthquakeCountsData():
return feedEarthquakeCountsData(_that);case FeedItemDataUnionFeedEarthquakeNankaiData():
return feedEarthquakeNankaiData(_that);case FeedItemDataUnionFeedAppUpdateData():
return feedAppUpdateData(_that);case FeedItemDataUnionFeedIncidentData():
return feedIncidentData(_that);case FeedItemDataUnionFeedDeveloperMessageData():
return feedDeveloperMessageData(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedItemDataUnionFeedEarthquakeNoticeData value)?  feedEarthquakeNoticeData,TResult? Function( FeedItemDataUnionFeedEarthquakeExplanationData value)?  feedEarthquakeExplanationData,TResult? Function( FeedItemDataUnionFeedEarthquakeCountsData value)?  feedEarthquakeCountsData,TResult? Function( FeedItemDataUnionFeedEarthquakeNankaiData value)?  feedEarthquakeNankaiData,TResult? Function( FeedItemDataUnionFeedAppUpdateData value)?  feedAppUpdateData,TResult? Function( FeedItemDataUnionFeedIncidentData value)?  feedIncidentData,TResult? Function( FeedItemDataUnionFeedDeveloperMessageData value)?  feedDeveloperMessageData,}){
final _that = this;
switch (_that) {
case FeedItemDataUnionFeedEarthquakeNoticeData() when feedEarthquakeNoticeData != null:
return feedEarthquakeNoticeData(_that);case FeedItemDataUnionFeedEarthquakeExplanationData() when feedEarthquakeExplanationData != null:
return feedEarthquakeExplanationData(_that);case FeedItemDataUnionFeedEarthquakeCountsData() when feedEarthquakeCountsData != null:
return feedEarthquakeCountsData(_that);case FeedItemDataUnionFeedEarthquakeNankaiData() when feedEarthquakeNankaiData != null:
return feedEarthquakeNankaiData(_that);case FeedItemDataUnionFeedAppUpdateData() when feedAppUpdateData != null:
return feedAppUpdateData(_that);case FeedItemDataUnionFeedIncidentData() when feedIncidentData != null:
return feedIncidentData(_that);case FeedItemDataUnionFeedDeveloperMessageData() when feedDeveloperMessageData != null:
return feedDeveloperMessageData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String type,  String text)?  feedEarthquakeNoticeData,TResult Function( String type,  InfoType infoType,  String text, @JsonKey(includeIfNull: false)  FeedNaming? naming, @JsonKey(includeIfNull: false)  FeedComments? comments)?  feedEarthquakeExplanationData,TResult Function( String type,  InfoType infoType, @JsonKey(includeIfNull: false)  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  FeedComments? comments)?  feedEarthquakeCountsData,TResult Function( String type,  InfoType infoType,  String telegramType, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)?  feedEarthquakeNankaiData,TResult Function( String type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)?  feedAppUpdateData,TResult Function( String type, @JsonKey(includeIfNull: false)  String? url)?  feedIncidentData,TResult Function( String type, @JsonKey(includeIfNull: false)  String? url)?  feedDeveloperMessageData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedItemDataUnionFeedEarthquakeNoticeData() when feedEarthquakeNoticeData != null:
return feedEarthquakeNoticeData(_that.type,_that.text);case FeedItemDataUnionFeedEarthquakeExplanationData() when feedEarthquakeExplanationData != null:
return feedEarthquakeExplanationData(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataUnionFeedEarthquakeCountsData() when feedEarthquakeCountsData != null:
return feedEarthquakeCountsData(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataUnionFeedEarthquakeNankaiData() when feedEarthquakeNankaiData != null:
return feedEarthquakeNankaiData(_that.type,_that.infoType,_that.telegramType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataUnionFeedAppUpdateData() when feedAppUpdateData != null:
return feedAppUpdateData(_that.type,_that.version,_that.url);case FeedItemDataUnionFeedIncidentData() when feedIncidentData != null:
return feedIncidentData(_that.type,_that.url);case FeedItemDataUnionFeedDeveloperMessageData() when feedDeveloperMessageData != null:
return feedDeveloperMessageData(_that.type,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String type,  String text)  feedEarthquakeNoticeData,required TResult Function( String type,  InfoType infoType,  String text, @JsonKey(includeIfNull: false)  FeedNaming? naming, @JsonKey(includeIfNull: false)  FeedComments? comments)  feedEarthquakeExplanationData,required TResult Function( String type,  InfoType infoType, @JsonKey(includeIfNull: false)  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  FeedComments? comments)  feedEarthquakeCountsData,required TResult Function( String type,  InfoType infoType,  String telegramType, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)  feedEarthquakeNankaiData,required TResult Function( String type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)  feedAppUpdateData,required TResult Function( String type, @JsonKey(includeIfNull: false)  String? url)  feedIncidentData,required TResult Function( String type, @JsonKey(includeIfNull: false)  String? url)  feedDeveloperMessageData,}) {final _that = this;
switch (_that) {
case FeedItemDataUnionFeedEarthquakeNoticeData():
return feedEarthquakeNoticeData(_that.type,_that.text);case FeedItemDataUnionFeedEarthquakeExplanationData():
return feedEarthquakeExplanationData(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataUnionFeedEarthquakeCountsData():
return feedEarthquakeCountsData(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataUnionFeedEarthquakeNankaiData():
return feedEarthquakeNankaiData(_that.type,_that.infoType,_that.telegramType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataUnionFeedAppUpdateData():
return feedAppUpdateData(_that.type,_that.version,_that.url);case FeedItemDataUnionFeedIncidentData():
return feedIncidentData(_that.type,_that.url);case FeedItemDataUnionFeedDeveloperMessageData():
return feedDeveloperMessageData(_that.type,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String type,  String text)?  feedEarthquakeNoticeData,TResult? Function( String type,  InfoType infoType,  String text, @JsonKey(includeIfNull: false)  FeedNaming? naming, @JsonKey(includeIfNull: false)  FeedComments? comments)?  feedEarthquakeExplanationData,TResult? Function( String type,  InfoType infoType, @JsonKey(includeIfNull: false)  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  FeedComments? comments)?  feedEarthquakeCountsData,TResult? Function( String type,  InfoType infoType,  String telegramType, @JsonKey(includeIfNull: false)  FeedNankaiEarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)?  feedEarthquakeNankaiData,TResult? Function( String type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)?  feedAppUpdateData,TResult? Function( String type, @JsonKey(includeIfNull: false)  String? url)?  feedIncidentData,TResult? Function( String type, @JsonKey(includeIfNull: false)  String? url)?  feedDeveloperMessageData,}) {final _that = this;
switch (_that) {
case FeedItemDataUnionFeedEarthquakeNoticeData() when feedEarthquakeNoticeData != null:
return feedEarthquakeNoticeData(_that.type,_that.text);case FeedItemDataUnionFeedEarthquakeExplanationData() when feedEarthquakeExplanationData != null:
return feedEarthquakeExplanationData(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataUnionFeedEarthquakeCountsData() when feedEarthquakeCountsData != null:
return feedEarthquakeCountsData(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataUnionFeedEarthquakeNankaiData() when feedEarthquakeNankaiData != null:
return feedEarthquakeNankaiData(_that.type,_that.infoType,_that.telegramType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataUnionFeedAppUpdateData() when feedAppUpdateData != null:
return feedAppUpdateData(_that.type,_that.version,_that.url);case FeedItemDataUnionFeedIncidentData() when feedIncidentData != null:
return feedIncidentData(_that.type,_that.url);case FeedItemDataUnionFeedDeveloperMessageData() when feedDeveloperMessageData != null:
return feedDeveloperMessageData(_that.type,_that.url);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedEarthquakeNoticeData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedEarthquakeNoticeData({required this.type, required this.text, final  String? $type}): $type = $type ?? 'feedEarthquakeNoticeData';
  factory FeedItemDataUnionFeedEarthquakeNoticeData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedEarthquakeNoticeDataFromJson(json);

/// const: "EARTHQUAKE_NOTICE"
@override final  String type;
 final  String text;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedEarthquakeNoticeDataCopyWith<FeedItemDataUnionFeedEarthquakeNoticeData> get copyWith => _$FeedItemDataUnionFeedEarthquakeNoticeDataCopyWithImpl<FeedItemDataUnionFeedEarthquakeNoticeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedEarthquakeNoticeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedEarthquakeNoticeData&&(identical(other.type, type) || other.type == type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,text);

@override
String toString() {
  return 'FeedItemDataUnion.feedEarthquakeNoticeData(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedEarthquakeNoticeDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedEarthquakeNoticeDataCopyWith(FeedItemDataUnionFeedEarthquakeNoticeData value, $Res Function(FeedItemDataUnionFeedEarthquakeNoticeData) _then) = _$FeedItemDataUnionFeedEarthquakeNoticeDataCopyWithImpl;
@override @useResult
$Res call({
 String type, String text
});




}
/// @nodoc
class _$FeedItemDataUnionFeedEarthquakeNoticeDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedEarthquakeNoticeDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedEarthquakeNoticeDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedEarthquakeNoticeData _self;
  final $Res Function(FeedItemDataUnionFeedEarthquakeNoticeData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? text = null,}) {
  return _then(FeedItemDataUnionFeedEarthquakeNoticeData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedEarthquakeExplanationData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedEarthquakeExplanationData({required this.type, required this.infoType, required this.text, @JsonKey(includeIfNull: false) this.naming, @JsonKey(includeIfNull: false) this.comments, final  String? $type}): $type = $type ?? 'feedEarthquakeExplanationData';
  factory FeedItemDataUnionFeedEarthquakeExplanationData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedEarthquakeExplanationDataFromJson(json);

/// const: "EARTHQUAKE_EXPLANATION"
@override final  String type;
 final  InfoType infoType;
 final  String text;
@JsonKey(includeIfNull: false) final  FeedNaming? naming;
@JsonKey(includeIfNull: false) final  FeedComments? comments;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedEarthquakeExplanationDataCopyWith<FeedItemDataUnionFeedEarthquakeExplanationData> get copyWith => _$FeedItemDataUnionFeedEarthquakeExplanationDataCopyWithImpl<FeedItemDataUnionFeedEarthquakeExplanationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedEarthquakeExplanationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedEarthquakeExplanationData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.text, text) || other.text == text)&&(identical(other.naming, naming) || other.naming == naming)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,text,naming,comments);

@override
String toString() {
  return 'FeedItemDataUnion.feedEarthquakeExplanationData(type: $type, infoType: $infoType, text: $text, naming: $naming, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedEarthquakeExplanationDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedEarthquakeExplanationDataCopyWith(FeedItemDataUnionFeedEarthquakeExplanationData value, $Res Function(FeedItemDataUnionFeedEarthquakeExplanationData) _then) = _$FeedItemDataUnionFeedEarthquakeExplanationDataCopyWithImpl;
@override @useResult
$Res call({
 String type, InfoType infoType, String text,@JsonKey(includeIfNull: false) FeedNaming? naming,@JsonKey(includeIfNull: false) FeedComments? comments
});


$FeedNamingCopyWith<$Res>? get naming;$FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedItemDataUnionFeedEarthquakeExplanationDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedEarthquakeExplanationDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedEarthquakeExplanationDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedEarthquakeExplanationData _self;
  final $Res Function(FeedItemDataUnionFeedEarthquakeExplanationData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? infoType = null,Object? text = null,Object? naming = freezed,Object? comments = freezed,}) {
  return _then(FeedItemDataUnionFeedEarthquakeExplanationData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,naming: freezed == naming ? _self.naming : naming // ignore: cast_nullable_to_non_nullable
as FeedNaming?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}

/// Create a copy of FeedItemDataUnion
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
}/// Create a copy of FeedItemDataUnion
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

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedEarthquakeCountsData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedEarthquakeCountsData({required this.type, required this.infoType, @JsonKey(includeIfNull: false) final  List<FeedEarthquakeCount>? earthquakeCounts, @JsonKey(includeIfNull: false) this.nextAdvisory, @JsonKey(includeIfNull: false) this.text, @JsonKey(includeIfNull: false) this.comments, final  String? $type}): _earthquakeCounts = earthquakeCounts,$type = $type ?? 'feedEarthquakeCountsData';
  factory FeedItemDataUnionFeedEarthquakeCountsData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedEarthquakeCountsDataFromJson(json);

/// const: "EARTHQUAKE_COUNTS"
@override final  String type;
 final  InfoType infoType;
 final  List<FeedEarthquakeCount>? _earthquakeCounts;
@JsonKey(includeIfNull: false) List<FeedEarthquakeCount>? get earthquakeCounts {
  final value = _earthquakeCounts;
  if (value == null) return null;
  if (_earthquakeCounts is EqualUnmodifiableListView) return _earthquakeCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@JsonKey(includeIfNull: false) final  String? nextAdvisory;
@JsonKey(includeIfNull: false) final  String? text;
@JsonKey(includeIfNull: false) final  FeedComments? comments;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedEarthquakeCountsDataCopyWith<FeedItemDataUnionFeedEarthquakeCountsData> get copyWith => _$FeedItemDataUnionFeedEarthquakeCountsDataCopyWithImpl<FeedItemDataUnionFeedEarthquakeCountsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedEarthquakeCountsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedEarthquakeCountsData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&const DeepCollectionEquality().equals(other._earthquakeCounts, _earthquakeCounts)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,const DeepCollectionEquality().hash(_earthquakeCounts),nextAdvisory,text,comments);

@override
String toString() {
  return 'FeedItemDataUnion.feedEarthquakeCountsData(type: $type, infoType: $infoType, earthquakeCounts: $earthquakeCounts, nextAdvisory: $nextAdvisory, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedEarthquakeCountsDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedEarthquakeCountsDataCopyWith(FeedItemDataUnionFeedEarthquakeCountsData value, $Res Function(FeedItemDataUnionFeedEarthquakeCountsData) _then) = _$FeedItemDataUnionFeedEarthquakeCountsDataCopyWithImpl;
@override @useResult
$Res call({
 String type, InfoType infoType,@JsonKey(includeIfNull: false) List<FeedEarthquakeCount>? earthquakeCounts,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) FeedComments? comments
});


$FeedCommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedItemDataUnionFeedEarthquakeCountsDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedEarthquakeCountsDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedEarthquakeCountsDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedEarthquakeCountsData _self;
  final $Res Function(FeedItemDataUnionFeedEarthquakeCountsData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? infoType = null,Object? earthquakeCounts = freezed,Object? nextAdvisory = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(FeedItemDataUnionFeedEarthquakeCountsData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,earthquakeCounts: freezed == earthquakeCounts ? _self._earthquakeCounts : earthquakeCounts // ignore: cast_nullable_to_non_nullable
as List<FeedEarthquakeCount>?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as FeedComments?,
  ));
}

/// Create a copy of FeedItemDataUnion
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

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedEarthquakeNankaiData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedEarthquakeNankaiData({required this.type, required this.infoType, required this.telegramType, @JsonKey(includeIfNull: false) this.earthquakeInfo, @JsonKey(includeIfNull: false) this.nextAdvisory, @JsonKey(includeIfNull: false) this.text, final  String? $type}): $type = $type ?? 'feedEarthquakeNankaiData';
  factory FeedItemDataUnionFeedEarthquakeNankaiData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedEarthquakeNankaiDataFromJson(json);

/// const: "EARTHQUAKE_NANKAI"
@override final  String type;
 final  InfoType infoType;
/// const: "NANKAI"
 final  String telegramType;
@JsonKey(includeIfNull: false) final  FeedNankaiEarthquakeInfo? earthquakeInfo;
@JsonKey(includeIfNull: false) final  String? nextAdvisory;
@JsonKey(includeIfNull: false) final  String? text;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedEarthquakeNankaiDataCopyWith<FeedItemDataUnionFeedEarthquakeNankaiData> get copyWith => _$FeedItemDataUnionFeedEarthquakeNankaiDataCopyWithImpl<FeedItemDataUnionFeedEarthquakeNankaiData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedEarthquakeNankaiDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedEarthquakeNankaiData&&(identical(other.type, type) || other.type == type)&&(identical(other.infoType, infoType) || other.infoType == infoType)&&(identical(other.telegramType, telegramType) || other.telegramType == telegramType)&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,infoType,telegramType,earthquakeInfo,nextAdvisory,text);

@override
String toString() {
  return 'FeedItemDataUnion.feedEarthquakeNankaiData(type: $type, infoType: $infoType, telegramType: $telegramType, earthquakeInfo: $earthquakeInfo, nextAdvisory: $nextAdvisory, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedEarthquakeNankaiDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedEarthquakeNankaiDataCopyWith(FeedItemDataUnionFeedEarthquakeNankaiData value, $Res Function(FeedItemDataUnionFeedEarthquakeNankaiData) _then) = _$FeedItemDataUnionFeedEarthquakeNankaiDataCopyWithImpl;
@override @useResult
$Res call({
 String type, InfoType infoType, String telegramType,@JsonKey(includeIfNull: false) FeedNankaiEarthquakeInfo? earthquakeInfo,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text
});


$FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo;

}
/// @nodoc
class _$FeedItemDataUnionFeedEarthquakeNankaiDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedEarthquakeNankaiDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedEarthquakeNankaiDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedEarthquakeNankaiData _self;
  final $Res Function(FeedItemDataUnionFeedEarthquakeNankaiData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? infoType = null,Object? telegramType = null,Object? earthquakeInfo = freezed,Object? nextAdvisory = freezed,Object? text = freezed,}) {
  return _then(FeedItemDataUnionFeedEarthquakeNankaiData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,infoType: null == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as InfoType,telegramType: null == telegramType ? _self.telegramType : telegramType // ignore: cast_nullable_to_non_nullable
as String,earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as FeedNankaiEarthquakeInfo?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedNankaiEarthquakeInfoCopyWith<$Res>? get earthquakeInfo {
    if (_self.earthquakeInfo == null) {
    return null;
  }

  return $FeedNankaiEarthquakeInfoCopyWith<$Res>(_self.earthquakeInfo!, (value) {
    return _then(_self.copyWith(earthquakeInfo: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedAppUpdateData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedAppUpdateData({required this.type, @JsonKey(includeIfNull: false) this.version, @JsonKey(includeIfNull: false) this.url, final  String? $type}): $type = $type ?? 'feedAppUpdateData';
  factory FeedItemDataUnionFeedAppUpdateData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedAppUpdateDataFromJson(json);

/// const: "APP_UPDATE"
@override final  String type;
@JsonKey(includeIfNull: false) final  String? version;
@JsonKey(includeIfNull: false) final  String? url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedAppUpdateDataCopyWith<FeedItemDataUnionFeedAppUpdateData> get copyWith => _$FeedItemDataUnionFeedAppUpdateDataCopyWithImpl<FeedItemDataUnionFeedAppUpdateData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedAppUpdateDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedAppUpdateData&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,url);

@override
String toString() {
  return 'FeedItemDataUnion.feedAppUpdateData(type: $type, version: $version, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedAppUpdateDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedAppUpdateDataCopyWith(FeedItemDataUnionFeedAppUpdateData value, $Res Function(FeedItemDataUnionFeedAppUpdateData) _then) = _$FeedItemDataUnionFeedAppUpdateDataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? version,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedItemDataUnionFeedAppUpdateDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedAppUpdateDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedAppUpdateDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedAppUpdateData _self;
  final $Res Function(FeedItemDataUnionFeedAppUpdateData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? version = freezed,Object? url = freezed,}) {
  return _then(FeedItemDataUnionFeedAppUpdateData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedIncidentData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedIncidentData({required this.type, @JsonKey(includeIfNull: false) this.url, final  String? $type}): $type = $type ?? 'feedIncidentData';
  factory FeedItemDataUnionFeedIncidentData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedIncidentDataFromJson(json);

/// const: "INCIDENT"
@override final  String type;
@JsonKey(includeIfNull: false) final  String? url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedIncidentDataCopyWith<FeedItemDataUnionFeedIncidentData> get copyWith => _$FeedItemDataUnionFeedIncidentDataCopyWithImpl<FeedItemDataUnionFeedIncidentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedIncidentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedIncidentData&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'FeedItemDataUnion.feedIncidentData(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedIncidentDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedIncidentDataCopyWith(FeedItemDataUnionFeedIncidentData value, $Res Function(FeedItemDataUnionFeedIncidentData) _then) = _$FeedItemDataUnionFeedIncidentDataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedItemDataUnionFeedIncidentDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedIncidentDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedIncidentDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedIncidentData _self;
  final $Res Function(FeedItemDataUnionFeedIncidentData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = freezed,}) {
  return _then(FeedItemDataUnionFeedIncidentData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionFeedDeveloperMessageData implements FeedItemDataUnion {
  const FeedItemDataUnionFeedDeveloperMessageData({required this.type, @JsonKey(includeIfNull: false) this.url, final  String? $type}): $type = $type ?? 'feedDeveloperMessageData';
  factory FeedItemDataUnionFeedDeveloperMessageData.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionFeedDeveloperMessageDataFromJson(json);

/// const: "DEVELOPER_MESSAGE"
@override final  String type;
@JsonKey(includeIfNull: false) final  String? url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionFeedDeveloperMessageDataCopyWith<FeedItemDataUnionFeedDeveloperMessageData> get copyWith => _$FeedItemDataUnionFeedDeveloperMessageDataCopyWithImpl<FeedItemDataUnionFeedDeveloperMessageData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionFeedDeveloperMessageDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionFeedDeveloperMessageData&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'FeedItemDataUnion.feedDeveloperMessageData(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionFeedDeveloperMessageDataCopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionFeedDeveloperMessageDataCopyWith(FeedItemDataUnionFeedDeveloperMessageData value, $Res Function(FeedItemDataUnionFeedDeveloperMessageData) _then) = _$FeedItemDataUnionFeedDeveloperMessageDataCopyWithImpl;
@override @useResult
$Res call({
 String type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedItemDataUnionFeedDeveloperMessageDataCopyWithImpl<$Res>
    implements $FeedItemDataUnionFeedDeveloperMessageDataCopyWith<$Res> {
  _$FeedItemDataUnionFeedDeveloperMessageDataCopyWithImpl(this._self, this._then);

  final FeedItemDataUnionFeedDeveloperMessageData _self;
  final $Res Function(FeedItemDataUnionFeedDeveloperMessageData) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = freezed,}) {
  return _then(FeedItemDataUnionFeedDeveloperMessageData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
