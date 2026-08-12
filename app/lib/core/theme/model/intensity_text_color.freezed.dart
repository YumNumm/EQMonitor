// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intensity_text_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
IntensityTextColor _$IntensityTextColorFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'auto':
          return IntensityTextColorAuto.fromJson(
            json
          );
                case 'manual':
          return IntensityTextColorManual.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'IntensityTextColor',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$IntensityTextColor {



  /// Serializes this IntensityTextColor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityTextColor);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntensityTextColor()';
}


}

/// @nodoc
class $IntensityTextColorCopyWith<$Res>  {
$IntensityTextColorCopyWith(IntensityTextColor _, $Res Function(IntensityTextColor) __);
}


/// Adds pattern-matching-related methods to [IntensityTextColor].
extension IntensityTextColorPatterns on IntensityTextColor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IntensityTextColorAuto value)?  auto,TResult Function( IntensityTextColorManual value)?  manual,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IntensityTextColorAuto() when auto != null:
return auto(_that);case IntensityTextColorManual() when manual != null:
return manual(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IntensityTextColorAuto value)  auto,required TResult Function( IntensityTextColorManual value)  manual,}){
final _that = this;
switch (_that) {
case IntensityTextColorAuto():
return auto(_that);case IntensityTextColorManual():
return manual(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IntensityTextColorAuto value)?  auto,TResult? Function( IntensityTextColorManual value)?  manual,}){
final _that = this;
switch (_that) {
case IntensityTextColorAuto() when auto != null:
return auto(_that);case IntensityTextColorManual() when manual != null:
return manual(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  auto,TResult Function(@ColorJsonConverter()  Color color)?  manual,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IntensityTextColorAuto() when auto != null:
return auto();case IntensityTextColorManual() when manual != null:
return manual(_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  auto,required TResult Function(@ColorJsonConverter()  Color color)  manual,}) {final _that = this;
switch (_that) {
case IntensityTextColorAuto():
return auto();case IntensityTextColorManual():
return manual(_that.color);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  auto,TResult? Function(@ColorJsonConverter()  Color color)?  manual,}) {final _that = this;
switch (_that) {
case IntensityTextColorAuto() when auto != null:
return auto();case IntensityTextColorManual() when manual != null:
return manual(_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class IntensityTextColorAuto implements IntensityTextColor {
  const IntensityTextColorAuto({ String? $type}): $type = $type ?? 'auto';
  factory IntensityTextColorAuto.fromJson(Map<String, dynamic> json) => _$IntensityTextColorAutoFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$IntensityTextColorAutoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityTextColorAuto);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntensityTextColor.auto()';
}


}




/// @nodoc
@JsonSerializable()

class IntensityTextColorManual implements IntensityTextColor {
  const IntensityTextColorManual({@ColorJsonConverter() required this.color,  String? $type}): $type = $type ?? 'manual';
  factory IntensityTextColorManual.fromJson(Map<String, dynamic> json) => _$IntensityTextColorManualFromJson(json);

@ColorJsonConverter() final  Color color;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of IntensityTextColor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntensityTextColorManualCopyWith<IntensityTextColorManual> get copyWith => _$IntensityTextColorManualCopyWithImpl<IntensityTextColorManual>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntensityTextColorManualToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntensityTextColorManual&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color);

@override
String toString() {
  return 'IntensityTextColor.manual(color: $color)';
}


}

/// @nodoc
abstract mixin class $IntensityTextColorManualCopyWith<$Res> implements $IntensityTextColorCopyWith<$Res> {
  factory $IntensityTextColorManualCopyWith(IntensityTextColorManual value, $Res Function(IntensityTextColorManual) _then) = _$IntensityTextColorManualCopyWithImpl;
@useResult
$Res call({
@ColorJsonConverter() Color color
});




}
/// @nodoc
class _$IntensityTextColorManualCopyWithImpl<$Res>
    implements $IntensityTextColorManualCopyWith<$Res> {
  _$IntensityTextColorManualCopyWithImpl(this._self, this._then);

  final IntensityTextColorManual _self;
  final $Res Function(IntensityTextColorManual) _then;

/// Create a copy of IntensityTextColor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? color = null,}) {
  return _then(IntensityTextColorManual(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
