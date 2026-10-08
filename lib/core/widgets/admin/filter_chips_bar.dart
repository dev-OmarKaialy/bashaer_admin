import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class FilterChipItem<T> {
  const FilterChipItem({required this.value, required this.label, this.count, this.icon});

  final T value;
  final String label;
  final int? count;
  final IconData? icon;
}

/// One-of-many filter as a horizontally scrollable chip row with counts
/// ("قيد الانتظار 3").
class FilterChipsBar<T> extends StatelessWidget {
  const FilterChipsBar({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final List<FilterChipItem<T>> items;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: AppTheme.spacingS),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item.value == selected;
          return Center(
            child: ChoiceChip(
              selected: isSelected,
              showCheckmark: false,
              avatar: item.icon == null
                  ? null
                  : Icon(
                      item.icon,
                      size: 16,
                      color: isSelected ? AppTheme.nitroBlue : AppTheme.inkSoft,
                    ),
              label: Text(item.count == null ? item.label : '${item.label}  ${item.count}'),
              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? AppTheme.nitroBlue : AppTheme.ink,
              ),
              side: BorderSide(color: isSelected ? AppTheme.nitroBlue : AppTheme.divider),
              onSelected: (_) => onSelected(item.value),
            ),
          );
        },
      ),
    );
  }
}
