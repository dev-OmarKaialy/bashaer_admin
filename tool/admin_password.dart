// Generates the `salt`, `passwordHash` and `iterations` fields for an
// `admins` document (see docs/admin-account.md).
//
//   fvm dart run tool/admin_password.dart
//
// The password is read from the terminal without echo, so it never lands in
// your shell history. Paste the printed values into the Firestore console.
import 'dart:io';

import 'package:bashaer_admin/features/auth/data/models/password_hasher.dart';

void main() {
  final password = _readHidden('New admin password: ');
  if (password.length < 8) {
    stderr.writeln('Use at least 8 characters.');
    exitCode = 64;
    return;
  }
  final again = _readHidden('Repeat the password: ');
  if (again != password) {
    stderr.writeln('The two passwords differ. Nothing was generated.');
    exitCode = 64;
    return;
  }

  final salt = PasswordHasher.newSalt();
  const iterations = PasswordHasher.defaultIterations;
  final hash = PasswordHasher.hash(password: password, salt: salt, iterations: iterations);

  stdout
    ..writeln()
    ..writeln('Set these fields on the admins document (types in brackets):')
    ..writeln('  salt          (string)  $salt')
    ..writeln('  passwordHash  (string)  $hash')
    ..writeln('  iterations    (number)  $iterations');
}

String _readHidden(String prompt) {
  stdout.write(prompt);
  final canHide = stdin.hasTerminal;
  if (canHide) stdin.echoMode = false;
  try {
    return stdin.readLineSync() ?? '';
  } finally {
    if (canHide) {
      stdin.echoMode = true;
      stdout.writeln();
    }
  }
}
