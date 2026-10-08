// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'license_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LicenseModel {

 String get deviceId; bool get isActive; DateTime? get activeUntil; DateTime? get createdAt; DateTime? get updatedAt; String? get fullName; String? get phoneNumber; String? get note;/// In memory only: folded text for search. Never written.
 String get searchKey;
/// Create a copy of LicenseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseModelCopyWith<LicenseModel> get copyWith => _$LicenseModelCopyWithImpl<LicenseModel>(this as LicenseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseModel&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.activeUntil, activeUntil) || other.activeUntil == activeUntil)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.note, note) || other.note == note)&&(identical(other.searchKey, searchKey) || other.searchKey == searchKey));
}


@override
int get hashCode => Object.hash(runtimeType,deviceId,isActive,activeUntil,createdAt,updatedAt,fullName,phoneNumber,note,searchKey);

@override
String toString() {
  return 'LicenseModel(deviceId: $deviceId, isActive: $isActive, activeUntil: $activeUntil, createdAt: $createdAt, updatedAt: $updatedAt, fullName: $fullName, phoneNumber: $phoneNumber, note: $note, searchKey: $searchKey)';
}


}

/// @nodoc
abstract mixin class $LicenseModelCopyWith<$Res>  {
  factory $LicenseModelCopyWith(LicenseModel value, $Res Function(LicenseModel) _then) = _$LicenseModelCopyWithImpl;
@useResult
$Res call({
 String deviceId, bool isActive, DateTime? activeUntil, DateTime? createdAt, DateTime? updatedAt, String? fullName, String? phoneNumber, String? note, String searchKey
});




}
/// @nodoc
class _$LicenseModelCopyWithImpl<$Res>
    implements $LicenseModelCopyWith<$Res> {
  _$LicenseModelCopyWithImpl(this._self, this._then);

  final LicenseModel _self;
  final $Res Function(LicenseModel) _then;

/// Create a copy of LicenseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? isActive = null,Object? activeUntil = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? fullName = freezed,Object? phoneNumber = freezed,Object? note = freezed,Object? searchKey = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,activeUntil: freezed == activeUntil ? _self.activeUntil : activeUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,searchKey: null == searchKey ? _self.searchKey : searchKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LicenseModel].
extension LicenseModelPatterns on LicenseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseModel value)  $default,){
final _that = this;
switch (_that) {
case _LicenseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseModel value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  bool isActive,  DateTime? activeUntil,  DateTime? createdAt,  DateTime? updatedAt,  String? fullName,  String? phoneNumber,  String? note,  String searchKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseModel() when $default != null:
return $default(_that.deviceId,_that.isActive,_that.activeUntil,_that.createdAt,_that.updatedAt,_that.fullName,_that.phoneNumber,_that.note,_that.searchKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  bool isActive,  DateTime? activeUntil,  DateTime? createdAt,  DateTime? updatedAt,  String? fullName,  String? phoneNumber,  String? note,  String searchKey)  $default,) {final _that = this;
switch (_that) {
case _LicenseModel():
return $default(_that.deviceId,_that.isActive,_that.activeUntil,_that.createdAt,_that.updatedAt,_that.fullName,_that.phoneNumber,_that.note,_that.searchKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  bool isActive,  DateTime? activeUntil,  DateTime? createdAt,  DateTime? updatedAt,  String? fullName,  String? phoneNumber,  String? note,  String searchKey)?  $default,) {final _that = this;
switch (_that) {
case _LicenseModel() when $default != null:
return $default(_that.deviceId,_that.isActive,_that.activeUntil,_that.createdAt,_that.updatedAt,_that.fullName,_that.phoneNumber,_that.note,_that.searchKey);case _:
  return null;

}
}

}

/// @nodoc


class _LicenseModel extends LicenseModel {
  const _LicenseModel({required this.deviceId, required this.isActive, this.activeUntil, this.createdAt, this.updatedAt, this.fullName, this.phoneNumber, this.note, this.searchKey = ''}): super._();
  

@override final  String deviceId;
@override final  bool isActive;
@override final  DateTime? activeUntil;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  String? fullName;
@override final  String? phoneNumber;
@override final  String? note;
/// In memory only: folded text for search. Never written.
@override@JsonKey() final  String searchKey;

/// Create a copy of LicenseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseModelCopyWith<_LicenseModel> get copyWith => __$LicenseModelCopyWithImpl<_LicenseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseModel&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.activeUntil, activeUntil) || other.activeUntil == activeUntil)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.note, note) || other.note == note)&&(identical(other.searchKey, searchKey) || other.searchKey == searchKey));
}


@override
int get hashCode => Object.hash(runtimeType,deviceId,isActive,activeUntil,createdAt,updatedAt,fullName,phoneNumber,note,searchKey);

@override
String toString() {
  return 'LicenseModel(deviceId: $deviceId, isActive: $isActive, activeUntil: $activeUntil, createdAt: $createdAt, updatedAt: $updatedAt, fullName: $fullName, phoneNumber: $phoneNumber, note: $note, searchKey: $searchKey)';
}


}

/// @nodoc
abstract mixin class _$LicenseModelCopyWith<$Res> implements $LicenseModelCopyWith<$Res> {
  factory _$LicenseModelCopyWith(_LicenseModel value, $Res Function(_LicenseModel) _then) = __$LicenseModelCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, bool isActive, DateTime? activeUntil, DateTime? createdAt, DateTime? updatedAt, String? fullName, String? phoneNumber, String? note, String searchKey
});




}
/// @nodoc
class __$LicenseModelCopyWithImpl<$Res>
    implements _$LicenseModelCopyWith<$Res> {
  __$LicenseModelCopyWithImpl(this._self, this._then);

  final _LicenseModel _self;
  final $Res Function(_LicenseModel) _then;

/// Create a copy of LicenseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? isActive = null,Object? activeUntil = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? fullName = freezed,Object? phoneNumber = freezed,Object? note = freezed,Object? searchKey = null,}) {
  return _then(_LicenseModel(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,activeUntil: freezed == activeUntil ? _self.activeUntil : activeUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,searchKey: null == searchKey ? _self.searchKey : searchKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LicensesPageModel {

 List<LicenseModel> get items; Object? get cursor; bool get hasMore;
/// Create a copy of LicensesPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicensesPageModelCopyWith<LicensesPageModel> get copyWith => _$LicensesPageModelCopyWithImpl<LicensesPageModel>(this as LicensesPageModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicensesPageModel&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.cursor, cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(cursor),hasMore);

@override
String toString() {
  return 'LicensesPageModel(items: $items, cursor: $cursor, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $LicensesPageModelCopyWith<$Res>  {
  factory $LicensesPageModelCopyWith(LicensesPageModel value, $Res Function(LicensesPageModel) _then) = _$LicensesPageModelCopyWithImpl;
@useResult
$Res call({
 List<LicenseModel> items, Object? cursor, bool hasMore
});




}
/// @nodoc
class _$LicensesPageModelCopyWithImpl<$Res>
    implements $LicensesPageModelCopyWith<$Res> {
  _$LicensesPageModelCopyWithImpl(this._self, this._then);

  final LicensesPageModel _self;
  final $Res Function(LicensesPageModel) _then;

/// Create a copy of LicensesPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? cursor = freezed,Object? hasMore = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LicenseModel>,cursor: freezed == cursor ? _self.cursor : cursor ,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LicensesPageModel].
extension LicensesPageModelPatterns on LicensesPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicensesPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicensesPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicensesPageModel value)  $default,){
final _that = this;
switch (_that) {
case _LicensesPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicensesPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _LicensesPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LicenseModel> items,  Object? cursor,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicensesPageModel() when $default != null:
return $default(_that.items,_that.cursor,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LicenseModel> items,  Object? cursor,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _LicensesPageModel():
return $default(_that.items,_that.cursor,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LicenseModel> items,  Object? cursor,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _LicensesPageModel() when $default != null:
return $default(_that.items,_that.cursor,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _LicensesPageModel implements LicensesPageModel {
  const _LicensesPageModel({required final  List<LicenseModel> items, this.cursor, required this.hasMore}): _items = items;
  

 final  List<LicenseModel> _items;
@override List<LicenseModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  Object? cursor;
@override final  bool hasMore;

/// Create a copy of LicensesPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicensesPageModelCopyWith<_LicensesPageModel> get copyWith => __$LicensesPageModelCopyWithImpl<_LicensesPageModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicensesPageModel&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other.cursor, cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(cursor),hasMore);

@override
String toString() {
  return 'LicensesPageModel(items: $items, cursor: $cursor, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$LicensesPageModelCopyWith<$Res> implements $LicensesPageModelCopyWith<$Res> {
  factory _$LicensesPageModelCopyWith(_LicensesPageModel value, $Res Function(_LicensesPageModel) _then) = __$LicensesPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<LicenseModel> items, Object? cursor, bool hasMore
});




}
/// @nodoc
class __$LicensesPageModelCopyWithImpl<$Res>
    implements _$LicensesPageModelCopyWith<$Res> {
  __$LicensesPageModelCopyWithImpl(this._self, this._then);

  final _LicensesPageModel _self;
  final $Res Function(_LicensesPageModel) _then;

/// Create a copy of LicensesPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? cursor = freezed,Object? hasMore = null,}) {
  return _then(_LicensesPageModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LicenseModel>,cursor: freezed == cursor ? _self.cursor : cursor ,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
