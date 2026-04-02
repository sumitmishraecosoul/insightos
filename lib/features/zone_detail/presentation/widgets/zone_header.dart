import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class ZoneHeader extends StatelessWidget {
  const ZoneHeader({
    super.key,
    required this.zoneName,
    required this.onClose,
  });

  final String zoneName;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final accent = context.appColors.brand;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Zone Detail',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Text(
                zoneName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}