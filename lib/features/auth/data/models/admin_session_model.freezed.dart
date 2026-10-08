// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminSessionModel {

/// Document id in `admins`.
 String get id; String get username; String? get displayName;
/// Create a copy of AdminSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminSessionModelCopyWith<AdminSessionModel> get copyWith => _$AdminSessionModelCopyWithImpl<AdminSessionModel>(this as AdminSessionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,id,username,displayName);

@override
String toString() {
  return 'AdminSessionModel(id: $id, username: $username, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $AdminSessionModelCopyWith<$Res>  {
  factory $AdminSessionModelCopyWith(AdminSessionModel value, $Res Function(AdminSessionModel) _then) = _$AdminSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? displayName
});




}
/// @nodoc
class _$AdminSessionModelCopyWithImpl<$Res>
    implements $AdminSessionModelCopyWith<$Res> {
  _$AdminSessionModelCopyWithImpl(this._self, this._then);

  final AdminSessionModel _self;
  final $Res Function(AdminSessionModel) _then;

/// Create a copy of AdminSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminSessionModel].
extension AdminSessionModelPatterns on AdminSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _AdminSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _AdminSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminSessionModel() when $default != null:
return $default(_that.id,_that.username,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName)  $default,) {final _that = this;
switch (_that) {
case _AdminSessionModel():
return $default(_that.id,_that.username,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? displayName)?  $default,) {final _that = this;
switch (_that) {
case _AdminSessionModel() when $default != null:
return $default(_that.id,_that.username,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc


class _AdminSessionModel implements AdminSessionModel {
  const _AdminSessionModel({required this.id, required this.username, this.displayName});
  

/// Document id in `admins`.
@override final  String id;
@override final  String username;
@override final  String? displayName;

/// Create a copy of AdminSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminSessionModelCopyWith<_AdminSessionModel> get copyWith => __$AdminSessionModelCopyWithImpl<_AdminSessionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,id,username,displayName);

@override
String toString() {
  return 'AdminSessionModel(id: $id, username: $username, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$AdminSessionModelCopyWith<$Res> implements $AdminSessionModelCopyWith<$Res> {
  factory _$AdminSessionModelCopyWith(_AdminSessionModel value, $Res Function(_AdminSessionModel) _then) = __$AdminSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? displayName
});




}
/// @nodoc
class __$AdminSessionModelCopyWithImpl<$Res>
    implements _$AdminSessionModelCopyWith<$Res> {
  __$AdminSessionModelCopyWithImpl(this._self, this._then);

  final _AdminSessionModel _self;
  final $Res Function(_AdminSessionModel) _then;

/// Create a copy of AdminSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,}) {
  return _then(_AdminSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
