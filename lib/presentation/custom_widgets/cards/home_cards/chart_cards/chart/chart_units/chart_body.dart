import 'package:flutter/material.dart';

Widget chartBody({required Widget child, required BuildContext context}) {
  return SizedBox(
    height: 280,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            width: constraints.maxWidth * 3.2,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: child,
          ),
        );
      },
    ),
  );
}
