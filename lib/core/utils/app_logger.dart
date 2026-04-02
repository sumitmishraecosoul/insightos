import 'package:logger/logger.dart';

/// Shared logger instance for non-UI logging.
final Logger appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 6,
    lineLength: 100,
    colors: true,
    printEmojis: false,
  ),
);

