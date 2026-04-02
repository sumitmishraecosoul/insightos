import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insightos/features/brand_report/presentation/widgets/bottom_nav_bar.dart';
import 'package:insightos/features/brand_report/presentation/widgets/dashboard_error_view.dart';
import 'package:insightos/features/brand_report/presentation/widgets/dashboard_loading_view.dart';
import 'package:insightos/features/brand_report/presentation/widgets/page_header.dart';
import 'package:insightos/features/brand_report/presentation/widgets/top_bar.dart';
import 'package:insightos/features/brand_report/providers/brand_report_repository_provider.dart';

import '../../../../core/theme/theme_mode_provider.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../providers/brand_report_providers.dart';
import '../widgets/ai_insights_feed_section.dart';
import '../widgets/brand_health_score_section.dart';
import '../widgets/channel_mix_donut_section.dart';
import '../widgets/spend_vs_performance_section.dart';
import '../widgets/zone_performance_section.dart';

/// Main dashboard screen aggregating the brand report.
class BrandReportDashboardScreen extends ConsumerWidget {
  const BrandReportDashboardScreen({super.key});

  static const double _tabletBreakpoint = 768;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsync = ref.watch(brandReportControllerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final failureRate = ref.watch(mockFailureRateProvider);

    return Scaffold(
      backgroundColor: context.appColors.surfaceAlt,
      bottomNavigationBar: BottomNavBar(
        activeIndex: 0,
        onTap: (_) {},
      ),
      body: Column(
        children: [
          TopBar(
            themeMode: themeMode,
            failureRate: failureRate,
            onSelectFailureRate: (value) async {
              ref.read(mockFailureRateProvider.notifier).state = value;
              ref.read(brandReportControllerProvider.notifier).refresh();
            },
            onToggleTheme: () {
              ref.read(themeModeProvider.notifier).state =
                  themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
          Expanded(
            child: reportAsync.when(
              loading: () => const DashboardLoadingView(),
              error: (error, stack) => DashboardErrorView(
                error: error,
                onRetry: () => ref.read(brandReportControllerProvider.notifier).refresh(),
              ),
              data: (report) {
                return RefreshIndicator(
                  onRefresh: () => ref.read(brandReportControllerProvider.notifier).refresh(),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isTablet = constraints.maxWidth > _tabletBreakpoint;
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const PageHeader(),
                            const SizedBox(height: 14),
                            BrandHealthScoreSection(score: report.brandHealthScore),
                            const SizedBox(height: 14),
                            ZonePerformanceSection(zones: report.zones, isTablet: isTablet),
                            const SizedBox(height: 14),
                            if (isTablet)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: SpendVsPerformanceSection(
                                      weeklySpend: report.weeklySpend,
                                      weeklyRoas: report.weeklyRoas,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    flex: 2,
                                    child: ChannelMixDonutSection(channelMix: report.channelMix),
                                  ),
                                ],
                              )
                            else ...[
                                SpendVsPerformanceSection(
                                  weeklySpend: report.weeklySpend,
                                  weeklyRoas: report.weeklyRoas,
                                ),
                                const SizedBox(height: 14),
                                ChannelMixDonutSection(channelMix: report.channelMix),
                              ],
                            const SizedBox(height: 14),
                            AiInsightsFeedSection(insights: report.insights),
                            const SizedBox(height: 18),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}








