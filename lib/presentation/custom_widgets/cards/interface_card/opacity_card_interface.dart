import 'package:flutter/material.dart';
import '../../../../common/app_theme/colors_first.dart';
import '../../../../common/app_theme/colors_second.dart';

class OpacityCardInterface extends StatefulWidget {
  final Widget child;
  final double? height;

  const OpacityCardInterface({super.key, this.height, required this.child});

  @override
  State<StatefulWidget> createState() => OpacityCardInterfaceState();
}

class OpacityCardInterfaceState extends State<OpacityCardInterface> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 100),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 2.0, left: 2.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? const [
                    ColorSystemForestRain.COLOR_SURFACE,
                    ColorSystemForestRain.COLOR_BACKGROUND,
                  ]
                : const [
                    ColorSystem.COLOR_SURFACE,
                    ColorSystem.COLOR_BACKGROUND,
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          color: ColorSystemForestRain.COLOR_SURFACE,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: widget.height,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
