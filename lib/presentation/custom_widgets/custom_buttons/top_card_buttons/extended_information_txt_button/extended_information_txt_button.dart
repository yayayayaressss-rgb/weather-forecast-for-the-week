import 'package:flutter/material.dart';

class ExtendedInformationButton extends StatelessWidget {
  final VoidCallback action;
  final bool flag;

  const ExtendedInformationButton({
    super.key,
    required this.flag,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: GestureDetector(
        onTap: () {
          action();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [_buttonTxt(context), _actionIcon(context, flag)],
        ),
      ),
    );
  }
}

Widget _buttonTxt(BuildContext context) {
  TextStyle txtStyle = TextStyle(
    color: Theme.of(context).textTheme.bodyLarge?.color,
    fontSize: 16.0,
    fontWeight: FontWeight(300),
  );

  Text txt = Text('Подбробная информация', style: txtStyle);
  return txt;
}

Icon _actionIcon(BuildContext context, bool flag) {
  return Icon(
    flag ? Icons.expand_less : Icons.expand_more,
    color: Theme.of(context).iconTheme.color,
  );
}
