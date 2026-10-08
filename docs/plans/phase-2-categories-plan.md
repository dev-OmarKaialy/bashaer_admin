# Phase 2 — Categories and subscription plan

Est. 1–2 d.

## 2.1 Categories data

**Model** — `CategoryModel` (freezed), a superset of what the students' app
reads:
- `slug` (the doc id), `name`, `icon`, `order`
- `description?`, `createdAt?`, `updatedAt?`
- `extra`: a `Map<String, dynamic>` of unknown fields, kept so that a
  round-trip never drops them. Only fields the editor owns are written back.

Before writing the model, read the real fields from
`quiz_remote_datasource.dart` and `seed_firestore.dart` (rule C3). The list
above must match them.

**Use cases**
- `watchCategories`: stream of the whole collection, `orderBy('order')`.
- `saveCategory`:
  - **create**: the slug is validated (kebab-case regex), then written in a
    transaction that fails if the doc already exists ("المعرّف مستخدم").
    `order` = max + 1.
  - **edit**: `update()` only `name`, `icon`, `description` and `updatedAt`.
    The slug is read-only (legacy camelCase is accepted).
- `reorderCategories(newOrder)`: compute `order` = index for each item, then
  write **only the changed ones** in one batch.
- `countCategoryQuestions(slug)`: `count()` aggregation.
- `deleteCategory(slug)`: count first. If the count is above 0, return
  `CategoryNotEmptyFailure(n)` and write nothing. Otherwise delete.

## 2.2 Categories state

- `CategoriesBloc` (singleton): the stream, `categories`, `reorderStatus`.
  During a drag, the bloc holds a **local order** so the list doesn't jump
  back while the batch is in flight. When the stream echoes the new order, the
  local order is dropped.
- `CategoryEditorCubit` (factory): draft, `isDirty`, `submitStatus`,
  `deleteStatus`, `blockedCount`.

## 2.3 Categories UI

**List pane**
```
┌ التصنيفات ─────────────────────────────── [+ تصنيف جديد] ┐
│ ⠿  🛢  الوقود والإشعال      fuelIgnition     ١٢ سؤالًا   │
│ ⠿  🚦  إشارات المرور        trafficSigns     ٣١ سؤالًا   │
└───────────────────────────────────────────────────────────┘
```
- `ReorderableListView.builder` with an explicit drag handle (`⠿`, tooltip
  "اسحب لإعادة الترتيب"). On a long press on Android the row lifts with
  elevation. On web the cursor is `grab`.
- The question count per row comes from the in-memory `QuestionsBloc`
  (01-performance §2). If that bloc hasn't loaded yet, start it here, because
  the counts are worth ~100 reads once.
- After a drop, a subtle "تم حفظ الترتيب" toast. On failure, revert to the
  stream order and show an error toast.

**Editor (detail pane or sheet)**
- Fields: name, slug (create only; auto-suggested from a transliteration of
  the name is not reliable for Arabic, so it starts empty with hint
  `traffic-signs`), description.
- **Icon picker**: a searchable grid dialog.
  - Tab "رموز" shows the emoji catalog for new picks.
  - Tab "الحالية" shows the Font Awesome names already in use (legacy).
  - The grid is a `GridView.builder` with fixed cell size. The current icon is
    highlighted.
  - The preview renders through the copied `CategoryIcon`, so it matches the
    students' app.
- **Live preview card**: the category tile the way it looks in the students'
  app, using its accent gradient by index (`AppTheme.accentGradientAt`).
- **Delete**:
  - The button is disabled when the in-memory count is above 0, with the
    helper text "لا يمكن حذف التصنيف — يحتوي على N سؤال" and a link
    "عرض الأسئلة" that opens the questions tab filtered to this category.
  - When the count is 0, delete asks for confirmation and runs the
    authoritative `count()` again inside the use case.

## 2.4 Subscription plan

**Model** — `SubscriptionPlanModel`, matching the students'
`subscription_plan_remote_datasource.dart` exactly:
- `title`, `price`, `currency`, `features: List<String>`, `updatedAt?`
- plus `extra` for unknown fields

Read the datasource before writing the model (rule C3).

**Use cases**: `getPlan` (`get()`) and `savePlan` (`update()` with the owned
fields).

**UI** — a single form, max width 480, next to a live preview of the
students' subscription card. Side by side on expanded, preview above the form
on compact.
- Price: numeric keyboard, decimal validation, and the currency suffix shown
  in the field.
- Features: a reorderable list of text rows with add ("+ ميزة") and remove
  (with undo toast). An empty row is ignored on save.
- Save is enabled only when the form is dirty and valid. `Ctrl+S` works.
- Note under the form: "التغيير يظهر للطلاب عند فتح التطبيق التالي". The
  students' app caches the plan in secure storage, so check how and when it
  refreshes and make the note say exactly that.

## 2.5 Tests (after approval)

- Reorder writes only the changed docs (moving item 3 to 1 writes 3 docs, not
  all of them).
- Delete is blocked when the count is above 0, and writes nothing.
- Slug validation on create; a legacy camelCase slug can still be edited.
- Category and plan models keep unknown fields through `fromJson` → edit →
  `toUpdateMap`.

## Acceptance

- [ ] Dragging a category reorders it on both platforms with no jump back. The
  students' app shows the new order after its next sync.
- [ ] Editing a seeded category (camelCase slug, Font Awesome icon) keeps its
  slug and icon unless changed, and drops no fields.
- [ ] Deleting a non-empty category is impossible from the UI and from the use
  case.
- [ ] The plan editor round-trips. The students' app shows the new price.
- [ ] 01 §8 and 02 §10 checklists pass.
