import 'dart:io';

import 'package:mason/mason.dart';

enum Platform {
  android,
  ios,
}

void run(HookContext context) {
  _verifyRunningInRootDirectory(context);
}

void _verifyRunningInRootDirectory(HookContext context) {
  final cwd = Directory.current.path;
  if (!File('$cwd/pubspec.yaml').existsSync()) {
    context.logger.err(
      'This hook must be run from the root of the project.',
    );
    exit(1);
  }
}
