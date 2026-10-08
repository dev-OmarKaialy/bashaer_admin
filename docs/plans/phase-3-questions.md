# Phase 3 — Questions

**Goal:** the admin can add or fix a question, including its image, without
breaking seeded data or the free trial. The admin sees exactly what students
will see before saving.

Est. 3–4 d.

## 3.1 Data

**Model** — `QuestionModel` (freezed). It is a superset of everything the
students' app and the seed tool use (parent plan §2.3), plus an `extra` map of
unknown fields. Before writing it, read `quiz_remote_datasource.dart`, the
seed tool and `media_manifest.json` (rule C3).
- `qid`, `categorySlug`, `type` (`true_false | single_choice |
  multiple_choice`, using the real values from the code)
- `title`, `description?`, `image?`, `audio?`
- `answers: List<AnswerModel>`; each answer has `id`, `text`, `image?`,
  `description?`, `isCorrect?`
- `correctAnswerIds`, `explanation?`, `hint?`, `difficulty?`
- `createdAt?`, `updatedAt?`
- in memory only: `searchKey`, `qidNumber`, `isTrial`

**Use cases**

| Use case | Notes |
|---|---|
| `watchQuestions` | Whole collection. Sorted **numerically** by `qidNumber` in the bloc, so the admin's order is right even though the students' app is lexicographic. `isTrial` = among the first 5 by the **students' lexicographic** order, so the badge matches what students actually get. |
| `nextQid` | Highest number + 1, keeping the existing pad width (`q84`). At 999, widen to the next width. Allocated in a transaction that fails if the doc already exists, then retries once. |
| `saveQuestion` | Create = `set` in the qid transaction. Edit = `update()` of the **owned fields only**. Normalizes answer ids (`a1…aN`; `true`/`false` for true-false) and remaps `correctAnswerIds` by id. Keeps per-answer `image`/`description` that the editor doesn't show. |
| `deleteQuestion` | Confirm in the UI. If the question is a trial question, show an extra warning. |
| `uploadQuestionImage(bytes)` | Validate the magic bytes and size ≤ 8 MB, then POST to ImgBB. Returns the URL (plus thumb/medium if the phase 0 spike confirmed them). Hidden when `!hasImgbb` or when the CORS spike failed on web. |

**Validation** (in the editor cubit, shown inline):
- The title is required, and the category must exist.
- true_false has exactly 2 fixed answers and exactly 1 correct.
- single_choice has 2–6 answers, all non-empty, exactly 1 correct.
- multiple_choice has 2–6 answers and at least 1 correct.
- No duplicate answer texts (a warning, not an error).

## 3.2 State

- `QuestionsBloc` (singleton): the stream, `all`, and `visible` (derived when
  filters, search or the source change), plus filters:
  - category
  - type
  - hasImage
  - trial only
  - search query

  The counts per filter are computed together with `visible` in one pass.
- `QuestionEditorCubit` (factory): `original`, `draft`, `isDirty`, `errors`
  (a field → message map), `imageStatus` (idle / uploading / failed),
  `pendingImageUrl`, `submitStatus`, `deleteStatus`.
  - Answer edits emit a new list (rule S2).
  - Each answer row's `BlocSelector` selects only its own answer by index, so
    typing in one answer rebuilds only that row (01-performance §3).
- Upload and save are independent. While an upload is in flight, save is
  allowed: it saves without the new image, after asking "الصورة لم تُرفع بعد —
  الحفظ بدونها؟".

## 3.3 UI

**List pane**
```
┌ الأسئلة ──────────────────────────────── 🔍 ابحث في نص السؤال   [+ سؤال] ┐
│ التصنيف ▾  النوع ▾  [بصورة]  [تجريبي]                     ٨٣ سؤالًا       │
├────────────────────────────────────────────────────────────────────────────┤
│ q01  [تجريبي]  🖼  ما معنى هذه الإشارة؟                صح/خطأ · إشارات     │
│ q02  [تجريبي]      عند الاقتراب من تقاطع…               اختيار · قواعد      │
└────────────────────────────────────────────────────────────────────────────┘
```
- Fixed-height rows:
  - `qid` (`IdText`)
  - trial pill
  - a 40 px thumbnail through `AdminNetworkImage`, with `cacheWidth`
  - the title (one line, ellipsized)
  - type and category as caption text
- The filter state is kept in the URL query (if D1 is approved) so a refresh
  keeps it.
- Opening from a category's "عرض الأسئلة" link pre-applies the category
  filter.

**Editor (detail pane; full-screen route on compact)**

Sections are in one scroll view, and on expanded the preview sits next to the
form:

```
┌ تعديل q12 ───────────────────────────── [معاينة] [حفظ] ┐┌ معاينة ────────────┐
│ التصنيف ▾      النوع: (صح/خطأ)(اختيار واحد)(متعدد)        ││  as students see it │
│ نص السؤال ______________________________________________ ││  [image]            │
│ الصورة  [🖼 thumbnail]  تغيير · إزالة   (or) [+ إضافة صورة] ││  question text      │
│ الإجابات                                                 ││  ○ answer 1         │
│  (◉) a1 ____________________  🗑                          ││  ● answer 2 ✓       │
│  ( ) a2 ____________________  🗑                          ││                     │
│  [+ إجابة]                                               ││  explanation        │
│ الشرح ________   التلميح ________   الصعوبة ▾             │└────────────────────┘
└──────────────────────────────────────────────────────────┘
```
- **Type switch**: switching keeps the answer texts when it can. Switching to
  true/false replaces the answers, with a confirm dialog if texts would be
  lost.
- **Correct answer**: radio for single, checkbox for multiple. The correct row
  gets a `successBackgroundColor` tint, so it is obvious at a glance.
- **Answers** support:
  - add (focuses the new field)
  - delete (with undo toast)
  - drag to reorder, only if the students' app shows answers in stored order.
    Check that first. If the app shuffles, leave reordering out.
- **Image tile** states:
  - empty: dashed "إضافة صورة"
  - uploading: thumbnail with an indeterminate bar, and the rest of the form
    stays enabled
  - ready: thumbnail with "تغيير · إزالة"
  - failed: error with "إعادة المحاولة", and the form is kept

  On web, also accept paste (`Ctrl+V` of an image) and drag-and-drop onto the
  tile if the spike shows it is cheap. Otherwise drop it (optional polish).
  The "paste URL" fallback is used if CORS failed.
- **Preview** (`widgets/quiz_preview.dart`): reuses the students' quiz card
  layout and `AnswerOptionCard` styling. The image is network-only through
  `AdminNetworkImage`, because the students' `QuizNetworkImage` uses
  `Image.file`, which needs `dart:io`. It updates live from the draft
  (`BlocSelector` on draft). On compact it opens from the "معاينة" button as
  a full-screen sheet.
- **Trial guard**: editing q01–q05 shows a top banner, "هذا السؤال ضمن
  التجربة المجانية — التعديل يظهر لجميع الطلاب غير المشتركين".
- `UnsavedChangesGuard`, `Ctrl+S`, and `Ctrl+Enter` adds an answer while an
  answer field is focused.
- After saving a new question, the toast offers "إضافة سؤال آخر", which opens
  a fresh editor with the same category and type preselected. This saves time
  during bulk entry.

## 3.4 Performance specifics

- The editor's answer list is a fixed small `Column` (≤ 6), not a lazy list.
  Each row is its own widget with its own controllers, owned by a
  `StatefulWidget` keyed by answer id, so controllers survive reorders.
- The preview is wrapped in a `RepaintBoundary`. Its image decodes at preview
  width.
- `visible` in `QuestionsBloc` is recomputed only when the filters, the query
  (debounced) or `all` change. That is one pass for about 1000 items, well
  under 1 ms.
- Picked images are kept as `Uint8List` only until the upload finishes, then
  released. They are never held in long-lived state.

## 3.5 Tests (after approval)

- Answer-id normalization, and the `correctAnswerIds` remap after deleting or
  reordering an answer.
- `nextQid`: `q83` → `q84`; `q999` → `q1000`, plus the widening rule; a
  collision retry.
- Merge-save keeps unknown fields and per-answer fields the editor doesn't
  show (the `extra` round-trip).
- Validation rules per type.
- Trial marking uses lexicographic order (`q100` sorts before `q11`).
- Image validation: magic bytes and the size limit.

## Acceptance

- [ ] Editing a seeded question with hint, difficulty, audio and per-answer
  descriptions changes only the edited fields. Diff the document in the
  console before and after.
- [ ] A new question gets the next padded qid and appears in the students' app
  in the right place.
- [ ] An image is uploaded, replaced and removed on Android, and on web (or
  falls back to URL paste on web). A cancelled edit stores nothing.
- [ ] The preview matches the students' app side by side for the
  true_false, single and multiple types.
- [ ] Typing in the editor repaints only the field and the preview (DevTools
  repaint highlight). Scrolling the list stays jank-free.
- [ ] 01 §8 and 02 §10 checklists pass.
