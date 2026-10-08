import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/firestore_paths.dart';
import '../../../../core/unified_api/error/failure.dart';
import '../models/category_model.dart';

/// Reads and writes `categories/{slug}`.
abstract class RemoteCategoriesDatasource {
  /// Whole collection by `order` (about ten documents).
  Stream<List<CategoryModel>> categoriesChanges();

  /// Fails with `categories.errors.slugTaken` when the slug exists.
  Future<void> createCategory(CategoryModel category);

  Future<void> updateCategory({
    required String slug,
    required String name,
    String? icon,
    String? description,
  });

  /// One batch with only the documents whose order changed.
  Future<void> updateOrders(Map<String, int> orderBySlug);

  Future<int> countQuestions(String slug);

  Future<void> deleteCategory(String slug);
}

@Injectable(as: RemoteCategoriesDatasource)
class RemoteCategoriesDatasourceImpl implements RemoteCategoriesDatasource {
  RemoteCategoriesDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _categories =>
      _firestore.collection(FirestorePaths.categories);

  @override
  Stream<List<CategoryModel>> categoriesChanges() {
    return _categories
        .orderBy('order')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromFirestore(doc.id, doc.data()))
              .toList(growable: false),
        );
  }

  @override
  Future<void> createCategory(CategoryModel category) async {
    final ref = _categories.doc(category.slug);
    // Returns false instead of throwing inside the handler: on web, errors
    // thrown in a transaction handler come back wrapped by the JS interop.
    final created = await _firestore.runTransaction<bool>((transaction) async {
      final existing = await transaction.get(ref);
      if (existing.exists) return false;
      transaction.set(ref, {
        'slug': category.slug,
        'name': category.name,
        'icon': category.icon,
        'description': category.description,
        'order': category.order,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    });
    if (!created) throw const ValidationFailure(message: 'categories.errors.slugTaken');
  }

  @override
  Future<void> updateCategory({
    required String slug,
    required String name,
    String? icon,
    String? description,
  }) {
    return _categories.doc(slug).update({
      'name': name,
      'icon': icon,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateOrders(Map<String, int> orderBySlug) {
    final batch = _firestore.batch();
    orderBySlug.forEach((slug, order) {
      batch.update(_categories.doc(slug), {
        'order': order,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
    return batch.commit();
  }

  @override
  Future<int> countQuestions(String slug) async {
    final snapshot = await _firestore
        .collection(FirestorePaths.questions)
        .where('categorySlug', isEqualTo: slug)
        .count()
        .get();
    return snapshot.count ?? 0;
  }

  @override
  Future<void> deleteCategory(String slug) => _categories.doc(slug).delete();
}
