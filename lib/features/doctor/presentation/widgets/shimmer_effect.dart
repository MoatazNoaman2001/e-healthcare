import 'package:flutter/material.dart';

class ShimmerLoading extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const ShimmerLoading({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color(0xFFEBEBF4),
                Color(0xFFF4F4F4),
                Color(0xFFEBEBF4),
              ],
              stops: const [0.1, 0.3, 0.4],
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}

/// Shimmer effect for app loading states
class ShimmerEffect extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerEffect({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Circular shimmer effect for avatars
class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Shimmer for a list of items
class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsetsGeometry padding;

  const ShimmerList({
    Key? key,
    required this.itemCount,
    this.itemHeight = 80,
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ShimmerLoading(
            isLoading: true,
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Shimmer for appointment card loading
class ShimmerAppointmentCard extends StatelessWidget {
  const ShimmerAppointmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerEffect(width: 100, height: 20),
                ShimmerEffect(width: 80, height: 24, borderRadius: 12),
              ],
            ),
            const SizedBox(height: 16),

            // Patient info row
            Row(
              children: [
                ShimmerCircle(size: 50),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerEffect(width: 120, height: 16),
                    SizedBox(height: 8),
                    ShimmerEffect(width: 80, height: 12),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ShimmerEffect(width: 80, height: 32, borderRadius: 16),
                SizedBox(width: 8),
                ShimmerEffect(width: 100, height: 32, borderRadius: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer for profile card loading
class ShimmerProfileCard extends StatelessWidget {
  const ShimmerProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ShimmerCircle(size: 80),
            const SizedBox(height: 16),
            const ShimmerEffect(width: 150, height: 20),
            const SizedBox(height: 8),
            const ShimmerEffect(width: 100, height: 16),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),

            // Info rows
            Row(
              children: const [
                ShimmerCircle(size: 24),
                SizedBox(width: 16),
                ShimmerEffect(width: 200, height: 16),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                ShimmerCircle(size: 24),
                SizedBox(width: 16),
                ShimmerEffect(width: 200, height: 16),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                ShimmerCircle(size: 24),
                SizedBox(width: 16),
                ShimmerEffect(width: 200, height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer for next appointment card
class ShimmerNextAppointmentCard extends StatelessWidget {
  const ShimmerNextAppointmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerEffect(width: 120, height: 20),
                ShimmerEffect(width: 80, height: 20),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ShimmerEffect(width: 60, height: 60, borderRadius: 16),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerEffect(width: double.infinity, height: 20),
                      SizedBox(height: 8),
                      ShimmerEffect(width: 100, height: 16),
                      SizedBox(height: 8),
                      ShimmerEffect(width: 80, height: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                ShimmerEffect(width: 100, height: 36, borderRadius: 12),
                SizedBox(width: 12),
                ShimmerEffect(width: 100, height: 36, borderRadius: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}