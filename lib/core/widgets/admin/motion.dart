import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Motion tokens and widgets for the admin app.
///
/// Rules: quick (150–320 ms), ease-out, small distances, never looping on
/// work screens, and nothing at all when the platform asks for reduced motion.
class Motion {
  Motion._();

  static const Duration fast = Duration(milliseconds: 160);
  static const Duration medium = Duration(milliseconds: 260);
  static const Duration slow = Duration(milliseconds: 380);
  static const Duration stagger = Duration(milliseconds: 28);
  static const Curve enter = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutBack;

  /// Only the first rows of a list animate in; the rest appear at once.
  static const int maxStaggered = 12;

  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;
}

/// Fades and slides [child] in once, when first built. [index] staggers
/// siblings (sections of an editor, cards of a page).
class Entrance extends StatelessWidget {
  const Entrance({
    super.key,
    required this.child,
    this.index = 0,
    this.offsetY = 0.06,
    this.scale = false,
    this.delay = Duration.zero,
  });

  final Widget child;
  final int index;
  final double offsetY;
  final bool scale;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    if (Motion.reduced(context)) return child;
    final start = delay + Motion.stagger * index.clamp(0, Motion.maxStaggered);
    var effect = child
        .animate(delay: start)
        .fadeIn(duration: Motion.medium, curve: Motion.enter)
        .slideY(begin: offsetY, end: 0, duration: Motion.medium, curve: Motion.enter);
    if (scale) {
      effect = effect.scaleXY(begin: 0.96, end: 1, duration: Motion.medium, curve: Motion.enter);
    }
    return effect;
  }
}

/// Marks a list as "just shown": rows built during the first moments after
/// mount (or after [replayKey] changes, e.g. a new filter) play a staggered
/// entrance; rows built later (scrolling) appear without animation.
class StaggerScope extends StatefulWidget {
  const StaggerScope({super.key, required this.child, this.replayKey});

  final Widget child;
  final Object? replayKey;

  @override
  State<StaggerScope> createState() => _StaggerScopeState();
}

class _StaggerScopeState extends State<StaggerScope> {
  bool _active = true;
  int _generation = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _arm();
  }

  @override
  void didUpdateWidget(StaggerScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.replayKey != widget.replayKey) {
      _active = true;
      _generation++;
      _arm();
    }
  }

  void _arm() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _active = false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _StaggerData(active: _active, generation: _generation, child: widget.child);
  }
}

class _StaggerData extends InheritedWidget {
  const _StaggerData({required this.active, required this.generation, required super.child});

  final bool active;
  final int generation;

  @override
  bool updateShouldNotify(_StaggerData oldWidget) =>
      active != oldWidget.active || generation != oldWidget.generation;
}

/// A list row that animates in only while its [StaggerScope] is fresh.
class StaggeredItem extends StatelessWidget {
  const StaggeredItem({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<_StaggerData>();
    if (scope == null || !scope.active || index >= Motion.maxStaggered) return child;
    return KeyedSubtree(
      key: ValueKey(scope.generation),
      child: Entrance(index: index, offsetY: 0.25, child: child),
    );
  }
}

/// Cross-fades between states (skeleton → list, list → empty, one editor →
/// another) with a slight rise, keeping the outgoing child under the new one.
class FadeThroughSwitcher extends StatelessWidget {
  const FadeThroughSwitcher({super.key, required this.child, this.alignment = Alignment.topCenter});

  final Widget child;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    if (Motion.reduced(context)) return child;
    return AnimatedSwitcher(
      duration: Motion.medium,
      reverseDuration: Motion.fast,
      switchInCurve: Motion.enter,
      switchOutCurve: Curves.easeIn,
      layoutBuilder: (current, previous) =>
          Stack(alignment: alignment, fit: StackFit.expand, children: [...previous, ?current]),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.015), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// Plays a short fade-and-rise each time a kept-alive tab becomes visible.
class TabEntrance extends StatefulWidget {
  const TabEntrance({super.key, required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  State<TabEntrance> createState() => _TabEntranceState();
}

class _TabEntranceState extends State<TabEntrance> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Motion.medium,
    value: 1,
  );
  late final Animation<double> _curve = CurvedAnimation(parent: _controller, curve: Motion.enter);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // First visit: play once (MediaQuery is available from here on).
    if (!_started) {
      _started = true;
      if (widget.active && !Motion.reduced(context)) _controller.forward(from: 0);
    }
  }

  bool _started = false;

  @override
  void didUpdateWidget(TabEntrance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active && !Motion.reduced(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.012), end: Offset.zero).animate(_curve),
        child: widget.child,
      ),
    );
  }
}
