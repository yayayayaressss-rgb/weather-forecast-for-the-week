import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircularGear extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback action;

  const CircularGear({
    required this.action,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action,
      icon: RotationTransition(
        turns: controller,
        child: FaIcon(
          FontAwesomeIcons.gear,
          size: 20,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
    );
  }
}
