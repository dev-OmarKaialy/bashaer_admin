import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../models/admin_account_model.dart';

/// Reads admin accounts from the Firestore `admins` collection. There is no
/// Firebase Auth: the password is checked in the app against the stored hash.
abstract class RemoteAuthDatasource {
  /// The account with this exact username, or null.
  Future<AdminAccountModel?> findByUsername(String username);

  /// Fresh copy of an account (session restore), or null when deleted.
  Future<AdminAccountModel?> getById(String id);
}

@Injectable(as: RemoteAuthDatasource)
class RemoteAuthDatasourceImpl implements RemoteAuthDatasource {
  RemoteAuthDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _admins =>
      _firestore.collection(FirestorePaths.admins);

  @override
  Future<AdminAccountModel?> findByUsername(String username) async {
    final snapshot = await _admins
        .where('username', isEqualTo: username)
        .limit(1)
        .get(const GetOptions(source: Source.server));
    if (snapshot.docs.isEmpty) return null;
    final doc = snapshot.docs.first;
    return AdminAccountModel.fromFirestore(doc.id, doc.data());
  }

  @override
  Future<AdminAccountModel?> getById(String id) async {
    final doc = await _admins.doc(id).get();
    final data = doc.data();
    if (!doc.exists || data == null) return null;
    return AdminAccountModel.fromFirestore(doc.id, data);
  }
}
