/// Build-time configuration, read from `config/env.json` (git-ignored; copy
/// `config/env.example.json`) by passing it to every run/build:
///
/// ```
/// fvm flutter run --dart-define-from-file=config/env.json
/// fvm flutter build apk --release --dart-define-from-file=config/env.json
/// ```
class Env {
  Env._();

  static const String imgbbApiKey = String.fromEnvironment('IMGBB_API_KEY');

  /// Without a key the image upload button is hidden; pasting a URL still works.
  static bool get hasImgbb => imgbbApiKey.isNotEmpty;
}
