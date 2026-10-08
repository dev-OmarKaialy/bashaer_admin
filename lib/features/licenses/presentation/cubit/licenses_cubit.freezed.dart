// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'licenses_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LicenseListItem {

 LicenseModel get license; LicenseStatus get status;
/// Create a copy of LicenseListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseListItemCopyWith<LicenseListItem> get copyWith => _$LicenseListItemCopyWithImpl<LicenseListItem>(this as LicenseListItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseListItem&&(identical(other.license, license) || other.license == license)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,license,status);

@override
String toString() {
  return 'LicenseListItem(license: $license, status: $status)';
}


}

/// @nodoc
abstract mixin class $LicenseListItemCopyWith<$Res>  {
  factory $LicenseListItemCopyWith(LicenseListItem value, $Res Function(LicenseListItem) _then) = _$LicenseListItemCopyWithImpl;
@useResult
$Res call({
 LicenseModel license, LicenseStatus status
});


$LicenseModelCopyWith<$Res> get license;

}
/// @nodoc
class _$LicenseListItemCopyWithImpl<$Res>
    implements $LicenseListItemCopyWith<$Res> {
  _$LicenseListItemCopyWithImpl(this._self, this._then);

  final LicenseListItem _self;
  final $Res Function(LicenseListItem) _then;

/// Create a copy of LicenseListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? license = null,Object? status = null,}) {
  return _then(_self.copyWith(
license: null == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as LicenseModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LicenseStatus,
  ));
}
/// Create a copy of LicenseListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseModelCopyWith<$Res> get license {
  
  return $LicenseModelCopyWith<$Res>(_self.license, (value) {
    return _then(_self.copyWith(license: value));
  });
}
}


/// Adds pattern-matching-related methods to [LicenseListItem].
extension LicenseListItemPatterns on LicenseListItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseListItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseListItem value)  $default,){
final _that = this;
switch (_that) {
case _LicenseListItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseListItem value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseListItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LicenseModel license,  LicenseStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseListItem() when $default != null:
return $default(_that.license,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LicenseModel license,  LicenseStatus status)  $default,) {final _that = this;
switch (_that) {
case _LicenseListItem():
return $default(_that.license,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LicenseModel license,  LicenseStatus status)?  $default,) {final _that = this;
switch (_that) {
case _LicenseListItem() when $default != null:
return $default(_that.license,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _LicenseListItem implements LicenseListItem {
  const _LicenseListItem({required this.license, required this.status});
  

@override final  LicenseModel license;
@override final  LicenseStatus status;

/// Create a copy of LicenseListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseListItemCopyWith<_LicenseListItem> get copyWith => __$LicenseListItemCopyWithImpl<_LicenseListItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseListItem&&(identical(other.license, license) || other.license == license)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,license,status);

@override
String toString() {
  return 'LicenseListItem(license: $license, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LicenseListItemCopyWith<$Res> implements $LicenseListItemCopyWith<$Res> {
  factory _$LicenseListItemCopyWith(_LicenseListItem value, $Res Function(_LicenseListItem) _then) = __$LicenseListItemCopyWithImpl;
@override @useResult
$Res call({
 LicenseModel license, LicenseStatus status
});


@override $LicenseModelCopyWith<$Res> get license;

}
/// @nodoc
class __$LicenseListItemCopyWithImpl<$Res>
    implements _$LicenseListItemCopyWith<$Res> {
  __$LicenseListItemCopyWithImpl(this._self, this._then);

  final _LicenseListItem _self;
  final $Res Function(_LicenseListItem) _then;

/// Create a copy of LicenseListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? license = null,Object? status = null,}) {
  return _then(_LicenseListItem(
license: null == license ? _self.license : license // ignore: cast_nullable_to_non_nullable
as LicenseModel,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LicenseStatus,
  ));
}

/// Create a copy of LicenseListItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseModelCopyWith<$Res> get license {
  
  return $LicenseModelCopyWith<$Res>(_self.license, (value) {
    return _then(_self.copyWith(license: value));
  });
}
}

/// @nodoc
mixin _$LicensePageState {

 List<LicenseModel> get items; Object? get cursor; bool get hasMore; RequestStatus get status; String? get errorKey;
/// Create a copy of LicensePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicensePageStateCopyWith<LicensePageState> get copyWith => _$LicensePageStateCopyWithImpl<LicensePageState>(this as LicensePageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicensePageState&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.cursor, cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(cursor),hasMore,status,errorKey);

@override
String toString() {
  return 'LicensePageState(items: $items, cursor: $cursor, hasMore: $hasMore, status: $status, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class $LicensePageStateCopyWith<$Res>  {
  factory $LicensePageStateCopyWith(LicensePageState value, $Res Function(LicensePageState) _then) = _$LicensePageStateCopyWithImpl;
@useResult
$Res call({
 List<LicenseModel> items, Object? cursor, bool hasMore, RequestStatus status, String? errorKey
});




}
/// @nodoc
class _$LicensePageStateCopyWithImpl<$Res>
    implements $LicensePageStateCopyWith<$Res> {
  _$LicensePageStateCopyWithImpl(this._self, this._then);

  final LicensePageState _self;
  final $Res Function(LicensePageState) _then;

/// Create a copy of LicensePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? cursor = freezed,Object? hasMore = null,Object? status = null,Object? errorKey = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LicenseModel>,cursor: freezed == cursor ? _self.cursor : cursor ,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LicensePageState].
extension LicensePageStatePatterns on LicensePageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicensePageState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicensePageState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicensePageState value)  $default,){
final _that = this;
switch (_that) {
case _LicensePageState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicensePageState value)?  $default,){
final _that = this;
switch (_that) {
case _LicensePageState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LicenseModel> items,  Object? cursor,  bool hasMore,  RequestStatus status,  String? errorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicensePageState() when $default != null:
return $default(_that.items,_that.cursor,_that.hasMore,_that.status,_that.errorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LicenseModel> items,  Object? cursor,  bool hasMore,  RequestStatus status,  String? errorKey)  $default,) {final _that = this;
switch (_that) {
case _LicensePageState():
return $default(_that.items,_that.cursor,_that.hasMore,_that.status,_that.errorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LicenseModel> items,  Object? cursor,  bool hasMore,  RequestStatus status,  String? errorKey)?  $default,) {final _that = this;
switch (_that) {
case _LicensePageState() when $default != null:
return $default(_that.items,_that.cursor,_that.hasMore,_that.status,_that.errorKey);case _:
  return null;

}
}

}

/// @nodoc


class _LicensePageState implements LicensePageState {
  const _LicensePageState({final  List<LicenseModel> items = const <LicenseModel>[], this.cursor, this.hasMore = true, this.status = RequestStatus.init, this.errorKey}): _items = items;
  

 final  List<LicenseModel> _items;
@override@JsonKey() List<LicenseModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  Object? cursor;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  RequestStatus status;
@override final  String? errorKey;

/// Create a copy of LicensePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicensePageStateCopyWith<_LicensePageState> get copyWith => __$LicensePageStateCopyWithImpl<_LicensePageState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicensePageState&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other.cursor, cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(cursor),hasMore,status,errorKey);

@override
String toString() {
  return 'LicensePageState(items: $items, cursor: $cursor, hasMore: $hasMore, status: $status, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class _$LicensePageStateCopyWith<$Res> implements $LicensePageStateCopyWith<$Res> {
  factory _$LicensePageStateCopyWith(_LicensePageState value, $Res Function(_LicensePageState) _then) = __$LicensePageStateCopyWithImpl;
@override @useResult
$Res call({
 List<LicenseModel> items, Object? cursor, bool hasMore, RequestStatus status, String? errorKey
});




}
/// @nodoc
class __$LicensePageStateCopyWithImpl<$Res>
    implements _$LicensePageStateCopyWith<$Res> {
  __$LicensePageStateCopyWithImpl(this._self, this._then);

  final _LicensePageState _self;
  final $Res Function(_LicensePageState) _then;

/// Create a copy of LicensePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? cursor = freezed,Object? hasMore = null,Object? status = null,Object? errorKey = freezed,}) {
  return _then(_LicensePageState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LicenseModel>,cursor: freezed == cursor ? _self.cursor : cursor ,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LicenseActionOutcome {

 int get seq; String get deviceId; LicenseActionKind get kind; DateTime? get until; String? get errorKey;
/// Create a copy of LicenseActionOutcome
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseActionOutcomeCopyWith<LicenseActionOutcome> get copyWith => _$LicenseActionOutcomeCopyWithImpl<LicenseActionOutcome>(this as LicenseActionOutcome, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseActionOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.until, until) || other.until == until)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,seq,deviceId,kind,until,errorKey);

@override
String toString() {
  return 'LicenseActionOutcome(seq: $seq, deviceId: $deviceId, kind: $kind, until: $until, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class $LicenseActionOutcomeCopyWith<$Res>  {
  factory $LicenseActionOutcomeCopyWith(LicenseActionOutcome value, $Res Function(LicenseActionOutcome) _then) = _$LicenseActionOutcomeCopyWithImpl;
@useResult
$Res call({
 int seq, String deviceId, LicenseActionKind kind, DateTime? until, String? errorKey
});




}
/// @nodoc
class _$LicenseActionOutcomeCopyWithImpl<$Res>
    implements $LicenseActionOutcomeCopyWith<$Res> {
  _$LicenseActionOutcomeCopyWithImpl(this._self, this._then);

  final LicenseActionOutcome _self;
  final $Res Function(LicenseActionOutcome) _then;

/// Create a copy of LicenseActionOutcome
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seq = null,Object? deviceId = null,Object? kind = null,Object? until = freezed,Object? errorKey = freezed,}) {
  return _then(_self.copyWith(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LicenseActionKind,until: freezed == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime?,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LicenseActionOutcome].
extension LicenseActionOutcomePatterns on LicenseActionOutcome {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseActionOutcome value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseActionOutcome() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseActionOutcome value)  $default,){
final _that = this;
switch (_that) {
case _LicenseActionOutcome():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseActionOutcome value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseActionOutcome() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int seq,  String deviceId,  LicenseActionKind kind,  DateTime? until,  String? errorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseActionOutcome() when $default != null:
return $default(_that.seq,_that.deviceId,_that.kind,_that.until,_that.errorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int seq,  String deviceId,  LicenseActionKind kind,  DateTime? until,  String? errorKey)  $default,) {final _that = this;
switch (_that) {
case _LicenseActionOutcome():
return $default(_that.seq,_that.deviceId,_that.kind,_that.until,_that.errorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int seq,  String deviceId,  LicenseActionKind kind,  DateTime? until,  String? errorKey)?  $default,) {final _that = this;
switch (_that) {
case _LicenseActionOutcome() when $default != null:
return $default(_that.seq,_that.deviceId,_that.kind,_that.until,_that.errorKey);case _:
  return null;

}
}

}

/// @nodoc


class _LicenseActionOutcome implements LicenseActionOutcome {
  const _LicenseActionOutcome({required this.seq, required this.deviceId, required this.kind, this.until, this.errorKey});
  

@override final  int seq;
@override final  String deviceId;
@override final  LicenseActionKind kind;
@override final  DateTime? until;
@override final  String? errorKey;

/// Create a copy of LicenseActionOutcome
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseActionOutcomeCopyWith<_LicenseActionOutcome> get copyWith => __$LicenseActionOutcomeCopyWithImpl<_LicenseActionOutcome>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseActionOutcome&&(identical(other.seq, seq) || other.seq == seq)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.until, until) || other.until == until)&&(identical(other.errorKey, errorKey) || other.errorKey == errorKey));
}


@override
int get hashCode => Object.hash(runtimeType,seq,deviceId,kind,until,errorKey);

@override
String toString() {
  return 'LicenseActionOutcome(seq: $seq, deviceId: $deviceId, kind: $kind, until: $until, errorKey: $errorKey)';
}


}

/// @nodoc
abstract mixin class _$LicenseActionOutcomeCopyWith<$Res> implements $LicenseActionOutcomeCopyWith<$Res> {
  factory _$LicenseActionOutcomeCopyWith(_LicenseActionOutcome value, $Res Function(_LicenseActionOutcome) _then) = __$LicenseActionOutcomeCopyWithImpl;
@override @useResult
$Res call({
 int seq, String deviceId, LicenseActionKind kind, DateTime? until, String? errorKey
});




}
/// @nodoc
class __$LicenseActionOutcomeCopyWithImpl<$Res>
    implements _$LicenseActionOutcomeCopyWith<$Res> {
  __$LicenseActionOutcomeCopyWithImpl(this._self, this._then);

  final _LicenseActionOutcome _self;
  final $Res Function(_LicenseActionOutcome) _then;

/// Create a copy of LicenseActionOutcome
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seq = null,Object? deviceId = null,Object? kind = null,Object? until = freezed,Object? errorKey = freezed,}) {
  return _then(_LicenseActionOutcome(
seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as LicenseActionKind,until: freezed == until ? _self.until : until // ignore: cast_nullable_to_non_nullable
as DateTime?,errorKey: freezed == errorKey ? _self.errorKey : errorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LicensesState {

 RequestStatus get inboxStatus; String? get inboxErrorKey; List<LicenseModel> get inbox; LicenseFilter get filter; Map<LicenseQueryFilter, LicensePageState> get pages; Map<LicenseFilter, int> get counts; String get query; RequestStatus get searchStatus; String? get searchErrorKey;/// What the list renders, derived from the fields above.
 List<LicenseListItem> get visible;/// Rows with a quick action in flight.
 Set<String> get busyIds; LicenseActionOutcome? get lastOutcome;
/// Create a copy of LicensesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicensesStateCopyWith<LicensesState> get copyWith => _$LicensesStateCopyWithImpl<LicensesState>(this as LicensesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicensesState&&(identical(other.inboxStatus, inboxStatus) || other.inboxStatus == inboxStatus)&&(identical(other.inboxErrorKey, inboxErrorKey) || other.inboxErrorKey == inboxErrorKey)&&const DeepCollectionEquality().equals(other.inbox, inbox)&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other.pages, pages)&&const DeepCollectionEquality().equals(other.counts, counts)&&(identical(other.query, query) || other.query == query)&&(identical(other.searchStatus, searchStatus) || other.searchStatus == searchStatus)&&(identical(other.searchErrorKey, searchErrorKey) || other.searchErrorKey == searchErrorKey)&&const DeepCollectionEquality().equals(other.visible, visible)&&const DeepCollectionEquality().equals(other.busyIds, busyIds)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,inboxStatus,inboxErrorKey,const DeepCollectionEquality().hash(inbox),filter,const DeepCollectionEquality().hash(pages),const DeepCollectionEquality().hash(counts),query,searchStatus,searchErrorKey,const DeepCollectionEquality().hash(visible),const DeepCollectionEquality().hash(busyIds),lastOutcome);

@override
String toString() {
  return 'LicensesState(inboxStatus: $inboxStatus, inboxErrorKey: $inboxErrorKey, inbox: $inbox, filter: $filter, pages: $pages, counts: $counts, query: $query, searchStatus: $searchStatus, searchErrorKey: $searchErrorKey, visible: $visible, busyIds: $busyIds, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class $LicensesStateCopyWith<$Res>  {
  factory $LicensesStateCopyWith(LicensesState value, $Res Function(LicensesState) _then) = _$LicensesStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus inboxStatus, String? inboxErrorKey, List<LicenseModel> inbox, LicenseFilter filter, Map<LicenseQueryFilter, LicensePageState> pages, Map<LicenseFilter, int> counts, String query, RequestStatus searchStatus, String? searchErrorKey, List<LicenseListItem> visible, Set<String> busyIds, LicenseActionOutcome? lastOutcome
});


$LicenseActionOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class _$LicensesStateCopyWithImpl<$Res>
    implements $LicensesStateCopyWith<$Res> {
  _$LicensesStateCopyWithImpl(this._self, this._then);

  final LicensesState _self;
  final $Res Function(LicensesState) _then;

/// Create a copy of LicensesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inboxStatus = null,Object? inboxErrorKey = freezed,Object? inbox = null,Object? filter = null,Object? pages = null,Object? counts = null,Object? query = null,Object? searchStatus = null,Object? searchErrorKey = freezed,Object? visible = null,Object? busyIds = null,Object? lastOutcome = freezed,}) {
  return _then(_self.copyWith(
inboxStatus: null == inboxStatus ? _self.inboxStatus : inboxStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,inboxErrorKey: freezed == inboxErrorKey ? _self.inboxErrorKey : inboxErrorKey // ignore: cast_nullable_to_non_nullable
as String?,inbox: null == inbox ? _self.inbox : inbox // ignore: cast_nullable_to_non_nullable
as List<LicenseModel>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LicenseFilter,pages: null == pages ? _self.pages : pages // ignore: cast_nullable_to_non_nullable
as Map<LicenseQueryFilter, LicensePageState>,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as Map<LicenseFilter, int>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchStatus: null == searchStatus ? _self.searchStatus : searchStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,searchErrorKey: freezed == searchErrorKey ? _self.searchErrorKey : searchErrorKey // ignore: cast_nullable_to_non_nullable
as String?,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as List<LicenseListItem>,busyIds: null == busyIds ? _self.busyIds : busyIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as LicenseActionOutcome?,
  ));
}
/// Create a copy of LicensesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseActionOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $LicenseActionOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}


/// Adds pattern-matching-related methods to [LicensesState].
extension LicensesStatePatterns on LicensesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicensesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicensesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicensesState value)  $default,){
final _that = this;
switch (_that) {
case _LicensesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicensesState value)?  $default,){
final _that = this;
switch (_that) {
case _LicensesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus inboxStatus,  String? inboxErrorKey,  List<LicenseModel> inbox,  LicenseFilter filter,  Map<LicenseQueryFilter, LicensePageState> pages,  Map<LicenseFilter, int> counts,  String query,  RequestStatus searchStatus,  String? searchErrorKey,  List<LicenseListItem> visible,  Set<String> busyIds,  LicenseActionOutcome? lastOutcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicensesState() when $default != null:
return $default(_that.inboxStatus,_that.inboxErrorKey,_that.inbox,_that.filter,_that.pages,_that.counts,_that.query,_that.searchStatus,_that.searchErrorKey,_that.visible,_that.busyIds,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus inboxStatus,  String? inboxErrorKey,  List<LicenseModel> inbox,  LicenseFilter filter,  Map<LicenseQueryFilter, LicensePageState> pages,  Map<LicenseFilter, int> counts,  String query,  RequestStatus searchStatus,  String? searchErrorKey,  List<LicenseListItem> visible,  Set<String> busyIds,  LicenseActionOutcome? lastOutcome)  $default,) {final _that = this;
switch (_that) {
case _LicensesState():
return $default(_that.inboxStatus,_that.inboxErrorKey,_that.inbox,_that.filter,_that.pages,_that.counts,_that.query,_that.searchStatus,_that.searchErrorKey,_that.visible,_that.busyIds,_that.lastOutcome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus inboxStatus,  String? inboxErrorKey,  List<LicenseModel> inbox,  LicenseFilter filter,  Map<LicenseQueryFilter, LicensePageState> pages,  Map<LicenseFilter, int> counts,  String query,  RequestStatus searchStatus,  String? searchErrorKey,  List<LicenseListItem> visible,  Set<String> busyIds,  LicenseActionOutcome? lastOutcome)?  $default,) {final _that = this;
switch (_that) {
case _LicensesState() when $default != null:
return $default(_that.inboxStatus,_that.inboxErrorKey,_that.inbox,_that.filter,_that.pages,_that.counts,_that.query,_that.searchStatus,_that.searchErrorKey,_that.visible,_that.busyIds,_that.lastOutcome);case _:
  return null;

}
}

}

/// @nodoc


class _LicensesState extends LicensesState {
  const _LicensesState({this.inboxStatus = RequestStatus.init, this.inboxErrorKey, final  List<LicenseModel> inbox = const <LicenseModel>[], this.filter = LicenseFilter.pending, final  Map<LicenseQueryFilter, LicensePageState> pages = const <LicenseQueryFilter, LicensePageState>{}, final  Map<LicenseFilter, int> counts = const <LicenseFilter, int>{}, this.query = '', this.searchStatus = RequestStatus.init, this.searchErrorKey, final  List<LicenseListItem> visible = const <LicenseListItem>[], final  Set<String> busyIds = const <String>{}, this.lastOutcome}): _inbox = inbox,_pages = pages,_counts = counts,_visible = visible,_busyIds = busyIds,super._();
  

@override@JsonKey() final  RequestStatus inboxStatus;
@override final  String? inboxErrorKey;
 final  List<LicenseModel> _inbox;
@override@JsonKey() List<LicenseModel> get inbox {
  if (_inbox is EqualUnmodifiableListView) return _inbox;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inbox);
}

@override@JsonKey() final  LicenseFilter filter;
 final  Map<LicenseQueryFilter, LicensePageState> _pages;
@override@JsonKey() Map<LicenseQueryFilter, LicensePageState> get pages {
  if (_pages is EqualUnmodifiableMapView) return _pages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pages);
}

 final  Map<LicenseFilter, int> _counts;
@override@JsonKey() Map<LicenseFilter, int> get counts {
  if (_counts is EqualUnmodifiableMapView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_counts);
}

@override@JsonKey() final  String query;
@override@JsonKey() final  RequestStatus searchStatus;
@override final  String? searchErrorKey;
/// What the list renders, derived from the fields above.
 final  List<LicenseListItem> _visible;
/// What the list renders, derived from the fields above.
@override@JsonKey() List<LicenseListItem> get visible {
  if (_visible is EqualUnmodifiableListView) return _visible;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visible);
}

/// Rows with a quick action in flight.
 final  Set<String> _busyIds;
/// Rows with a quick action in flight.
@override@JsonKey() Set<String> get busyIds {
  if (_busyIds is EqualUnmodifiableSetView) return _busyIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_busyIds);
}

@override final  LicenseActionOutcome? lastOutcome;

/// Create a copy of LicensesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicensesStateCopyWith<_LicensesState> get copyWith => __$LicensesStateCopyWithImpl<_LicensesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicensesState&&(identical(other.inboxStatus, inboxStatus) || other.inboxStatus == inboxStatus)&&(identical(other.inboxErrorKey, inboxErrorKey) || other.inboxErrorKey == inboxErrorKey)&&const DeepCollectionEquality().equals(other._inbox, _inbox)&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other._pages, _pages)&&const DeepCollectionEquality().equals(other._counts, _counts)&&(identical(other.query, query) || other.query == query)&&(identical(other.searchStatus, searchStatus) || other.searchStatus == searchStatus)&&(identical(other.searchErrorKey, searchErrorKey) || other.searchErrorKey == searchErrorKey)&&const DeepCollectionEquality().equals(other._visible, _visible)&&const DeepCollectionEquality().equals(other._busyIds, _busyIds)&&(identical(other.lastOutcome, lastOutcome) || other.lastOutcome == lastOutcome));
}


@override
int get hashCode => Object.hash(runtimeType,inboxStatus,inboxErrorKey,const DeepCollectionEquality().hash(_inbox),filter,const DeepCollectionEquality().hash(_pages),const DeepCollectionEquality().hash(_counts),query,searchStatus,searchErrorKey,const DeepCollectionEquality().hash(_visible),const DeepCollectionEquality().hash(_busyIds),lastOutcome);

@override
String toString() {
  return 'LicensesState(inboxStatus: $inboxStatus, inboxErrorKey: $inboxErrorKey, inbox: $inbox, filter: $filter, pages: $pages, counts: $counts, query: $query, searchStatus: $searchStatus, searchErrorKey: $searchErrorKey, visible: $visible, busyIds: $busyIds, lastOutcome: $lastOutcome)';
}


}

/// @nodoc
abstract mixin class _$LicensesStateCopyWith<$Res> implements $LicensesStateCopyWith<$Res> {
  factory _$LicensesStateCopyWith(_LicensesState value, $Res Function(_LicensesState) _then) = __$LicensesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus inboxStatus, String? inboxErrorKey, List<LicenseModel> inbox, LicenseFilter filter, Map<LicenseQueryFilter, LicensePageState> pages, Map<LicenseFilter, int> counts, String query, RequestStatus searchStatus, String? searchErrorKey, List<LicenseListItem> visible, Set<String> busyIds, LicenseActionOutcome? lastOutcome
});


@override $LicenseActionOutcomeCopyWith<$Res>? get lastOutcome;

}
/// @nodoc
class __$LicensesStateCopyWithImpl<$Res>
    implements _$LicensesStateCopyWith<$Res> {
  __$LicensesStateCopyWithImpl(this._self, this._then);

  final _LicensesState _self;
  final $Res Function(_LicensesState) _then;

/// Create a copy of LicensesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inboxStatus = null,Object? inboxErrorKey = freezed,Object? inbox = null,Object? filter = null,Object? pages = null,Object? counts = null,Object? query = null,Object? searchStatus = null,Object? searchErrorKey = freezed,Object? visible = null,Object? busyIds = null,Object? lastOutcome = freezed,}) {
  return _then(_LicensesState(
inboxStatus: null == inboxStatus ? _self.inboxStatus : inboxStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,inboxErrorKey: freezed == inboxErrorKey ? _self.inboxErrorKey : inboxErrorKey // ignore: cast_nullable_to_non_nullable
as String?,inbox: null == inbox ? _self._inbox : inbox // ignore: cast_nullable_to_non_nullable
as List<LicenseModel>,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LicenseFilter,pages: null == pages ? _self._pages : pages // ignore: cast_nullable_to_non_nullable
as Map<LicenseQueryFilter, LicensePageState>,counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as Map<LicenseFilter, int>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchStatus: null == searchStatus ? _self.searchStatus : searchStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,searchErrorKey: freezed == searchErrorKey ? _self.searchErrorKey : searchErrorKey // ignore: cast_nullable_to_non_nullable
as String?,visible: null == visible ? _self._visible : visible // ignore: cast_nullable_to_non_nullable
as List<LicenseListItem>,busyIds: null == busyIds ? _self._busyIds : busyIds // ignore: cast_nullable_to_non_nullable
as Set<String>,lastOutcome: freezed == lastOutcome ? _self.lastOutcome : lastOutcome // ignore: cast_nullable_to_non_nullable
as LicenseActionOutcome?,
  ));
}

/// Create a copy of LicensesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseActionOutcomeCopyWith<$Res>? get lastOutcome {
    if (_self.lastOutcome == null) {
    return null;
  }

  return $LicenseActionOutcomeCopyWith<$Res>(_self.lastOutcome!, (value) {
    return _then(_self.copyWith(lastOutcome: value));
  });
}
}

// dart format on
