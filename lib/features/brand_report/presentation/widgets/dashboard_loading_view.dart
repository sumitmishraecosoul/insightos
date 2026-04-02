import 'package:flutter/material.dart';
import 'package:insightos/core/theme/app_spacing.dart';
import 'package:insightos/shared/components/skeleton_card.dart';

class DashboardLoadingView extends StatelessWidget {
  const DashboardLoadingView({super.key});

  static const double _cardHeight = 120;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        SkeletonCard(height: _cardHeight),
        const SizedBox(height: AppSpacing.xl),
        SkeletonCard(height: _cardHeight),
        const SizedBox(height: AppSpacing.xl),
        SkeletonCard(height: _cardHeight),
        const SizedBox(height: AppSpacing.xl),
        SkeletonCard(height: _cardHeight),
      ],
    );
  }
}
