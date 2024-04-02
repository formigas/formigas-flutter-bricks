import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future<void> run(HookContext context) async {
  final cwd = Directory.current.path;
  final pubspecFile = File('$cwd/pubspec.yaml');
  Map<dynamic, dynamic>? devDependencies;
  Map<dynamic, dynamic>? dependencies;
  if (pubspecFile.existsSync()) {
    final pubspecYaml = loadYaml(pubspecFile.readAsStringSync()) as Map;
    devDependencies = pubspecYaml['dev_dependencies'] as Map;
    dependencies = pubspecYaml['dependencies'] as Map;
  }
  await _installMvcLibrary(context, dependencies);
  if (context.vars['use_freezed'] == true) {
    await _installFreezedLibrary(context, devDependencies);
    await _installFreezedAnnotationLibrary(context, dependencies);
    await _installBuildRunnerLibrary(context, devDependencies);
    await _installPackages(context);
    // build_runner fails, because install packages is not ready
    await Future<void>.delayed(const Duration(seconds: 1));
    await _runBuildRunner(context);
  } else {
    await _installPackages(context);
  }
}

Future<void> _installMvcLibrary(
  HookContext context,
  Map<dynamic, dynamic>? dependencies,
) async {
  context.logger.info('Verifying formigas_mvc version from pubspec.yaml');
  if (dependencies?.containsKey('formigas_mvc') ?? true) {
    context.logger.info(
      'Found formigas_mvc version ${dependencies?['formigas_mvc']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find formigas_mvc version in pubspec.yaml');
  final progress = context.logger.progress('Installing formigas-mvc library');
  try {
    await _runProcess(context, 'dart', [
      'pub',
      'add',
      'formigas_mvc',
    ]);
  } catch (e) {
    progress.fail('Could not install formigas_mvc library');
  }
  progress.complete();
}

Future<void> _installBuildRunnerLibrary(
  HookContext context,
  Map<dynamic, dynamic>? devDependencies,
) async {
  context.logger.info('Verifying build_runner version from pubspec.yaml');
  if (devDependencies?.containsKey('build_runner') ?? true) {
    context.logger.info(
      'Found build_runner version ${devDependencies?['build_runner']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find build_runner version in pubspec.yaml');
  final progress = context.logger.progress('Installing build_runner');
  try {
    await _runProcess(context, 'dart', [
      'pub',
      'add',
      'dev:build_runner: ^2.4.8',
    ]);
  } catch (e) {
    progress.fail('Could not install build_runner');
  }
  progress.complete();
}

Future<void> _installFreezedAnnotationLibrary(
  HookContext context,
  Map<dynamic, dynamic>? dependencies,
) async {
  context.logger.info('Verifying freezed_annotation version from pubspec.yaml');
  if (dependencies?.containsKey('freezed_annotation') ?? true) {
    context.logger.info(
      'Found freezed_annotation version ${dependencies?['freezed_annotation']} in pubspec.yaml',
    );
    return;
  }
  context.logger
      .info('Could not find freezed_annotation version in pubspec.yaml');
  final progress = context.logger.progress('Installing freezed_annotation');
  try {
    await _runProcess(context, 'dart', [
      'pub',
      'add',
      'freezed_annotation: ^2.4.1',
    ]);
  } catch (e) {
    progress.fail('Could not install freezed_annotation');
  }
  progress.complete();
}

Future<void> _installFreezedLibrary(
  HookContext context,
  Map<dynamic, dynamic>? devDependencies,
) async {
  context.logger.info('Verifying freezed version from pubspec.yaml');
  if (devDependencies?.containsKey('freezed') ?? true) {
    context.logger.info(
      'Found freezed version ${devDependencies?['freezed']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find freezed version in pubspec.yaml');
  final progress = context.logger.progress('Installing freezed');
  try {
    await _runProcess(context, 'dart', [
      'pub',
      'add',
      'dev:freezed: ^2.4.5',
    ]);
  } catch (e) {
    progress.fail('Could not install freezed');
  }
  progress.complete();
}

Future<void> _installPackages(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  try {
    await _runProcess(context, 'dart', ['packages', 'get']);
  } catch (e) {
    progress.fail('Installing packages failed');
  }
  progress.complete();
}

Future<void> _runBuildRunner(HookContext context) async {
  final progress = context.logger.progress('Running build runner');

  try {
    await _runProcess(context, 'dart', [
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ]);
  } catch (e) {
    progress.fail('Running build runner failed');
    return;
  }
  progress.complete();
}

Future<void> _runProcess(
  HookContext context,
  String executable,
  List<String> arguments,
) async {
  final exec = _useFvm(context) ? 'fvm' : executable;
  final args = _useFvm(context) ? [executable, ...arguments] : arguments;
  final result = await Process.run(
    exec,
    args,
  );
  if (result.exitCode != 0) {
    context.logger.err(result.stdout.toString());
    context.logger.err(result.stderr.toString());
    throw Exception('process exited with code ${result.exitCode}');
  }
}

bool _useFvm(HookContext context) => context.vars['use_fvm'] == true;
