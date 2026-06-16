import 'package:flutter/material.dart';

class TextTitleInfo extends StatelessWidget {
  const TextTitleInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle = TextStyle(
      color: Theme.of(context).textTheme.bodyLarge?.color,
      fontWeight: FontWeight.w400,
      fontSize: 26.0,
      letterSpacing: -1.0,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Text(
          'Нажмите на кнопку ниже для смены формата единицы измерения',
          style: txtStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
