import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../data/models/insight.dart';
import 'section_header.dart';

/// AI insights feed section.
class AiInsightsFeedSection extends StatelessWidget {
  const AiInsightsFeedSection({super.key, required this.insights});

  final List<Insight> insights;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'AI Insights',
              trailing: Text(
                'View all →',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: context.appColors.brand,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final insight = insights[index];
                return _InsightTile(insight: insight);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context) {
    final (icon, iconColor, iconBg) = _iconColors(context, insight.type);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          backgroundColor: context.appColors.surface,
          builder: (_) => _InsightDetailSheet(insight: insight),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.cardAlt,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.appColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (insight.isUrgent)
              Container(
                width: 3,
                decoration: BoxDecoration(
                  color: context.appColors.danger,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Icon(icon, size: 16, color: iconColor),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight.headline,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: context.appColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            insight.body,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 10,
                                  color: context.appColors.textSecondary,
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              if (insight.isUrgent)
                                _TagChip(
                                  label: 'Urgent',
                                  background: context.appColors.dangerBg,
                                  foreground: context.appColors.danger,
                                ),
                              _TagChip(
                                label: _zoneLabel(insight.zoneId),
                                background: context.appColors.surfaceAlt.withOpacity(0.35),
                                foreground: context.appColors.textTertiary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '›',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: context.appColors.textTertiary,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  (IconData, Color, Color) _iconColors(BuildContext context, InsightType type) {
    return switch (type) {
      InsightType.alert => (
          Icons.warning_amber_rounded,
          context.appColors.danger,
          context.appColors.dangerBg,
        ),
      InsightType.opportunity => (
          Icons.auto_awesome_rounded,
          context.appColors.success,
          context.appColors.successBg,
        ),
      InsightType.fyi => (
          Icons.info_outline_rounded,
          context.appColors.brand,
          context.appColors.brandBg,
        ),
    };
  }

  String _zoneLabel(String id) {
    return switch (id) {
      'paid_ads' => 'Paid Ads',
      'seo' => 'SEO',
      'social_media' => 'Social',
      'marketplace' => 'Marketplace',
      'messaging' => 'Messaging',
      _ => id,
    };
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: foreground,
              letterSpacing: 0.3,
            ),
      ),
    );
  }
}

class _InsightDetailSheet extends StatelessWidget {
  const _InsightDetailSheet({required this.insight});

  final Insight insight;

  static const double _minChildSize = 0.4;
  static const double _maxChildSize = 0.85;
  static const double _initialChildSize = 0.55;

  @override
  Widget build(BuildContext context) {
    final (icon, color, label) = _typeMeta(context, insight.type);
    final urgentColor = context.appColors.danger;

    return DraggableScrollableSheet(
      minChildSize: _minChildSize,
      maxChildSize: _maxChildSize,
      initialChildSize: _initialChildSize,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: color),
                      ),
                      if (insight.isUrgent)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: urgentColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: context.appColors.surface, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: context.appColors.textTertiary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          insight.headline,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: context.appColors.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                insight.body,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: context.appColors.textSecondary, height: 1.35),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  _MetaChip(label: 'Zone', value: insight.zoneId),
                  const SizedBox(width: AppSpacing.sm),
                  if (insight.isUrgent) _MetaChip(label: 'Priority', value: 'Urgent'),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.check_rounded),
                label: const Text('Done'),
              ),
            ],
          ),
        );
      },
    );
  }

  (IconData, Color, String) _typeMeta(BuildContext context, InsightType type) {
    return switch (type) {
      InsightType.alert => (
          Icons.warning_amber_rounded,
          context.appColors.warning,
          'Alert',
        ),
      InsightType.opportunity => (
          Icons.trending_up_rounded,
          context.appColors.success,
          'Opportunity',
        ),
      InsightType.fyi => (
          Icons.info_outline_rounded,
          context.appColors.brand,
          'FYI',
        ),
    };
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: context.appColors.surfaceAlt,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: context.appColors.border),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: context.appColors.textSecondary),
      ),
    );
  }
}

