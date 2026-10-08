/// One `admins/{id}` document, as `docs/admin-account.md` describes it:
/// `username`, `salt`, `passwordHash`, `iterations`, optional `displayName`.
class AdminAccountModel {
  const AdminAccountModel({
    required this.id,
    required this.username,
    required this.salt,
    required this.passwordHash,
    required this.iterations,
    this.displayName,
  });

  final String id;
  final String username;
  final String salt;
  final String passwordHash;

  /// Null when the document has no `iterations` (not set up with the tool).
  final int? iterations;
  final String? displayName;

  factory AdminAccountModel.fromFirestore(String id, Map<String, dynamic> data) {
    final iterations = data['iteration'];
    final displayName = (data['displayName'] as String?)?.trim();
    print(data);
    return AdminAccountModel(
      id: id,
      username: (data['username'] as String?)?.trim() ?? '',
      salt: (data['salt'] as String?)?.trim() ?? '',
      passwordHash: (data['passwordHash'] as String?)?.trim().toLowerCase() ?? '',
      iterations: iterations is num && iterations > 0 ? iterations.toInt() : null,
      displayName: displayName == null || displayName.isEmpty ? null : displayName,
    );
  }
}
