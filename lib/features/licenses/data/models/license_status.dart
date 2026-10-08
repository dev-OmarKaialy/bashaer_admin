import 'license_model.dart';

/// What the student currently sees, mirrored from the students' app
/// (`LicenseRepositoryImpl._evaluate`), plus `expiring` as an admin hint.
enum LicenseStatus { pending, active, expiring, expired, revoked }

/// The filters that query Firestore directly (the rest come from the inbox).
enum LicenseQueryFilter { active, expiring, expired }

/// Days before `activeUntil` at which an active license counts as expiring.
const int expiringWindowDays = 7;

/// The single source of a license's status: pills, filters and counts all use
/// this, so they always agree with each other and with the students' app.
///
/// | isActive | activeUntil | status   |
/// |----------|-------------|----------|
/// | false    | null        | pending  |
/// | false    | set         | revoked  |
/// | true     | null        | pending  |
/// | true     | past        | expired  |
/// | true     | ≤ 7 days    | expiring |
/// | true     | later       | active   |
LicenseStatus statusOf(LicenseModel license, DateTime now) {
  final until = license.activeUntil;
  if (!license.isActive) return until == null ? LicenseStatus.pending : LicenseStatus.revoked;
  if (until == null) return LicenseStatus.pending;
  final nowUtc = now.toUtc();
  // Students' app: expired when now.isAfter(activeUntil).
  if (nowUtc.isAfter(until)) return LicenseStatus.expired;
  if (until.difference(nowUtc) <= const Duration(days: expiringWindowDays)) {
    return LicenseStatus.expiring;
  }
  return LicenseStatus.active;
}
