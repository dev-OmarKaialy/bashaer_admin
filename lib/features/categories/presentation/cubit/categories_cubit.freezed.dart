// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoriesState {

 RequestStatus get status; String? get errorKey; List<CategoryModel> get categories; RequestStatus get reorderStatus;/// Bumped on every finished reorder, so the screen toasts once per drop.
 int get reorderSeq; String? get reorderErrorKey;
/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesStateCopyWith<CategoriesState> get copyWith => _$CategoriesStateCopyWithImpl<CategoriesState>(this as CategoriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.reorderStatus, reorderStatus) || other.reorderStatus == reorderStatus)&&(identical(other.reorderSeq, reorderSeq) || other.reorderSeq == reorderSeq)&&(identical(other.reorderErrorKey, reorderErrorKey) || other.reorderErrorKey == reorderErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorKey,const DeepCollectionEquality().hash(categories),reorderStatus,reorderSeq,reorderErrorKey);

@override
String toString() {
  return 'CategoriesState(status: $status, errorKey: $errorKey, categories: $categories, reorderStatus: $reorderStatus, reorderSeq: $reorderSeq, reorderErrorKey: $reorderErrorKey)';
}


}

/// @nodoc
abstract mixin class $CategoriesStateCopyWith<$Res>  {
  factory $CategoriesStateCopyWith(CategoriesState value, $Res Function(CategoriesState) _then) = _$CategoriesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, String? errorKey, List<CategoryModel> categories, RequestStatus reorderStatus, int reorderSeq, String? reorderErrorKey
});




}
/// @nodoc
class _$CategoriesStateCopyWithImpl<$Res>
    implements $CategoriesStateCopyWith<$Res> {
  _$CategoriesStateCopyWithImpl(this._self, this._then);

  final CategoriesState _self;
  final $Res Function(CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorKey = freezed,Object? categories = null,Object? reorderStatus = null,Object? reorderSeq = null,Object? reorderErrorKey = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,reorderStatus: null == reorderStatus ? _self.reorderStatus : reorderStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,reorderSeq: null == reorderSeq ? _self.reorderSeq : reorderSeq // ignore: cast_nullable_to_non_nullable
as int,reorderErrorKey: freezed == reorderErrorKey ? _self.reorderErrorKey : reorderErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesState].
extension CategoriesStatePatterns on CategoriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesState value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorKey,  List<CategoryModel> categories,  RequestStatus reorderStatus,  int reorderSeq,  String? reorderErrorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.status,_that.errorKey,_that.categories,_that.reorderStatus,_that.reorderSeq,_that.reorderErrorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorKey,  List<CategoryModel> categories,  RequestStatus reorderStatus,  int reorderSeq,  String? reorderErrorKey)  $default,) {final _that = this;
switch (_that) {
case _CategoriesState():
return $default(_that.status,_that.errorKey,_that.categories,_that.reorderStatus,_that.reorderSeq,_that.reorderErrorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  String? errorKey,  List<CategoryModel> categories,  RequestStatus reorderStatus,  int reorderSeq,  String? reorderErrorKey)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesState() when $default != null:
return $default(_that.status,_that.errorKey,_that.categories,_that.reorderStatus,_that.reorderSeq,_that.reorderErrorKey);case _:
  return null;

}
}

}

/// @nodoc


class _CategoriesState extends CategoriesState {
  const _CategoriesState({this.status = RequestStatus.init, this.errorKey, final  List<CategoryModel> categories = const <CategoryModel>[], this.reorderStatus = RequestStatus.init, this.reorderSeq = 0, this.reorderErrorKey}): _categories = categories,super._();
  

@override@JsonKey() final  RequestStatus status;
@override final  String? errorKey;
 final  List<CategoryModel> _categories;
@override@JsonKey() List<CategoryModel> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  RequestStatus reorderStatus;
/// Bumped on every finished reorder, so the screen toasts once per drop.
@override@JsonKey() final  int reorderSeq;
@override final  String? reorderErrorKey;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesStateCopyWith<_CategoriesState> get copyWith => __$CategoriesStateCopyWithImpl<_CategoriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.reorderStatus, reorderStatus) || other.reorderStatus == reorderStatus)&&(identical(other.reorderSeq, reorderSeq) || other.reorderSeq == reorderSeq)&&(identical(other.reorderErrorKey, reorderErrorKey) || other.reorderErrorKey == reorderErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorKey,const DeepCollectionEquality().hash(_categories),reorderStatus,reorderSeq,reorderErrorKey);

@override
String toString() {
  return 'CategoriesState(status: $status, errorKey: $errorKey, categories: $categories, reorderStatus: $reorderStatus, reorderSeq: $reorderSeq, reorderErrorKey: $reorderErrorKey)';
}


}

/// @nodoc
abstract mixin class _$CategoriesStateCopyWith<$Res> implements $CategoriesStateCopyWith<$Res> {
  factory _$CategoriesStateCopyWith(_CategoriesState value, $Res Function(_CategoriesState) _then) = __$CategoriesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, String? errorKey, List<CategoryModel> categories, RequestStatus reorderStatus, int reorderSeq, String? reorderErrorKey
});




}
/// @nodoc
class __$CategoriesStateCopyWithImpl<$Res>
    implements _$CategoriesStateCopyWith<$Res> {
  __$CategoriesStateCopyWithImpl(this._self, this._then);

  final _CategoriesState _self;
  final $Res Function(_CategoriesState) _then;

/// Create a copy of CategoriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorKey = freezed,Object? categories = null,Object? reorderStatus = null,Object? reorderSeq = null,Object? reorderErrorKey = freezed,}) {
  return _then(_CategoriesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryModel>,reorderStatus: null == reorderStatus ? _self.reorderStatus : reorderStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,reorderSeq: null == reorderSeq ? _self.reorderSeq : reorderSeq // ignore: cast_nullable_to_non_nullable
as int,reorderErrorKey: freezed == reorderErrorKey ? _self.reorderErrorKey : reorderErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
