// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_state_usb_port.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UIStateUsbPort {

 List<UsbDevice> get availablePorts; UsbDevice? get connectedDevice; UsbPort? get port; PORT_COMMANDS? get lastCommand; int get resetFailCount;
/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateUsbPortCopyWith<UIStateUsbPort> get copyWith => _$UIStateUsbPortCopyWithImpl<UIStateUsbPort>(this as UIStateUsbPort, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateUsbPort&&const DeepCollectionEquality().equals(other.availablePorts, availablePorts)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.port, port) || other.port == port)&&(identical(other.lastCommand, lastCommand) || other.lastCommand == lastCommand)&&(identical(other.resetFailCount, resetFailCount) || other.resetFailCount == resetFailCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(availablePorts),connectedDevice,port,lastCommand,resetFailCount);

@override
String toString() {
  return 'UIStateUsbPort(availablePorts: $availablePorts, connectedDevice: $connectedDevice, port: $port, lastCommand: $lastCommand, resetFailCount: $resetFailCount)';
}


}

/// @nodoc
abstract mixin class $UIStateUsbPortCopyWith<$Res>  {
  factory $UIStateUsbPortCopyWith(UIStateUsbPort value, $Res Function(UIStateUsbPort) _then) = _$UIStateUsbPortCopyWithImpl;
@useResult
$Res call({
 List<UsbDevice> availablePorts, UsbDevice? connectedDevice, UsbPort? port, PORT_COMMANDS? lastCommand, int resetFailCount
});




}
/// @nodoc
class _$UIStateUsbPortCopyWithImpl<$Res>
    implements $UIStateUsbPortCopyWith<$Res> {
  _$UIStateUsbPortCopyWithImpl(this._self, this._then);

  final UIStateUsbPort _self;
  final $Res Function(UIStateUsbPort) _then;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availablePorts = null,Object? connectedDevice = freezed,Object? port = freezed,Object? lastCommand = freezed,Object? resetFailCount = null,}) {
  return _then(_self.copyWith(
availablePorts: null == availablePorts ? _self.availablePorts : availablePorts // ignore: cast_nullable_to_non_nullable
as List<UsbDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as UsbDevice?,port: freezed == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as UsbPort?,lastCommand: freezed == lastCommand ? _self.lastCommand : lastCommand // ignore: cast_nullable_to_non_nullable
as PORT_COMMANDS?,resetFailCount: null == resetFailCount ? _self.resetFailCount : resetFailCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UIStateUsbPort].
extension UIStateUsbPortPatterns on UIStateUsbPort {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UIStateUsbPortInit value)?  init,TResult Function( UIStateUsbPortConnected value)?  connected,TResult Function( UIStateUsbPortLoading value)?  loading,TResult Function( UIStateUsbPortError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UIStateUsbPortInit() when init != null:
return init(_that);case UIStateUsbPortConnected() when connected != null:
return connected(_that);case UIStateUsbPortLoading() when loading != null:
return loading(_that);case UIStateUsbPortError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UIStateUsbPortInit value)  init,required TResult Function( UIStateUsbPortConnected value)  connected,required TResult Function( UIStateUsbPortLoading value)  loading,required TResult Function( UIStateUsbPortError value)  error,}){
final _that = this;
switch (_that) {
case UIStateUsbPortInit():
return init(_that);case UIStateUsbPortConnected():
return connected(_that);case UIStateUsbPortLoading():
return loading(_that);case UIStateUsbPortError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UIStateUsbPortInit value)?  init,TResult? Function( UIStateUsbPortConnected value)?  connected,TResult? Function( UIStateUsbPortLoading value)?  loading,TResult? Function( UIStateUsbPortError value)?  error,}){
final _that = this;
switch (_that) {
case UIStateUsbPortInit() when init != null:
return init(_that);case UIStateUsbPortConnected() when connected != null:
return connected(_that);case UIStateUsbPortLoading() when loading != null:
return loading(_that);case UIStateUsbPortError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  init,TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  connected,TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  loading,TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  String errorMsg,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UIStateUsbPortInit() when init != null:
return init(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortConnected() when connected != null:
return connected(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortLoading() when loading != null:
return loading(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortError() when error != null:
return error(_that.availablePorts,_that.connectedDevice,_that.port,_that.errorMsg,_that.lastCommand,_that.resetFailCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)  init,required TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)  connected,required TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)  loading,required TResult Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  String errorMsg,  PORT_COMMANDS? lastCommand,  int resetFailCount)  error,}) {final _that = this;
switch (_that) {
case UIStateUsbPortInit():
return init(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortConnected():
return connected(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortLoading():
return loading(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortError():
return error(_that.availablePorts,_that.connectedDevice,_that.port,_that.errorMsg,_that.lastCommand,_that.resetFailCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  init,TResult? Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  connected,TResult? Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  loading,TResult? Function( List<UsbDevice> availablePorts,  UsbDevice? connectedDevice,  UsbPort? port,  String errorMsg,  PORT_COMMANDS? lastCommand,  int resetFailCount)?  error,}) {final _that = this;
switch (_that) {
case UIStateUsbPortInit() when init != null:
return init(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortConnected() when connected != null:
return connected(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortLoading() when loading != null:
return loading(_that.availablePorts,_that.connectedDevice,_that.port,_that.lastCommand,_that.resetFailCount);case UIStateUsbPortError() when error != null:
return error(_that.availablePorts,_that.connectedDevice,_that.port,_that.errorMsg,_that.lastCommand,_that.resetFailCount);case _:
  return null;

}
}

}

/// @nodoc


class UIStateUsbPortInit implements UIStateUsbPort {
  const UIStateUsbPortInit({final  List<UsbDevice> availablePorts = const [], this.connectedDevice, this.port, this.lastCommand, this.resetFailCount = 0}): _availablePorts = availablePorts;
  

 final  List<UsbDevice> _availablePorts;
@override@JsonKey() List<UsbDevice> get availablePorts {
  if (_availablePorts is EqualUnmodifiableListView) return _availablePorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePorts);
}

@override final  UsbDevice? connectedDevice;
@override final  UsbPort? port;
@override final  PORT_COMMANDS? lastCommand;
@override@JsonKey() final  int resetFailCount;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateUsbPortInitCopyWith<UIStateUsbPortInit> get copyWith => _$UIStateUsbPortInitCopyWithImpl<UIStateUsbPortInit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateUsbPortInit&&const DeepCollectionEquality().equals(other._availablePorts, _availablePorts)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.port, port) || other.port == port)&&(identical(other.lastCommand, lastCommand) || other.lastCommand == lastCommand)&&(identical(other.resetFailCount, resetFailCount) || other.resetFailCount == resetFailCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availablePorts),connectedDevice,port,lastCommand,resetFailCount);

@override
String toString() {
  return 'UIStateUsbPort.init(availablePorts: $availablePorts, connectedDevice: $connectedDevice, port: $port, lastCommand: $lastCommand, resetFailCount: $resetFailCount)';
}


}

/// @nodoc
abstract mixin class $UIStateUsbPortInitCopyWith<$Res> implements $UIStateUsbPortCopyWith<$Res> {
  factory $UIStateUsbPortInitCopyWith(UIStateUsbPortInit value, $Res Function(UIStateUsbPortInit) _then) = _$UIStateUsbPortInitCopyWithImpl;
@override @useResult
$Res call({
 List<UsbDevice> availablePorts, UsbDevice? connectedDevice, UsbPort? port, PORT_COMMANDS? lastCommand, int resetFailCount
});




}
/// @nodoc
class _$UIStateUsbPortInitCopyWithImpl<$Res>
    implements $UIStateUsbPortInitCopyWith<$Res> {
  _$UIStateUsbPortInitCopyWithImpl(this._self, this._then);

  final UIStateUsbPortInit _self;
  final $Res Function(UIStateUsbPortInit) _then;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availablePorts = null,Object? connectedDevice = freezed,Object? port = freezed,Object? lastCommand = freezed,Object? resetFailCount = null,}) {
  return _then(UIStateUsbPortInit(
availablePorts: null == availablePorts ? _self._availablePorts : availablePorts // ignore: cast_nullable_to_non_nullable
as List<UsbDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as UsbDevice?,port: freezed == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as UsbPort?,lastCommand: freezed == lastCommand ? _self.lastCommand : lastCommand // ignore: cast_nullable_to_non_nullable
as PORT_COMMANDS?,resetFailCount: null == resetFailCount ? _self.resetFailCount : resetFailCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UIStateUsbPortConnected implements UIStateUsbPort {
  const UIStateUsbPortConnected({final  List<UsbDevice> availablePorts = const [], required this.connectedDevice, required this.port, this.lastCommand, this.resetFailCount = 0}): _availablePorts = availablePorts;
  

 final  List<UsbDevice> _availablePorts;
@override@JsonKey() List<UsbDevice> get availablePorts {
  if (_availablePorts is EqualUnmodifiableListView) return _availablePorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePorts);
}

@override final  UsbDevice? connectedDevice;
@override final  UsbPort? port;
@override final  PORT_COMMANDS? lastCommand;
@override@JsonKey() final  int resetFailCount;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateUsbPortConnectedCopyWith<UIStateUsbPortConnected> get copyWith => _$UIStateUsbPortConnectedCopyWithImpl<UIStateUsbPortConnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateUsbPortConnected&&const DeepCollectionEquality().equals(other._availablePorts, _availablePorts)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.port, port) || other.port == port)&&(identical(other.lastCommand, lastCommand) || other.lastCommand == lastCommand)&&(identical(other.resetFailCount, resetFailCount) || other.resetFailCount == resetFailCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availablePorts),connectedDevice,port,lastCommand,resetFailCount);

@override
String toString() {
  return 'UIStateUsbPort.connected(availablePorts: $availablePorts, connectedDevice: $connectedDevice, port: $port, lastCommand: $lastCommand, resetFailCount: $resetFailCount)';
}


}

/// @nodoc
abstract mixin class $UIStateUsbPortConnectedCopyWith<$Res> implements $UIStateUsbPortCopyWith<$Res> {
  factory $UIStateUsbPortConnectedCopyWith(UIStateUsbPortConnected value, $Res Function(UIStateUsbPortConnected) _then) = _$UIStateUsbPortConnectedCopyWithImpl;
@override @useResult
$Res call({
 List<UsbDevice> availablePorts, UsbDevice? connectedDevice, UsbPort? port, PORT_COMMANDS? lastCommand, int resetFailCount
});




}
/// @nodoc
class _$UIStateUsbPortConnectedCopyWithImpl<$Res>
    implements $UIStateUsbPortConnectedCopyWith<$Res> {
  _$UIStateUsbPortConnectedCopyWithImpl(this._self, this._then);

  final UIStateUsbPortConnected _self;
  final $Res Function(UIStateUsbPortConnected) _then;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availablePorts = null,Object? connectedDevice = freezed,Object? port = freezed,Object? lastCommand = freezed,Object? resetFailCount = null,}) {
  return _then(UIStateUsbPortConnected(
availablePorts: null == availablePorts ? _self._availablePorts : availablePorts // ignore: cast_nullable_to_non_nullable
as List<UsbDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as UsbDevice?,port: freezed == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as UsbPort?,lastCommand: freezed == lastCommand ? _self.lastCommand : lastCommand // ignore: cast_nullable_to_non_nullable
as PORT_COMMANDS?,resetFailCount: null == resetFailCount ? _self.resetFailCount : resetFailCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UIStateUsbPortLoading implements UIStateUsbPort {
  const UIStateUsbPortLoading({final  List<UsbDevice> availablePorts = const [], required this.connectedDevice, this.port, this.lastCommand, this.resetFailCount = 0}): _availablePorts = availablePorts;
  

 final  List<UsbDevice> _availablePorts;
@override@JsonKey() List<UsbDevice> get availablePorts {
  if (_availablePorts is EqualUnmodifiableListView) return _availablePorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePorts);
}

@override final  UsbDevice? connectedDevice;
@override final  UsbPort? port;
@override final  PORT_COMMANDS? lastCommand;
@override@JsonKey() final  int resetFailCount;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateUsbPortLoadingCopyWith<UIStateUsbPortLoading> get copyWith => _$UIStateUsbPortLoadingCopyWithImpl<UIStateUsbPortLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateUsbPortLoading&&const DeepCollectionEquality().equals(other._availablePorts, _availablePorts)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.port, port) || other.port == port)&&(identical(other.lastCommand, lastCommand) || other.lastCommand == lastCommand)&&(identical(other.resetFailCount, resetFailCount) || other.resetFailCount == resetFailCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availablePorts),connectedDevice,port,lastCommand,resetFailCount);

@override
String toString() {
  return 'UIStateUsbPort.loading(availablePorts: $availablePorts, connectedDevice: $connectedDevice, port: $port, lastCommand: $lastCommand, resetFailCount: $resetFailCount)';
}


}

/// @nodoc
abstract mixin class $UIStateUsbPortLoadingCopyWith<$Res> implements $UIStateUsbPortCopyWith<$Res> {
  factory $UIStateUsbPortLoadingCopyWith(UIStateUsbPortLoading value, $Res Function(UIStateUsbPortLoading) _then) = _$UIStateUsbPortLoadingCopyWithImpl;
@override @useResult
$Res call({
 List<UsbDevice> availablePorts, UsbDevice? connectedDevice, UsbPort? port, PORT_COMMANDS? lastCommand, int resetFailCount
});




}
/// @nodoc
class _$UIStateUsbPortLoadingCopyWithImpl<$Res>
    implements $UIStateUsbPortLoadingCopyWith<$Res> {
  _$UIStateUsbPortLoadingCopyWithImpl(this._self, this._then);

  final UIStateUsbPortLoading _self;
  final $Res Function(UIStateUsbPortLoading) _then;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availablePorts = null,Object? connectedDevice = freezed,Object? port = freezed,Object? lastCommand = freezed,Object? resetFailCount = null,}) {
  return _then(UIStateUsbPortLoading(
availablePorts: null == availablePorts ? _self._availablePorts : availablePorts // ignore: cast_nullable_to_non_nullable
as List<UsbDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as UsbDevice?,port: freezed == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as UsbPort?,lastCommand: freezed == lastCommand ? _self.lastCommand : lastCommand // ignore: cast_nullable_to_non_nullable
as PORT_COMMANDS?,resetFailCount: null == resetFailCount ? _self.resetFailCount : resetFailCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UIStateUsbPortError implements UIStateUsbPort {
  const UIStateUsbPortError({final  List<UsbDevice> availablePorts = const [], this.connectedDevice, this.port, required this.errorMsg, this.lastCommand, this.resetFailCount = 0}): _availablePorts = availablePorts;
  

 final  List<UsbDevice> _availablePorts;
@override@JsonKey() List<UsbDevice> get availablePorts {
  if (_availablePorts is EqualUnmodifiableListView) return _availablePorts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availablePorts);
}

@override final  UsbDevice? connectedDevice;
@override final  UsbPort? port;
 final  String errorMsg;
@override final  PORT_COMMANDS? lastCommand;
@override@JsonKey() final  int resetFailCount;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UIStateUsbPortErrorCopyWith<UIStateUsbPortError> get copyWith => _$UIStateUsbPortErrorCopyWithImpl<UIStateUsbPortError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UIStateUsbPortError&&const DeepCollectionEquality().equals(other._availablePorts, _availablePorts)&&(identical(other.connectedDevice, connectedDevice) || other.connectedDevice == connectedDevice)&&(identical(other.port, port) || other.port == port)&&(identical(other.errorMsg, errorMsg) || other.errorMsg == errorMsg)&&(identical(other.lastCommand, lastCommand) || other.lastCommand == lastCommand)&&(identical(other.resetFailCount, resetFailCount) || other.resetFailCount == resetFailCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availablePorts),connectedDevice,port,errorMsg,lastCommand,resetFailCount);

@override
String toString() {
  return 'UIStateUsbPort.error(availablePorts: $availablePorts, connectedDevice: $connectedDevice, port: $port, errorMsg: $errorMsg, lastCommand: $lastCommand, resetFailCount: $resetFailCount)';
}


}

/// @nodoc
abstract mixin class $UIStateUsbPortErrorCopyWith<$Res> implements $UIStateUsbPortCopyWith<$Res> {
  factory $UIStateUsbPortErrorCopyWith(UIStateUsbPortError value, $Res Function(UIStateUsbPortError) _then) = _$UIStateUsbPortErrorCopyWithImpl;
@override @useResult
$Res call({
 List<UsbDevice> availablePorts, UsbDevice? connectedDevice, UsbPort? port, String errorMsg, PORT_COMMANDS? lastCommand, int resetFailCount
});




}
/// @nodoc
class _$UIStateUsbPortErrorCopyWithImpl<$Res>
    implements $UIStateUsbPortErrorCopyWith<$Res> {
  _$UIStateUsbPortErrorCopyWithImpl(this._self, this._then);

  final UIStateUsbPortError _self;
  final $Res Function(UIStateUsbPortError) _then;

/// Create a copy of UIStateUsbPort
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availablePorts = null,Object? connectedDevice = freezed,Object? port = freezed,Object? errorMsg = null,Object? lastCommand = freezed,Object? resetFailCount = null,}) {
  return _then(UIStateUsbPortError(
availablePorts: null == availablePorts ? _self._availablePorts : availablePorts // ignore: cast_nullable_to_non_nullable
as List<UsbDevice>,connectedDevice: freezed == connectedDevice ? _self.connectedDevice : connectedDevice // ignore: cast_nullable_to_non_nullable
as UsbDevice?,port: freezed == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as UsbPort?,errorMsg: null == errorMsg ? _self.errorMsg : errorMsg // ignore: cast_nullable_to_non_nullable
as String,lastCommand: freezed == lastCommand ? _self.lastCommand : lastCommand // ignore: cast_nullable_to_non_nullable
as PORT_COMMANDS?,resetFailCount: null == resetFailCount ? _self.resetFailCount : resetFailCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
