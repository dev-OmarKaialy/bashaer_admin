import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Password hashing for `admins` documents: PBKDF2-HMAC-SHA256.
///
/// - `salt`: 16 random bytes as 32 hex characters.
/// - `passwordHash`: the 32-byte derived key as 64 hex characters.
/// - `iterations`: stored on the document so it can be raised later.
///
/// `tool/admin_password.dart` uses this same class to generate the values.
class PasswordHasher {
  PasswordHasher._();

  /// Low enough to stay under ~1 s on web, where hashing runs in JavaScript.
  static const int defaultIterations = 20000;

  static const int _keyLength = 32;

  static String newSalt() {
    final random = Random.secure();
    return _hex(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  static String hash({required String password, required String salt, required int iterations}) {
    final hmac = Hmac(sha256, utf8.encode(password));
    final saltBytes = _fromHex(salt);
    final output = <int>[];
    for (var block = 1; output.length < _keyLength; block++) {
      // U1 = HMAC(P, S || INT(block)); T = U1 ^ U2 ^ ... ^ Uc
      final blockIndex = Uint8List(4)..buffer.asByteData().setUint32(0, block);
      var u = hmac.convert([...saltBytes, ...blockIndex]).bytes;
      final t = Uint8List.fromList(u);
      for (var i = 1; i < iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < t.length; j++) {
          t[j] ^= u[j];
        }
      }
      output.addAll(t);
    }
    return _hex(output.sublist(0, _keyLength));
  }

  /// Compares in constant time, so timing doesn't reveal how much matched.
  static bool verify({
    required String password,
    required String salt,
    required int iterations,
    required String expectedHash,
  }) {
    final actual = hash(password: password, salt: salt, iterations: iterations);
    final expected = expectedHash.toLowerCase();
    if (actual.length != expected.length) return false;
    var diff = 0;
    for (var i = 0; i < actual.length; i++) {
      diff |= actual.codeUnitAt(i) ^ expected.codeUnitAt(i);
    }
    return diff == 0;
  }

  static String _hex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  static List<int> _fromHex(String hex) {
    final clean = hex.trim();
    if (clean.length.isOdd || !RegExp(r'^[0-9a-fA-F]*$').hasMatch(clean)) {
      throw const FormatException('salt must be hex');
    }
    return [
      for (var i = 0; i < clean.length; i += 2) int.parse(clean.substring(i, i + 2), radix: 16),
    ];
  }
}
