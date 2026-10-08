# Performance plan (cross-cutting)

Applies to every phase. Each rule says what is measured or enforced, not only
what is good practice.

## 1. Budgets

| Area | Budget | How it is measured |
|---|---|---|
| Android scrolling (licenses, questions) | No frame over 16 ms in a 5 s fling on a mid-range phone; 99th-percentile raster under 12 ms | `flutter run --profile`, DevTools performance tab |
| Android cold start to the first useful screen | ≤ 2.0 s with a signed-in admin | `adb shell am start -W` plus a timeline mark when the inbox renders |
| Web first load (Chrome, Fast 4G profile, empty cache) | First paint of the branded splash ≤ 1.0 s; interactive shell ≤ 4 s | Lighthouse and the DevTools network tab |
| Web repeat load (warm cache) | Interactive shell ≤ 1.5 s | Same, warm cache |
| Web bundle | Measure in phase 0. Later phases may not grow `main.dart.js` by more than 10% each | `ls -l build/web/main.dart.js` recorded in a table at the end of this file |
| Interaction latency | Tap → visible response ≤ 100 ms (button state, optimistic row change) | Manual check plus the timeline |
| Firestore reads | Cold admin session ≤ 250 reads; the daily total stays well under the Spark free tier of 50k/day | Firebase console usage tab after a typical day |

## 2. Firestore: reads, listeners, writes

**Listener ownership.** Long-lived collection streams belong to blocs that live
for the whole signed-in shell (`@lazySingleton`, provided with
`BlocProvider.value`): `LicensesInboxBloc`, `CategoriesBloc` and
`QuestionsBloc`. Switching tabs doesn't cancel and re-open listeners, so it
doesn't re-read documents. The blocs are closed on sign-out (a `reset()` method
that cancels subscriptions, because singletons are never `close()`d, rule S12).

**Query scope per collection.**

| Collection | Listener | Expected size | Reads per cold session |
|---|---|---|---|
| `categories` | whole collection, `orderBy('order')` | ~10 | ~10 |
| `questions` | whole collection | ~100–1000 | ~100 |
| `licenses` (inbox) | `isActive == false`, `orderBy('createdAt', desc)`, `limit(100)` | bounded | ≤ 100 |
| `licenses` (active, expiring, expired) | `get()` on demand, paged by 50 | — | 50 per page |
| `subscription_plans/monthly` | `get()` when the screen opens | 1 | 1 |

Never stream the whole `licenses` collection.

**Offline cache.** Turn on persistence on web as well as Android
(`FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true)`
before the first query). After a refresh, cached lists render from IndexedDB
before the network replies, which hides most latency. Check the multi-tab
behavior in the phase 0 spike.

**Rebuild filtering.** `snapshots()` is subscribed without
`includeMetadataChanges`. The datasource maps `docChanges` into models only once
per snapshot, and the bloc emits only if the mapped list changed (freezed `==`).

**Optimistic UI is free.** Firestore applies local writes to listeners at once
(`hasPendingWrites`). Approve, revoke and reorder don't need any optimistic
state of their own. The row changes the moment the write is issued. A button
shows its own `submitStatus` only until the write future resolves.

**Writes.**
- Use `update()` or `set(merge: true)` with only the fields the editor owns
  (parent plan §5).
- Reorder writes **only the documents whose `order` changed**, in one
  `WriteBatch`.
- Import (phase 4) splits writes into batches of at most 500 operations and
  commits them in sequence, showing progress.

**Cheap counts.** "Questions in this category" for the UI comes from the
in-memory `QuestionsBloc` list, which costs no reads. The delete guard still
runs the authoritative `count()` aggregation at delete time, which costs one
read.

**Rules cost.** `isAdmin()` uses `exists()`, which is billed as one read per
write. For one admin this is negligible. If it ever matters, set a custom
claim from a local Admin-SDK script (works on Spark) and check
`request.auth.token.admin`.

## 3. State and rebuilds

- Freezed states, so `==` is deep and correct (rule S1). Large lists live in a
  single field. Derived lists such as filtered or searched questions are
  **computed in the bloc** when filters or source data change, and stored in
  state. `build()` never filters or sorts (rule F6).
- Search input is debounced by 250 ms with the template's `Debouncer`.
- Text is normalized once per document when the list is mapped, never per
  keystroke: lowercase, strip Arabic diacritics (tashkeel, U+064B–U+0652), and
  unify `أ إ آ → ا`, `ى → ي` and `ة → ه`. The result is stored as `searchKey`
  on the in-memory model and never written to Firestore.
- If a list grows past ~3000 items, move filtering to `compute()`. Below that,
  it runs in well under a frame.
- Every list row is its own `StatelessWidget` with a `ValueKey(id)` and takes
  only the fields it renders. A changed row rebuilds alone.
- Forms (license, category, question and plan editors): the
  `TextEditingController`s live in the screen's `State`, and the cubit holds the
  draft. Each section listens through `BlocSelector` to its own slice. Typing in
  the title never rebuilds the answers list.
- `BlocListener` handles toasts, navigation and dialogs. These never go in
  builders.

## 4. Lists and scrolling

- Use `ListView.builder` or `SliverList.builder`. Never use `shrinkWrap: true`
  for a list that can grow, and never nest a scroll view inside one.
- Fixed-height rows use `itemExtent` (or `prototypeItem`), which lets the
  viewport skip layout for off-screen rows. License rows and question rows are
  designed to a fixed height (two text lines) for this reason.
- Use `ReorderableListView.builder` for categories, with
  `buildDefaultDragHandles: false` and an explicit handle so a scroll doesn't
  start a drag.
- Put `RepaintBoundary` around each row's image thumbnail only. Rows are cheap,
  so don't wrap whole rows.
- Paging (license filter tabs): load the next page with `startAfterDocument`
  when the user scrolls within 3 rows of the end. Show a footer loader, never a
  full-screen one.

## 5. Images

- **Decode size.** Every `Image.network` sets `cacheWidth` to the rendered
  logical width × `devicePixelRatio`, so a list thumbnail shown at 56 px never
  decodes a 1600 px image. Wrap this in one core widget, `AdminNetworkImage`,
  and use nothing else.
- Placeholders: a fixed-size box in `mutedSurface` with a subtle shimmer while
  loading, and an icon on error. Layout never jumps.
- **Upload size.** Android: `image_picker` with `maxWidth: 1600` and
  `imageQuality: 85`. Web: verify in the phase 0 spike that
  `image_picker_for_web` honors `maxWidth`. If it doesn't, upload as-is and
  enforce the 8 MB limit.
- Validate before uploading by reading the magic bytes (PNG, JPEG, WebP, GIF),
  not the extension.
- Upload progress: `http` multipart has no progress callback, so show an
  indeterminate bar on the image tile and keep the rest of the form usable.

## 6. Web build

- Release builds only for measuring: `flutter build web --release`
  (`--wasm` only if spike D5 passes).
- **Fonts.** Cairo is set as the theme font family. Every Arabic glyph is then
  found in a bundled font, so CanvasKit never downloads Noto fallbacks. That
  download is a common hidden 1–2 s delay. Check this in the network tab.
- **Icon tree-shaking.** Keep `--tree-shake-icons` on (the release default).
  `CategoryIcon` must map names to **const** `IconData` (a `const Map`), never
  build `IconData(codePoint)` at runtime, or the build fails to shake and ships
  the whole Font Awesome font.
- Lazy-load the import/export tool and the question editor with
  `deferred as` (web only gains from this). Do it in phase 4, after the
  baseline shows it is worth it.
- **Splash.** `web/index.html` shows a pure-HTML/CSS branded splash (logo and
  spinner in brand colors) that is removed on the first Flutter frame. Users
  see the brand within ~1 s instead of a blank page while CanvasKit loads.
- **Firebase Hosting headers** in `firebase.json`:
  - `index.html`, `flutter_bootstrap.js`, `flutter_service_worker.js`,
    `version.json`: `Cache-Control: no-cache`
  - `canvaskit/**`: `max-age=31536000, immutable` (the path is versioned by the
    engine)
  - `assets/**`, `main.dart.js`: `max-age=3600`. These are not content-hashed,
    so long caching would serve stale code after a deploy.
- Hosting compresses with gzip/brotli by default. No configuration needed.

## 7. Startup

- `main()` runs `WidgetsFlutterBinding.ensureInitialized` →
  `Firebase.initializeApp` → Firestore settings → DI → `runApp`. Nothing else
  awaits before the first frame (`EasyLocalization` loads only `ar.json`).
- The auth gate listens to `authStateChanges()`. The first event restores the
  session with no network round trip. The `admins/{uid}` check runs once,
  reads from cache first (`Source.cache`, falling back to server) and then
  confirms from the server in the background.
- Don't preload questions on startup. `QuestionsBloc` starts its listener the
  first time the questions tab (or the dashboard) is opened.

## 8. Verification per phase

1. Profile build on Android: scroll every list built in the phase and confirm
   no red frames in the DevTools timeline.
2. Release web build: record bundle size and Lighthouse performance score in
   the table below.
3. Firebase usage tab: reads for one scripted session (open each tab, run one
   search, save one item).
4. Turn on "Highlight repaints" for the editor screens: typing in one field
   repaints only that field.

| Phase | `main.dart.js` | Lighthouse (desktop) | Reads / scripted session |
|---|---|---|---|
| 0 | | | |
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
