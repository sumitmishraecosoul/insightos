import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';

/// Brand health score section showing a circular progress indicator.
class BrandHealthScoreSection extends StatelessWidget {
  const BrandHealthScoreSection({super.key, required this.score});

  final int score;

  static const Duration _animDuration = Duration(milliseconds: 900);
  static const double _strokeWidth = 8;
  static const double _indicatorSize = 84;
  static const double _narrowBreakpoint = 420;

  @override
  Widget build(BuildContext context) {
    final (label, color) = _labelAndColor(context, score);
    final arrow = switch (label) {
      'Good' => '↑',
      'Needs Attention' => '→',
      _ => '↓',
    };
    final deltaText = _deltaText(label);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Brand Health',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: context.appColors.textTertiary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < _narrowBreakpoint;
                final indicator = TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: score / 100),
                  duration: _animDuration,
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return SizedBox(
                      width: _indicatorSize,
                      height: _indicatorSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: value,
                            strokeWidth: _strokeWidth,
                            backgroundColor:
                                context.appColors.surfaceAlt.withOpacity(0.35),
                            color: color,
                          ),
                          TweenAnimationBuilder<int>(
                            tween: IntTween(begin: 0, end: score),
                            duration: _animDuration,
                            curve: Curves.easeOutCubic,
                            builder: (context, v, _) {
                              return Text(
                                '$v',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: color,
                                      fontWeight: FontWeight.w700,
                                    ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );

                final textBlock = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$label $arrow',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      deltaText,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: context.appColors.textSecondary),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        minHeight: 4,
                        value: score / 100,
                        backgroundColor:
                            context.appColors.surfaceAlt.withOpacity(0.35),
                        color: color,
                      ),
                    ),
                  ],
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: indicator),
                      const SizedBox(height: AppSpacing.lg),
                      textBlock,
                    ],
                  );
                }

                return Row(
                  children: [
                    indicator,
                    const SizedBox(width: AppSpacing.xl),
                    Expanded(child: textBlock),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  (String, Color) _labelAndColor(BuildContext context, int score) {
    if (score >= 70) return ('Good', context.appColors.success);
    if (score >= 40) return ('Needs Attention', context.appColors.warning);
    return ('Critical', context.appColors.danger);
  }

  String _deltaText(String label) {
    return switch (label) {
      'Good' => '+5 pts from last week across all channels',
      'Needs Attention' => '-2 pts from last week across all channels',
      _ => '-7 pts from last week across all channels',
    };
  }
}

