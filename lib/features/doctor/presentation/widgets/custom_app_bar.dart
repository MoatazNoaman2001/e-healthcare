import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget title;
  final List<Widget> actions;
  final double expandedHeight;
  final double collapsedHeight;
  final Color? backgroundColor;

  CustomAppBarDelegate({
    required this.title,
    required this.actions,
    this.expandedHeight = 180.0,
    this.collapsedHeight = 80.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double opacity = math.max(0, 1 - shrinkOffset / (expandedHeight - collapsedHeight));
    final double percent = math.min(1, shrinkOffset / (expandedHeight - collapsedHeight));
    final double scale = 0.8 + 0.2 * opacity;

    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.primary;

    return Container(
      height: expandedHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bgColor,
            Color.lerp(bgColor, bgColor.withOpacity(0.8), 0.5)!,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30 * opacity),
          bottomRight: Radius.circular(30 * opacity),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1 * opacity),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Decorative elements that fade out as we scroll
          if (opacity > 0.5) ...[
            Positioned(
              top: -60 * (1 - opacity),
              left: -20,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60 * (1 - opacity),
              right: -20,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ],

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: 8 + 16 * (1 - opacity),
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Actions row (always visible)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions.map((action) {
                      return Transform.scale(
                        scale: 0.8 + 0.2 * (1 - percent),
                        child: action,
                      );
                    }).toList(),
                  ),

                  // Title section with smooth transition
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8.0 * percent,
                        bottom: 16.0 * opacity,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - opacity)),
                          child: Transform.scale(
                            scale: scale,
                            child: Opacity(
                              opacity: opacity,
                              child: title,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant CustomAppBarDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.actions != actions ||
        oldDelegate.expandedHeight != expandedHeight ||
        oldDelegate.collapsedHeight != collapsedHeight;
  }
}