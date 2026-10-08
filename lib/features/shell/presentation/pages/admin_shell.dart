import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../auth/presentation/pages/profile_screen.dart';
import '../../../categories/presentation/pages/categories_screen.dart';
import '../../../licenses/presentation/cubit/licenses_cubit.dart';
import '../../../licenses/presentation/pages/licenses_screen.dart';
import '../../../questions/presentation/pages/questions_screen.dart';
import '../cubit/shell_cubit.dart';

/// Signed-in frame: bottom navigation bar on phones, navigation rail on wider
/// screens (with labels from 1100 px). Tabs are built on first visit and then
/// kept alive, so their scroll position, search and listeners survive
/// switching.
class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  final Set<AdminTab> _visited = {};

  static const _screens = <AdminTab, Widget>{
    AdminTab.licenses: LicensesScreen(),
    AdminTab.questions: QuestionsScreen(),
    AdminTab.categories: CategoriesScreen(),
    AdminTab.profile: ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShellCubit, AdminTab>(
      builder: (context, tab) {
        _visited.add(tab);
        final body = IndexedStack(
          index: tab.index,
          children: [
            for (final t in AdminTab.values)
              _visited.contains(t)
                  ? TabEntrance(active: t == tab, child: _screens[t]!)
                  : const SizedBox.shrink(),
          ],
        );
        if (!context.useRail) {
          return Scaffold(
            appBar: AppBar(title: Text('shell.tabs.${tab.name}'.tr())),
            body: body,
            bottomNavigationBar: NavigationBar(
              selectedIndex: tab.index,
              onDestinationSelected: (i) => context.read<ShellCubit>().select(AdminTab.values[i]),
              destinations: [
                for (final t in AdminTab.values)
                  NavigationDestination(
                    icon: _TabIcon(tab: t, selected: false),
                    selectedIcon: _TabIcon(tab: t, selected: true),
                    label: 'shell.tabs.${t.name}'.tr(),
                  ),
              ],
            ),
          );
        }
        final extended = context.useExtendedRail;
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                NavigationRail(
                  extended: extended,
                  minExtendedWidth: 220,
                  selectedIndex: tab.index,
                  labelType: extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
                  onDestinationSelected: (i) =>
                      context.read<ShellCubit>().select(AdminTab.values[i]),
                  leading: _RailBrand(extended: extended),
                  destinations: [
                    for (final t in AdminTab.values)
                      NavigationRailDestination(
                        icon: _TabIcon(tab: t, selected: false),
                        selectedIcon: _TabIcon(tab: t, selected: true),
                        label: Text('shell.tabs.${t.name}'.tr()),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TabIcon extends StatelessWidget {
  const _TabIcon({required this.tab, required this.selected});

  final AdminTab tab;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(switch (tab) {
      AdminTab.licenses => selected ? Icons.how_to_reg_rounded : Icons.how_to_reg_outlined,
      AdminTab.questions => selected ? Icons.quiz_rounded : Icons.quiz_outlined,
      AdminTab.categories => selected ? Icons.category_rounded : Icons.category_outlined,
      AdminTab.profile => selected ? Icons.account_circle_rounded : Icons.account_circle_outlined,
    });
    if (tab != AdminTab.licenses) return icon;
    // Pending requests badge: only this icon rebuilds when the count changes.
    return BlocSelector<LicensesCubit, LicensesState, int>(
      selector: (state) => state.pendingCount,
      builder: (context, count) => Badge(
        isLabelVisible: count > 0,
        backgroundColor: AppTheme.racingRed,
        label: Text('$count'),
        child: icon,
      ),
    );
  }
}

class _RailBrand extends StatelessWidget {
  const _RailBrand({required this.extended});

  final bool extended;

  @override
  Widget build(BuildContext context) {
    final logo = ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radiusS),
      child: Image.asset('assets/icons/launcher_icon.png', width: 40, height: 40),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingL),
      child: extended
          ? SizedBox(
              width: 196,
              child: Row(
                children: [
                  logo,
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: Text(
                      'shell.brand'.tr(),
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            )
          : logo,
    );
  }
}
