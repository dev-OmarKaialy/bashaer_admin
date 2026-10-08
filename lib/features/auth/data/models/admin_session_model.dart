import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_session_model.freezed.dart';

/// The signed-in admin: their `admins/{id}` document.
@freezed
abstract class AdminSessionModel with _$AdminSessionModel {
  const factory AdminSessionModel({
    /// Document id in `admins`.
    required String id,
    required String username,
    String? displayName,
  }) = _AdminSessionModel;
}
