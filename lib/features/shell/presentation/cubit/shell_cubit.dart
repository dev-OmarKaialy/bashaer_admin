import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Top-level destinations, in navigation order.
enum AdminTab { licenses, questions, categories, profile }

/// The selected destination. A cubit (not local state) because other
/// features jump between tabs, e.g. a category's "show its questions".
@lazySingleton
class ShellCubit extends Cubit<AdminTab> {
  ShellCubit() : super(AdminTab.licenses);

  void select(AdminTab tab) {
    if (tab != state) emit(tab);
  }

  void reset() => emit(AdminTab.licenses);
}
