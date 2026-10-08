// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionFilters {

 String? get categorySlug; QuestionType? get type; bool get withImageOnly; bool get trialOnly; String get query;
/// Create a copy of QuestionFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionFiltersCopyWith<QuestionFilters> get copyWith => _$QuestionFiltersCopyWithImpl<QuestionFilters>(this as QuestionFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionFilters&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.type, type) || other.type == type)&&(identical(other.withImageOnly, withImageOnly) || other.withImageOnly == withImageOnly)&&(identical(other.trialOnly, trialOnly) || other.trialOnly == trialOnly)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,categorySlug,type,withImageOnly,trialOnly,query);

@override
String toString() {
  return 'QuestionFilters(categorySlug: $categorySlug, type: $type, withImageOnly: $withImageOnly, trialOnly: $trialOnly, query: $query)';
}


}

/// @nodoc
abstract mixin class $QuestionFiltersCopyWith<$Res>  {
  factory $QuestionFiltersCopyWith(QuestionFilters value, $Res Function(QuestionFilters) _then) = _$QuestionFiltersCopyWithImpl;
@useResult
$Res call({
 String? categorySlug, QuestionType? type, bool withImageOnly, bool trialOnly, String query
});




}
/// @nodoc
class _$QuestionFiltersCopyWithImpl<$Res>
    implements $QuestionFiltersCopyWith<$Res> {
  _$QuestionFiltersCopyWithImpl(this._self, this._then);

  final QuestionFilters _self;
  final $Res Function(QuestionFilters) _then;

/// Create a copy of QuestionFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categorySlug = freezed,Object? type = freezed,Object? withImageOnly = null,Object? trialOnly = null,Object? query = null,}) {
  return _then(_self.copyWith(
categorySlug: freezed == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType?,withImageOnly: null == withImageOnly ? _self.withImageOnly : withImageOnly // ignore: cast_nullable_to_non_nullable
as bool,trialOnly: null == trialOnly ? _self.trialOnly : trialOnly // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionFilters].
extension QuestionFiltersPatterns on QuestionFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionFilters value)  $default,){
final _that = this;
switch (_that) {
case _QuestionFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionFilters value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? categorySlug,  QuestionType? type,  bool withImageOnly,  bool trialOnly,  String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionFilters() when $default != null:
return $default(_that.categorySlug,_that.type,_that.withImageOnly,_that.trialOnly,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? categorySlug,  QuestionType? type,  bool withImageOnly,  bool trialOnly,  String query)  $default,) {final _that = this;
switch (_that) {
case _QuestionFilters():
return $default(_that.categorySlug,_that.type,_that.withImageOnly,_that.trialOnly,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? categorySlug,  QuestionType? type,  bool withImageOnly,  bool trialOnly,  String query)?  $default,) {final _that = this;
switch (_that) {
case _QuestionFilters() when $default != null:
return $default(_that.categorySlug,_that.type,_that.withImageOnly,_that.trialOnly,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionFilters extends QuestionFilters {
  const _QuestionFilters({this.categorySlug, this.type, this.withImageOnly = false, this.trialOnly = false, this.query = ''}): super._();
  

@override final  String? categorySlug;
@override final  QuestionType? type;
@override@JsonKey() final  bool withImageOnly;
@override@JsonKey() final  bool trialOnly;
@override@JsonKey() final  String query;

/// Create a copy of QuestionFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionFiltersCopyWith<_QuestionFilters> get copyWith => __$QuestionFiltersCopyWithImpl<_QuestionFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionFilters&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.type, type) || other.type == type)&&(identical(other.withImageOnly, withImageOnly) || other.withImageOnly == withImageOnly)&&(identical(other.trialOnly, trialOnly) || other.trialOnly == trialOnly)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,categorySlug,type,withImageOnly,trialOnly,query);

@override
String toString() {
  return 'QuestionFilters(categorySlug: $categorySlug, type: $type, withImageOnly: $withImageOnly, trialOnly: $trialOnly, query: $query)';
}


}

/// @nodoc
abstract mixin class _$QuestionFiltersCopyWith<$Res> implements $QuestionFiltersCopyWith<$Res> {
  factory _$QuestionFiltersCopyWith(_QuestionFilters value, $Res Function(_QuestionFilters) _then) = __$QuestionFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? categorySlug, QuestionType? type, bool withImageOnly, bool trialOnly, String query
});




}
/// @nodoc
class __$QuestionFiltersCopyWithImpl<$Res>
    implements _$QuestionFiltersCopyWith<$Res> {
  __$QuestionFiltersCopyWithImpl(this._self, this._then);

  final _QuestionFilters _self;
  final $Res Function(_QuestionFilters) _then;

/// Create a copy of QuestionFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categorySlug = freezed,Object? type = freezed,Object? withImageOnly = null,Object? trialOnly = null,Object? query = null,}) {
  return _then(_QuestionFilters(
categorySlug: freezed == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType?,withImageOnly: null == withImageOnly ? _self.withImageOnly : withImageOnly // ignore: cast_nullable_to_non_nullable
as bool,trialOnly: null == trialOnly ? _self.trialOnly : trialOnly // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$QuestionsState {

 RequestStatus get status; String? get errorKey;/// Whole bank, numeric qid order.
 List<QuestionModel> get all;/// What the list renders (derived from [all] and [filters]).
 List<QuestionModel> get visible; QuestionFilters get filters;/// Questions per category slug, for category rows and the delete guard.
 Map<String, int> get countsByCategory;
/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionsStateCopyWith<QuestionsState> get copyWith => _$QuestionsStateCopyWithImpl<QuestionsState>(this as QuestionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionsState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&const DeepCollectionEquality().equals(other.all, all)&&const DeepCollectionEquality().equals(other.visible, visible)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other.countsByCategory, countsByCategory));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorKey,const DeepCollectionEquality().hash(all),const DeepCollectionEquality().hash(visible),filters,const DeepCollectionEquality().hash(countsByCategory));

@override
String toString() {
  return 'QuestionsState(status: $status, errorKey: $errorKey, all: $all, visible: $visible, filters: $filters, countsByCategory: $countsByCategory)';
}


}

/// @nodoc
abstract mixin class $QuestionsStateCopyWith<$Res>  {
  factory $QuestionsStateCopyWith(QuestionsState value, $Res Function(QuestionsState) _then) = _$QuestionsStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus status, String? errorKey, List<QuestionModel> all, List<QuestionModel> visible, QuestionFilters filters, Map<String, int> countsByCategory
});


$QuestionFiltersCopyWith<$Res> get filters;

}
/// @nodoc
class _$QuestionsStateCopyWithImpl<$Res>
    implements $QuestionsStateCopyWith<$Res> {
  _$QuestionsStateCopyWithImpl(this._self, this._then);

  final QuestionsState _self;
  final $Res Function(QuestionsState) _then;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorKey = freezed,Object? all = null,Object? visible = null,Object? filters = null,Object? countsByCategory = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,all: null == all ? _self.all : all // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as QuestionFilters,countsByCategory: null == countsByCategory ? _self.countsByCategory : countsByCategory // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}
/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionFiltersCopyWith<$Res> get filters {
  
  return $QuestionFiltersCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuestionsState].
extension QuestionsStatePatterns on QuestionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionsState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionsState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorKey,  List<QuestionModel> all,  List<QuestionModel> visible,  QuestionFilters filters,  Map<String, int> countsByCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
return $default(_that.status,_that.errorKey,_that.all,_that.visible,_that.filters,_that.countsByCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus status,  String? errorKey,  List<QuestionModel> all,  List<QuestionModel> visible,  QuestionFilters filters,  Map<String, int> countsByCategory)  $default,) {final _that = this;
switch (_that) {
case _QuestionsState():
return $default(_that.status,_that.errorKey,_that.all,_that.visible,_that.filters,_that.countsByCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus status,  String? errorKey,  List<QuestionModel> all,  List<QuestionModel> visible,  QuestionFilters filters,  Map<String, int> countsByCategory)?  $default,) {final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
return $default(_that.status,_that.errorKey,_that.all,_that.visible,_that.filters,_that.countsByCategory);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionsState extends QuestionsState {
  const _QuestionsState({this.status = RequestStatus.init, this.errorKey, final  List<QuestionModel> all = const <QuestionModel>[], final  List<QuestionModel> visible = const <QuestionModel>[], this.filters = const QuestionFilters(), final  Map<String, int> countsByCategory = const <String, int>{}}): _all = all,_visible = visible,_countsByCategory = countsByCategory,super._();
  

@override@JsonKey() final  RequestStatus status;
@override final  String? errorKey;
/// Whole bank, numeric qid order.
 final  List<QuestionModel> _all;
/// Whole bank, numeric qid order.
@override@JsonKey() List<QuestionModel> get all {
  if (_all is EqualUnmodifiableListView) return _all;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_all);
}

/// What the list renders (derived from [all] and [filters]).
 final  List<QuestionModel> _visible;
/// What the list renders (derived from [all] and [filters]).
@override@JsonKey() List<QuestionModel> get visible {
  if (_visible is EqualUnmodifiableListView) return _visible;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visible);
}

@override@JsonKey() final  QuestionFilters filters;
/// Questions per category slug, for category rows and the delete guard.
 final  Map<String, int> _countsByCategory;
/// Questions per category slug, for category rows and the delete guard.
@override@JsonKey() Map<String, int> get countsByCategory {
  if (_countsByCategory is EqualUnmodifiableMapView) return _countsByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_countsByCategory);
}


/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionsStateCopyWith<_QuestionsState> get copyWith => __$QuestionsStateCopyWithImpl<_QuestionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionsState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey)&&const DeepCollectionEquality().equals(other._all, _all)&&const DeepCollectionEquality().equals(other._visible, _visible)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other._countsByCategory, _countsByCategory));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorKey,const DeepCollectionEquality().hash(_all),const DeepCollectionEquality().hash(_visible),filters,const DeepCollectionEquality().hash(_countsByCategory));

@override
String toString() {
  return 'QuestionsState(status: $status, errorKey: $errorKey, all: $all, visible: $visible, filters: $filters, countsByCategory: $countsByCategory)';
}


}

/// @nodoc
abstract mixin class _$QuestionsStateCopyWith<$Res> implements $QuestionsStateCopyWith<$Res> {
  factory _$QuestionsStateCopyWith(_QuestionsState value, $Res Function(_QuestionsState) _then) = __$QuestionsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus status, String? errorKey, List<QuestionModel> all, List<QuestionModel> visible, QuestionFilters filters, Map<String, int> countsByCategory
});


@override $QuestionFiltersCopyWith<$Res> get filters;

}
/// @nodoc
class __$QuestionsStateCopyWithImpl<$Res>
    implements _$QuestionsStateCopyWith<$Res> {
  __$QuestionsStateCopyWithImpl(this._self, this._then);

  final _QuestionsState _self;
  final $Res Function(_QuestionsState) _then;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorKey = freezed,Object? all = null,Object? visible = null,Object? filters = null,Object? countsByCategory = null,}) {
  return _then(_QuestionsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,all: null == all ? _self._all : all // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,visible: null == visible ? _self._visible : visible // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as QuestionFilters,countsByCategory: null == countsByCategory ? _self._countsByCategory : countsByCategory // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionFiltersCopyWith<$Res> get filters {
  
  return $QuestionFiltersCopyWith<$Res>(_self.filters, (value) {
    return _then(_self.copyWith(filters: value));
  });
}
}

// dart format on
