// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnswerModel {

 String get id; String get text; bool get isCorrect;/// Per-answer media and notes exist in seeded data. The editor does not
/// show them but always writes them back unchanged.
 String? get image; String? get description;
/// Create a copy of AnswerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerModelCopyWith<AnswerModel> get copyWith => _$AnswerModelCopyWithImpl<AnswerModel>(this as AnswerModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.image, image) || other.image == image)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,isCorrect,image,description);

@override
String toString() {
  return 'AnswerModel(id: $id, text: $text, isCorrect: $isCorrect, image: $image, description: $description)';
}


}

/// @nodoc
abstract mixin class $AnswerModelCopyWith<$Res>  {
  factory $AnswerModelCopyWith(AnswerModel value, $Res Function(AnswerModel) _then) = _$AnswerModelCopyWithImpl;
@useResult
$Res call({
 String id, String text, bool isCorrect, String? image, String? description
});




}
/// @nodoc
class _$AnswerModelCopyWithImpl<$Res>
    implements $AnswerModelCopyWith<$Res> {
  _$AnswerModelCopyWithImpl(this._self, this._then);

  final AnswerModel _self;
  final $Res Function(AnswerModel) _then;

/// Create a copy of AnswerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? isCorrect = null,Object? image = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AnswerModel].
extension AnswerModelPatterns on AnswerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnswerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnswerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnswerModel value)  $default,){
final _that = this;
switch (_that) {
case _AnswerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnswerModel value)?  $default,){
final _that = this;
switch (_that) {
case _AnswerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  bool isCorrect,  String? image,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnswerModel() when $default != null:
return $default(_that.id,_that.text,_that.isCorrect,_that.image,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  bool isCorrect,  String? image,  String? description)  $default,) {final _that = this;
switch (_that) {
case _AnswerModel():
return $default(_that.id,_that.text,_that.isCorrect,_that.image,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  bool isCorrect,  String? image,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _AnswerModel() when $default != null:
return $default(_that.id,_that.text,_that.isCorrect,_that.image,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _AnswerModel extends AnswerModel {
  const _AnswerModel({required this.id, this.text = '', this.isCorrect = false, this.image, this.description}): super._();
  

@override final  String id;
@override@JsonKey() final  String text;
@override@JsonKey() final  bool isCorrect;
/// Per-answer media and notes exist in seeded data. The editor does not
/// show them but always writes them back unchanged.
@override final  String? image;
@override final  String? description;

/// Create a copy of AnswerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerModelCopyWith<_AnswerModel> get copyWith => __$AnswerModelCopyWithImpl<_AnswerModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnswerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.image, image) || other.image == image)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,id,text,isCorrect,image,description);

@override
String toString() {
  return 'AnswerModel(id: $id, text: $text, isCorrect: $isCorrect, image: $image, description: $description)';
}


}

/// @nodoc
abstract mixin class _$AnswerModelCopyWith<$Res> implements $AnswerModelCopyWith<$Res> {
  factory _$AnswerModelCopyWith(_AnswerModel value, $Res Function(_AnswerModel) _then) = __$AnswerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, bool isCorrect, String? image, String? description
});




}
/// @nodoc
class __$AnswerModelCopyWithImpl<$Res>
    implements _$AnswerModelCopyWith<$Res> {
  __$AnswerModelCopyWithImpl(this._self, this._then);

  final _AnswerModel _self;
  final $Res Function(_AnswerModel) _then;

/// Create a copy of AnswerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? isCorrect = null,Object? image = freezed,Object? description = freezed,}) {
  return _then(_AnswerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$QuestionModel {

 String get qid; String get categorySlug; QuestionType get type; String get title; String? get image; List<AnswerModel> get answers; List<String> get correctAnswerIds; String? get hint; DateTime? get createdAt; DateTime? get updatedAt;/// In memory only: folded title + qid for search.
 String get searchKey;/// In memory only: among the first five by the students' (lexicographic)
/// qid order, i.e. part of the free trial.
 bool get isTrial;
/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionModelCopyWith<QuestionModel> get copyWith => _$QuestionModelCopyWithImpl<QuestionModel>(this as QuestionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionModel&&(identical(other.qid, qid) || other.qid == qid)&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other.answers, answers)&&const DeepCollectionEquality().equals(other.correctAnswerIds, correctAnswerIds)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.searchKey, searchKey) || other.searchKey == searchKey)&&(identical(other.isTrial, isTrial) || other.isTrial == isTrial));
}


@override
int get hashCode => Object.hash(runtimeType,qid,categorySlug,type,title,image,const DeepCollectionEquality().hash(answers),const DeepCollectionEquality().hash(correctAnswerIds),hint,createdAt,updatedAt,searchKey,isTrial);

@override
String toString() {
  return 'QuestionModel(qid: $qid, categorySlug: $categorySlug, type: $type, title: $title, image: $image, answers: $answers, correctAnswerIds: $correctAnswerIds, hint: $hint, createdAt: $createdAt, updatedAt: $updatedAt, searchKey: $searchKey, isTrial: $isTrial)';
}


}

/// @nodoc
abstract mixin class $QuestionModelCopyWith<$Res>  {
  factory $QuestionModelCopyWith(QuestionModel value, $Res Function(QuestionModel) _then) = _$QuestionModelCopyWithImpl;
@useResult
$Res call({
 String qid, String categorySlug, QuestionType type, String title, String? image, List<AnswerModel> answers, List<String> correctAnswerIds, String? hint, DateTime? createdAt, DateTime? updatedAt, String searchKey, bool isTrial
});




}
/// @nodoc
class _$QuestionModelCopyWithImpl<$Res>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._self, this._then);

  final QuestionModel _self;
  final $Res Function(QuestionModel) _then;

/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? qid = null,Object? categorySlug = null,Object? type = null,Object? title = null,Object? image = freezed,Object? answers = null,Object? correctAnswerIds = null,Object? hint = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? searchKey = null,Object? isTrial = null,}) {
  return _then(_self.copyWith(
qid: null == qid ? _self.qid : qid // ignore: cast_nullable_to_non_nullable
as String,categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<AnswerModel>,correctAnswerIds: null == correctAnswerIds ? _self.correctAnswerIds : correctAnswerIds // ignore: cast_nullable_to_non_nullable
as List<String>,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,searchKey: null == searchKey ? _self.searchKey : searchKey // ignore: cast_nullable_to_non_nullable
as String,isTrial: null == isTrial ? _self.isTrial : isTrial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionModel].
extension QuestionModelPatterns on QuestionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionModel value)  $default,){
final _that = this;
switch (_that) {
case _QuestionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionModel value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String qid,  String categorySlug,  QuestionType type,  String title,  String? image,  List<AnswerModel> answers,  List<String> correctAnswerIds,  String? hint,  DateTime? createdAt,  DateTime? updatedAt,  String searchKey,  bool isTrial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
return $default(_that.qid,_that.categorySlug,_that.type,_that.title,_that.image,_that.answers,_that.correctAnswerIds,_that.hint,_that.createdAt,_that.updatedAt,_that.searchKey,_that.isTrial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String qid,  String categorySlug,  QuestionType type,  String title,  String? image,  List<AnswerModel> answers,  List<String> correctAnswerIds,  String? hint,  DateTime? createdAt,  DateTime? updatedAt,  String searchKey,  bool isTrial)  $default,) {final _that = this;
switch (_that) {
case _QuestionModel():
return $default(_that.qid,_that.categorySlug,_that.type,_that.title,_that.image,_that.answers,_that.correctAnswerIds,_that.hint,_that.createdAt,_that.updatedAt,_that.searchKey,_that.isTrial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String qid,  String categorySlug,  QuestionType type,  String title,  String? image,  List<AnswerModel> answers,  List<String> correctAnswerIds,  String? hint,  DateTime? createdAt,  DateTime? updatedAt,  String searchKey,  bool isTrial)?  $default,) {final _that = this;
switch (_that) {
case _QuestionModel() when $default != null:
return $default(_that.qid,_that.categorySlug,_that.type,_that.title,_that.image,_that.answers,_that.correctAnswerIds,_that.hint,_that.createdAt,_that.updatedAt,_that.searchKey,_that.isTrial);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionModel extends QuestionModel {
  const _QuestionModel({required this.qid, this.categorySlug = '', this.type = QuestionType.singleChoice, this.title = '', this.image, final  List<AnswerModel> answers = const <AnswerModel>[], final  List<String> correctAnswerIds = const <String>[], this.hint, this.createdAt, this.updatedAt, this.searchKey = '', this.isTrial = false}): _answers = answers,_correctAnswerIds = correctAnswerIds,super._();
  

@override final  String qid;
@override@JsonKey() final  String categorySlug;
@override@JsonKey() final  QuestionType type;
@override@JsonKey() final  String title;
@override final  String? image;
 final  List<AnswerModel> _answers;
@override@JsonKey() List<AnswerModel> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

 final  List<String> _correctAnswerIds;
@override@JsonKey() List<String> get correctAnswerIds {
  if (_correctAnswerIds is EqualUnmodifiableListView) return _correctAnswerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctAnswerIds);
}

@override final  String? hint;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
/// In memory only: folded title + qid for search.
@override@JsonKey() final  String searchKey;
/// In memory only: among the first five by the students' (lexicographic)
/// qid order, i.e. part of the free trial.
@override@JsonKey() final  bool isTrial;

/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionModelCopyWith<_QuestionModel> get copyWith => __$QuestionModelCopyWithImpl<_QuestionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionModel&&(identical(other.qid, qid) || other.qid == qid)&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.image, image) || other.image == image)&&const DeepCollectionEquality().equals(other._answers, _answers)&&const DeepCollectionEquality().equals(other._correctAnswerIds, _correctAnswerIds)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.searchKey, searchKey) || other.searchKey == searchKey)&&(identical(other.isTrial, isTrial) || other.isTrial == isTrial));
}


@override
int get hashCode => Object.hash(runtimeType,qid,categorySlug,type,title,image,const DeepCollectionEquality().hash(_answers),const DeepCollectionEquality().hash(_correctAnswerIds),hint,createdAt,updatedAt,searchKey,isTrial);

@override
String toString() {
  return 'QuestionModel(qid: $qid, categorySlug: $categorySlug, type: $type, title: $title, image: $image, answers: $answers, correctAnswerIds: $correctAnswerIds, hint: $hint, createdAt: $createdAt, updatedAt: $updatedAt, searchKey: $searchKey, isTrial: $isTrial)';
}


}

/// @nodoc
abstract mixin class _$QuestionModelCopyWith<$Res> implements $QuestionModelCopyWith<$Res> {
  factory _$QuestionModelCopyWith(_QuestionModel value, $Res Function(_QuestionModel) _then) = __$QuestionModelCopyWithImpl;
@override @useResult
$Res call({
 String qid, String categorySlug, QuestionType type, String title, String? image, List<AnswerModel> answers, List<String> correctAnswerIds, String? hint, DateTime? createdAt, DateTime? updatedAt, String searchKey, bool isTrial
});




}
/// @nodoc
class __$QuestionModelCopyWithImpl<$Res>
    implements _$QuestionModelCopyWith<$Res> {
  __$QuestionModelCopyWithImpl(this._self, this._then);

  final _QuestionModel _self;
  final $Res Function(_QuestionModel) _then;

/// Create a copy of QuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? qid = null,Object? categorySlug = null,Object? type = null,Object? title = null,Object? image = freezed,Object? answers = null,Object? correctAnswerIds = null,Object? hint = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? searchKey = null,Object? isTrial = null,}) {
  return _then(_QuestionModel(
qid: null == qid ? _self.qid : qid // ignore: cast_nullable_to_non_nullable
as String,categorySlug: null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<AnswerModel>,correctAnswerIds: null == correctAnswerIds ? _self._correctAnswerIds : correctAnswerIds // ignore: cast_nullable_to_non_nullable
as List<String>,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,searchKey: null == searchKey ? _self.searchKey : searchKey // ignore: cast_nullable_to_non_nullable
as String,isTrial: null == isTrial ? _self.isTrial : isTrial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
