import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/admin/filter_chips_bar.dart';
import '../../../../core/widgets/admin/list_header.dart';
import '../../../../core/widgets/admin/master_detail_layout.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../../core/widgets/admin/admin_search_field.dart';
import '../../../../core/widgets/admin/skeleton_list.dart';
import '../../../../core/widgets/admin/state_views.dart';
import '../cubit/licenses_cubit.dart';
import '../widgets/license_row.dart';
import '../widgets/quick_grant_sheet.dart';
import 'license_editor_screen.dart';

/// Licenses tab: the inbox of pending requests (home of the app), filters,
/// search, and the license editor beside the list on wide screens.
class LicensesScreen extends StatefulWidget {
  const LicensesScreen({super.key});

  @override
  State<LicensesScreen> createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {
  final _controller = MasterDetailController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<LicensesCubit>().start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _open(String deviceId) {
    _controller.open(
      context,
      deviceId,
      pageBuilder: (_) => LicenseEditorScreen(deviceId: deviceId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {const SingleActivator(LogicalKeyboardKey.slash): _searchFocus.requestFocus},
      child: BlocListener<LicensesCubit, LicensesState>(
        listenWhen: (previous, current) =>
            current.lastOutcome != null && previous.lastOutcome != current.lastOutcome,
        listener: (context, state) => _showOutcome(state.lastOutcome!),
        child: MasterDetailLayout(
          list: _LicensesListPanel(
            controller: _controller,
            searchFocus: _searchFocus,
            onOpen: _open,
          ),
          detail: ValueListenableBuilder<String?>(
            valueListenable: _controller.selected,
            builder: (context, deviceId, _) => FadeThroughSwitcher(
              child: deviceId == null
                  ? DetailPlaceholder(
                      icon: Icons.badge_outlined,
                      message: 'licenses.selectHint'.tr(),
                    )
                  : LicenseEditorView(
                      key: ValueKey(deviceId),
                      deviceId: deviceId,
                      isPane: true,
                      onClose: _controller.close,
                      onDirtyChanged: (dirty) => _controller.editorDirty.value = dirty,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOutcome(LicenseActionOutcome outcome) {
    if (outcome.errorKey != null) {
      Toaster.showError(outcome.errorKey!.tr());
      return;
    }
    Toaster.showSuccess(switch (outcome.kind) {
      LicenseActionKind.granted => 'licenses.toast.granted'.tr(),
      LicenseActionKind.restored => 'licenses.toast.restored'.tr(),
      LicenseActionKind.revoked => 'licenses.toast.revoked'.tr(),
    });
  }
}

class _LicensesListPanel extends StatelessWidget {
  const _LicensesListPanel({
    required this.controller,
    required this.searchFocus,
    required this.onOpen,
  });

  final MasterDetailController controller;
  final FocusNode searchFocus;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.cardSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListHeader(
            title: 'licenses.title'.tr(),
            actions: [
              IconButton(
                tooltip: 'common.refresh'.tr(),
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () => context.read<LicensesCubit>().refresh(),
              ),
            ],
            search: AdminSearchField(
              hint: 'licenses.searchHint'.tr(),
              focusNode: searchFocus,
              initialValue: context.read<LicensesCubit>().state.query,
              onChanged: (query) => context.read<LicensesCubit>().search(query),
            ),
            filters: const _LicenseFilters(),
          ),
          Expanded(
            child: _LicensesListBody(controller: controller, onOpen: onOpen),
          ),
        ],
      ),
    );
  }
}

class _LicenseFilters extends StatelessWidget {
  const _LicenseFilters();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LicensesCubit, LicensesState>(
      buildWhen: (previous, current) =>
          previous.filter != current.filter ||
          previous.counts != current.counts ||
          previous.isSearching != current.isSearching,
      builder: (context, state) {
        return AnimatedOpacity(
          duration: AdminTokens.fast,
          opacity: state.isSearching ? 0.4 : 1,
          child: IgnorePointer(
            ignoring: state.isSearching,
            child: FilterChipsBar<LicenseFilter>(
              selected: state.filter,
              onSelected: context.read<LicensesCubit>().selectFilter,
              items: [
                for (final filter in LicenseFilter.values)
                  FilterChipItem(
                    value: filter,
                    label: 'licenses.filters.${filter.name}'.tr(),
                    count: state.counts[filter],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LicensesListBody extends StatelessWidget {
  const _LicensesListBody({required this.controller, required this.onOpen});

  final MasterDetailController controller;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LicensesCubit, LicensesState>(
      buildWhen: (previous, current) =>
          previous.visible != current.visible ||
          previous.filter != current.filter ||
          previous.inboxStatus != current.inboxStatus ||
          previous.searchStatus != current.searchStatus ||
          previous.isSearching != current.isSearching ||
          previous.currentPage?.status != current.currentPage?.status ||
          previous.busyIds != current.busyIds,
      builder: (context, state) {
        final cubit = context.read<LicensesCubit>();
        final _ListView view = _viewOf(state);
        // Skeleton → list → empty states cross-fade instead of popping.
        return FadeThroughSwitcher(
          child: KeyedSubtree(
            key: ValueKey(view),
            child: Builder(
              builder: (context) {
                switch (view) {
                  case _ListView.loading:
                    return const SkeletonList(itemExtent: AdminTokens.licenseRowExtent);
                  case _ListView.error:
                    final key = state.isSearching
                        ? state.searchErrorKey
                        : state.filter.queryFilter == null
                        ? state.inboxErrorKey
                        : state.currentPage?.errorKey;
                    return ErrorState(
                      message: (key ?? 'errors.unknown').tr(),
                      onRetry: state.isSearching
                          ? () => cubit.search(state.query)
                          : state.filter.queryFilter == null
                          ? cubit.retryInbox
                          : cubit.refresh,
                    );
                  case _ListView.empty:
                    return state.isSearching
                        ? EmptyState(
                            icon: Icons.search_off_rounded,
                            title: 'common.noResults'.tr(namedArgs: {'query': state.query}),
                            message: 'licenses.searchEmptyHint'.tr(),
                          )
                        : EmptyState(
                            icon: state.filter == LicenseFilter.pending
                                ? Icons.mark_email_read_outlined
                                : Icons.inbox_outlined,
                            title: 'licenses.empty.${state.filter.name}'.tr(),
                          );
                  case _ListView.data:
                    final page = state.currentPage;
                    final loadingMore = !state.isSearching && (page?.status.isLoading ?? false);
                    return RefreshIndicator(
                      onRefresh: cubit.refresh,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.extentAfter < AdminTokens.licenseRowExtent * 3) {
                            cubit.loadMore();
                          }
                          return false;
                        },
                        child: StaggerScope(
                          replayKey: (state.filter, state.query),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemExtent: AdminTokens.licenseRowExtent,
                            itemCount: state.visible.length + (loadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= state.visible.length) return const _FooterLoader();
                              final item = state.visible[index];
                              final id = item.license.deviceId;
                              return StaggeredItem(
                                key: ValueKey(id),
                                index: index,
                                child: ValueListenableBuilder<String?>(
                                  valueListenable: controller.selected,
                                  builder: (context, selectedId, _) => LicenseRow(
                                    item: item,
                                    selected: selectedId == id,
                                    busy: state.busyIds.contains(id),
                                    onOpen: () => onOpen(id),
                                    onQuickGrant: () async {
                                      final until = await showQuickGrantSheet(
                                        context,
                                        item.license,
                                      );
                                      if (until == null || !context.mounted) return;
                                      await context.read<LicensesCubit>().quickGrant(
                                        item.license,
                                        until,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                }
              },
            ),
          ),
        );
      },
    );
  }

  static _ListView _viewOf(LicensesState state) {
    if (state.isSearching) {
      if (state.searchStatus.isLoading && state.visible.isEmpty) return _ListView.loading;
      if (state.searchStatus.isFailed) return _ListView.error;
      return state.visible.isEmpty ? _ListView.empty : _ListView.data;
    }
    if (state.filter.queryFilter == null) {
      if (state.inboxStatus.isInit || state.inboxStatus.isLoading) return _ListView.loading;
      if (state.inboxStatus.isFailed && state.inbox.isEmpty) return _ListView.error;
      return state.visible.isEmpty ? _ListView.empty : _ListView.data;
    }
    final page = state.currentPage;
    if (page == null || page.status.isInit) return _ListView.loading;
    if (page.items.isEmpty) {
      if (page.status.isLoading) return _ListView.loading;
      if (page.status.isFailed) return _ListView.error;
      return _ListView.empty;
    }
    return _ListView.data;
  }
}

enum _ListView { loading, error, empty, data }

class _FooterLoader extends StatelessWidget {
  const _FooterLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(dimension: 22, child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}
