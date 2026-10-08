import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/arabic_normalizer.dart';

part 'license_model.freezed.dart';

/// One `licenses/{deviceId}` row.
///
/// The students' app writes `deviceId`, `isActive: false` and `createdAt`; the
/// admin adds `activeUntil`, the profile fields and `updatedAt`. Any other
/// field a student might inject is ignored here and never shown.
@freezed
abstract class LicenseModel with _$LicenseModel {
  const factory LicenseModel({
    required String deviceId,
    required bool isActive,
    DateTime? activeUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullName,
    String? phoneNumber,
    String? note,

    /// In memory only: folded text for search. Never written.
    @Default('') String searchKey,
  }) = _LicenseModel;

  const LicenseModel._();

  factory LicenseModel.fromFirestore(String id, Map<String, dynamic> data) {
    final fullName = _text(data['fullName']);
    final phoneNumber = _text(data['phoneNumber']);
    final note = _text(data['note']);
    return LicenseModel(
      deviceId: id,
      isActive: data['isActive'] == true,
      activeUntil: _date(data['activeUntil']),
      createdAt: _date(data['createdAt']),
      updatedAt: _date(data['updatedAt']),
      fullName: fullName,
      phoneNumber: phoneNumber,
      note: note,
      searchKey: normalizeForSearch(
        [id, fullName, phoneNumber, note].whereType<String>().join(' '),
      ),
    );
  }

  /// Name if the admin entered one, otherwise null (the UI shows the id).
  String? get displayName => fullName;

  static String? _text(Object? raw) {
    if (raw is! String) return null;
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  /// Same parsing as the students' app (`parseLicenseDate`).
  static DateTime? _date(Object? raw) {
    if (raw is Timestamp) return raw.toDate().toUtc();
    if (raw is DateTime) return raw.toUtc();
    if (raw is String) return DateTime.tryParse(raw.trim())?.toUtc();
    return null;
  }
}

/// One page of a filtered license list. [cursor] is opaque to the domain
/// (the last Firestore snapshot of the page).
@freezed
abstract class LicensesPageModel with _$LicensesPageModel {
  const factory LicensesPageModel({
    required List<LicenseModel> items,
    Object? cursor,
    required bool hasMore,
  }) = _LicensesPageModel;
}
