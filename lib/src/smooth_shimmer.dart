import 'package:flutter/material.dart';

/// Direction of the shimmer gradient sweep.
enum ShimmerDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop,
}

/// A high-performance, zero-dependency skeleton loading shimmer effect.
///
/// Sweeps a smooth highlight sheen across any [child] widget or placeholder layout.
class SmoothShimmer extends StatefulWidget {
  const SmoothShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.leftToRight,
    this.enabled = true,
  });

  /// The widget or layout tree to apply the shimmer effect to.
  final Widget child;

  /// Base color of the skeleton. Defaults to theme-aware grey.
  final Color? baseColor;

  /// Highlight sheen color. Defaults to theme-aware lighter grey.
  final Color? highlightColor;

  /// Duration of one complete gradient sweep.
  final Duration duration;

  /// Direction of the shimmer travel.
  final ShimmerDirection direction;

  /// Whether the shimmer animation is active. When false, renders [child] untouched.
  final bool enabled;

  @override
  State<SmoothShimmer> createState() => _SmoothShimmerState();
}

class _SmoothShimmerState extends State<SmoothShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(SmoothShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.enabled != widget.enabled) {
      if (widget.enabled) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations == true;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final base = widget.baseColor ??
        (isDark ? const Color(0xFF2C2C2E) : const Color(0xFFE5E5EA));
    final highlight = widget.highlightColor ??
        (isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF2F2F7));

    if (reduceMotion) {
      return ColorFiltered(
        colorFilter: ColorFilter.mode(base, BlendMode.srcATop),
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final t = _controller.value;
            final rect = _calculateGradientRect(bounds, t);

            return LinearGradient(
              begin: _gradientBegin,
              end: _gradientEnd,
              stops: const [0.1, 0.5, 0.9],
              colors: [base, highlight, base],
            ).createShader(rect);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Alignment get _gradientBegin {
    switch (widget.direction) {
      case ShimmerDirection.leftToRight:
        return const Alignment(-1.0, -0.3);
      case ShimmerDirection.rightToLeft:
        return const Alignment(1.0, 0.3);
      case ShimmerDirection.topToBottom:
        return const Alignment(0.0, -1.0);
      case ShimmerDirection.bottomToTop:
        return const Alignment(0.0, 1.0);
    }
  }

  Alignment get _gradientEnd {
    switch (widget.direction) {
      case ShimmerDirection.leftToRight:
        return const Alignment(1.0, 0.3);
      case ShimmerDirection.rightToLeft:
        return const Alignment(-1.0, -0.3);
      case ShimmerDirection.topToBottom:
        return const Alignment(0.0, 1.0);
      case ShimmerDirection.bottomToTop:
        return const Alignment(0.0, -1.0);
    }
  }

  Rect _calculateGradientRect(Rect bounds, double t) {
    final width = bounds.width;
    final height = bounds.height;

    switch (widget.direction) {
      case ShimmerDirection.leftToRight:
        final dx = -width + (width * 2) * t;
        return Rect.fromLTWH(dx, 0, width, height);
      case ShimmerDirection.rightToLeft:
        final dx = width - (width * 2) * t;
        return Rect.fromLTWH(dx, 0, width, height);
      case ShimmerDirection.topToBottom:
        final dy = -height + (height * 2) * t;
        return Rect.fromLTWH(0, dy, width, height);
      case ShimmerDirection.bottomToTop:
        final dy = height - (height * 2) * t;
        return Rect.fromLTWH(0, dy, width, height);
    }
  }
}

/// Convenience extension on [Widget] to quickly apply [SmoothShimmer].
extension SmoothShimmerExtension on Widget {
  /// Wraps this widget in a skeleton loading [SmoothShimmer] effect.
  Widget shimmer({
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(milliseconds: 1500),
    ShimmerDirection direction = ShimmerDirection.leftToRight,
    bool enabled = true,
  }) =>
      SmoothShimmer(
        baseColor: baseColor,
        highlightColor: highlightColor,
        duration: duration,
        direction: direction,
        enabled: enabled,
        child: this,
      );
}
