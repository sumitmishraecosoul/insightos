import 'package:flutter/material.dart';
import 'package:insightos/core/theme/theme_extensions.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, 
    required this.activeIndex,
    required this.onTap,
  });

  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(top: BorderSide(color: context.appColors.border)),
      ),
      child: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.appColors.surface,
        selectedItemColor: context.appColors.brand,
        unselectedItemColor: context.appColors.textTertiary,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.sensors_rounded), label: 'Zones'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}
