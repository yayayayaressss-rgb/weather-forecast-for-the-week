import 'package:flutter/material.dart';

import '../../../custom_buttons/refresh_network_connection/refresh_network_connection_button.dart';

class DisconnectedDisplay extends StatelessWidget {
  const DisconnectedDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Нет подключения\nк сети',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 35.0,
              fontWeight: FontWeight(500),
              letterSpacing: 1.0,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 15.0),
          RefreshNetworkConnectionButton(),
        ],
      ),
    );
  }
}
