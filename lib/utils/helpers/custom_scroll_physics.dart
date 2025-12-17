import 'package:flutter/material.dart';

/// Clamps at the top (no overscroll) and allows iOS-style bounce at the bottom.
class ClampedTopBouncingBottomScrollPhysics extends ScrollPhysics {
  const ClampedTopBouncingBottomScrollPhysics({super.parent});

  ScrollPhysics get _top => const ClampingScrollPhysics();

  ScrollPhysics get _bottom => const BouncingScrollPhysics();

  @override
  ClampedTopBouncingBottomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ClampedTopBouncingBottomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // value is the proposed new pixel position; compare to current
    final delta = value - position.pixels;

    if (delta < 0) {
      // Moving up (toward minScrollExtent): clamp like Android
      return _top.applyBoundaryConditions(position, value);
    } else if (delta > 0) {
      // Moving down (toward/beyond maxScrollExtent): allow bounce like iOS
      return _bottom.applyBoundaryConditions(position, value);
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if (velocity < 0) {
      // Flinging up: clamp behavior
      return _top.createBallisticSimulation(position, velocity) ??
          super.createBallisticSimulation(position, velocity);
    } else if (velocity > 0) {
      // Flinging down: bouncing behavior
      return _bottom.createBallisticSimulation(position, velocity) ??
          super.createBallisticSimulation(position, velocity);
    } else {
      // No velocity; if out of range, settle appropriately.
      if (position.pixels < position.minScrollExtent) {
        return _top.createBallisticSimulation(position, velocity);
      }
      if (position.pixels > position.maxScrollExtent) {
        return _bottom.createBallisticSimulation(position, velocity);
      }
      return null;
    }
  }

  @override
  bool get allowImplicitScrolling => true;
}
