# UI system plan (cross-cutting)

The goal: an admin tool that **looks like part of the Bashaer brand** (same
palette, font and icons as the students' app) but behaves like a **calm,
dense, fast work tool**. The students' app is playful ("Turbo" racing theme,
speed lines, Lottie). The admin keeps the colors and drops the theatrics.

## 1. Principles

1. **Brand tokens, work-tool density.** Reuse `AppTheme` colors, radii, spacing
   and the Cairo font. Don't use `SpeedLinesBackground`, race animations or
   engine sounds.
2. **Status is color plus a word plus an icon.** Never color alone (a11y). The
   same license status always looks the same everywhere.
3. **The most common task is one tap from the start.** Approving a pending
   license is the daily job. The inbox is the home screen, and Approve is on
   the row.
4. **Never lose work.** Editors track dirty state. Leaving with unsaved changes
   asks first, and failed saves keep the form.
5. **Show what students will see.** Category icons and question cards preview
   with the same renderers the students' app uses.

## 2. Tokens (from `AppTheme`, admin-specific roles added)

Copy `AppTheme` from the template. Add a small `AdminTokens` section **only for
roles**, with no new hex values (rule F10):

| Role | Token | Use |
|---|---|---|
| Page background | `skyBackground` | scaffold |
| Panel | `cardSurface` + 1 px `divider` border, `radiusM` | list panel, editor panel, cards |
| Selected row | `nitroBlue` at 8% alpha + a 3 px start-edge bar in `nitroBlue` | master-detail selection |
| Hover row (web) | `mutedSurface` | pointer hover |
| Pending | `warningColor` / `warningBackgroundColor`, icon `hourglass_top` | license status |
| Active | `successColor` / `successBackgroundColor`, icon `verified` | license status |
| Expiring ≤ 7 d | `turboOrange` on an 12% tint, icon `schedule` | license status |
| Expired | `dangerColor` / `dangerBackgroundColor`, icon `event_busy` | license status |
| Revoked | `inkSoft` on `mutedSurface`, icon `block` | license status |
| Trial question | `electricViolet` tint, label "تجريبي" | question rows |
| Ids (device id, qid, slug) | `ChakraPetch` 600, `SelectableText` | wherever an id is shown |

Text: Cairo 400/600/700 only. Scale: display 28, title 20, subtitle 16, body
14, caption 12. Use these through `textTheme`, never inline sizes.

## 3. Responsive sizing (fixes the screenutil problem)

The template scales everything against a 390 × 844 design. On web desktop that
makes the UI about 3.7× too big. Rule for the admin app:

- `ScreenUtilInit` sits under a `LayoutBuilder` in `app.dart` and picks
  `designSize` by width class:
  - **compact** < 600 → `Size(390, 844)` (same as the students' app)
  - **medium** 600–1099 → `Size(834, 1112)`
  - **expanded** ≥ 1100 → `Size(1440, 900)`
  
  Also set `minTextAdapt: true`, `splitScreenMode: true`. Crossing a breakpoint
  rebuilds the tree once, which is acceptable because it is rare.
- On top of that, clamp the text scale (`MediaQuery.textScalerOf(context)
  .clamp(minScaleFactor: 0.9, maxScaleFactor: 1.3)`) so OS font scaling can't
  break dense tables while it still helps readability.
- Content never stretches edge to edge. Lists have a max width of 560, editors
  720 and forms 480, centered in their panel.
- Branch layout on `MediaQuery.sizeOf(context).width` and the breakpoints
  above, never on platform (rule F11). An Android tablet gets the same
  two-pane layout as web.

## 4. App shell

```
compact (<600)                        expanded (≥1100), RTL
┌─────────────────────────┐   ┌──────────┬─────────────────────┬──────────────┐
│ AppBar: title  🔍  ⋮    │   │ Rail     │ List panel (≤560)   │ Detail panel │
│                         │   │ (extended│  search + filters   │  editor /    │
│ list                    │   │  labels) │  rows…              │  preview     │
│                         │   │ ● طلبات⁽³⁾│                     │              │
│                         │   │   الأسئلة │                     │              │
├─────────────────────────┤   │   التصنيفات│                     │              │
│ NavigationBar (4 items) │   │   الاشتراك │                     │              │
└─────────────────────────┘   └──────────┴─────────────────────┴──────────────┘
```
(The rail sits on the right because the layout is RTL.)

- Destinations: **الطلبات** (licenses, with a badge for the pending count),
  **الأسئلة**, **التصنيفات** and **الاشتراك**. In phase 4 a **الرئيسية**
  dashboard goes first.
- compact: `NavigationBar`, and a detail is a pushed route.
- medium: collapsed `NavigationRail`, list and detail side by side when width
  ≥ 900, otherwise pushed.
- expanded: extended `NavigationRail` and two panes. Selecting a row fills the
  detail pane without a route push, and the URL still changes (with D1).
- The tab body is an `IndexedStack` so scroll positions and search text survive
  tab switches. The blocs are singletons (01-performance §2).
- Account menu (⋮ / avatar): signed-in email and sign out.

## 5. Five states for every data screen (rule F8)

| State | Pattern |
|---|---|
| initial / loading | **Skeleton rows** with the same height as real rows (`flutter_animate` `.shimmer()`, already in the template). No center spinner on list screens. |
| error | Inline panel: icon, Arabic message from the failure mapping, and "إعادة المحاولة". Never a raw exception. Cached data stays visible with a thin error banner above it. |
| empty | Illustration (a template Lottie, played once rather than looped), a one-line explanation, and the primary action, e.g. "لا توجد طلبات جديدة" or "أضف أول سؤال". An empty search result is a different message ("لا نتائج لـ «…»") with a "مسح البحث" action. |
| data | The list. |
| offline | A thin top banner, "أنت غير متصل — التغييرات ستُرسل عند عودة الاتصال", driven by Firestore `snapshotsInSync` / `hasPendingWrites` together with connectivity. No new package. |

## 6. Shared components (build in phase 0, reuse everywhere)

Put these in `lib/core/widgets/admin/`. Each one is a small `const`-able
`StatelessWidget`:

| Widget | Purpose |
|---|---|
| `AdminScaffold` | Adaptive shell: chooses bar, rail or extended rail and one or two panes |
| `MasterDetail` | List and detail panes, resizable divider on expanded, push on compact |
| `PanelCard` | Surface with border and radius, optional header row (title + actions) |
| `SearchField` | Debounced search with a clear button. `/` focuses it on web |
| `FilterChipsBar` | Horizontally scrollable chips with counts, e.g. "قيد الانتظار ٣" |
| `StatusPill` | Color + icon + label from one `enum`, used by licenses and questions |
| `SkeletonList` | N fixed-height shimmer rows |
| `EmptyState`, `ErrorState` | See §5 |
| `AdminNetworkImage` | The single image widget, with `cacheWidth`, placeholder and error (01-performance §5) |
| `IdText` | Monospace selectable id with a copy button (toast "تم النسخ") |
| `ConfirmDialog` | Built on the template's `IconConfirmationDialog`. Destructive variant in red, and the confirm button names the action ("حذف السؤال"), not "نعم" |
| `UnsavedChangesGuard` | `PopScope` plus a dialog when the editor cubit says it is dirty |
| `SaveBar` | Sticky bottom bar on compact, header actions on expanded: "حفظ" (primary, shows loading) and "إلغاء" |
| `RelativeDateText` | "منذ ٣ ساعات", "ينتهي بعد ٥ أيام", with the full date in a tooltip |

## 7. Feedback and motion

- **Toasts** (template `Toaster` / `bot_toast`): success is short (2 s). An
  undoable action shows "تراجع" for 5 s (revoke, and delete of an answer while
  editing). Errors stay until dismissed.
- **Motion** is fast and subtle: 150–200 ms, `Curves.easeOutCubic`. Rows
  fade-and-slide in once on first load, staggered by 20 ms and capped at the
  first 12 rows. Status pills cross-fade (`AnimatedSwitcher`) when a license
  changes state. No looping animations on work screens.
- Respect `MediaQuery.disableAnimations`, which skips entrance animations.

## 8. Web and desktop ergonomics

- Hover states on rows and buttons, with a `SystemMouseCursors.click` cursor.
- Visible focus rings (`FocusTheme` / `focusColor` = `nitroBlue` at 40%).
  Logical tab order in editors.
- Keyboard shortcuts through `Shortcuts`/`Actions` at the shell level:
  - `/` focuses search
  - `Ctrl+S` saves the open editor
  - `Esc` closes the detail or dialog
  - `Ctrl+N` creates a new item on the current tab
  - `↑`/`↓` move the selection in the list, `Enter` opens it
- `SelectableText` for ids and long texts the admin may copy.
- Tooltips on every icon-only button (rule F14). Tap targets ≥ 48 px even on
  desktop.

## 9. RTL and Arabic

- `EdgeInsetsDirectional`, `AlignmentDirectional` and `start`/`end`
  everywhere (rule F12). Arrow icons use their directional variants.
- Numbers: Western digits in ids, prices and dates. They match the students'
  app and are what the admin types. Check what the students' app shows and
  match it.
- Mixed content (an Arabic title containing a Latin plate code) is wrapped in
  `Directionality`-aware `Text` with no manual direction marks. Test with real
  seeded data.
- All strings live in `assets/translations/ar.json`, with keys grouped by
  feature (`licenses.approve`, …), rule F13.

## 10. UI review checklist (run at the end of each phase)

- [ ] Checked at 360 px, 768 px and 1440 px widths. No overflow stripes and no
      horizontal scroll.
- [ ] Every data screen shows skeleton, error, empty, empty-search and data
      states.
- [ ] Every destructive action asks for confirmation and names the action.
      Revoke offers undo.
- [ ] Keyboard-only run-through on web: reach and complete the phase's main
      task without a mouse.
- [ ] TalkBack pass on the main task: every control is announced with a label.
- [ ] System font scale at 1.3: nothing is clipped.
- [ ] No hex literals or `Colors.*` in feature code
      (`grep -rn "Color(0x\|Colors\." lib/features`).
