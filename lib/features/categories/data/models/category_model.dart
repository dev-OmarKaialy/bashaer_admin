import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';

/// One `categories/{slug}` row, as the seed tool writes it
/// (`slug`, `name`, `icon`, `description`, `order`, `questionCount`).
///
/// `questionCount` is not read or written here: the students' app recomputes
/// counts on the device. Saves are merge-updates of the fields below, so any
/// other field on the document survives.
@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String slug,
    required String name,
    String? icon,
    String? description,
    @Default(0) int order,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CategoryModel;

  const CategoryModel._();

  factory CategoryModel.fromFirestore(String id, Map<String, dynamic> data) {
    final slug = data['slug'];
    final order = data['order'];
    return CategoryModel(
      slug: slug is String && slug.isNotEmpty ? slug : id,
      name: (data['name'] as String?)?.trim() ?? '',
      icon: _text(data['icon']),
      description: _text(data['description']),
      order: order is num ? order.toInt() : 0,
      createdAt: _date(data['createdAt']),
      updatedAt: _date(data['updatedAt']),
    );
  }

  static String? _text(Object? raw) {
    if (raw is! String) return null;
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  static DateTime? _date(Object? raw) => raw is Timestamp ? raw.toDate() : null;
}
