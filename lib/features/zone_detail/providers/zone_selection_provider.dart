import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Currently selected zone ID (for bottom sheet)
final selectedZoneIdProvider = StateProvider<String?>((ref) => null);