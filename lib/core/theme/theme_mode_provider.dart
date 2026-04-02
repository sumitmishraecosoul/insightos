import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode for the application.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

