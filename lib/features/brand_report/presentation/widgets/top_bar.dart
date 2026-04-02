import 'package:flutter/material.dart';
import 'package:insightos/core/theme/theme_extensions.dart';
import 'package:insightos/shared/components/icon_chip.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    required this.themeMode,
    required this.failureRate,
    required this.onSelectFailureRate,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final double failureRate;
  final Future<void> Function(double) onSelectFailureRate;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(bottom: BorderSide(color: context.appColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Evernine ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: 'OS',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: context.appColors.brand,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Brand Report · May 2025',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: context.appColors.textTertiary,
                      ),
                ),
              ],
            ),
          ),
          PopupMenuButton<double>(
            tooltip: 'Mock network',
            onSelected: onSelectFailureRate,
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                value: 0.0,
                checked: failureRate == 0.0,
                child: const Text('Network: Normal'),
              ),
              CheckedPopupMenuItem(
                value: 0.3,
                checked: failureRate == 0.3,
                child: const Text('Network: Flaky (30%)'),
              ),
              CheckedPopupMenuItem(
                value: 1.0,
                checked: failureRate == 1.0,
                child: const Text('Network: Offline (100%)'),
              ),
            ],
            child: IconChip(
              icon: Icons.notifications_none_rounded,
              showDot: true,
            ),
          ),
          const SizedBox(width: 8),
          IconChip(
            icon: themeMode == ThemeMode.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            onTap: onToggleTheme,
          ),
          const SizedBox(width: 8),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [context.appColors.purple, context.appColors.brand],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'AK',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
