// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_step2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIStateStep2 {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateStep2);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UIStateStep2()';
}


}

/// @nodoc
class $UIStateStep2CopyWith<$Res>  {
$UIStateStep2CopyWith(UIStateStep2 _, $Res Function(UIStateStep2) __);
}


/// Adds pattern-matching-related methods to [UIStateStep2].
extension UIStateStep2Patterns on UIStateStep2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UIStateStep2Init value)?  init,TResult Function( UIStateStep2Completed value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UIStateStep2Init() when init != null:
return init(_that);case UIStateStep2Completed() when completed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UIStateStep2Init value)  init,required TResult Function( UIStateStep2Completed value)  completed,}){
final _that = this;
switch (_that) {
case UIStateStep2Init():
return init(_that);case UIStateStep2Completed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UIStateStep2Init value)?  init,TResult? Function( UIStateStep2Completed value)?  completed,}){
final _that = this;
switch (_that) {
case UIStateStep2Init() when init != null:
return init(_that);case UIStateStep2Completed() when completed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function()?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UIStateStep2Init() when init != null:
return init();case UIStateStep2Completed() when completed != null:
return completed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function()  completed,}) {final _that = this;
switch (_that) {
case UIStateStep2Init():
return init();case UIStateStep2Completed():
return completed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function()?  completed,}) {final _that = this;
switch (_that) {
case UIStateStep2Init() when init != null:
return init();case UIStateStep2Completed() when completed != null:
return completed();case _:
  return null;

}
}

}

/// @nodoc


class UIStateStep2Init implements UIStateStep2 {
  const UIStateStep2Init();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateStep2Init);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UIStateStep2.init()';
}


}




/// @nodoc


class UIStateStep2Completed implements UIStateStep2 {
  const UIStateStep2Completed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateStep2Completed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UIStateStep2.completed()';
}


}




// dart format on
