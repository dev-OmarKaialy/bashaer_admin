import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../models/license_model.dart';
import '../models/license_status.dart';

/// Reads and updates `licenses/{deviceId}`.
///
/// Firestore can't match a missing field, and student rows never carry
/// `activeUntil`, so "pending" can't be queried exactly: the inbox streams
/// every `isActive == false` row and pending/revoked are split on the client.
/// Never streams the whole collection.
abstract class RemoteLicensesDatasource {
  /// Newest first: pending requests and revoked rows.
  Stream<List<LicenseModel>> inboxChanges({required int limit});

  /// One row, live (null when it doesn't exist).
  Stream<LicenseModel?> licenseChanges(String deviceId);

  Future<LicensesPageModel> getPage({
    required LicenseQueryFilter filter,
    required DateTime now,
    required int pageSize,
    Object? cursor,
  });

  /// Server-side counts for the query filters (one read each).
  Future<Map<LicenseQueryFilter, int>> getCounts(DateTime now);

  /// Every row with `isActive == true` (the only ones with admin-entered
  /// name and phone). Loaded once per session for search.
  Future<List<LicenseModel>> getApproved();

  Future<LicenseModel?> getById(String deviceId);

  Future<void> updateAccess({
    required String deviceId,
    required bool isActive,
    DateTime? activeUntil,
  });

  Future<void> updateProfile({
    required String deviceId,
    String? fullName,
    String? phoneNumber,
    String? note,
  });
}

@Injectable(as: RemoteLicensesDatasource)
class RemoteLicensesDatasourceImpl implements RemoteLicensesDatasource {
  RemoteLicensesDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _licenses =>
      _firestore.collection(FirestorePaths.licenses);

  LicenseModel _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) =>
      LicenseModel.fromFirestore(doc.id, doc.data() ?? const {});

  @override
  Stream<List<LicenseModel>> inboxChanges({required int limit}) {
    return _licenses
        .where('isActive', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_fromDoc).toList(growable: false));
  }

  @override
  Stream<LicenseModel?> licenseChanges(String deviceId) {
    return _licenses.doc(deviceId).snapshots().map((doc) => doc.exists ? _fromDoc(doc) : null);
  }

  Query<Map<String, dynamic>> _query(LicenseQueryFilter filter, DateTime now) {
    final nowTs = Timestamp.fromDate(now.toUtc());
    final active = _licenses.where('isActive', isEqualTo: true);
    switch (filter) {
      case LicenseQueryFilter.active:
        return active.where('activeUntil', isGreaterThan: nowTs).orderBy('activeUntil');
      case LicenseQueryFilter.expiring:
        final soon = Timestamp.fromDate(now.toUtc().add(const Duration(days: expiringWindowDays)));
        return active
            .where('activeUntil', isGreaterThan: nowTs)
            .where('activeUntil', isLessThanOrEqualTo: soon)
            .orderBy('activeUntil');
      case LicenseQueryFilter.expired:
        return active
            .where('activeUntil', isLessThanOrEqualTo: nowTs)
            .orderBy('activeUntil', descending: true);
    }
  }

  @override
  Future<LicensesPageModel> getPage({
    required LicenseQueryFilter filter,
    required DateTime now,
    required int pageSize,
    Object? cursor,
  }) async {
    var query = _query(filter, now).limit(pageSize);
    if (cursor is DocumentSnapshot<Map<String, dynamic>>) {
      query = query.startAfterDocument(cursor);
    }
    final snapshot = await query.get();
    return LicensesPageModel(
      items: snapshot.docs.map(_fromDoc).toList(growable: false),
      cursor: snapshot.docs.isEmpty ? cursor : snapshot.docs.last,
      hasMore: snapshot.docs.length == pageSize,
    );
  }

  @override
  Future<Map<LicenseQueryFilter, int>> getCounts(DateTime now) async {
    const filters = LicenseQueryFilter.values;
    final results = await Future.wait(filters.map((f) => _query(f, now).count().get()));
    return {for (var i = 0; i < filters.length; i++) filters[i]: results[i].count ?? 0};
  }

  @override
  Future<List<LicenseModel>> getApproved() async {
    final snapshot = await _licenses.where('isActive', isEqualTo: true).get();
    return snapshot.docs.map(_fromDoc).toList(growable: false);
  }

  @override
  Future<LicenseModel?> getById(String deviceId) async {
    final doc = await _licenses.doc(deviceId).get();
    return doc.exists ? _fromDoc(doc) : null;
  }

  @override
  Future<void> updateAccess({
    required String deviceId,
    required bool isActive,
    DateTime? activeUntil,
  }) {
    return _licenses.doc(deviceId).update({
      'isActive': isActive,
      if (activeUntil != null) 'activeUntil': Timestamp.fromDate(activeUntil.toUtc()),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateProfile({
    required String deviceId,
    String? fullName,
    String? phoneNumber,
    String? note,
  }) {
    return _licenses.doc(deviceId).update({
      'fullName': fullName ?? FieldValue.delete(),
      'phoneNumber': phoneNumber ?? FieldValue.delete(),
      'note': note ?? FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
