import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../utils/debouncer.dart';

/// Search box that reports its text after the user pauses typing (250 ms), so
/// filtering never runs on every keystroke. Has a clear button.
class AdminSearchField extends StatefulWidget {
  const AdminSearchField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.initialValue = '',
    this.focusNode,
  });

  final String hint;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final FocusNode? focusNode;

  @override
  State<AdminSearchField> createState() => _AdminSearchFieldState();
}

class _AdminSearchFieldState extends State<AdminSearchField> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);
  final Debouncer _debouncer = Debouncer(milliseconds: 250);

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    _debouncer.dispose();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.search,
      onChanged: (value) => _debouncer.run(() => widget.onChanged(value)),
      onSubmitted: (value) {
        _debouncer.dispose();
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        isDense: true,
        fillColor: AppTheme.skyBackground,
        prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.inkFaint),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, _) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              tooltip: 'common.clearSearch'.tr(),
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: _clear,
            );
          },
        ),
      ),
    );
  }
}
