// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionEditorOutcome {

 int get seq; QuestionEditorAction get action; String? get errorKey;/// After creating: the allocated qid.
 String? get createdQid;
/// Create a copy of QuestionEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionEditorOutcomeCopyWith<QuestionEditorOutcome> get copyWith => _$QuestionEditorOutcomeCopyWithImpl<QuestionEditorOutcome>(this as QuestionEditorOutcome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionEditorOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.action, action) || other.action == action)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&(identical(other.createdQid, createdQid) || other.createdQid == createdQid));
}


@override
int get hashCode => Object.hash(runtimeType,seq,action,errorKey,createdQid);

@override
String toString() {
  return 'QuestionEditorOutcome(seq: $seq, action: $action, errorKey: $errorKey, createdQid: $createdQid)';
}


}

/// @nodoc
abstract mixin class $QuestionEditorOutcomeCopyWith<$Res>  {
  factory $QuestionEditorOutcomeCopyWith(QuestionEditorOutcome value, $Res Function(QuestionEditorOutcome) _then) = _$QuestionEditorOutcomeCopyWithImpl;
@useResult
$Res call({
 int seq, QuestionEditorAction action, String? errorKey, String? createdQid
});




}
/// @nodoc
class _$QuestionEditorOutcomeCopyWithImpl<$Res>
    implements $QuestionEditorOutcomeCopyWith<$Res> {
  _$QuestionEditorOutcomeCopyWithImpl(this._self, this._then);

  final QuestionEditorOutcome _self;
  final $Res Function(QuestionEditorOutcome) _then;

/// Create a copy of QuestionEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? action = null,Object? errorKey = freezed,Object? createdQid = freezed,}) {
  return _then(_self.copyWith(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as QuestionEditorAction,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,createdQid: freezed == createdQid ? _self.createdQid : createdQid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionEditorOutcome].
extension QuestionEditorOutcomePatterns on QuestionEditorOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionEditorOutcome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionEditorOutcome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionEditorOutcome value)  $default,){
final _that = this;
switch (_that) {
case _QuestionEditorOutcome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionEditorOutcome value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionEditorOutcome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  QuestionEditorAction action,  String? errorKey,  String? createdQid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionEditorOutcome() when $default != null:
return $default(_that.seq,_that.action,_that.errorKey,_that.createdQid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  QuestionEditorAction action,  String? errorKey,  String? createdQid)  $default,) {final _that = this;
switch (_that) {
case _QuestionEditorOutcome():
return $default(_that.seq,_that.action,_that.errorKey,_that.createdQid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  QuestionEditorAction action,  String? errorKey,  String? createdQid)?  $default,) {final _that = this;
switch (_that) {
case _QuestionEditorOutcome() when $default != null:
return $default(_that.seq,_that.action,_that.errorKey,_that.createdQid);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionEditorOutcome implements QuestionEditorOutcome {
  const _QuestionEditorOutcome({required this.seq, required this.action, this.errorKey, this.createdQid});
  

@override final  int seq;
@override final  QuestionEditorAction action;
@override final  String? errorKey;
/// After creating: the allocated qid.
@override final  String? createdQid;

/// Create a copy of QuestionEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionEditorOutcomeCopyWith<_QuestionEditorOutcome> get copyWith => __$QuestionEditorOutcomeCopyWithImpl<_QuestionEditorOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionEditorOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.action, action) || other.action == action)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&(identical(other.createdQid, createdQid) || other.createdQid == createdQid));
}


@override
int get hashCode => Object.hash(runtimeType,seq,action,errorKey,createdQid);

@override
String toString() {
  return 'QuestionEditorOutcome(seq: $seq, action: $action, errorKey: $errorKey, createdQid: $createdQid)';
}


}

/// @nodoc
abstract mixin class _$QuestionEditorOutcomeCopyWith<$Res> implements $QuestionEditorOutcomeCopyWith<$Res> {
  factory _$QuestionEditorOutcomeCopyWith(_QuestionEditorOutcome value, $Res Function(_QuestionEditorOutcome) _then) = __$QuestionEditorOutcomeCopyWithImpl;
@override @useResult
$Res call({
 int seq, QuestionEditorAction action, String? errorKey, String? createdQid
});




}
/// @nodoc
class __$QuestionEditorOutcomeCopyWithImpl<$Res>
    implements _$QuestionEditorOutcomeCopyWith<$Res> {
  __$QuestionEditorOutcomeCopyWithImpl(this._self, this._then);

  final _QuestionEditorOutcome _self;
  final $Res Function(_QuestionEditorOutcome) _then;

/// Create a copy of QuestionEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? action = null,Object? errorKey = freezed,Object? createdQid = freezed,}) {
  return _then(_QuestionEditorOutcome(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as QuestionEditorAction,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,createdQid: freezed == createdQid ? _self.createdQid : createdQid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$QuestionEditorState {

/// The saved question; null while creating.
 QuestionModel? get original;/// What "unchanged" looks like (the original, or the empty new draft).
 QuestionModel get baseline; QuestionModel get draft;/// qid the new question will most likely get (shown in the title).
 String get nextQid;/// The next qid is wider than existing ones, so it sorts out of numeric
/// order in the students' app.
 bool get qidBreaksOrder;/// Field → translation key. Shown once a save was attempted.
 Map<String, String> get errors; bool get showErrors; RequestStatus get imageStatus; RequestStatus get submitStatus; RequestStatus get deleteStatus; QuestionEditorOutcome? get lastOutcome;
/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionEditorStateCopyWith<QuestionEditorState> get copyWith => _$QuestionEditorStateCopyWithImpl<QuestionEditorState>(this as QuestionEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionEditorState&&(identical(other.original, original) || other.original == original)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.nextQid, nextQid) || other.nextQid == nextQid)&&(identical(other.qidBreaksOrder, qidBreaksOrder) || other.qidBreaksOrder == qidBreaksOrder)&&const DeepCollectionEquality().equals(other.errors, errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.imageStatus, imageStatus) || other.imageStatus == imageStatus)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,original,baseline,draft,nextQid,qidBreaksOrder,const DeepCollectionEquality().hash(errors),showErrors,imageStatus,submitStatus,deleteStatus,lastOutcome);

@override
String toString() {
  return 'QuestionEditorState(original: $original, baseline: $baseline, draft: $draft, nextQid: $nextQid, qidBreaksOrder: $qidBreaksOrder, errors: $errors, showErrors: $showErrors, imageStatus: $imageStatus, submitStatus: $submitStatus, deleteStatus: $deleteStatus, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class $QuestionEditorStateCopyWith<$Res>  {
  factory $QuestionEditorStateCopyWith(QuestionEditorState value, $Res Function(QuestionEditorState) _then) = _$QuestionEditorStateCopyWithImpl;
@useResult
$Res call({
 QuestionModel? original, QuestionModel baseline, QuestionModel draft, String nextQid, bool qidBreaksOrder, Map<String, String> errors, bool showErrors, RequestStatus imageStatus, RequestStatus submitStatus, RequestStatus deleteStatus, QuestionEditorOutcome? lastOutcome
});


$QuestionModelCopyWith<$Res>? get original;$QuestionModelCopyWith<$Res> get baseline;$QuestionModelCopyWith<$Res> get draft;$QuestionEditorOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class _$QuestionEditorStateCopyWithImpl<$Res>
    implements $QuestionEditorStateCopyWith<$Res> {
  _$QuestionEditorStateCopyWithImpl(this._self, this._then);

  final QuestionEditorState _self;
  final $Res Function(QuestionEditorState) _then;

/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? original = freezed,Object? baseline = null,Object? draft = null,Object? nextQid = null,Object? qidBreaksOrder = null,Object? errors = null,Object? showErrors = null,Object? imageStatus = null,Object? submitStatus = null,Object? deleteStatus = null,Object? lastOutcome = freezed,}) {
  return _then(_self.copyWith(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as QuestionModel?,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as QuestionModel,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as QuestionModel,nextQid: null == nextQid ? _self.nextQid : nextQid // ignore: cast_nullable_to_non_nullable
as String,qidBreaksOrder: null == qidBreaksOrder ? _self.qidBreaksOrder : qidBreaksOrder // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,imageStatus: null == imageStatus ? _self.imageStatus : imageStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as QuestionEditorOutcome?,
  ));
}
/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $QuestionModelCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<$Res> get baseline {
  
  return $QuestionModelCopyWith<$Res>(_self.baseline, (value) {
    return _then(_self.copyWith(baseline: value));
  });
}/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<$Res> get draft {
  
  return $QuestionModelCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionEditorOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $QuestionEditorOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuestionEditorState].
extension QuestionEditorStatePatterns on QuestionEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionEditorState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuestionModel? original,  QuestionModel baseline,  QuestionModel draft,  String nextQid,  bool qidBreaksOrder,  Map<String, String> errors,  bool showErrors,  RequestStatus imageStatus,  RequestStatus submitStatus,  RequestStatus deleteStatus,  QuestionEditorOutcome? lastOutcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionEditorState() when $default != null:
return $default(_that.original,_that.baseline,_that.draft,_that.nextQid,_that.qidBreaksOrder,_that.errors,_that.showErrors,_that.imageStatus,_that.submitStatus,_that.deleteStatus,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuestionModel? original,  QuestionModel baseline,  QuestionModel draft,  String nextQid,  bool qidBreaksOrder,  Map<String, String> errors,  bool showErrors,  RequestStatus imageStatus,  RequestStatus submitStatus,  RequestStatus deleteStatus,  QuestionEditorOutcome? lastOutcome)  $default,) {final _that = this;
switch (_that) {
case _QuestionEditorState():
return $default(_that.original,_that.baseline,_that.draft,_that.nextQid,_that.qidBreaksOrder,_that.errors,_that.showErrors,_that.imageStatus,_that.submitStatus,_that.deleteStatus,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuestionModel? original,  QuestionModel baseline,  QuestionModel draft,  String nextQid,  bool qidBreaksOrder,  Map<String, String> errors,  bool showErrors,  RequestStatus imageStatus,  RequestStatus submitStatus,  RequestStatus deleteStatus,  QuestionEditorOutcome? lastOutcome)?  $default,) {final _that = this;
switch (_that) {
case _QuestionEditorState() when $default != null:
return $default(_that.original,_that.baseline,_that.draft,_that.nextQid,_that.qidBreaksOrder,_that.errors,_that.showErrors,_that.imageStatus,_that.submitStatus,_that.deleteStatus,_that.lastOutcome);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionEditorState extends QuestionEditorState {
  const _QuestionEditorState({this.original, this.baseline = const QuestionModel(qid: ''), this.draft = const QuestionModel(qid: ''), this.nextQid = '', this.qidBreaksOrder = false, final  Map<String, String> errors = const <String, String>{}, this.showErrors = false, this.imageStatus = RequestStatus.init, this.submitStatus = RequestStatus.init, this.deleteStatus = RequestStatus.init, this.lastOutcome}): _errors = errors,super._();
  

/// The saved question; null while creating.
@override final  QuestionModel? original;
/// What "unchanged" looks like (the original, or the empty new draft).
@override@JsonKey() final  QuestionModel baseline;
@override@JsonKey() final  QuestionModel draft;
/// qid the new question will most likely get (shown in the title).
@override@JsonKey() final  String nextQid;
/// The next qid is wider than existing ones, so it sorts out of numeric
/// order in the students' app.
@override@JsonKey() final  bool qidBreaksOrder;
/// Field → translation key. Shown once a save was attempted.
 final  Map<String, String> _errors;
/// Field → translation key. Shown once a save was attempted.
@override@JsonKey() Map<String, String> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}

@override@JsonKey() final  bool showErrors;
@override@JsonKey() final  RequestStatus imageStatus;
@override@JsonKey() final  RequestStatus submitStatus;
@override@JsonKey() final  RequestStatus deleteStatus;
@override final  QuestionEditorOutcome? lastOutcome;

/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionEditorStateCopyWith<_QuestionEditorState> get copyWith => __$QuestionEditorStateCopyWithImpl<_QuestionEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionEditorState&&(identical(other.original, original) || other.original == original)&&(identical(other.baseline, baseline) || other.baseline == baseline)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.nextQid, nextQid) || other.nextQid == nextQid)&&(identical(other.qidBreaksOrder, qidBreaksOrder) || other.qidBreaksOrder == qidBreaksOrder)&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.imageStatus, imageStatus) || other.imageStatus == imageStatus)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,original,baseline,draft,nextQid,qidBreaksOrder,const DeepCollectionEquality().hash(_errors),showErrors,imageStatus,submitStatus,deleteStatus,lastOutcome);

@override
String toString() {
  return 'QuestionEditorState(original: $original, baseline: $baseline, draft: $draft, nextQid: $nextQid, qidBreaksOrder: $qidBreaksOrder, errors: $errors, showErrors: $showErrors, imageStatus: $imageStatus, submitStatus: $submitStatus, deleteStatus: $deleteStatus, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class _$QuestionEditorStateCopyWith<$Res> implements $QuestionEditorStateCopyWith<$Res> {
  factory _$QuestionEditorStateCopyWith(_QuestionEditorState value, $Res Function(_QuestionEditorState) _then) = __$QuestionEditorStateCopyWithImpl;
@override @useResult
$Res call({
 QuestionModel? original, QuestionModel baseline, QuestionModel draft, String nextQid, bool qidBreaksOrder, Map<String, String> errors, bool showErrors, RequestStatus imageStatus, RequestStatus submitStatus, RequestStatus deleteStatus, QuestionEditorOutcome? lastOutcome
});


@override $QuestionModelCopyWith<$Res>? get original;@override $QuestionModelCopyWith<$Res> get baseline;@override $QuestionModelCopyWith<$Res> get draft;@override $QuestionEditorOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class __$QuestionEditorStateCopyWithImpl<$Res>
    implements _$QuestionEditorStateCopyWith<$Res> {
  __$QuestionEditorStateCopyWithImpl(this._self, this._then);

  final _QuestionEditorState _self;
  final $Res Function(_QuestionEditorState) _then;

/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? original = freezed,Object? baseline = null,Object? draft = null,Object? nextQid = null,Object? qidBreaksOrder = null,Object? errors = null,Object? showErrors = null,Object? imageStatus = null,Object? submitStatus = null,Object? deleteStatus = null,Object? lastOutcome = freezed,}) {
  return _then(_QuestionEditorState(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as QuestionModel?,baseline: null == baseline ? _self.baseline : baseline // ignore: cast_nullable_to_non_nullable
as QuestionModel,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as QuestionModel,nextQid: null == nextQid ? _self.nextQid : nextQid // ignore: cast_nullable_to_non_nullable
as String,qidBreaksOrder: null == qidBreaksOrder ? _self.qidBreaksOrder : qidBreaksOrder // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,imageStatus: null == imageStatus ? _self.imageStatus : imageStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as QuestionEditorOutcome?,
  ));
}

/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $QuestionModelCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<$Res> get baseline {
  
  return $QuestionModelCopyWith<$Res>(_self.baseline, (value) {
    return _then(_self.copyWith(baseline: value));
  });
}/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<$Res> get draft {
  
  return $QuestionModelCopyWith<$Res>(_self.draft, (value) {
    return _then(_self.copyWith(draft: value));
  });
}/// Create a copy of QuestionEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionEditorOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $QuestionEditorOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}

// dart format on
