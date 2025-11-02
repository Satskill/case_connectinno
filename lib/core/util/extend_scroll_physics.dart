import 'package:flutter/material.dart';

class ExtentScrollPhysics extends ScrollPhysics {
  final double itemExtent;
  final double dividerSpacing;

  const ExtentScrollPhysics({super.parent, required this.itemExtent, required double separatorSpacing})
      : assert(itemExtent > 0),
        dividerSpacing = separatorSpacing;

  @override
  ExtentScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ExtentScrollPhysics(
      parent: buildParent(ancestor),
      itemExtent: itemExtent,
      separatorSpacing: dividerSpacing,
    );
  }

  double _getItem(ScrollMetrics position) {
    return position.pixels / (itemExtent + dividerSpacing);
  }

  double _getPixels(ScrollMetrics position, double item) {
    return item * (itemExtent + dividerSpacing);
  }

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getItem(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) || (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Tolerance tolerance = toleranceFor(position);
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
