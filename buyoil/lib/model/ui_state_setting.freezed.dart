// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIStateSetting {

 int get oilContainer; double get measureOil; double get measureWater; bool get isMotorOn; bool get isValveOn;
/// Create a copy of UIStateSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateSettingCopyWith<UIStateSetting> get copyWith => _$UIStateSettingCopyWithImpl<UIStateSetting>(this as UIStateSetting, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateSetting&&(identical(other.oilContainer, oilContainer) || other.oilContainer == oilContainer)&&(identical(other.measureOil, measureOil) || other.measureOil == measureOil)&&(identical(other.measureWater, measureWater) || other.measureWater == measureWater)&&(identical(other.isMotorOn, isMotorOn) || other.isMotorOn == isMotorOn)&&(identical(other.isValveOn, isValveOn) || other.isValveOn == isValveOn));
}


@override
int get hashCode => Object.hash(runtimeType,oilContainer,measureOil,measureWater,isMotorOn,isValveOn);

@override
String toString() {
  return 'UIStateSetting(oilContainer: $oilContainer, measureOil: $measureOil, measureWater: $measureWater, isMotorOn: $isMotorOn, isValveOn: $isValveOn)';
}


}

/// @nodoc
abstract mixin class $UIStateSettingCopyWith<$Res>  {
  factory $UIStateSettingCopyWith(UIStateSetting value, $Res Function(UIStateSetting) _then) = _$UIStateSettingCopyWithImpl;
@useResult
$Res call({
 int oilContainer, double measureOil, double measureWater, bool isMotorOn, bool isValveOn
});




}
/// @nodoc
class _$UIStateSettingCopyWithImpl<$Res>
    implements $UIStateSettingCopyWith<$Res> {
  _$UIStateSettingCopyWithImpl(this._self, this._then);

  final UIStateSetting _self;
  final $Res Function(UIStateSetting) _then;

/// Create a copy of UIStateSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oilContainer = null,Object? measureOil = null,Object? measureWater = null,Object? isMotorOn = null,Object? isValveOn = null,}) {
  return _then(_self.copyWith(
oilContainer: null == oilContainer ? _self.oilContainer : oilContainer // ignore: cast_nullable_to_non_nullable
as int,measureOil: null == measureOil ? _self.measureOil : measureOil // ignore: cast_nullable_to_non_nullable
as double,measureWater: null == measureWater ? _self.measureWater : measureWater // ignore: cast_nullable_to_non_nullable
as double,isMotorOn: null == isMotorOn ? _self.isMotorOn : isMotorOn // ignore: cast_nullable_to_non_nullable
as bool,isValveOn: null == isValveOn ? _self.isValveOn : isValveOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UIStateSetting].
extension UIStateSettingPatterns on UIStateSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UIStateSettingInit value)?  init,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UIStateSettingInit() when init != null:
return init(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UIStateSettingInit value)  init,}){
final _that = this;
switch (_that) {
case UIStateSettingInit():
return init(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UIStateSettingInit value)?  init,}){
final _that = this;
switch (_that) {
case UIStateSettingInit() when init != null:
return init(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int oilContainer,  double measureOil,  double measureWater,  bool isMotorOn,  bool isValveOn)?  init,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UIStateSettingInit() when init != null:
return init(_that.oilContainer,_that.measureOil,_that.measureWater,_that.isMotorOn,_that.isValveOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int oilContainer,  double measureOil,  double measureWater,  bool isMotorOn,  bool isValveOn)  init,}) {final _that = this;
switch (_that) {
case UIStateSettingInit():
return init(_that.oilContainer,_that.measureOil,_that.measureWater,_that.isMotorOn,_that.isValveOn);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int oilContainer,  double measureOil,  double measureWater,  bool isMotorOn,  bool isValveOn)?  init,}) {final _that = this;
switch (_that) {
case UIStateSettingInit() when init != null:
return init(_that.oilContainer,_that.measureOil,_that.measureWater,_that.isMotorOn,_that.isValveOn);case _:
  return null;

}
}

}

/// @nodoc


class UIStateSettingInit implements UIStateSetting {
  const UIStateSettingInit({this.oilContainer = 0, this.measureOil = 0, this.measureWater = 0, this.isMotorOn = false, this.isValveOn = false});
  

@override@JsonKey() final  int oilContainer;
@override@JsonKey() final  double measureOil;
@override@JsonKey() final  double measureWater;
@override@JsonKey() final  bool isMotorOn;
@override@JsonKey() final  bool isValveOn;

/// Create a copy of UIStateSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateSettingInitCopyWith<UIStateSettingInit> get copyWith => _$UIStateSettingInitCopyWithImpl<UIStateSettingInit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateSettingInit&&(identical(other.oilContainer, oilContainer) || other.oilContainer == oilContainer)&&(identical(other.measureOil, measureOil) || other.measureOil == measureOil)&&(identical(other.measureWater, measureWater) || other.measureWater == measureWater)&&(identical(other.isMotorOn, isMotorOn) || other.isMotorOn == isMotorOn)&&(identical(other.isValveOn, isValveOn) || other.isValveOn == isValveOn));
}


@override
int get hashCode => Object.hash(runtimeType,oilContainer,measureOil,measureWater,isMotorOn,isValveOn);

@override
String toString() {
  return 'UIStateSetting.init(oilContainer: $oilContainer, measureOil: $measureOil, measureWater: $measureWater, isMotorOn: $isMotorOn, isValveOn: $isValveOn)';
}


}

/// @nodoc
abstract mixin class $UIStateSettingInitCopyWith<$Res> implements $UIStateSettingCopyWith<$Res> {
  factory $UIStateSettingInitCopyWith(UIStateSettingInit value, $Res Function(UIStateSettingInit) _then) = _$UIStateSettingInitCopyWithImpl;
@override @useResult
$Res call({
 int oilContainer, double measureOil, double measureWater, bool isMotorOn, bool isValveOn
});




}
/// @nodoc
class _$UIStateSettingInitCopyWithImpl<$Res>
    implements $UIStateSettingInitCopyWith<$Res> {
  _$UIStateSettingInitCopyWithImpl(this._self, this._then);

  final UIStateSettingInit _self;
  final $Res Function(UIStateSettingInit) _then;

/// Create a copy of UIStateSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oilContainer = null,Object? measureOil = null,Object? measureWater = null,Object? isMotorOn = null,Object? isValveOn = null,}) {
  return _then(UIStateSettingInit(
oilContainer: null == oilContainer ? _self.oilContainer : oilContainer // ignore: cast_nullable_to_non_nullable
as int,measureOil: null == measureOil ? _self.measureOil : measureOil // ignore: cast_nullable_to_non_nullable
as double,measureWater: null == measureWater ? _self.measureWater : measureWater // ignore: cast_nullable_to_non_nullable
as double,isMotorOn: null == isMotorOn ? _self.isMotorOn : isMotorOn // ignore: cast_nullable_to_non_nullable
as bool,isValveOn: null == isValveOn ? _self.isValveOn : isValveOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
