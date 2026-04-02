import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_mode_provider.dart';
import 'features/brand_report/presentation/screens/brand_report_dashboard_screen.dart';

void main() {
  runApp(const ProviderScope(child: InsightOsApp()));
}

/// Root application widget.
class InsightOsApp extends ConsumerWidget {
  const InsightOsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'AI Marketing OS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      home: const BrandReportDashboardScreen(),
    );
  }
}
