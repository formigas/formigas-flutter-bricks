import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  context.logger.info('running pre_gen hook...');
  final cwd = Directory.current.path;
  if (!File('$cwd/pubspec.yaml').existsSync()) {
    context.logger.err(
      'This hook must be run from the root of the project.',
    );
    exit(1);
  }
  final pubspecYaml =
      loadYaml(File('$cwd/pubspec.yaml').readAsStringSync()) as Map;
  _assertProjectName(pubspecYaml, context);
  context.vars = {
    ...context.vars,
    'project_name': pubspecYaml['name'],
  };
  context.logger.info('pre_gen hook completed');
}

void _assertProjectName(
  Map<dynamic, dynamic> pubspecYaml,
  HookContext context,
) {
  if (pubspecYaml['name'] == null) {
    context.logger.err(
      "Couldn't find project name in pubspec.yaml.",
    );
    exit(1);
  }
}
