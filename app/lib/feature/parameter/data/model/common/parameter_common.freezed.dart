// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parameter_common.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizedName {

 String get ja; String? get en; String? get zhHans; String? get zhHant; String? get ko; String? get es; String? get pt; String? get id; String? get vi; String? get tl; String? get th; String? get ne; String? get km; String? get my; String? get mn;
/// Create a copy of LocalizedName
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedNameCopyWith<LocalizedName> get copyWith => _$LocalizedNameCopyWithImpl<LocalizedName>(this as LocalizedName, _$identity);

  /// Serializes this LocalizedName to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedName&&(identical(other.ja, ja) || other.ja == ja)&&(identical(other.en, en) || other.en == en)&&(identical(other.zhHans, zhHans) || other.zhHans == zhHans)&&(identical(other.zhHant, zhHant) || other.zhHant == zhHant)&&(identical(other.ko, ko) || other.ko == ko)&&(identical(other.es, es) || other.es == es)&&(identical(other.pt, pt) || other.pt == pt)&&(identical(other.id, id) || other.id == id)&&(identical(other.vi, vi) || other.vi == vi)&&(identical(other.tl, tl) || other.tl == tl)&&(identical(other.th, th) || other.th == th)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.km, km) || other.km == km)&&(identical(other.my, my) || other.my == my)&&(identical(other.mn, mn) || other.mn == mn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ja,en,zhHans,zhHant,ko,es,pt,id,vi,tl,th,ne,km,my,mn);

@override
String toString() {
  return 'LocalizedName(ja: $ja, en: $en, zhHans: $zhHans, zhHant: $zhHant, ko: $ko, es: $es, pt: $pt, id: $id, vi: $vi, tl: $tl, th: $th, ne: $ne, km: $km, my: $my, mn: $mn)';
}


}

/// @nodoc
abstract mixin class $LocalizedNameCopyWith<$Res>  {
  factory $LocalizedNameCopyWith(LocalizedName value, $Res Function(LocalizedName) _then) = _$LocalizedNameCopyWithImpl;
@useResult
$Res call({
 String ja, String? en, String? zhHans, String? zhHant, String? ko, String? es, String? pt, String? id, String? vi, String? tl, String? th, String? ne, String? km, String? my, String? mn
});




}
/// @nodoc
class _$LocalizedNameCopyWithImpl<$Res>
    implements $LocalizedNameCopyWith<$Res> {
  _$LocalizedNameCopyWithImpl(this._self, this._then);

  final LocalizedName _self;
  final $Res Function(LocalizedName) _then;

/// Create a copy of LocalizedName
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ja = null,Object? en = freezed,Object? zhHans = freezed,Object? zhHant = freezed,Object? ko = freezed,Object? es = freezed,Object? pt = freezed,Object? id = freezed,Object? vi = freezed,Object? tl = freezed,Object? th = freezed,Object? ne = freezed,Object? km = freezed,Object? my = freezed,Object? mn = freezed,}) {
  return _then(_self.copyWith(
ja: null == ja ? _self.ja : ja // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,zhHans: freezed == zhHans ? _self.zhHans : zhHans // ignore: cast_nullable_to_non_nullable
as String?,zhHant: freezed == zhHant ? _self.zhHant : zhHant // ignore: cast_nullable_to_non_nullable
as String?,ko: freezed == ko ? _self.ko : ko // ignore: cast_nullable_to_non_nullable
as String?,es: freezed == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String?,pt: freezed == pt ? _self.pt : pt // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,vi: freezed == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String?,tl: freezed == tl ? _self.tl : tl // ignore: cast_nullable_to_non_nullable
as String?,th: freezed == th ? _self.th : th // ignore: cast_nullable_to_non_nullable
as String?,ne: freezed == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String?,km: freezed == km ? _self.km : km // ignore: cast_nullable_to_non_nullable
as String?,my: freezed == my ? _self.my : my // ignore: cast_nullable_to_non_nullable
as String?,mn: freezed == mn ? _self.mn : mn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalizedName].
extension LocalizedNamePatterns on LocalizedName {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalizedName value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalizedName() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalizedName value)  $default,){
final _that = this;
switch (_that) {
case _LocalizedName():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalizedName value)?  $default,){
final _that = this;
switch (_that) {
case _LocalizedName() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ja,  String? en,  String? zhHans,  String? zhHant,  String? ko,  String? es,  String? pt,  String? id,  String? vi,  String? tl,  String? th,  String? ne,  String? km,  String? my,  String? mn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalizedName() when $default != null:
return $default(_that.ja,_that.en,_that.zhHans,_that.zhHant,_that.ko,_that.es,_that.pt,_that.id,_that.vi,_that.tl,_that.th,_that.ne,_that.km,_that.my,_that.mn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ja,  String? en,  String? zhHans,  String? zhHant,  String? ko,  String? es,  String? pt,  String? id,  String? vi,  String? tl,  String? th,  String? ne,  String? km,  String? my,  String? mn)  $default,) {final _that = this;
switch (_that) {
case _LocalizedName():
return $default(_that.ja,_that.en,_that.zhHans,_that.zhHant,_that.ko,_that.es,_that.pt,_that.id,_that.vi,_that.tl,_that.th,_that.ne,_that.km,_that.my,_that.mn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ja,  String? en,  String? zhHans,  String? zhHant,  String? ko,  String? es,  String? pt,  String? id,  String? vi,  String? tl,  String? th,  String? ne,  String? km,  String? my,  String? mn)?  $default,) {final _that = this;
switch (_that) {
case _LocalizedName() when $default != null:
return $default(_that.ja,_that.en,_that.zhHans,_that.zhHant,_that.ko,_that.es,_that.pt,_that.id,_that.vi,_that.tl,_that.th,_that.ne,_that.km,_that.my,_that.mn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalizedName implements LocalizedName {
  const _LocalizedName({required this.ja, this.en, this.zhHans, this.zhHant, this.ko, this.es, this.pt, this.id, this.vi, this.tl, this.th, this.ne, this.km, this.my, this.mn});
  factory _LocalizedName.fromJson(Map<String, dynamic> json) => _$LocalizedNameFromJson(json);

@override final  String ja;
@override final  String? en;
@override final  String? zhHans;
@override final  String? zhHant;
@override final  String? ko;
@override final  String? es;
@override final  String? pt;
@override final  String? id;
@override final  String? vi;
@override final  String? tl;
@override final  String? th;
@override final  String? ne;
@override final  String? km;
@override final  String? my;
@override final  String? mn;

/// Create a copy of LocalizedName
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedNameCopyWith<_LocalizedName> get copyWith => __$LocalizedNameCopyWithImpl<_LocalizedName>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalizedNameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedName&&(identical(other.ja, ja) || other.ja == ja)&&(identical(other.en, en) || other.en == en)&&(identical(other.zhHans, zhHans) || other.zhHans == zhHans)&&(identical(other.zhHant, zhHant) || other.zhHant == zhHant)&&(identical(other.ko, ko) || other.ko == ko)&&(identical(other.es, es) || other.es == es)&&(identical(other.pt, pt) || other.pt == pt)&&(identical(other.id, id) || other.id == id)&&(identical(other.vi, vi) || other.vi == vi)&&(identical(other.tl, tl) || other.tl == tl)&&(identical(other.th, th) || other.th == th)&&(identical(other.ne, ne) || other.ne == ne)&&(identical(other.km, km) || other.km == km)&&(identical(other.my, my) || other.my == my)&&(identical(other.mn, mn) || other.mn == mn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ja,en,zhHans,zhHant,ko,es,pt,id,vi,tl,th,ne,km,my,mn);

@override
String toString() {
  return 'LocalizedName(ja: $ja, en: $en, zhHans: $zhHans, zhHant: $zhHant, ko: $ko, es: $es, pt: $pt, id: $id, vi: $vi, tl: $tl, th: $th, ne: $ne, km: $km, my: $my, mn: $mn)';
}


}

/// @nodoc
abstract mixin class _$LocalizedNameCopyWith<$Res> implements $LocalizedNameCopyWith<$Res> {
  factory _$LocalizedNameCopyWith(_LocalizedName value, $Res Function(_LocalizedName) _then) = __$LocalizedNameCopyWithImpl;
@override @useResult
$Res call({
 String ja, String? en, String? zhHans, String? zhHant, String? ko, String? es, String? pt, String? id, String? vi, String? tl, String? th, String? ne, String? km, String? my, String? mn
});




}
/// @nodoc
class __$LocalizedNameCopyWithImpl<$Res>
    implements _$LocalizedNameCopyWith<$Res> {
  __$LocalizedNameCopyWithImpl(this._self, this._then);

  final _LocalizedName _self;
  final $Res Function(_LocalizedName) _then;

/// Create a copy of LocalizedName
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ja = null,Object? en = freezed,Object? zhHans = freezed,Object? zhHant = freezed,Object? ko = freezed,Object? es = freezed,Object? pt = freezed,Object? id = freezed,Object? vi = freezed,Object? tl = freezed,Object? th = freezed,Object? ne = freezed,Object? km = freezed,Object? my = freezed,Object? mn = freezed,}) {
  return _then(_LocalizedName(
ja: null == ja ? _self.ja : ja // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,zhHans: freezed == zhHans ? _self.zhHans : zhHans // ignore: cast_nullable_to_non_nullable
as String?,zhHant: freezed == zhHant ? _self.zhHant : zhHant // ignore: cast_nullable_to_non_nullable
as String?,ko: freezed == ko ? _self.ko : ko // ignore: cast_nullable_to_non_nullable
as String?,es: freezed == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String?,pt: freezed == pt ? _self.pt : pt // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,vi: freezed == vi ? _self.vi : vi // ignore: cast_nullable_to_non_nullable
as String?,tl: freezed == tl ? _self.tl : tl // ignore: cast_nullable_to_non_nullable
as String?,th: freezed == th ? _self.th : th // ignore: cast_nullable_to_non_nullable
as String?,ne: freezed == ne ? _self.ne : ne // ignore: cast_nullable_to_non_nullable
as String?,km: freezed == km ? _self.km : km // ignore: cast_nullable_to_non_nullable
as String?,my: freezed == my ? _self.my : my // ignore: cast_nullable_to_non_nullable
as String?,mn: freezed == mn ? _self.mn : mn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
