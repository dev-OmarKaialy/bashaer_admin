/// Collection and document names shared with the students' app. One place,
/// so a typo can't silently write to a collection nobody reads.
class FirestorePaths {
  FirestorePaths._();

  static const String admins = 'admins';
  static const String categories = 'categories';
  static const String questions = 'questions';
  static const String licenses = 'licenses';
}
