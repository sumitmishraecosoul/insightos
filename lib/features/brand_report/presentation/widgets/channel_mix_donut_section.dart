import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';

/// Channel mix donut chart section.
class ChannelMixDonutSection extends StatefulWidget {
  const ChannelMixDonutSection({super.key, required this.channelMix});

  final Map<String, num> channelMix;

  @override
  State<ChannelMixDonutSection> createState() => _ChannelMixDonutSectionState();
}

class _ChannelMixDonutSectionState extends State<ChannelMixDonutSection> {
  int? _touchedIndex;

  static const Duration _animDuration = Duration(milliseconds: 900);
  static const double _donutSize = 170;

  /// Outer arc radius — keep ring thick enough if [centerSpaceRadius] grows.
  static const double _donutRadius = 46;

  /// Inner hole — large enough for a single centered % label without painting on segments.
  static const double _holeRadius = 34;

  @override
  Widget build(BuildContext context) {
    final entries = widget.channelMix.entries.toList(growable: false);
    final colors = _sectionColors(context, entries.length);

    final selected =
        (_touchedIndex != null &&
            _touchedIndex! >= 0 &&
            _touchedIndex! < entries.length)
        ? entries[_touchedIndex!]
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Channel Mix',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: context.appColors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 360;
                final legend = SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < entries.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: i == entries.length - 1 ? 0 : 7,
                          ),
                          child: _LegendRow(
                            color: colors[i],
                            label: _labelForKey(entries[i].key),
                            value: entries[i].value.toDouble(),
                            isSelected: _touchedIndex == i,
                            onTap: () => setState(() => _touchedIndex = i),
                          ),
                        ),
                    ],
                  ),
                );

                final donut = SizedBox(
                  width: _donutSize,
                  height: _donutSize,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (event, response) {
                                if (!mounted) return;
                                setState(() {
                                  final idx = response
                                      ?.touchedSection
                                      ?.touchedSectionIndex;
                                  _touchedIndex = (idx != null && idx >= 0)
                                      ? idx
                                      : null;
                                });
                              },
                            ),
                            sectionsSpace: 2,
                            centerSpaceRadius: _holeRadius,
                            sections: [
                              for (var i = 0; i < entries.length; i++)
                                _section(
                                  context,
                                  i,
                                  entries[i].key,
                                  entries[i].value.toDouble(),
                                  colors[i],
                                ),
                            ],
                          ),
                          swapAnimationDuration: _animDuration,
                          swapAnimationCurve: Curves.easeOutCubic,
                        ),
                        _CenterLabel(
                          holeDiameter: _holeRadius * 2,
                          hasSelection: selected != null,
                          percent: selected?.value.toDouble(),
                        ),
                      ],
                    ),
                  ),
                );

                if (isNarrow) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: donut),
                      const SizedBox(height: AppSpacing.lg),
                      legend,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    donut,
                    const SizedBox(width: 14),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: _donutSize,
                        ),
                        child: legend,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PieChartSectionData _section(
    BuildContext context,
    int index,
    String key,
    double value,
    Color color,
  ) {
    final isSelected = _touchedIndex == index;
    return PieChartSectionData(
      value: value,
      color: color,
      showTitle: false,
      radius: isSelected ? _donutRadius + 3 : _donutRadius,
      badgeWidget: const SizedBox.shrink(),
    );
  }

  List<Color> _sectionColors(BuildContext context, int count) {
    final palette = <Color>[
      context.appColors.brand,
      context.appColors.success,
      context.appColors.purple,
      context.appColors.warning,
      context.appColors.borderStrong,
    ];
    return List<Color>.generate(count, (i) => palette[i % palette.length]);
  }

  String _labelForKey(String key) {
    return switch (key) {
      'paid_social' => 'Paid Social',
      'marketplace' => 'Marketplace',
      'influencer' => 'Influencer',
      'seo' => 'SEO',
      'others' => 'Others',
      _ => key,
    };
  }
}

class _CenterLabel extends StatelessWidget {
  const _CenterLabel({
    required this.holeDiameter,
    required this.hasSelection,
    required this.percent,
  });

  final double holeDiameter;
  final bool hasSelection;
  final double? percent;

  @override
  Widget build(BuildContext context) {
    final inset = 6.0;
    final side = (holeDiameter - inset * 2).clamp(16.0, holeDiameter);

    final text = !hasSelection
        ? 'Tap'
        : '${percent?.toStringAsFixed(0) ?? '–'}%';

    return SizedBox(
      width: holeDiameter,
      height: holeDiameter,
      child: Center(
        child: ClipOval(
          child: SizedBox(
            width: side,
            height: side,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: !hasSelection
                      ? Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: context.appColors.textTertiary,
                          fontWeight: FontWeight.w700,
                        )
                      : Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: context.appColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.color,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final double value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1 : 0.9,
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: context.appColors.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${value.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: context.appColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
