// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_step1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIStateStep1 {

 String get phoneNumber; String get rfidNumber; TextEditingController get controller; bool get showErrorToast;
/// Create a copy of UIStateStep1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateStep1CopyWith<UIStateStep1> get copyWith => _$UIStateStep1CopyWithImpl<UIStateStep1>(this as UIStateStep1, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateStep1&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.rfidNumber, rfidNumber) || other.rfidNumber == rfidNumber)&&(identical(other.controller, controller) || other.controller == controller)&&(identical(other.showErrorToast, showErrorToast) || other.showErrorToast == showErrorToast));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,rfidNumber,controller,showErrorToast);

@override
String toString() {
  return 'UIStateStep1(phoneNumber: $phoneNumber, rfidNumber: $rfidNumber, controller: $controller, showErrorToast: $showErrorToast)';
}


}

/// @nodoc
abstract mixin class $UIStateStep1CopyWith<$Res>  {
  factory $UIStateStep1CopyWith(UIStateStep1 value, $Res Function(UIStateStep1) _then) = _$UIStateStep1CopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String rfidNumber, TextEditingController controller, bool showErrorToast
});




}
/// @nodoc
class _$UIStateStep1CopyWithImpl<$Res>
    implements $UIStateStep1CopyWith<$Res> {
  _$UIStateStep1CopyWithImpl(this._self, this._then);

  final UIStateStep1 _self;
  final $Res Function(UIStateStep1) _then;

/// Create a copy of UIStateStep1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? rfidNumber = null,Object? controller = null,Object? showErrorToast = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,rfidNumber: null == rfidNumber ? _self.rfidNumber : rfidNumber // ignore: cast_nullable_to_non_nullable
as String,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as TextEditingController,showErrorToast: null == showErrorToast ? _self.showErrorToast : showErrorToast // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UIStateStep1].
extension UIStateStep1Patterns on UIStateStep1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UIStateStep1Input value)?  input,TResult Function( UIStateStep1Completed value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UIStateStep1Input() when input != null:
return input(_that);case UIStateStep1Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UIStateStep1Input value)  input,required TResult Function( UIStateStep1Completed value)  completed,}){
final _that = this;
switch (_that) {
case UIStateStep1Input():
return input(_that);case UIStateStep1Completed():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UIStateStep1Input value)?  input,TResult? Function( UIStateStep1Completed value)?  completed,}){
final _that = this;
switch (_that) {
case UIStateStep1Input() when input != null:
return input(_that);case UIStateStep1Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String phoneNumber,  String rfidNumber,  TextEditingController controller,  bool showErrorToast)?  input,TResult Function( String phoneNumber,  String rfidNumber,  TextEditingController controller,  bool showErrorToast)?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UIStateStep1Input() when input != null:
return input(_that.phoneNumber,_that.rfidNumber,_that.controller,_that.showErrorToast);case UIStateStep1Completed() when completed != null:
return completed(_that.phoneNumber,_that.rfidNumber,_that.controller,_that.showErrorToast);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String phoneNumber,  String rfidNumber,  TextEditingController controller,  bool showErrorToast)  input,required TResult Function( String phoneNumber,  String rfidNumber,  TextEditingController controller,  bool showErrorToast)  completed,}) {final _that = this;
switch (_that) {
case UIStateStep1Input():
return input(_that.phoneNumber,_that.rfidNumber,_that.controller,_that.showErrorToast);case UIStateStep1Completed():
return completed(_that.phoneNumber,_that.rfidNumber,_that.controller,_that.showErrorToast);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String phoneNumber,  String rfidNumber,  TextEditingController controller,  bool showErrorToast)?  input,TResult? Function( String phoneNumber,  String rfidNumber,  TextEditingController controller,  bool showErrorToast)?  completed,}) {final _that = this;
switch (_that) {
case UIStateStep1Input() when input != null:
return input(_that.phoneNumber,_that.rfidNumber,_that.controller,_that.showErrorToast);case UIStateStep1Completed() when completed != null:
return completed(_that.phoneNumber,_that.rfidNumber,_that.controller,_that.showErrorToast);case _:
  return null;

}
}

}

/// @nodoc


class UIStateStep1Input implements UIStateStep1 {
  const UIStateStep1Input({this.phoneNumber = "", this.rfidNumber = "", required this.controller, this.showErrorToast = false});
  

@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String rfidNumber;
@override final  TextEditingController controller;
@override@JsonKey() final  bool showErrorToast;

/// Create a copy of UIStateStep1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateStep1InputCopyWith<UIStateStep1Input> get copyWith => _$UIStateStep1InputCopyWithImpl<UIStateStep1Input>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateStep1Input&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.rfidNumber, rfidNumber) || other.rfidNumber == rfidNumber)&&(identical(other.controller, controller) || other.controller == controller)&&(identical(other.showErrorToast, showErrorToast) || other.showErrorToast == showErrorToast));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,rfidNumber,controller,showErrorToast);

@override
String toString() {
  return 'UIStateStep1.input(phoneNumber: $phoneNumber, rfidNumber: $rfidNumber, controller: $controller, showErrorToast: $showErrorToast)';
}


}

/// @nodoc
abstract mixin class $UIStateStep1InputCopyWith<$Res> implements $UIStateStep1CopyWith<$Res> {
  factory $UIStateStep1InputCopyWith(UIStateStep1Input value, $Res Function(UIStateStep1Input) _then) = _$UIStateStep1InputCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String rfidNumber, TextEditingController controller, bool showErrorToast
});




}
/// @nodoc
class _$UIStateStep1InputCopyWithImpl<$Res>
    implements $UIStateStep1InputCopyWith<$Res> {
  _$UIStateStep1InputCopyWithImpl(this._self, this._then);

  final UIStateStep1Input _self;
  final $Res Function(UIStateStep1Input) _then;

/// Create a copy of UIStateStep1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? rfidNumber = null,Object? controller = null,Object? showErrorToast = null,}) {
  return _then(UIStateStep1Input(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,rfidNumber: null == rfidNumber ? _self.rfidNumber : rfidNumber // ignore: cast_nullable_to_non_nullable
as String,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as TextEditingController,showErrorToast: null == showErrorToast ? _self.showErrorToast : showErrorToast // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class UIStateStep1Completed implements UIStateStep1 {
  const UIStateStep1Completed({this.phoneNumber = "", this.rfidNumber = "", required this.controller, this.showErrorToast = false});
  

@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String rfidNumber;
@override final  TextEditingController controller;
@override@JsonKey() final  bool showErrorToast;

/// Create a copy of UIStateStep1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateStep1CompletedCopyWith<UIStateStep1Completed> get copyWith => _$UIStateStep1CompletedCopyWithImpl<UIStateStep1Completed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateStep1Completed&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.rfidNumber, rfidNumber) || other.rfidNumber == rfidNumber)&&(identical(other.controller, controller) || other.controller == controller)&&(identical(other.showErrorToast, showErrorToast) || other.showErrorToast == showErrorToast));
}


@override
int get hashCode => Object.hash(runtimeType,phoneNumber,rfidNumber,controller,showErrorToast);

@override
String toString() {
  return 'UIStateStep1.completed(phoneNumber: $phoneNumber, rfidNumber: $rfidNumber, controller: $controller, showErrorToast: $showErrorToast)';
}


}

/// @nodoc
abstract mixin class $UIStateStep1CompletedCopyWith<$Res> implements $UIStateStep1CopyWith<$Res> {
  factory $UIStateStep1CompletedCopyWith(UIStateStep1Completed value, $Res Function(UIStateStep1Completed) _then) = _$UIStateStep1CompletedCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String rfidNumber, TextEditingController controller, bool showErrorToast
});




}
/// @nodoc
class _$UIStateStep1CompletedCopyWithImpl<$Res>
    implements $UIStateStep1CompletedCopyWith<$Res> {
  _$UIStateStep1CompletedCopyWithImpl(this._self, this._then);

  final UIStateStep1Completed _self;
  final $Res Function(UIStateStep1Completed) _then;

/// Create a copy of UIStateStep1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? rfidNumber = null,Object? controller = null,Object? showErrorToast = null,}) {
  return _then(UIStateStep1Completed(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,rfidNumber: null == rfidNumber ? _self.rfidNumber : rfidNumber // ignore: cast_nullable_to_non_nullable
as String,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as TextEditingController,showErrorToast: null == showErrorToast ? _self.showErrorToast : showErrorToast // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
