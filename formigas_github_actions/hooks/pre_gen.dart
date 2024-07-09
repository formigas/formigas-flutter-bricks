import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  if (!File('${Directory.current.path}/pubspec.yaml').existsSync()) {
    context.logger.err(
      'This hook must be run from the root of the project.',
    );
    exit(1);
  }
}
