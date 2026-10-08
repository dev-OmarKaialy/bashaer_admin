// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_editor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryEditorOutcome {

 int get seq; CategoryEditorAction get action; String? get errorKey; Map<String, String> get errorArgs;
/// Create a copy of CategoryEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryEditorOutcomeCopyWith<CategoryEditorOutcome> get copyWith => _$CategoryEditorOutcomeCopyWithImpl<CategoryEditorOutcome>(this as CategoryEditorOutcome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryEditorOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.action, action) || other.action == action)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&const DeepCollectionEquality().equals(other.errorArgs, errorArgs));
}


@override
int get hashCode => Object.hash(runtimeType,seq,action,errorKey,const DeepCollectionEquality().hash(errorArgs));

@override
String toString() {
  return 'CategoryEditorOutcome(seq: $seq, action: $action, errorKey: $errorKey, errorArgs: $errorArgs)';
}


}

/// @nodoc
abstract mixin class $CategoryEditorOutcomeCopyWith<$Res>  {
  factory $CategoryEditorOutcomeCopyWith(CategoryEditorOutcome value, $Res Function(CategoryEditorOutcome) _then) = _$CategoryEditorOutcomeCopyWithImpl;
@useResult
$Res call({
 int seq, CategoryEditorAction action, String? errorKey, Map<String, String> errorArgs
});




}
/// @nodoc
class _$CategoryEditorOutcomeCopyWithImpl<$Res>
    implements $CategoryEditorOutcomeCopyWith<$Res> {
  _$CategoryEditorOutcomeCopyWithImpl(this._self, this._then);

  final CategoryEditorOutcome _self;
  final $Res Function(CategoryEditorOutcome) _then;

/// Create a copy of CategoryEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? action = null,Object? errorKey = freezed,Object? errorArgs = null,}) {
  return _then(_self.copyWith(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as CategoryEditorAction,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,errorArgs: null == errorArgs ? _self.errorArgs : errorArgs // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryEditorOutcome].
extension CategoryEditorOutcomePatterns on CategoryEditorOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryEditorOutcome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryEditorOutcome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryEditorOutcome value)  $default,){
final _that = this;
switch (_that) {
case _CategoryEditorOutcome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryEditorOutcome value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryEditorOutcome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  CategoryEditorAction action,  String? errorKey,  Map<String, String> errorArgs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryEditorOutcome() when $default != null:
return $default(_that.seq,_that.action,_that.errorKey,_that.errorArgs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  CategoryEditorAction action,  String? errorKey,  Map<String, String> errorArgs)  $default,) {final _that = this;
switch (_that) {
case _CategoryEditorOutcome():
return $default(_that.seq,_that.action,_that.errorKey,_that.errorArgs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  CategoryEditorAction action,  String? errorKey,  Map<String, String> errorArgs)?  $default,) {final _that = this;
switch (_that) {
case _CategoryEditorOutcome() when $default != null:
return $default(_that.seq,_that.action,_that.errorKey,_that.errorArgs);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryEditorOutcome implements CategoryEditorOutcome {
  const _CategoryEditorOutcome({required this.seq, required this.action, this.errorKey, final  Map<String, String> errorArgs = const <String, String>{}}): _errorArgs = errorArgs;
  

@override final  int seq;
@override final  CategoryEditorAction action;
@override final  String? errorKey;
 final  Map<String, String> _errorArgs;
@override@JsonKey() Map<String, String> get errorArgs {
  if (_errorArgs is EqualUnmodifiableMapView) return _errorArgs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errorArgs);
}


/// Create a copy of CategoryEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryEditorOutcomeCopyWith<_CategoryEditorOutcome> get copyWith => __$CategoryEditorOutcomeCopyWithImpl<_CategoryEditorOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryEditorOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.action, action) || other.action == action)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&const DeepCollectionEquality().equals(other._errorArgs, _errorArgs));
}


@override
int get hashCode => Object.hash(runtimeType,seq,action,errorKey,const DeepCollectionEquality().hash(_errorArgs));

@override
String toString() {
  return 'CategoryEditorOutcome(seq: $seq, action: $action, errorKey: $errorKey, errorArgs: $errorArgs)';
}


}

/// @nodoc
abstract mixin class _$CategoryEditorOutcomeCopyWith<$Res> implements $CategoryEditorOutcomeCopyWith<$Res> {
  factory _$CategoryEditorOutcomeCopyWith(_CategoryEditorOutcome value, $Res Function(_CategoryEditorOutcome) _then) = __$CategoryEditorOutcomeCopyWithImpl;
@override @useResult
$Res call({
 int seq, CategoryEditorAction action, String? errorKey, Map<String, String> errorArgs
});




}
/// @nodoc
class __$CategoryEditorOutcomeCopyWithImpl<$Res>
    implements _$CategoryEditorOutcomeCopyWith<$Res> {
  __$CategoryEditorOutcomeCopyWithImpl(this._self, this._then);

  final _CategoryEditorOutcome _self;
  final $Res Function(_CategoryEditorOutcome) _then;

/// Create a copy of CategoryEditorOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? action = null,Object? errorKey = freezed,Object? errorArgs = null,}) {
  return _then(_CategoryEditorOutcome(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as CategoryEditorAction,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,errorArgs: null == errorArgs ? _self._errorArgs : errorArgs // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc
mixin _$CategoryEditorState {

/// Null while creating a new category.
 CategoryModel? get original; String get slug; String get name; String? get icon; String get description;/// Field → translation key, shown under the field after a failed save.
 Map<String, String> get errors; RequestStatus get submitStatus; RequestStatus get deleteStatus; CategoryEditorOutcome? get lastOutcome;
/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryEditorStateCopyWith<CategoryEditorState> get copyWith => _$CategoryEditorStateCopyWithImpl<CategoryEditorState>(this as CategoryEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryEditorState&&(identical(other.original, original) || other.original == original)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.errors, errors)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,original,slug,name,icon,description,const DeepCollectionEquality().hash(errors),submitStatus,deleteStatus,lastOutcome);

@override
String toString() {
  return 'CategoryEditorState(original: $original, slug: $slug, name: $name, icon: $icon, description: $description, errors: $errors, submitStatus: $submitStatus, deleteStatus: $deleteStatus, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class $CategoryEditorStateCopyWith<$Res>  {
  factory $CategoryEditorStateCopyWith(CategoryEditorState value, $Res Function(CategoryEditorState) _then) = _$CategoryEditorStateCopyWithImpl;
@useResult
$Res call({
 CategoryModel? original, String slug, String name, String? icon, String description, Map<String, String> errors, RequestStatus submitStatus, RequestStatus deleteStatus, CategoryEditorOutcome? lastOutcome
});


$CategoryModelCopyWith<$Res>? get original;$CategoryEditorOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class _$CategoryEditorStateCopyWithImpl<$Res>
    implements $CategoryEditorStateCopyWith<$Res> {
  _$CategoryEditorStateCopyWithImpl(this._self, this._then);

  final CategoryEditorState _self;
  final $Res Function(CategoryEditorState) _then;

/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? original = freezed,Object? slug = null,Object? name = null,Object? icon = freezed,Object? description = null,Object? errors = null,Object? submitStatus = null,Object? deleteStatus = null,Object? lastOutcome = freezed,}) {
  return _then(_self.copyWith(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as CategoryModel?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as CategoryEditorOutcome?,
  ));
}
/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryEditorOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $CategoryEditorOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryEditorState].
extension CategoryEditorStatePatterns on CategoryEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryEditorState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryModel? original,  String slug,  String name,  String? icon,  String description,  Map<String, String> errors,  RequestStatus submitStatus,  RequestStatus deleteStatus,  CategoryEditorOutcome? lastOutcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryEditorState() when $default != null:
return $default(_that.original,_that.slug,_that.name,_that.icon,_that.description,_that.errors,_that.submitStatus,_that.deleteStatus,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryModel? original,  String slug,  String name,  String? icon,  String description,  Map<String, String> errors,  RequestStatus submitStatus,  RequestStatus deleteStatus,  CategoryEditorOutcome? lastOutcome)  $default,) {final _that = this;
switch (_that) {
case _CategoryEditorState():
return $default(_that.original,_that.slug,_that.name,_that.icon,_that.description,_that.errors,_that.submitStatus,_that.deleteStatus,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryModel? original,  String slug,  String name,  String? icon,  String description,  Map<String, String> errors,  RequestStatus submitStatus,  RequestStatus deleteStatus,  CategoryEditorOutcome? lastOutcome)?  $default,) {final _that = this;
switch (_that) {
case _CategoryEditorState() when $default != null:
return $default(_that.original,_that.slug,_that.name,_that.icon,_that.description,_that.errors,_that.submitStatus,_that.deleteStatus,_that.lastOutcome);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryEditorState extends CategoryEditorState {
  const _CategoryEditorState({this.original, this.slug = '', this.name = '', this.icon, this.description = '', final  Map<String, String> errors = const <String, String>{}, this.submitStatus = RequestStatus.init, this.deleteStatus = RequestStatus.init, this.lastOutcome}): _errors = errors,super._();
  

/// Null while creating a new category.
@override final  CategoryModel? original;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String name;
@override final  String? icon;
@override@JsonKey() final  String description;
/// Field → translation key, shown under the field after a failed save.
 final  Map<String, String> _errors;
/// Field → translation key, shown under the field after a failed save.
@override@JsonKey() Map<String, String> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}

@override@JsonKey() final  RequestStatus submitStatus;
@override@JsonKey() final  RequestStatus deleteStatus;
@override final  CategoryEditorOutcome? lastOutcome;

/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryEditorStateCopyWith<_CategoryEditorState> get copyWith => __$CategoryEditorStateCopyWithImpl<_CategoryEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryEditorState&&(identical(other.original, original) || other.original == original)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._errors, _errors)&&(identical(other.submitStatus, submitStatus) || other.submitStatus == submitStatus)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,original,slug,name,icon,description,const DeepCollectionEquality().hash(_errors),submitStatus,deleteStatus,lastOutcome);

@override
String toString() {
  return 'CategoryEditorState(original: $original, slug: $slug, name: $name, icon: $icon, description: $description, errors: $errors, submitStatus: $submitStatus, deleteStatus: $deleteStatus, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class _$CategoryEditorStateCopyWith<$Res> implements $CategoryEditorStateCopyWith<$Res> {
  factory _$CategoryEditorStateCopyWith(_CategoryEditorState value, $Res Function(_CategoryEditorState) _then) = __$CategoryEditorStateCopyWithImpl;
@override @useResult
$Res call({
 CategoryModel? original, String slug, String name, String? icon, String description, Map<String, String> errors, RequestStatus submitStatus, RequestStatus deleteStatus, CategoryEditorOutcome? lastOutcome
});


@override $CategoryModelCopyWith<$Res>? get original;@override $CategoryEditorOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class __$CategoryEditorStateCopyWithImpl<$Res>
    implements _$CategoryEditorStateCopyWith<$Res> {
  __$CategoryEditorStateCopyWithImpl(this._self, this._then);

  final _CategoryEditorState _self;
  final $Res Function(_CategoryEditorState) _then;

/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? original = freezed,Object? slug = null,Object? name = null,Object? icon = freezed,Object? description = null,Object? errors = null,Object? submitStatus = null,Object? deleteStatus = null,Object? lastOutcome = freezed,}) {
  return _then(_CategoryEditorState(
original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as CategoryModel?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,submitStatus: null == submitStatus ? _self.submitStatus : submitStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as CategoryEditorOutcome?,
  ));
}

/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of CategoryEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryEditorOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $CategoryEditorOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}

// dart format on
