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
                  case 'variant1':
          return FeedItemDataUnionVariant1.fromJson(
            json
          );
                case 'variant2':
          return FeedItemDataUnionVariant2.fromJson(
            json
          );
                case 'variant3':
          return FeedItemDataUnionVariant3.fromJson(
            json
          );
                case 'variant4':
          return FeedItemDataUnionVariant4.fromJson(
            json
          );
                case 'variant5':
          return FeedItemDataUnionVariant5.fromJson(
            json
          );
                case 'variant6':
          return FeedItemDataUnionVariant6.fromJson(
            json
          );
                case 'variant7':
          return FeedItemDataUnionVariant7.fromJson(
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

 dynamic get type;
/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionCopyWith<FeedItemDataUnion> get copyWith => _$FeedItemDataUnionCopyWithImpl<FeedItemDataUnion>(this as FeedItemDataUnion, _$identity);

  /// Serializes this FeedItemDataUnion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnion&&const DeepCollectionEquality().equals(other.type, type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type));

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
 dynamic type
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
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedItemDataUnionVariant1 value)?  variant1,TResult Function( FeedItemDataUnionVariant2 value)?  variant2,TResult Function( FeedItemDataUnionVariant3 value)?  variant3,TResult Function( FeedItemDataUnionVariant4 value)?  variant4,TResult Function( FeedItemDataUnionVariant5 value)?  variant5,TResult Function( FeedItemDataUnionVariant6 value)?  variant6,TResult Function( FeedItemDataUnionVariant7 value)?  variant7,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedItemDataUnionVariant1() when variant1 != null:
return variant1(_that);case FeedItemDataUnionVariant2() when variant2 != null:
return variant2(_that);case FeedItemDataUnionVariant3() when variant3 != null:
return variant3(_that);case FeedItemDataUnionVariant4() when variant4 != null:
return variant4(_that);case FeedItemDataUnionVariant5() when variant5 != null:
return variant5(_that);case FeedItemDataUnionVariant6() when variant6 != null:
return variant6(_that);case FeedItemDataUnionVariant7() when variant7 != null:
return variant7(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedItemDataUnionVariant1 value)  variant1,required TResult Function( FeedItemDataUnionVariant2 value)  variant2,required TResult Function( FeedItemDataUnionVariant3 value)  variant3,required TResult Function( FeedItemDataUnionVariant4 value)  variant4,required TResult Function( FeedItemDataUnionVariant5 value)  variant5,required TResult Function( FeedItemDataUnionVariant6 value)  variant6,required TResult Function( FeedItemDataUnionVariant7 value)  variant7,}){
final _that = this;
switch (_that) {
case FeedItemDataUnionVariant1():
return variant1(_that);case FeedItemDataUnionVariant2():
return variant2(_that);case FeedItemDataUnionVariant3():
return variant3(_that);case FeedItemDataUnionVariant4():
return variant4(_that);case FeedItemDataUnionVariant5():
return variant5(_that);case FeedItemDataUnionVariant6():
return variant6(_that);case FeedItemDataUnionVariant7():
return variant7(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedItemDataUnionVariant1 value)?  variant1,TResult? Function( FeedItemDataUnionVariant2 value)?  variant2,TResult? Function( FeedItemDataUnionVariant3 value)?  variant3,TResult? Function( FeedItemDataUnionVariant4 value)?  variant4,TResult? Function( FeedItemDataUnionVariant5 value)?  variant5,TResult? Function( FeedItemDataUnionVariant6 value)?  variant6,TResult? Function( FeedItemDataUnionVariant7 value)?  variant7,}){
final _that = this;
switch (_that) {
case FeedItemDataUnionVariant1() when variant1 != null:
return variant1(_that);case FeedItemDataUnionVariant2() when variant2 != null:
return variant2(_that);case FeedItemDataUnionVariant3() when variant3 != null:
return variant3(_that);case FeedItemDataUnionVariant4() when variant4 != null:
return variant4(_that);case FeedItemDataUnionVariant5() when variant5 != null:
return variant5(_that);case FeedItemDataUnionVariant6() when variant6 != null:
return variant6(_that);case FeedItemDataUnionVariant7() when variant7 != null:
return variant7(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( dynamic type,  String text)?  variant1,TResult Function( dynamic type,  dynamic infoType,  String text, @JsonKey(includeIfNull: false)  Naming? naming, @JsonKey(includeIfNull: false)  Comments? comments)?  variant2,TResult Function( dynamic type,  dynamic infoType, @JsonKey(includeIfNull: false)  List<EarthquakeCounts>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  Comments2? comments)?  variant3,TResult Function( dynamic type,  dynamic infoType,  dynamic telegramType, @JsonKey(includeIfNull: false)  EarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)?  variant4,TResult Function( dynamic type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)?  variant5,TResult Function( dynamic type, @JsonKey(includeIfNull: false)  String? url)?  variant6,TResult Function( dynamic type, @JsonKey(includeIfNull: false)  String? url)?  variant7,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedItemDataUnionVariant1() when variant1 != null:
return variant1(_that.type,_that.text);case FeedItemDataUnionVariant2() when variant2 != null:
return variant2(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataUnionVariant3() when variant3 != null:
return variant3(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataUnionVariant4() when variant4 != null:
return variant4(_that.type,_that.infoType,_that.telegramType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataUnionVariant5() when variant5 != null:
return variant5(_that.type,_that.version,_that.url);case FeedItemDataUnionVariant6() when variant6 != null:
return variant6(_that.type,_that.url);case FeedItemDataUnionVariant7() when variant7 != null:
return variant7(_that.type,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( dynamic type,  String text)  variant1,required TResult Function( dynamic type,  dynamic infoType,  String text, @JsonKey(includeIfNull: false)  Naming? naming, @JsonKey(includeIfNull: false)  Comments? comments)  variant2,required TResult Function( dynamic type,  dynamic infoType, @JsonKey(includeIfNull: false)  List<EarthquakeCounts>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  Comments2? comments)  variant3,required TResult Function( dynamic type,  dynamic infoType,  dynamic telegramType, @JsonKey(includeIfNull: false)  EarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)  variant4,required TResult Function( dynamic type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)  variant5,required TResult Function( dynamic type, @JsonKey(includeIfNull: false)  String? url)  variant6,required TResult Function( dynamic type, @JsonKey(includeIfNull: false)  String? url)  variant7,}) {final _that = this;
switch (_that) {
case FeedItemDataUnionVariant1():
return variant1(_that.type,_that.text);case FeedItemDataUnionVariant2():
return variant2(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataUnionVariant3():
return variant3(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataUnionVariant4():
return variant4(_that.type,_that.infoType,_that.telegramType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataUnionVariant5():
return variant5(_that.type,_that.version,_that.url);case FeedItemDataUnionVariant6():
return variant6(_that.type,_that.url);case FeedItemDataUnionVariant7():
return variant7(_that.type,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( dynamic type,  String text)?  variant1,TResult? Function( dynamic type,  dynamic infoType,  String text, @JsonKey(includeIfNull: false)  Naming? naming, @JsonKey(includeIfNull: false)  Comments? comments)?  variant2,TResult? Function( dynamic type,  dynamic infoType, @JsonKey(includeIfNull: false)  List<EarthquakeCounts>? earthquakeCounts, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text, @JsonKey(includeIfNull: false)  Comments2? comments)?  variant3,TResult? Function( dynamic type,  dynamic infoType,  dynamic telegramType, @JsonKey(includeIfNull: false)  EarthquakeInfo? earthquakeInfo, @JsonKey(includeIfNull: false)  String? nextAdvisory, @JsonKey(includeIfNull: false)  String? text)?  variant4,TResult? Function( dynamic type, @JsonKey(includeIfNull: false)  String? version, @JsonKey(includeIfNull: false)  String? url)?  variant5,TResult? Function( dynamic type, @JsonKey(includeIfNull: false)  String? url)?  variant6,TResult? Function( dynamic type, @JsonKey(includeIfNull: false)  String? url)?  variant7,}) {final _that = this;
switch (_that) {
case FeedItemDataUnionVariant1() when variant1 != null:
return variant1(_that.type,_that.text);case FeedItemDataUnionVariant2() when variant2 != null:
return variant2(_that.type,_that.infoType,_that.text,_that.naming,_that.comments);case FeedItemDataUnionVariant3() when variant3 != null:
return variant3(_that.type,_that.infoType,_that.earthquakeCounts,_that.nextAdvisory,_that.text,_that.comments);case FeedItemDataUnionVariant4() when variant4 != null:
return variant4(_that.type,_that.infoType,_that.telegramType,_that.earthquakeInfo,_that.nextAdvisory,_that.text);case FeedItemDataUnionVariant5() when variant5 != null:
return variant5(_that.type,_that.version,_that.url);case FeedItemDataUnionVariant6() when variant6 != null:
return variant6(_that.type,_that.url);case FeedItemDataUnionVariant7() when variant7 != null:
return variant7(_that.type,_that.url);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant1 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant1({required this.type, required this.text, final  String? $type}): $type = $type ?? 'variant1';
  factory FeedItemDataUnionVariant1.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant1FromJson(json);

@override final  dynamic type;
 final  String text;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant1CopyWith<FeedItemDataUnionVariant1> get copyWith => _$FeedItemDataUnionVariant1CopyWithImpl<FeedItemDataUnionVariant1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant1&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),text);

@override
String toString() {
  return 'FeedItemDataUnion.variant1(type: $type, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant1CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant1CopyWith(FeedItemDataUnionVariant1 value, $Res Function(FeedItemDataUnionVariant1) _then) = _$FeedItemDataUnionVariant1CopyWithImpl;
@override @useResult
$Res call({
 dynamic type, String text
});




}
/// @nodoc
class _$FeedItemDataUnionVariant1CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant1CopyWith<$Res> {
  _$FeedItemDataUnionVariant1CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant1 _self;
  final $Res Function(FeedItemDataUnionVariant1) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? text = null,}) {
  return _then(FeedItemDataUnionVariant1(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant2 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant2({required this.type, required this.infoType, required this.text, @JsonKey(includeIfNull: false) this.naming, @JsonKey(includeIfNull: false) this.comments, final  String? $type}): $type = $type ?? 'variant2';
  factory FeedItemDataUnionVariant2.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant2FromJson(json);

@override final  dynamic type;
 final  dynamic infoType;
 final  String text;
@JsonKey(includeIfNull: false) final  Naming? naming;
@JsonKey(includeIfNull: false) final  Comments? comments;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant2CopyWith<FeedItemDataUnionVariant2> get copyWith => _$FeedItemDataUnionVariant2CopyWithImpl<FeedItemDataUnionVariant2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant2&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.infoType, infoType)&&(identical(other.text, text) || other.text == text)&&(identical(other.naming, naming) || other.naming == naming)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(infoType),text,naming,comments);

@override
String toString() {
  return 'FeedItemDataUnion.variant2(type: $type, infoType: $infoType, text: $text, naming: $naming, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant2CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant2CopyWith(FeedItemDataUnionVariant2 value, $Res Function(FeedItemDataUnionVariant2) _then) = _$FeedItemDataUnionVariant2CopyWithImpl;
@override @useResult
$Res call({
 dynamic type, dynamic infoType, String text,@JsonKey(includeIfNull: false) Naming? naming,@JsonKey(includeIfNull: false) Comments? comments
});


$NamingCopyWith<$Res>? get naming;$CommentsCopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedItemDataUnionVariant2CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant2CopyWith<$Res> {
  _$FeedItemDataUnionVariant2CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant2 _self;
  final $Res Function(FeedItemDataUnionVariant2) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? infoType = freezed,Object? text = null,Object? naming = freezed,Object? comments = freezed,}) {
  return _then(FeedItemDataUnionVariant2(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,infoType: freezed == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as dynamic,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,naming: freezed == naming ? _self.naming : naming // ignore: cast_nullable_to_non_nullable
as Naming?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as Comments?,
  ));
}

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamingCopyWith<$Res>? get naming {
    if (_self.naming == null) {
    return null;
  }

  return $NamingCopyWith<$Res>(_self.naming!, (value) {
    return _then(_self.copyWith(naming: value));
  });
}/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommentsCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $CommentsCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant3 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant3({required this.type, required this.infoType, @JsonKey(includeIfNull: false) final  List<EarthquakeCounts>? earthquakeCounts, @JsonKey(includeIfNull: false) this.nextAdvisory, @JsonKey(includeIfNull: false) this.text, @JsonKey(includeIfNull: false) this.comments, final  String? $type}): _earthquakeCounts = earthquakeCounts,$type = $type ?? 'variant3';
  factory FeedItemDataUnionVariant3.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant3FromJson(json);

@override final  dynamic type;
 final  dynamic infoType;
 final  List<EarthquakeCounts>? _earthquakeCounts;
@JsonKey(includeIfNull: false) List<EarthquakeCounts>? get earthquakeCounts {
  final value = _earthquakeCounts;
  if (value == null) return null;
  if (_earthquakeCounts is EqualUnmodifiableListView) return _earthquakeCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@JsonKey(includeIfNull: false) final  String? nextAdvisory;
@JsonKey(includeIfNull: false) final  String? text;
@JsonKey(includeIfNull: false) final  Comments2? comments;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant3CopyWith<FeedItemDataUnionVariant3> get copyWith => _$FeedItemDataUnionVariant3CopyWithImpl<FeedItemDataUnionVariant3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant3&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.infoType, infoType)&&const DeepCollectionEquality().equals(other._earthquakeCounts, _earthquakeCounts)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(infoType),const DeepCollectionEquality().hash(_earthquakeCounts),nextAdvisory,text,comments);

@override
String toString() {
  return 'FeedItemDataUnion.variant3(type: $type, infoType: $infoType, earthquakeCounts: $earthquakeCounts, nextAdvisory: $nextAdvisory, text: $text, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant3CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant3CopyWith(FeedItemDataUnionVariant3 value, $Res Function(FeedItemDataUnionVariant3) _then) = _$FeedItemDataUnionVariant3CopyWithImpl;
@override @useResult
$Res call({
 dynamic type, dynamic infoType,@JsonKey(includeIfNull: false) List<EarthquakeCounts>? earthquakeCounts,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text,@JsonKey(includeIfNull: false) Comments2? comments
});


$Comments2CopyWith<$Res>? get comments;

}
/// @nodoc
class _$FeedItemDataUnionVariant3CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant3CopyWith<$Res> {
  _$FeedItemDataUnionVariant3CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant3 _self;
  final $Res Function(FeedItemDataUnionVariant3) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? infoType = freezed,Object? earthquakeCounts = freezed,Object? nextAdvisory = freezed,Object? text = freezed,Object? comments = freezed,}) {
  return _then(FeedItemDataUnionVariant3(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,infoType: freezed == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as dynamic,earthquakeCounts: freezed == earthquakeCounts ? _self._earthquakeCounts : earthquakeCounts // ignore: cast_nullable_to_non_nullable
as List<EarthquakeCounts>?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as Comments2?,
  ));
}

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$Comments2CopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $Comments2CopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant4 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant4({required this.type, required this.infoType, required this.telegramType, @JsonKey(includeIfNull: false) this.earthquakeInfo, @JsonKey(includeIfNull: false) this.nextAdvisory, @JsonKey(includeIfNull: false) this.text, final  String? $type}): $type = $type ?? 'variant4';
  factory FeedItemDataUnionVariant4.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant4FromJson(json);

@override final  dynamic type;
 final  dynamic infoType;
 final  dynamic telegramType;
@JsonKey(includeIfNull: false) final  EarthquakeInfo? earthquakeInfo;
@JsonKey(includeIfNull: false) final  String? nextAdvisory;
@JsonKey(includeIfNull: false) final  String? text;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant4CopyWith<FeedItemDataUnionVariant4> get copyWith => _$FeedItemDataUnionVariant4CopyWithImpl<FeedItemDataUnionVariant4>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant4ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant4&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.infoType, infoType)&&const DeepCollectionEquality().equals(other.telegramType, telegramType)&&(identical(other.earthquakeInfo, earthquakeInfo) || other.earthquakeInfo == earthquakeInfo)&&(identical(other.nextAdvisory, nextAdvisory) || other.nextAdvisory == nextAdvisory)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(infoType),const DeepCollectionEquality().hash(telegramType),earthquakeInfo,nextAdvisory,text);

@override
String toString() {
  return 'FeedItemDataUnion.variant4(type: $type, infoType: $infoType, telegramType: $telegramType, earthquakeInfo: $earthquakeInfo, nextAdvisory: $nextAdvisory, text: $text)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant4CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant4CopyWith(FeedItemDataUnionVariant4 value, $Res Function(FeedItemDataUnionVariant4) _then) = _$FeedItemDataUnionVariant4CopyWithImpl;
@override @useResult
$Res call({
 dynamic type, dynamic infoType, dynamic telegramType,@JsonKey(includeIfNull: false) EarthquakeInfo? earthquakeInfo,@JsonKey(includeIfNull: false) String? nextAdvisory,@JsonKey(includeIfNull: false) String? text
});


$EarthquakeInfoCopyWith<$Res>? get earthquakeInfo;

}
/// @nodoc
class _$FeedItemDataUnionVariant4CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant4CopyWith<$Res> {
  _$FeedItemDataUnionVariant4CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant4 _self;
  final $Res Function(FeedItemDataUnionVariant4) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? infoType = freezed,Object? telegramType = freezed,Object? earthquakeInfo = freezed,Object? nextAdvisory = freezed,Object? text = freezed,}) {
  return _then(FeedItemDataUnionVariant4(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,infoType: freezed == infoType ? _self.infoType : infoType // ignore: cast_nullable_to_non_nullable
as dynamic,telegramType: freezed == telegramType ? _self.telegramType : telegramType // ignore: cast_nullable_to_non_nullable
as dynamic,earthquakeInfo: freezed == earthquakeInfo ? _self.earthquakeInfo : earthquakeInfo // ignore: cast_nullable_to_non_nullable
as EarthquakeInfo?,nextAdvisory: freezed == nextAdvisory ? _self.nextAdvisory : nextAdvisory // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeInfoCopyWith<$Res>? get earthquakeInfo {
    if (_self.earthquakeInfo == null) {
    return null;
  }

  return $EarthquakeInfoCopyWith<$Res>(_self.earthquakeInfo!, (value) {
    return _then(_self.copyWith(earthquakeInfo: value));
  });
}
}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant5 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant5({required this.type, @JsonKey(includeIfNull: false) this.version, @JsonKey(includeIfNull: false) this.url, final  String? $type}): $type = $type ?? 'variant5';
  factory FeedItemDataUnionVariant5.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant5FromJson(json);

@override final  dynamic type;
@JsonKey(includeIfNull: false) final  String? version;
@JsonKey(includeIfNull: false) final  String? url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant5CopyWith<FeedItemDataUnionVariant5> get copyWith => _$FeedItemDataUnionVariant5CopyWithImpl<FeedItemDataUnionVariant5>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant5ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant5&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.version, version) || other.version == version)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),version,url);

@override
String toString() {
  return 'FeedItemDataUnion.variant5(type: $type, version: $version, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant5CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant5CopyWith(FeedItemDataUnionVariant5 value, $Res Function(FeedItemDataUnionVariant5) _then) = _$FeedItemDataUnionVariant5CopyWithImpl;
@override @useResult
$Res call({
 dynamic type,@JsonKey(includeIfNull: false) String? version,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedItemDataUnionVariant5CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant5CopyWith<$Res> {
  _$FeedItemDataUnionVariant5CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant5 _self;
  final $Res Function(FeedItemDataUnionVariant5) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? version = freezed,Object? url = freezed,}) {
  return _then(FeedItemDataUnionVariant5(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant6 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant6({required this.type, @JsonKey(includeIfNull: false) this.url, final  String? $type}): $type = $type ?? 'variant6';
  factory FeedItemDataUnionVariant6.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant6FromJson(json);

@override final  dynamic type;
@JsonKey(includeIfNull: false) final  String? url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant6CopyWith<FeedItemDataUnionVariant6> get copyWith => _$FeedItemDataUnionVariant6CopyWithImpl<FeedItemDataUnionVariant6>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant6ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant6&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),url);

@override
String toString() {
  return 'FeedItemDataUnion.variant6(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant6CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant6CopyWith(FeedItemDataUnionVariant6 value, $Res Function(FeedItemDataUnionVariant6) _then) = _$FeedItemDataUnionVariant6CopyWithImpl;
@override @useResult
$Res call({
 dynamic type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedItemDataUnionVariant6CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant6CopyWith<$Res> {
  _$FeedItemDataUnionVariant6CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant6 _self;
  final $Res Function(FeedItemDataUnionVariant6) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? url = freezed,}) {
  return _then(FeedItemDataUnionVariant6(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc

@JsonSerializable()
class FeedItemDataUnionVariant7 implements FeedItemDataUnion {
  const FeedItemDataUnionVariant7({required this.type, @JsonKey(includeIfNull: false) this.url, final  String? $type}): $type = $type ?? 'variant7';
  factory FeedItemDataUnionVariant7.fromJson(Map<String, dynamic> json) => _$FeedItemDataUnionVariant7FromJson(json);

@override final  dynamic type;
@JsonKey(includeIfNull: false) final  String? url;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedItemDataUnionVariant7CopyWith<FeedItemDataUnionVariant7> get copyWith => _$FeedItemDataUnionVariant7CopyWithImpl<FeedItemDataUnionVariant7>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedItemDataUnionVariant7ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedItemDataUnionVariant7&&const DeepCollectionEquality().equals(other.type, type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),url);

@override
String toString() {
  return 'FeedItemDataUnion.variant7(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $FeedItemDataUnionVariant7CopyWith<$Res> implements $FeedItemDataUnionCopyWith<$Res> {
  factory $FeedItemDataUnionVariant7CopyWith(FeedItemDataUnionVariant7 value, $Res Function(FeedItemDataUnionVariant7) _then) = _$FeedItemDataUnionVariant7CopyWithImpl;
@override @useResult
$Res call({
 dynamic type,@JsonKey(includeIfNull: false) String? url
});




}
/// @nodoc
class _$FeedItemDataUnionVariant7CopyWithImpl<$Res>
    implements $FeedItemDataUnionVariant7CopyWith<$Res> {
  _$FeedItemDataUnionVariant7CopyWithImpl(this._self, this._then);

  final FeedItemDataUnionVariant7 _self;
  final $Res Function(FeedItemDataUnionVariant7) _then;

/// Create a copy of FeedItemDataUnion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? url = freezed,}) {
  return _then(FeedItemDataUnionVariant7(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as dynamic,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
