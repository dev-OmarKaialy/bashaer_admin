import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The remembered session on this device: which admin document, and the
/// password hash it had at sign-in. Changing the password in Firestore
/// therefore signs every device out.
class StoredSession {
  const StoredSession({required this.adminId, required this.passwordHash});

  final String adminId;
  final String passwordHash;
}

abstract class LocalAuthDatasource {
  Future<StoredSession?> read();

  Future<void> write(StoredSession session);

  Future<void> clear();
}

@Injectable(as: LocalAuthDatasource)
class LocalAuthDatasourceImpl implements LocalAuthDatasource {
  LocalAuthDatasourceImpl(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const _adminIdKey = 'admin_session.id';
  static const _hashKey = 'admin_session.hash';

  @override
  Future<StoredSession?> read() async {
    final adminId = await _prefs.getString(_adminIdKey);
    final hash = await _prefs.getString(_hashKey);
    if (adminId == null || adminId.isEmpty || hash == null || hash.isEmpty) return null;
    return StoredSession(adminId: adminId, passwordHash: hash);
  }

  @override
  Future<void> write(StoredSession session) async {
    await _prefs.setString(_adminIdKey, session.adminId);
    await _prefs.setString(_hashKey, session.passwordHash);
  }

  @override
  Future<void> clear() async {
    await _prefs.remove(_adminIdKey);
    await _prefs.remove(_hashKey);
  }
}
