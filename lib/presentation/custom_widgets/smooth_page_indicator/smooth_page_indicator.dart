import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Smooth extends StatelessWidget {
  final int counter;
  final PageController _controller;

  const Smooth({
    super.key,
    required PageController controller,
    required this.counter,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    WormEffect effect() {
      return WormEffect(
        activeDotColor: Theme.of(context).colorScheme.secondary,
        dotColor: Theme.of(context).dividerColor,
        dotHeight: 8.0,
        dotWidth: 8.0,
        spacing: 8.0,
      );
    }

    return SmoothPageIndicator(
      controller: _controller,
      count: counter,
      effect: effect(),
    );
  }
}
