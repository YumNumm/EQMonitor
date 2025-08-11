// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tsunami_comments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TsunamiComments {

/// 自由形式のコメント
 String? get free;/// 警告情報
 TsunamiWarningComment? get warning;
/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiCommentsCopyWith<TsunamiComments> get copyWith => _$TsunamiCommentsCopyWithImpl<TsunamiComments>(this as TsunamiComments, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiComments&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}


@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'TsunamiComments(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class $TsunamiCommentsCopyWith<$Res>  {
  factory $TsunamiCommentsCopyWith(TsunamiComments value, $Res Function(TsunamiComments) _then) = _$TsunamiCommentsCopyWithImpl;
@useResult
$Res call({
 String? free, TsunamiWarningComment? warning
});


$TsunamiWarningCommentCopyWith<$Res>? get warning;

}
/// @nodoc
class _$TsunamiCommentsCopyWithImpl<$Res>
    implements $TsunamiCommentsCopyWith<$Res> {
  _$TsunamiCommentsCopyWithImpl(this._self, this._then);

  final TsunamiComments _self;
  final $Res Function(TsunamiComments) _then;

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_self.copyWith(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as TsunamiWarningComment?,
  ));
}
/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiWarningCommentCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $TsunamiWarningCommentCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}


/// @nodoc


class _TsunamiComments implements TsunamiComments {
  const _TsunamiComments({this.free, this.warning});
  

/// 自由形式のコメント
@override final  String? free;
/// 警告情報
@override final  TsunamiWarningComment? warning;

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiCommentsCopyWith<_TsunamiComments> get copyWith => __$TsunamiCommentsCopyWithImpl<_TsunamiComments>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiComments&&(identical(other.free, free) || other.free == free)&&(identical(other.warning, warning) || other.warning == warning));
}


@override
int get hashCode => Object.hash(runtimeType,free,warning);

@override
String toString() {
  return 'TsunamiComments(free: $free, warning: $warning)';
}


}

/// @nodoc
abstract mixin class _$TsunamiCommentsCopyWith<$Res> implements $TsunamiCommentsCopyWith<$Res> {
  factory _$TsunamiCommentsCopyWith(_TsunamiComments value, $Res Function(_TsunamiComments) _then) = __$TsunamiCommentsCopyWithImpl;
@override @useResult
$Res call({
 String? free, TsunamiWarningComment? warning
});


@override $TsunamiWarningCommentCopyWith<$Res>? get warning;

}
/// @nodoc
class __$TsunamiCommentsCopyWithImpl<$Res>
    implements _$TsunamiCommentsCopyWith<$Res> {
  __$TsunamiCommentsCopyWithImpl(this._self, this._then);

  final _TsunamiComments _self;
  final $Res Function(_TsunamiComments) _then;

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? free = freezed,Object? warning = freezed,}) {
  return _then(_TsunamiComments(
free: freezed == free ? _self.free : free // ignore: cast_nullable_to_non_nullable
as String?,warning: freezed == warning ? _self.warning : warning // ignore: cast_nullable_to_non_nullable
as TsunamiWarningComment?,
  ));
}

/// Create a copy of TsunamiComments
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TsunamiWarningCommentCopyWith<$Res>? get warning {
    if (_self.warning == null) {
    return null;
  }

  return $TsunamiWarningCommentCopyWith<$Res>(_self.warning!, (value) {
    return _then(_self.copyWith(warning: value));
  });
}
}

/// @nodoc
mixin _$TsunamiWarningComment {

 String get text; List<String> get codes;
/// Create a copy of TsunamiWarningComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TsunamiWarningCommentCopyWith<TsunamiWarningComment> get copyWith => _$TsunamiWarningCommentCopyWithImpl<TsunamiWarningComment>(this as TsunamiWarningComment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TsunamiWarningComment&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.codes, codes));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(codes));

@override
String toString() {
  return 'TsunamiWarningComment(text: $text, codes: $codes)';
}


}

/// @nodoc
abstract mixin class $TsunamiWarningCommentCopyWith<$Res>  {
  factory $TsunamiWarningCommentCopyWith(TsunamiWarningComment value, $Res Function(TsunamiWarningComment) _then) = _$TsunamiWarningCommentCopyWithImpl;
@useResult
$Res call({
 String text, List<String> codes
});




}
/// @nodoc
class _$TsunamiWarningCommentCopyWithImpl<$Res>
    implements $TsunamiWarningCommentCopyWith<$Res> {
  _$TsunamiWarningCommentCopyWithImpl(this._self, this._then);

  final TsunamiWarningComment _self;
  final $Res Function(TsunamiWarningComment) _then;

/// Create a copy of TsunamiWarningComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? codes = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,codes: null == codes ? _self.codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc


class _TsunamiWarningComment implements TsunamiWarningComment {
  const _TsunamiWarningComment({required this.text, required final  List<String> codes}): _codes = codes;
  

@override final  String text;
 final  List<String> _codes;
@override List<String> get codes {
  if (_codes is EqualUnmodifiableListView) return _codes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_codes);
}


/// Create a copy of TsunamiWarningComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TsunamiWarningCommentCopyWith<_TsunamiWarningComment> get copyWith => __$TsunamiWarningCommentCopyWithImpl<_TsunamiWarningComment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TsunamiWarningComment&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._codes, _codes));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_codes));

@override
String toString() {
  return 'TsunamiWarningComment(text: $text, codes: $codes)';
}


}

/// @nodoc
abstract mixin class _$TsunamiWarningCommentCopyWith<$Res> implements $TsunamiWarningCommentCopyWith<$Res> {
  factory _$TsunamiWarningCommentCopyWith(_TsunamiWarningComment value, $Res Function(_TsunamiWarningComment) _then) = __$TsunamiWarningCommentCopyWithImpl;
@override @useResult
$Res call({
 String text, List<String> codes
});




}
/// @nodoc
class __$TsunamiWarningCommentCopyWithImpl<$Res>
    implements _$TsunamiWarningCommentCopyWith<$Res> {
  __$TsunamiWarningCommentCopyWithImpl(this._self, this._then);

  final _TsunamiWarningComment _self;
  final $Res Function(_TsunamiWarningComment) _then;

/// Create a copy of TsunamiWarningComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? codes = null,}) {
  return _then(_TsunamiWarningComment(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,codes: null == codes ? _self._codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
