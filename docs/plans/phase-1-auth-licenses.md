# Phase 1 — Auth and licenses

**Goal:** the admin signs in and approves a new student in **under 10
seconds** from opening the app: open → inbox → approve → choose a period →
done.

Est. 2–3 d.

## 1.1 Auth and admin gate

**Data**
- `AuthRemoteDataSource`:
  - `authStateChanges()`
  - `signIn(email, password)`
  - `signOut()`
  - `isAdmin(uid)`: `get` of `admins/{uid}`, cache first and then server (01-performance §7)
- Map `FirebaseAuthException` codes to Arabic messages:
  - `invalid-credential` / `wrong-password` / `user-not-found` → "البريد أو كلمة المرور غير صحيحة"
  - `too-many-requests` → "محاولات كثيرة، حاول لاحقًا"
  - `network-request-failed` → "تحقق من الاتصال"

**State** — `AuthCubit` (singleton) with a sealed state:
`unknown | signedOut | checking | notAdmin | admin(user)`.
- `notAdmin` signs out and shows "هذا الحساب ليس لديه صلاحية الإدارة".
- On sign-out, the cubit calls `reset()` on every feature bloc
  (01-performance §2).

**UI** — `SignInScreen`
- A centered `PanelCard`, max width 420, with logo, title "لوحة إدارة البشائر",
  email and password fields. The password field has a visibility toggle (a
  `ValueNotifier`, rule F1).
- Enter submits. `autofillHints` for email and password, so browsers and
  Android can autofill.
- The button shows loading. Errors appear inline under the form, not as a
  toast.
- No sign-up and no "forgot password" (one admin; the password is reset in the
  console).
- `unknown` state: show the splash-style logo, not a spinner.

## 1.2 Licenses data

**Model** — `LicenseModel` (freezed) with these fields:
- `deviceId`, `isActive`, `activeUntil?`, `createdAt?`, `updatedAt?`
- `fullName?`, `phoneNumber?`, `note?`
- computed `searchKey` (01-performance §3)

Use `Timestamp` ↔ `DateTime` converters. A single place derives the status:

```dart
enum LicenseStatus { pending, active, expiring, expired, revoked }
LicenseStatus statusOf(LicenseModel l, DateTime now) // mirrors LicenseRepositoryImpl._evaluate
```
`expiring` = active and `activeUntil - now ≤ 7 days`. This function is the
**only** source of status for pills, filters and counts, and it is unit-tested
against the table in parent plan §1.

**Queries** (indexes from phase 0):

| View | Query | Mode |
|---|---|---|
| Inbox (pending + recently revoked) | `isActive == false`, `orderBy createdAt desc`, `limit 100` | stream |
| Active | `isActive == true`, `activeUntil >= now`, `orderBy activeUntil` | get, page 50 |
| Expiring | `isActive == true`, `activeUntil in [now, now+7d]`, `orderBy activeUntil` | get, page 50 |
| Expired | `isActive == true`, `activeUntil < now`, `orderBy activeUntil desc` | get, page 50 |
| Revoked | from the inbox stream where `activeUntil != null` | in memory |
| Single | `doc(deviceId)` | stream while the detail is open |

**Pending vs revoked.** Firestore can't filter on a missing `activeUntil`, so
the inbox stream is split on the client. If revoked rows ever crowd out
pending ones within the 100-row limit, add `revokedAt` on revoke (ignored by
the students' app) and query pending with `orderBy createdAt` on a separate,
narrower query. Don't do this until it is needed.

**Search.**
- A device id that is pasted (long, no spaces) → direct `doc(id).get()`. That
  is exact and costs one read.
- Name or phone → on the first search of the session, `get()` every license
  where `isActive == true` (the only rows with admin-entered name and phone),
  cache it in the bloc, and filter in memory against `searchKey`. Refresh this
  cache whenever a write happens in this app.
- Revisit if there are more than ~2000 licenses. At that point, store
  normalized `searchTokens` (phone suffixes, name words) and use
  `arrayContains`.

**Writes** (use cases; every write also sets
`updatedAt: FieldValue.serverTimestamp()`):

| Use case | Write |
|---|---|
| `approve` / `extend(until)` | `isActive: true`, `activeUntil: endOfLocalDay(until)` as a UTC `Timestamp` |
| `revoke` | `isActive: false` (keep `activeUntil`) |
| `undoRevoke(prev)` | `isActive: true` with the previous `activeUntil` |
| `updateProfile` | `fullName`, `phoneNumber` (normalized), `note`. Only these fields |

Preset math: `base = max(today, activeUntil ?? today)`, then
`until = addMonths(base, n)`, clamped to the end of the month (Jan 31 + 1 month
gives Feb 28/29).

## 1.3 State

- `LicensesInboxBloc` (singleton): owns the inbox stream, the active filter,
  the search query, the session search cache, and the paged lists per filter.
  State fields include:
  - `inbox`, `visible` (derived), `filter`, `query`
  - `counts` (per filter, shown on chips)
  - `pages` (per filter: items, `lastDoc`, `hasMore`, status)
  - `getInboxStatus`, `searchStatus`
- `LicenseEditorCubit` (factory, one per open license): holds the draft
  (`until`, `fullName`, `phone`, `note`), `isDirty`, `submitStatus`, and
  `lastAction` for undo.
- The pending count for the nav badge comes from a `BlocSelector` on the inbox
  bloc, so only the badge rebuilds.

## 1.4 UI

**Licenses screen (list pane)**

```
┌ الطلبات ───────────────────────────────── 🔍 بحث بالرقم أو الاسم أو الهاتف ┐
│ [قيد الانتظار ٣] [نشط ٤٢] [ينتهي قريبًا ٥] [منتهي ١١] [موقوف ٢]               │
├──────────────────────────────────────────────────────────────────────────────┤
│ ⏳ قيد الانتظار   a1b2c3…f9  ⧉            منذ ١٢ دقيقة          [تفعيل ▾]   │
│ ✔ نشط           أحمد محمد · 0599…        ينتهي بعد ٢٣ يومًا        [تمديد]   │
└──────────────────────────────────────────────────────────────────────────────┘
```
- Fixed-height rows (`itemExtent`). The row shows a status pill, the name or a
  shortened device id (`IdText` with a copy button), a relative date, and one
  primary inline action that fits the status:
  - pending → تفعيل
  - active or expiring → تمديد
  - expired → تجديد
  - revoked → إعادة تفعيل
- **Quick approve**: the inline button opens a compact popover/bottom sheet
  with the 1/3/6/12-month chips (3 months preselected). One more tap confirms.
  So approving takes two taps without opening the detail.
- A new pending row arriving on the live stream slides in at the top with a
  brief highlight. The badge count animates.
- Empty inbox: "لا توجد طلبات جديدة 🎉".

**License detail / editor (detail pane or pushed route)**
- Header: the full device id (selectable, with copy), a large status pill, and
  "منذ … / ينتهي …".
- **Access** section:
  - preset chips: +1, +3, +6, +12 months
  - a date field that opens the template's `LocalizedDatePicker`
    (`firstDate` = tomorrow)
  - a live summary line: "سيصبح نشطًا حتى ١٥ يناير ٢٠٢٧ (٩٨ يومًا)"
- **Student** section: name, phone (with the country code picker if the
  template's `phone_parser` setup is reused), and note (multi-line).
- Actions: primary "تفعيل" / "تمديد" / "حفظ"; destructive "إيقاف" in the
  overflow menu with a confirm dialog → a toast with "تراجع" for 5 s.
- `UnsavedChangesGuard` and `Ctrl+S`.
- Fields a student might have injected (anything not listed in the model) are
  ignored when read and never shown.

## 1.5 Tests (after approval, C7)

- `statusOf`: every row of parent plan §1, plus the `expiring` boundary at
  exactly 7 days and a timezone check (end of local day → UTC).
- Preset math: extend from active (keeps the remaining days), from expired
  (starts today), and the month-end clamp.
- `LicenseEditorCubit`: approve, revoke then undo, profile update writes only
  the profile fields (mock the repository with mocktail).
- Inbox split: pending vs revoked from mixed snapshots.

## Acceptance

- [ ] A student's request from the students' app appears in the open inbox
  within ~2 s without a refresh, on both platforms.
- [ ] Two-tap approve from the list. The students' app then shows access.
- [ ] Revoke → the students' app shows *inactive*, not *pending*. Undo
  restores the previous `activeUntil`.
- [ ] Extending an active license with 1 month adds to its current
  `activeUntil`.
- [ ] Search finds a license by pasted device id, by part of a name (ignoring
  hamza and ta-marbuta differences), and by the last 4 digits of a phone.
- [ ] Filter chip counts match the lists. Paging loads more with no
  full-screen loader.
- [ ] Performance and UI checklists in 01 §8 and 02 §10 pass.
