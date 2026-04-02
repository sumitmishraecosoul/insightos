import 'package:flutter/material.dart';
import 'package:insightos/core/theme/theme_extensions.dart';

class PageHeader extends StatelessWidget {
  const PageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Brand Report', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 2),
        Text(
          'Updated 2 hours ago · All channels',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: context.appColors.textTertiary,
              ),
        ),
      ],
    );
  }
}
