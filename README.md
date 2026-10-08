# Bashaer Admin

Admin app for Al-Bashaer driving school (Android + web, Arabic/RTL). It manages
what the students' app (`bashaer_user`) reads from Firestore project
`bashaer-68ee6`: license requests, categories, questions and the monthly plan.

Plans: `admin-app-plan.md` and `docs/plans/`.

## One-time setup

1. **Firebase rules and indexes** (in `bashaer_user`, already edited there):
   ```
   firebase deploy --only firestore
   ```
   Test the rules in the emulator first. The students' app keeps working: its
   only write (a pending license request) is still allowed.
2. **Admin account (username + password):** accounts live in the Firestore
   `admins` collection, with no Firebase Auth. Follow `docs/admin-account.md`:
   run `fvm dart run tool/admin_password.dart`, then paste `salt`,
   `passwordHash` and `iterations` into the admin document.
3. **Firebase options:** done (`flutterfire configure` registered Android
   `com.bashaer.admin` and the web app `bashaer_admin (web)`).

## ImgBB key (question images)

The key is read at build time from `config/env.json`, which is git-ignored:

```json
{
  "IMGBB_API_KEY": "<your imgbb key>"
}
```

`config/env.example.json` is the committed template. With an empty key the
"upload image" button is hidden; pasting an image link still works.

## Run

```
fvm flutter pub get
fvm flutter run -d chrome --dart-define-from-file=config/env.json
fvm flutter run -d <android-device> --dart-define-from-file=config/env.json
```

VS Code: the configurations in `.vscode/launch.json` already pass the file.

## Release APK (signed with android/key.properties)

```
fvm flutter build apk --release --dart-define-from-file=config/env.json
```

## Codegen

```
fvm dart run build_runner build --delete-conflicting-outputs
```

## Web deploy

```
fvm flutter build web --release --dart-define-from-file=config/env.json
firebase deploy --only hosting
```
`firebase.json` here sets the hosting cache headers and `noindex`.
