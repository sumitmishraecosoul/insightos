import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightos/features/zone_detail/providers/zone_selection_provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../data/models/zone.dart';
import '../../../zone_detail/presentation/screens/zone_detail_bottom_sheet.dart';
import 'section_header.dart';
import 'zone_card.dart';

/// Zone performance summary section.
class ZonePerformanceSection extends ConsumerWidget {
  const ZonePerformanceSection({
    super.key,
    required this.zones,
    required this.isTablet,
  });

  final List<Zone> zones;
  final bool isTablet;

  static const int _tabletGridColumns = 2;
  static const double _horizontalListHeight = 112;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedZoneId = ref.watch(selectedZoneIdProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Zone Performance',
              trailing: Text(
                'See all →',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: context.appColors.brand,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (isTablet)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _tabletGridColumns,
                  mainAxisSpacing: AppSpacing.lg,
                  crossAxisSpacing: AppSpacing.lg,
                  childAspectRatio: 3.2,
                ),
                itemCount: zones.length,
                itemBuilder: (context, index) {
                  final zone = zones[index];
                  return ZoneCard(
                    zone: zone,
                    onTap: () => _openZoneBottomSheet(context, ref, zone),
                    isActive: selectedZoneId == zone.id,
                  );
                },
              )
            else
              SizedBox(
                height: _horizontalListHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: zones.length,
                  itemBuilder: (context, index) {
                    final zone = zones[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == zones.length - 1 ? 0 : AppSpacing.lg,
                      ),
                      child: SizedBox(
                        width: 110,
                        child: ZoneCard(
                          zone: zone,
                          onTap: () => _openZoneBottomSheet(context, ref, zone),
                          isActive: selectedZoneId == zone.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _openZoneBottomSheet(
    BuildContext context,
    WidgetRef ref,
    Zone zone,
  ) async {
    ref.read(selectedZoneIdProvider.notifier).state = zone.id;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.surface,
      showDragHandle: true,
      builder: (_) => ZoneDetailBottomSheet(zone: zone),
    );
  }
}

