import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forecast_app_pet_proj/domain/entities/meteo_enity/meteo_enity.dart';
import '../../interface_card/opacity_card_interface.dart';
import 'current_information/card/card.dart';

class TopCard extends StatefulWidget {
  final MeteoEntity currentWeather;
  final VoidCallback actionRemove;
  final bool isMetric;

  const TopCard({
    super.key,
    required this.currentWeather,
    required this.actionRemove,
    required this.isMetric,
  });

  @override
  State<StatefulWidget> createState() => TopCardState();
}

class TopCardState extends State<TopCard> {
  bool flag = false;

  void _changeFlag() {
    setState(() {
      flag = !flag;
      log(flag.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return OpacityCardInterface(
      child: CurrentInfo(
        data: widget.currentWeather,
        flag: flag,
        action: () {
          _changeFlag();
        },
        removeLogicAction: () {
          widget.actionRemove();
        },
      ),
    );
  }
}
