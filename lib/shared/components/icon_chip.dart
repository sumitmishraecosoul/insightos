import 'package:flutter/material.dart';
import 'package:insightos/core/theme/theme_extensions.dart';

class IconChip extends StatelessWidget {
  const IconChip({super.key, 
    required this.icon,
    this.onTap,
    this.showDot = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: context.appColors.surfaceAlt.withValues(alpha:0.35),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.appColors.border),
      ),
      child: Stack(
        children: [
          Center(child: Icon(icon, size: 16, color: context.appColors.textSecondary)),
          if (showDot)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: context.appColors.danger,
                  shape: BoxShape.circle,
                  border: Border.all(color: context.appColors.surface, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );

    if (onTap == null) return child;
    return InkWell(borderRadius: BorderRadius.circular(8), onTap: onTap, child: child);
  }
}
