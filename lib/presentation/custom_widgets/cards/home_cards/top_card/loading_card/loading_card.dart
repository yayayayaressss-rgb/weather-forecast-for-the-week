import 'package:flutter/material.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100.0,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
