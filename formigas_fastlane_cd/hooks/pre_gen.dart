import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

void run(HookContext context) {
  _assertRootDirectory(context);
  _selectProjectName(context);
  _selectPackageName(context);
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

void _selectPackageName(HookContext context) {
  final cwd = Directory.current.path;
  final buildFile = File('$cwd/android/app/build.gradle');
  if (buildFile.existsSync()) {
    final build = buildFile.readAsStringSync();
    final packageStart = build.indexOf('namespace = "') + 13;
    final packageEnd = build.substring(packageStart).indexOf('"');
    final package = build.substring(packageStart, packageStart + packageEnd);
    context.vars = {
      ...context.vars,
      'package_name': package,
    };
  } else {
    context.logger.err(
      "Couldn't find AndroidManifest.xml from current directory.",
    );
    exit(1);
  }
}
