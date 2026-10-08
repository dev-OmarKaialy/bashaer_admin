# Phase 4 — Dashboard and import/export

Est. 2 d.

## 4.1 Dashboard (الرئيسية)

**Data**, built to cost almost nothing in reads:
- License counts: `count()` aggregations, one per bucket. Each costs one read
  per 1000 index entries:
  - pending/revoked: `isActive == false`
  - active: `isActive == true && activeUntil >= now`
  - expiring: `… <= now+7d`
  - expired: `isActive == true && activeUntil < now`
  
  Pending vs revoked is taken from the inbox stream already in memory.
- Questions per category: from `QuestionsBloc` and `CategoriesBloc`, which are
  in memory and cost no reads.
- Refresh on open and pull-to-refresh. No streams for counts.

**UI**
```
┌ الرئيسية ──────────────────────────────────────────────────────────────┐
│ [⏳ قيد الانتظار ٣ →] [✔ نشط ٤٢] [⏰ ينتهي خلال ٧ أيام ٥ →] [✖ منتهي ١١] │
│ ┌ تنتهي قريبًا ─────────────┐  ┌ الأسئلة حسب التصنيف ─────────────────┐ │
│ │ أحمد · بعد ٢ يوم [تمديد] │  │ إشارات المرور  ███████████  ٣١        │ │
│ │ …                         │  │ الوقود         ████  ١٢               │ │
│ └───────────────────────────┘  └───────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────────┘
```
- Stat tiles are tappable and open the licenses tab with that filter applied.
  The numbers animate once with the template's `AnimatedCount`.
- "تنتهي قريبًا": the first 5 expiring licenses, each with an inline extend
  action that reuses the phase 1 quick-approve popover.
- Questions per category: horizontal bars drawn with plain widgets
  (`FractionallySizedBox`), with no chart package. Bars are sorted by count
  and use category accent colors.
- Layout: tiles in a `Wrap` (4 across on expanded, 2 on compact), then the two
  panels side by side on expanded and stacked on compact.

## 4.2 Export

- Exports `{ categories: [...], questions: [...], exportedAt }` with **every
  field**, including `extra`. The format is the one the seed tool reads, so
  the export can seed a fresh project. Check the seed tool's input format
  first (rule C3).
- Built from the in-memory blocs, so it costs no reads. The JSON is encoded in
  `compute()`.
- Download:
  - web: a `Blob` and anchor through `package:web`. Check whether this needs
    approval as a direct dependency (it is already transitive).
  - Android: the share sheet or a save-file dialog. Pick whatever existing
    package covers it, or ask before adding one (C5).

## 4.3 Import

A guarded, multi-step flow. Import is the most dangerous feature in the app.

1. **Pick** a JSON file (`image_picker` doesn't cover files; Android needs a
   file picker → C5 approval). On web, drag and drop onto a drop zone as well.
2. **Validate** in `compute()` with the seed tool's validation rules, ported
   into a pure-Dart `QuestionBankValidator` shared by the import and the tests.
   It reports per-row errors with a path (e.g. `questions[12].answers[1].text:
   فارغ`).
3. **Diff** against the in-memory data. Show a summary: "جديد ١٢ · معدّل ٤ ·
   بلا تغيير ٦٧ · أخطاء ٢". The admin can expand each group. Modified rows
   show a field-level diff (old → new).
4. **Options**:
   - skip rows with errors (default on)
   - update existing (default on; uses merge-update, never overwrite)
   - never delete. Import doesn't delete documents missing from the file
     (state this in the UI).
5. **Write** in batches of ≤ 500 operations, committed in sequence, with a
   progress bar ("٢٠٠ / ٨٣٠"). The screen can't be closed while it runs. On
   failure, stop, report how many batches were committed, and offer a retry
   of the rest. Batches are idempotent because they are merge-updates by id.
6. **Done**: summary and a link to the questions list filtered to the changed
   rows.

Trial questions (q01–q05) that change are flagged in the diff with the trial
pill.

**Performance**
- Deferred-load this screen on web (`deferred as import_page`), and also the
  export encoder. Measure the bundle size before and after, and record it in
  the 01-performance table.
- Parsing, validation and diffing all run in `compute()`. The UI only renders
  the summary and a lazy list of the expanded group.

## 4.4 Tests (after approval)

- `QuestionBankValidator` against the seed tool's own fixtures, if they exist.
  Otherwise use the exported production data as a fixture.
- Diff: new, modified (field-level) and unchanged; the `extra` field is
  preserved.
- Batch splitter: 1, 500, 501 and 1201 ops.
- Export → import round-trip of production data gives "بلا تغيير" for every
  row.

## Acceptance

- [ ] Dashboard numbers match the license filter counts and the question
  list. A cold dashboard costs ≤ 10 reads beyond what the blocs already
  loaded.
- [ ] Export → import into the emulator recreates the bank exactly. The
  students' app pointed at the emulator works unchanged.
- [ ] An import with deliberate errors shows them by path and imports only the
  valid rows.
- [ ] The web bundle didn't grow more than 10% (deferred loading works).
- [ ] 01 §8 and 02 §10 checklists pass.
