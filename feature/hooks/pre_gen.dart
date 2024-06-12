import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  _assertRootDirectory(context);
  _selectUseFvm(context);
  _selectProjectName(context);
  _selectStateManagementSolution(context);
}

void _assertRootDirectory(HookContext context) {
  final cwd = Directory.current.path;
  if (!File('$cwd/pubspec.yaml').existsSync()) {
    context.logger.err(
      'This hook must be run from the root of the project.',
    );
    exit(1);
  }
}

void _selectUseFvm(HookContext context) {
  final cwd = Directory.current.path;
  context.vars = {
    ...context.vars,
    'use_fvm': File('$cwd/.fvm/fvm_config.json').existsSync(),
  };
}

void _selectProjectName(HookContext context) {
  final cwd = Directory.current.path;
  final pubspecFile = File('$cwd/pubspec.yaml');
  if (pubspecFile.existsSync()) {
    final pubspecYaml = loadYaml(pubspecFile.readAsStringSync()) as Map;
    _assertProjectName(pubspecYaml, context);
    context.vars = {
      ...context.vars,
      'project_name': pubspecYaml['name'],
    };
  } else {
    context.logger.err(
      "Couldn't find pubspec.yaml in the current directory.",
    );
    exit(1);
  }
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

void _selectStateManagementSolution(HookContext context) {
  final useCI = context.vars['use_sms'] as String?;
  switch (useCI) {
    case 'Formigas MVC':
      context.vars = {...context.vars, 'formigas_mvc': true};
    case 'BLoC':
      context.vars = {...context.vars, 'bloc': true};

    case 'Riverpod':
      context.vars = {...context.vars, 'riverpod': true};
    default:
  }
}
