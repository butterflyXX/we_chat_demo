import 'package:flutter/material.dart';

class SliverHeaderWidget extends StatelessWidget {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  const SliverHeaderWidget({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, // 吸顶
      delegate: _MyHeaderDelegate(
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: child,
      ),
    );
  }
}

class _MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _MyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_MyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
