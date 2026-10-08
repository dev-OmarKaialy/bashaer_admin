# Phase 0 — Foundation

**Goal:** a signed-out admin app that builds for Android and web, deploys to
Hosting, and already has the shell, the core widgets, and a measured
performance baseline. Every later phase only adds features.

Est. 1.5 d. The parent plan's 1 d plus about half a day for the shell, core
widgets and baseline. That time is saved back in phases 1–3.

## 0.1 Firebase (in `bashaer_user`, parent plan §6)

- [ ] `firestore.rules` as in parent plan §6.
- [ ] `firestore.indexes.json`, **both** indexes:
  ```json
  { "collectionGroup": "licenses", "queryScope": "COLLECTION",
    "fields": [ {"fieldPath": "isActive", "order": "ASCENDING"},
                {"fieldPath": "createdAt", "order": "DESCENDING"} ] },
  { "collectionGroup": "licenses", "queryScope": "COLLECTION",
    "fields": [ {"fieldPath": "isActive", "order": "ASCENDING"},
                {"fieldPath": "activeUntil", "order": "ASCENDING"} ] }
  ```
- [ ] Rules tests in the emulator, covering:
  - anonymous users read categories, questions and plans, and can't write them
  - a student creates a pending row; a create with `activeUntil` is denied; a
    create with `isActive: true` is denied
  - a student can `get` a license but can't `list` licenses
  - a signed-in non-admin can't write
  - the admin can do everything except write `admins`
- [ ] Turn on Email/Password auth, create the admin user, and add the
  `admins/{uid}` doc. Add the Hosting domain to the authorized domains.
- [ ] Deploy rules and indexes **after** the tests pass. The students' app
  doesn't change, so check that it still loads after the deploy.

## 0.2 Scaffold (`D:\projects\bashaer_admin`)

- [ ] New Flutter project from the template (Android + web only). Copy
  `AGENTS.md` and `.agents/`, and update the Project profile: name, app id
  `com.bashaer.admin`, no Hive, no notifications.
- [ ] Keep from `core/`: theme, extensions, `usecase`, `error/failure`,
  `request_status`, `debouncer`, `toaster`, the DI setup, and the
  `main_button`/`main_text_field`/confirmation dialogs.
- [ ] Drop: Hive, notifications, `sfx`, `race/*`, `dio` (unless the
  `unified_api` error types depend on it; check before removing),
  `android_package_installer`, TTS and audio.
- [ ] Dependencies (with C5 approval): `firebase_core`, `cloud_firestore`,
  `firebase_auth`, `http`, `image_picker`, plus D1–D3 from the index if
  approved.
- [ ] `flutterfire configure` for Android and web. `firebase_options.dart` is
  generated and committed (it contains no secret). The ImgBB key comes only
  from `--dart-define`.
- [ ] `lib/core/firebase/firestore_paths.dart`, with all collection names in
  one place.
- [ ] `lib/core/config/env.dart`:
  `const imgbbKey = String.fromEnvironment('IMGBB_API_KEY');` and
  `bool get hasImgbb => imgbbKey.isNotEmpty;`
- [ ] `ar.json` only. `EasyLocalization(supportedLocales: [Locale('ar')])` and
  RTL from the locale.

## 0.3 Shell and core widgets (02-ui-system §3, §4, §6)

- [ ] `app.dart`: `LayoutBuilder` → `ScreenUtilInit` with a design size per
  width class, the text-scale clamp, and the theme with Cairo as default
  family.
- [ ] `AdminScaffold` with four placeholder destinations, an `IndexedStack`
  body, and a pending badge (static 0 for now).
- [ ] Router (if D1 is approved): `/sign-in`, `/licenses`, `/licenses/:id`,
  `/questions`, `/questions/:qid`, `/questions/new`, `/categories`,
  `/categories/:slug`, `/plan`. Use a `redirect` driven by the auth gate's
  state.
- [ ] Core widgets from 02-ui-system §6, each with a widget-gallery entry in a
  debug-only route (`/_gallery`) so they can be checked at all three widths
  before any feature uses them.
- [ ] `web/index.html` HTML/CSS splash in brand colors, removed on the first
  frame.
- [ ] `firebase.json` hosting block and cache headers (01-performance §6).

## 0.4 Spikes (time-boxed, the results are written into this file)

| Spike | Time box | Pass condition | If it fails |
|---|---|---|---|
| ImgBB CORS from Flutter web | 1 h | A release web build uploads a 200 KB PNG and gets `data.url` | Web gets "paste image URL"; Android keeps uploading |
| ImgBB response fields | 15 min | Record the real response JSON (from the seed tool or the spike) here, including whether `thumb`/`medium` URLs exist | Use only `data.url` |
| `image_picker` web resize | 30 min | `maxWidth: 1600` produces a smaller file on web | Upload the original, enforce 8 MB |
| Firestore web persistence | 30 min | Reload shows cached data before network; two tabs open don't error | Turn persistence off on web |
| wasm build (D5) | 1 h | `flutter build web --wasm` builds and runs with all plugins | Use CanvasKit |

Results:

> _fill in_

## 0.5 Baseline

- [ ] Release web build deployed to Hosting. Record `main.dart.js` size and
  the Lighthouse desktop score in the 01-performance table.
- [ ] Profile Android build: cold start to the sign-in screen.
- [ ] Confirm in DevTools that no Noto font is fetched on web.

## Acceptance

- [ ] `flutter build apk --release` and `flutter build web --release` both
  succeed. The analyzer is clean.
- [ ] The deployed web URL shows the splash, then the sign-in placeholder, in
  RTL at 360 / 768 / 1440 px with correct sizing (no 3.7× text).
- [ ] Rules tests pass in the emulator. The students' app still loads the quiz
  and its license check against the deployed rules.
- [ ] Spike results are recorded above, and phase 3's image scope is fixed.
