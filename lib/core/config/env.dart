/// Build-time configuration passed with `--dart-define`. Never commit values.
///
/// `fvm flutter run --dart-define=IMGBB_API_KEY=<key>`
class Env {
  Env._();

  static const String imgbbApiKey = String.fromEnvironment('IMGBB_API_KEY');

  /// Without a key the image upload button is hidden; pasting a URL still works.
  static bool get hasImgbb => imgbbApiKey.isNotEmpty;
}
