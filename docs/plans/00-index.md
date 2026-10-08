# Admin app — sub-plans

These files split `admin-app-plan.md` into work you can carry out and check. The
parent plan still decides **what** to build. These files decide **how** to build
it so it is fast and looks polished on Android phones and on desktop web.

| File | Scope | Used by |
|---|---|---|
| [01-performance.md](01-performance.md) | Cross-cutting performance rules and budgets: Firestore reads, listeners, rebuilds, lists, images, web build, startup | every phase |
| [02-ui-system.md](02-ui-system.md) | Design system, adaptive shell, shared components, the five screen states, RTL, a11y, motion, web ergonomics | every phase |
| [phase-0-foundation.md](phase-0-foundation.md) | Firebase, scaffold, shell, core widgets, spikes, baseline measurements | phase 0 |
| [phase-1-auth-licenses.md](phase-1-auth-licenses.md) | Sign-in, admin gate, licenses inbox, filters, search, editor | phase 1 |
| [phase-2-categories-plan.md](phase-2-categories-plan.md) | Categories CRUD and reorder, icon picker, subscription plan editor | phase 2 |
| [phase-3-questions.md](phase-3-questions.md) | Question list, editor, image upload, preview, merge-save, qid | phase 3 |
| [phase-4-dashboard-import.md](phase-4-dashboard-import.md) | Dashboard, JSON import/export | phase 4 |

## What reading the students' app (`bashaer_user`) found

These findings are not in the parent plan, and each one changes the work:

1. **`flutter_screenutil` uses `designSize: Size(390, 844)`.** On a 1440 px
   browser every `.sp`, `.w` and `.r` grows about 3.7×, which makes the web
   admin unusable. The admin app must choose the design size by width class
   (see 02-ui-system §3). This is the largest UI risk on web.
2. **`QuizNetworkImage` uses `Image.file` and `QuizMediaCache`, which need
   `dart:io`.** It can't be copied as-is for the quiz preview. The admin
   version is network-only (see phase 3).
3. **License filters need a second composite index.** The plan lists only
   `isActive ASC, createdAt DESC`. Active, expiring and expired all query
   `isActive == true` with a range on `activeUntil`, so they also need
   `licenses (isActive ASC, activeUntil ASC)`.
4. **Firestore can't query "pending" exactly.** Student rows never contain
   `activeUntil`, and Firestore can't match a missing field. The inbox
   streams `isActive == false` and splits pending from revoked on the client
   (see phase 1).
5. **Firestore has no full-text search.** Name and phone search runs in memory
   over a session cache (see phase 1). That is fine at one school's volume,
   and phase 1 records the threshold at which to switch approaches.

## Order and gates

```
phase 0 ──► phase 1 ──► phase 2 ──► phase 3 ──► phase 4
   │  core widgets, shell, perf baseline are built once in phase 0
   └─ spikes (CORS, wasm, image_picker web resize) decide phase 3 scope
```

A phase is **done** when:
- every acceptance box in its file is ticked
- it meets the performance budgets in 01-performance §1 on a mid-range Android
  phone (profile build) and on Chrome desktop (release build)
- it renders all five states (02-ui-system §5) for every data-driven screen
- `dart analyze` is clean and the approved tests pass

## Decisions (answered 2026-10-08)

| # | Question | Decision |
|---|---|---|
| D1 | `go_router` for URL routing on web? | **No.** Simple admin app; imperative `Navigator` like the template. A web refresh returns to the licenses tab. |
| D2 | `intl` for Arabic dates? | **Yes**, added. |
| D3 | `bloc_test` / tests? | **No test files.** The owner tests the app manually. |
| D4 | Dark theme? | **No.** |
| D5 | Build web/Android here? | **No builds.** Code only; the owner runs and tests the app. Wasm is not decided. |

## Implementation notes (where the code differs from these plans)

- **Screen sizing:** instead of a design size per width class, `ScreenUtilInit` keeps the
  students' 390×844 design and turns scaling **off** at ≥ 600 px (`enableScaleWH` /
  `enableScaleText`), so desktop uses sizes 1:1.
- **Answer ids are kept, not renumbered.** Seeded data uses `a1…`, `a`/`b`/`c` and
  `true`/`false`. Renaming them could break students' saved answer history, so only new
  answers get the next free `aN`. `correctAnswerIds` is still remapped by id.
- **qids:** the seed bank also has `ts01`–`ts05`. `nextQid` only counts `qN` ids. A banner
  warns when the next id is wider than the existing ones and would sort out of order
  in the students' app.
- **Third license index:** expired licenses are listed newest first, so
  `licenses (isActive ASC, activeUntil DESC)` is also needed (three indexes in total).
- **Merge updates** write only the editor's fields. Unknown fields such as `audio`
  survive on their own, so the models carry no `extra` map.
- **Image upload** has a "paste link" fallback that always works, so a CORS failure on web
  doesn't block anything.
- **Phase 4** (dashboard, import/export) is not implemented yet.
- **No subscription editor.** The owner removed it (2026-10-08). The fourth tab
  is **Profile** (signed-in admin, session info, how to change the password, sign out).
  The students' app still reads `subscription_plans/monthly`; it is edited in the
  Firebase console.
- **Auth:** username + password checked against the Firestore `admins` collection
  (PBKDF2), with no Firebase Auth. See `docs/admin-account.md`.
