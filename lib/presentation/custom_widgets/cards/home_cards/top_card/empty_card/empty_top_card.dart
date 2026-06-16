import 'package:flutter/material.dart';

import 'body.dart';

class EmptyTopCard extends StatelessWidget {
  const EmptyTopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return emptyCardBody(child: _text(context));
  }
}

Widget _text(BuildContext context) {
  final textStyle = TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontSize: 16.0,
    fontWeight: FontWeight(600),
  );
  const String text = 'Актуальные данные пока не загруженны';
  return Text(text, style: textStyle);
}
