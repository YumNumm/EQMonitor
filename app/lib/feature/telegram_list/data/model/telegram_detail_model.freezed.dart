// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telegram_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TelegramDetailModel {

 EarthquakeTelegramBodyModel? get earthquakeBody; TelegramCommentsModel? get comments;
/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelegramDetailModelCopyWith<TelegramDetailModel> get copyWith => _$TelegramDetailModelCopyWithImpl<TelegramDetailModel>(this as TelegramDetailModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelegramDetailModel&&(identical(other.earthquakeBody, earthquakeBody) || other.earthquakeBody == earthquakeBody)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,earthquakeBody,comments);

@override
String toString() {
  return 'TelegramDetailModel(earthquakeBody: $earthquakeBody, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $TelegramDetailModelCopyWith<$Res>  {
  factory $TelegramDetailModelCopyWith(TelegramDetailModel value, $Res Function(TelegramDetailModel) _then) = _$TelegramDetailModelCopyWithImpl;
@useResult
$Res call({
 EarthquakeTelegramBodyModel? earthquakeBody, TelegramCommentsModel? comments
});


$EarthquakeTelegramBodyModelCopyWith<$Res>? get earthquakeBody;$TelegramCommentsModelCopyWith<$Res>? get comments;

}
/// @nodoc
class _$TelegramDetailModelCopyWithImpl<$Res>
    implements $TelegramDetailModelCopyWith<$Res> {
  _$TelegramDetailModelCopyWithImpl(this._self, this._then);

  final TelegramDetailModel _self;
  final $Res Function(TelegramDetailModel) _then;

/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? earthquakeBody = freezed,Object? comments = freezed,}) {
  return _then(TelegramDetailModel(
earthquakeBody: freezed == earthquakeBody ? _self.earthquakeBody : earthquakeBody // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyModel?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TelegramCommentsModel?,
  ));
}
/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyModelCopyWith<$Res>? get earthquakeBody {
    if (_self.earthquakeBody == null) {
    return null;
  }

  return $EarthquakeTelegramBodyModelCopyWith<$Res>(_self.earthquakeBody!, (value) {
    return _then(_self.copyWith(earthquakeBody: value));
  });
}/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCommentsModelCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TelegramCommentsModelCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}


/// Adds pattern-matching-related methods to [TelegramDetailModel].
extension TelegramDetailModelPatterns on TelegramDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelegramDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelegramDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelegramDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _TelegramDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelegramDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _TelegramDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EarthquakeTelegramBodyModel? earthquakeBody,  TelegramCommentsModel? comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelegramDetailModel() when $default != null:
return $default(_that.earthquakeBody,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EarthquakeTelegramBodyModel? earthquakeBody,  TelegramCommentsModel? comments)  $default,) {final _that = this;
switch (_that) {
case _TelegramDetailModel():
return $default(_that.earthquakeBody,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EarthquakeTelegramBodyModel? earthquakeBody,  TelegramCommentsModel? comments)?  $default,) {final _that = this;
switch (_that) {
case _TelegramDetailModel() when $default != null:
return $default(_that.earthquakeBody,_that.comments);case _:
  return null;

}
}

}

/// @nodoc


class _TelegramDetailModel implements TelegramDetailModel {
  const _TelegramDetailModel({this.earthquakeBody, this.comments});
  

@override final  EarthquakeTelegramBodyModel? earthquakeBody;
@override final  TelegramCommentsModel? comments;

/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelegramDetailModelCopyWith<_TelegramDetailModel> get copyWith => __$TelegramDetailModelCopyWithImpl<_TelegramDetailModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelegramDetailModel&&(identical(other.earthquakeBody, earthquakeBody) || other.earthquakeBody == earthquakeBody)&&(identical(other.comments, comments) || other.comments == comments));
}


@override
int get hashCode => Object.hash(runtimeType,earthquakeBody,comments);

@override
String toString() {
  return 'TelegramDetailModel(earthquakeBody: $earthquakeBody, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$TelegramDetailModelCopyWith<$Res> implements $TelegramDetailModelCopyWith<$Res> {
  factory _$TelegramDetailModelCopyWith(_TelegramDetailModel value, $Res Function(_TelegramDetailModel) _then) = __$TelegramDetailModelCopyWithImpl;
@override @useResult
$Res call({
 EarthquakeTelegramBodyModel? earthquakeBody, TelegramCommentsModel? comments
});


@override $EarthquakeTelegramBodyModelCopyWith<$Res>? get earthquakeBody;@override $TelegramCommentsModelCopyWith<$Res>? get comments;

}
/// @nodoc
class __$TelegramDetailModelCopyWithImpl<$Res>
    implements _$TelegramDetailModelCopyWith<$Res> {
  __$TelegramDetailModelCopyWithImpl(this._self, this._then);

  final _TelegramDetailModel _self;
  final $Res Function(_TelegramDetailModel) _then;

/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? earthquakeBody = freezed,Object? comments = freezed,}) {
  return _then(_TelegramDetailModel(
earthquakeBody: freezed == earthquakeBody ? _self.earthquakeBody : earthquakeBody // ignore: cast_nullable_to_non_nullable
as EarthquakeTelegramBodyModel?,comments: freezed == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as TelegramCommentsModel?,
  ));
}

/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EarthquakeTelegramBodyModelCopyWith<$Res>? get earthquakeBody {
    if (_self.earthquakeBody == null) {
    return null;
  }

  return $EarthquakeTelegramBodyModelCopyWith<$Res>(_self.earthquakeBody!, (value) {
    return _then(_self.copyWith(earthquakeBody: value));
  });
}/// Create a copy of TelegramDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelegramCommentsModelCopyWith<$Res>? get comments {
    if (_self.comments == null) {
    return null;
  }

  return $TelegramCommentsModelCopyWith<$Res>(_self.comments!, (value) {
    return _then(_self.copyWith(comments: value));
  });
}
}

// dart format on
