// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'license_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LicenseEditorOutcome {

 int get seq; LicenseEditorAction get action; String? get errorKey;/// After a revoke: the end date to restore on undo.
 DateTime? get undoUntil;
/// Create a copy of LicenseEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseEditorOutcomeCopyWith<LicenseEditorOutcome> get copyWith => _$LicenseEditorOutcomeCopyWithImpl<LicenseEditorOutcome>(this as LicenseEditorOutcome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseEditorOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.action, action) || other.action == action)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&(identical(other.undoUntil, undoUntil) || other.undoUntil == undoUntil));
}


@override
int get hashCode => Object.hash(runtimeType,seq,action,errorKey,undoUntil);

@override
String toString() {
  return 'LicenseEditorOutcome(seq: $seq, action: $action, errorKey: $errorKey, undoUntil: $undoUntil)';
}


}

/// @nodoc
abstract mixin class $LicenseEditorOutcomeCopyWith<$Res>  {
  factory $LicenseEditorOutcomeCopyWith(LicenseEditorOutcome value, $Res Function(LicenseEditorOutcome) _then) = _$LicenseEditorOutcomeCopyWithImpl;
@useResult
$Res call({
 int seq, LicenseEditorAction action, String? errorKey, DateTime? undoUntil
});




}
/// @nodoc
class _$LicenseEditorOutcomeCopyWithImpl<$Res>
    implements $LicenseEditorOutcomeCopyWith<$Res> {
  _$LicenseEditorOutcomeCopyWithImpl(this._self, this._then);

  final LicenseEditorOutcome _self;
  final $Res Function(LicenseEditorOutcome) _then;

/// Create a copy of LicenseEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? action = null,Object? errorKey = freezed,Object? undoUntil = freezed,}) {
  return _then(_self.copyWith(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as LicenseEditorAction,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,undoUntil: freezed == undoUntil ? _self.undoUntil : undoUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LicenseEditorOutcome].
extension LicenseEditorOutcomePatterns on LicenseEditorOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseEditorOutcome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseEditorOutcome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseEditorOutcome value)  $default,){
final _that = this;
switch (_that) {
case _LicenseEditorOutcome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseEditorOutcome value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseEditorOutcome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  LicenseEditorAction action,  String? errorKey,  DateTime? undoUntil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseEditorOutcome() when $default != null:
return $default(_that.seq,_that.action,_that.errorKey,_that.undoUntil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  LicenseEditorAction action,  String? errorKey,  DateTime? undoUntil)  $default,) {final _that = this;
switch (_that) {
case _LicenseEditorOutcome():
return $default(_that.seq,_that.action,_that.errorKey,_that.undoUntil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  LicenseEditorAction action,  String? errorKey,  DateTime? undoUntil)?  $default,) {final _that = this;
switch (_that) {
case _LicenseEditorOutcome() when $default != null:
return $default(_that.seq,_that.action,_that.errorKey,_that.undoUntil);case _:
  return null;

}
}

}

/// @nodoc


class _LicenseEditorOutcome implements LicenseEditorOutcome {
  const _LicenseEditorOutcome({required this.seq, required this.action, this.errorKey, this.undoUntil});
  

@override final  int seq;
@override final  LicenseEditorAction action;
@override final  String? errorKey;
/// After a revoke: the end date to restore on undo.
@override final  DateTime? undoUntil;

/// Create a copy of LicenseEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseEditorOutcomeCopyWith<_LicenseEditorOutcome> get copyWith => __$LicenseEditorOutcomeCopyWithImpl<_LicenseEditorOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseEditorOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.action, action) || other.action == action)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&(identical(other.undoUntil, undoUntil) || other.undoUntil == undoUntil));
}


@override
int get hashCode => Object.hash(runtimeType,seq,action,errorKey,undoUntil);

@override
String toString() {
  return 'LicenseEditorOutcome(seq: $seq, action: $action, errorKey: $errorKey, undoUntil: $undoUntil)';
}


}

/// @nodoc
abstract mixin class _$LicenseEditorOutcomeCopyWith<$Res> implements $LicenseEditorOutcomeCopyWith<$Res> {
  factory _$LicenseEditorOutcomeCopyWith(_LicenseEditorOutcome value, $Res Function(_LicenseEditorOutcome) _then) = __$LicenseEditorOutcomeCopyWithImpl;
@override @useResult
$Res call({
 int seq, LicenseEditorAction action, String? errorKey, DateTime? undoUntil
});




}
/// @nodoc
class __$LicenseEditorOutcomeCopyWithImpl<$Res>
    implements _$LicenseEditorOutcomeCopyWith<$Res> {
  __$LicenseEditorOutcomeCopyWithImpl(this._self, this._then);

  final _LicenseEditorOutcome _self;
  final $Res Function(_LicenseEditorOutcome) _then;

/// Create a copy of LicenseEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? action = null,Object? errorKey = freezed,Object? undoUntil = freezed,}) {
  return _then(_LicenseEditorOutcome(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as LicenseEditorAction,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,undoUntil: freezed == undoUntil ? _self.undoUntil : undoUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$LicenseEditorState {

 RequestStatus get loadStatus; String? get loadErrorKey; LicenseModel? get license;/// Chosen end date for approve / extend (end of day, local).
 DateTime? get draftUntil;/// The preset chip that produced [draftUntil], if any.
 int? get selectedPreset; String get fullName; String get phoneNumber; String get note;/// Bumped when the profile draft is replaced from the server, so the
/// text fields reload their controllers.
 int get formVersion; RequestStatus get accessStatus; RequestStatus get profileStatus; LicenseEditorOutcome? get lastOutcome;
/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseEditorStateCopyWith<LicenseEditorState> get copyWith => _$LicenseEditorStateCopyWithImpl<LicenseEditorState>(this as LicenseEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseEditorState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorKey, loadErrorKey) || other.loadErrorKey == loadErrorKey)&&(identical(other.license, license) || other.license == license)&&(identical(other.draftUntil, draftUntil) || other.draftUntil == draftUntil)&&(identical(other.selectedPreset, selectedPreset) || other.selectedPreset == selectedPreset)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.note, note) || other.note == note)&&(identical(other.formVersion, formVersion) || other.formVersion == formVersion)&&(identical(other.accessStatus, accessStatus) || other.accessStatus == accessStatus)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,loadErrorKey,license,draftUntil,selectedPreset,fullName,phoneNumber,note,formVersion,accessStatus,profileStatus,lastOutcome);

@override
String toString() {
  return 'LicenseEditorState(loadStatus: $loadStatus, loadErrorKey: $loadErrorKey, license: $license, draftUntil: $draftUntil, selectedPreset: $selectedPreset, fullName: $fullName, phoneNumber: $phoneNumber, note: $note, formVersion: $formVersion, accessStatus: $accessStatus, profileStatus: $profileStatus, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class $LicenseEditorStateCopyWith<$Res>  {
  factory $LicenseEditorStateCopyWith(LicenseEditorState value, $Res Function(LicenseEditorState) _then) = _$LicenseEditorStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus loadStatus, String? loadErrorKey, LicenseModel? license, DateTime? draftUntil, int? selectedPreset, String fullName, String phoneNumber, String note, int formVersion, RequestStatus accessStatus, RequestStatus profileStatus, LicenseEditorOutcome? lastOutcome
});


$LicenseModelCopyWith<$Res>? get license;$LicenseEditorOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class _$LicenseEditorStateCopyWithImpl<$Res>
    implements $LicenseEditorStateCopyWith<$Res> {
  _$LicenseEditorStateCopyWithImpl(this._self, this._then);

  final LicenseEditorState _self;
  final $Res Function(LicenseEditorState) _then;

/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadStatus = null,Object? loadErrorKey = freezed,Object? license = freezed,Object? draftUntil = freezed,Object? selectedPreset = freezed,Object? fullName = null,Object? phoneNumber = null,Object? note = null,Object? formVersion = null,Object? accessStatus = null,Object? profileStatus = null,Object? lastOutcome = freezed,}) {
  return _then(_self.copyWith(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,loadErrorKey: freezed == loadErrorKey ? _self.loadErrorKey : loadErrorKey // ignore: cast_nullable_to_non_nullable
as String?,license: freezed == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as LicenseModel?,draftUntil: freezed == draftUntil ? _self.draftUntil : draftUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedPreset: freezed == selectedPreset ? _self.selectedPreset : selectedPreset // ignore: cast_nullable_to_non_nullable
as int?,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,formVersion: null == formVersion ? _self.formVersion : formVersion // ignore: cast_nullable_to_non_nullable
as int,accessStatus: null == accessStatus ? _self.accessStatus : accessStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as LicenseEditorOutcome?,
  ));
}
/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseModelCopyWith<$Res>? get license {
    if (_self.license == null) {
    return null;
  }

  return $LicenseModelCopyWith<$Res>(_self.license!, (value) {
    return _then(_self.copyWith(license: value));
  });
}/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseEditorOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $LicenseEditorOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}


/// Adds pattern-matching-related methods to [LicenseEditorState].
extension LicenseEditorStatePatterns on LicenseEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseEditorState value)  $default,){
final _that = this;
switch (_that) {
case _LicenseEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus loadStatus,  String? loadErrorKey,  LicenseModel? license,  DateTime? draftUntil,  int? selectedPreset,  String fullName,  String phoneNumber,  String note,  int formVersion,  RequestStatus accessStatus,  RequestStatus profileStatus,  LicenseEditorOutcome? lastOutcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseEditorState() when $default != null:
return $default(_that.loadStatus,_that.loadErrorKey,_that.license,_that.draftUntil,_that.selectedPreset,_that.fullName,_that.phoneNumber,_that.note,_that.formVersion,_that.accessStatus,_that.profileStatus,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus loadStatus,  String? loadErrorKey,  LicenseModel? license,  DateTime? draftUntil,  int? selectedPreset,  String fullName,  String phoneNumber,  String note,  int formVersion,  RequestStatus accessStatus,  RequestStatus profileStatus,  LicenseEditorOutcome? lastOutcome)  $default,) {final _that = this;
switch (_that) {
case _LicenseEditorState():
return $default(_that.loadStatus,_that.loadErrorKey,_that.license,_that.draftUntil,_that.selectedPreset,_that.fullName,_that.phoneNumber,_that.note,_that.formVersion,_that.accessStatus,_that.profileStatus,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus loadStatus,  String? loadErrorKey,  LicenseModel? license,  DateTime? draftUntil,  int? selectedPreset,  String fullName,  String phoneNumber,  String note,  int formVersion,  RequestStatus accessStatus,  RequestStatus profileStatus,  LicenseEditorOutcome? lastOutcome)?  $default,) {final _that = this;
switch (_that) {
case _LicenseEditorState() when $default != null:
return $default(_that.loadStatus,_that.loadErrorKey,_that.license,_that.draftUntil,_that.selectedPreset,_that.fullName,_that.phoneNumber,_that.note,_that.formVersion,_that.accessStatus,_that.profileStatus,_that.lastOutcome);case _:
  return null;

}
}

}

/// @nodoc


class _LicenseEditorState extends LicenseEditorState {
  const _LicenseEditorState({this.loadStatus = RequestStatus.init, this.loadErrorKey, this.license, this.draftUntil, this.selectedPreset, this.fullName = '', this.phoneNumber = '', this.note = '', this.formVersion = 0, this.accessStatus = RequestStatus.init, this.profileStatus = RequestStatus.init, this.lastOutcome}): super._();
  

@override@JsonKey() final  RequestStatus loadStatus;
@override final  String? loadErrorKey;
@override final  LicenseModel? license;
/// Chosen end date for approve / extend (end of day, local).
@override final  DateTime? draftUntil;
/// The preset chip that produced [draftUntil], if any.
@override final  int? selectedPreset;
@override@JsonKey() final  String fullName;
@override@JsonKey() final  String phoneNumber;
@override@JsonKey() final  String note;
/// Bumped when the profile draft is replaced from the server, so the
/// text fields reload their controllers.
@override@JsonKey() final  int formVersion;
@override@JsonKey() final  RequestStatus accessStatus;
@override@JsonKey() final  RequestStatus profileStatus;
@override final  LicenseEditorOutcome? lastOutcome;

/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseEditorStateCopyWith<_LicenseEditorState> get copyWith => __$LicenseEditorStateCopyWithImpl<_LicenseEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseEditorState&&(identical(other.loadStatus, loadStatus) || other.loadStatus == loadStatus)&&(identical(other.loadErrorKey, loadErrorKey) || other.loadErrorKey == loadErrorKey)&&(identical(other.license, license) || other.license == license)&&(identical(other.draftUntil, draftUntil) || other.draftUntil == draftUntil)&&(identical(other.selectedPreset, selectedPreset) || other.selectedPreset == selectedPreset)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.note, note) || other.note == note)&&(identical(other.formVersion, formVersion) || other.formVersion == formVersion)&&(identical(other.accessStatus, accessStatus) || other.accessStatus == accessStatus)&&(identical(other.profileStatus, profileStatus) || other.profileStatus == profileStatus)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,loadStatus,loadErrorKey,license,draftUntil,selectedPreset,fullName,phoneNumber,note,formVersion,accessStatus,profileStatus,lastOutcome);

@override
String toString() {
  return 'LicenseEditorState(loadStatus: $loadStatus, loadErrorKey: $loadErrorKey, license: $license, draftUntil: $draftUntil, selectedPreset: $selectedPreset, fullName: $fullName, phoneNumber: $phoneNumber, note: $note, formVersion: $formVersion, accessStatus: $accessStatus, profileStatus: $profileStatus, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class _$LicenseEditorStateCopyWith<$Res> implements $LicenseEditorStateCopyWith<$Res> {
  factory _$LicenseEditorStateCopyWith(_LicenseEditorState value, $Res Function(_LicenseEditorState) _then) = __$LicenseEditorStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus loadStatus, String? loadErrorKey, LicenseModel? license, DateTime? draftUntil, int? selectedPreset, String fullName, String phoneNumber, String note, int formVersion, RequestStatus accessStatus, RequestStatus profileStatus, LicenseEditorOutcome? lastOutcome
});


@override $LicenseModelCopyWith<$Res>? get license;@override $LicenseEditorOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class __$LicenseEditorStateCopyWithImpl<$Res>
    implements _$LicenseEditorStateCopyWith<$Res> {
  __$LicenseEditorStateCopyWithImpl(this._self, this._then);

  final _LicenseEditorState _self;
  final $Res Function(_LicenseEditorState) _then;

/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadStatus = null,Object? loadErrorKey = freezed,Object? license = freezed,Object? draftUntil = freezed,Object? selectedPreset = freezed,Object? fullName = null,Object? phoneNumber = null,Object? note = null,Object? formVersion = null,Object? accessStatus = null,Object? profileStatus = null,Object? lastOutcome = freezed,}) {
  return _then(_LicenseEditorState(
loadStatus: null == loadStatus ? _self.loadStatus : loadStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,loadErrorKey: freezed == loadErrorKey ? _self.loadErrorKey : loadErrorKey // ignore: cast_nullable_to_non_nullable
as String?,license: freezed == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as LicenseModel?,draftUntil: freezed == draftUntil ? _self.draftUntil : draftUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedPreset: freezed == selectedPreset ? _self.selectedPreset : selectedPreset // ignore: cast_nullable_to_non_nullable
as int?,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,formVersion: null == formVersion ? _self.formVersion : formVersion // ignore: cast_nullable_to_non_nullable
as int,accessStatus: null == accessStatus ? _self.accessStatus : accessStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,profileStatus: null == profileStatus ? _self.profileStatus : profileStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as LicenseEditorOutcome?,
  ));
}

/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseModelCopyWith<$Res>? get license {
    if (_self.license == null) {
    return null;
  }

  return $LicenseModelCopyWith<$Res>(_self.license!, (value) {
    return _then(_self.copyWith(license: value));
  });
}/// Create a copy of LicenseEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseEditorOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $LicenseEditorOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}

// dart format on
