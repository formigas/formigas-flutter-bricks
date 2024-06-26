import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future<void> run(HookContext context) async {
  final cwd = Directory.current.path;
  final pubspecFile = File('$cwd/pubspec.yaml');
  Map<dynamic, dynamic>? devDependencies;
  Map<dynamic, dynamic> dependencies;
  try {
    if (pubspecFile.existsSync()) {
      final pubspecYaml = loadYaml(pubspecFile.readAsStringSync()) as Map;
      devDependencies = pubspecYaml['dev_dependencies'] as Map?;
      dependencies = pubspecYaml['dependencies'] as Map;
    } else {
      context.logger.err(
        "Couldn't find pubspec.yaml in the current directory.",
      );
      return;
    }
    final useSms = context.vars['state_management_solution'] as String;
    switch (useSms) {
      case 'BLoC':
        await _installBlocPackage(context, dependencies);
        await _installBlocTestPackage(context, devDependencies);
      case 'Formigas MVC':
        await _installMvcPackage(context, dependencies);
    }

    if (context.vars['use_freezed'] == true) {
      await _installFreezedPackage(context, devDependencies);
      await _installFreezedAnnotationPackage(context, dependencies);
      await _installBuildRunnerPackage(context, devDependencies);
      await _installPackages(context);
      // build_runner fails, because install packages is not ready
      await Future<void>.delayed(const Duration(seconds: 2));
      await _runBuildRunner(context);
    } else {
      await _installEquatablePackage(context, dependencies);
      await _installPackages(context);
    }
  } catch (e) {
    context.logger.err('An error occurred while running post gen hooks. '
        'Check the output above for more information.');
  }
}

Future<void> _installBlocPackage(
  HookContext context,
  Map<dynamic, dynamic> dependencies,
) async {
  context.logger.info('Verifying flutter_bloc version from pubspec.yaml');
  if (dependencies.containsKey('flutter_bloc')) {
    context.logger.info(
      'Found flutter_bloc version ${dependencies['flutter_bloc']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find flutter_bloc version in pubspec.yaml');
  final progress = context.logger.progress('Installing flutter_bloc package');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'flutter_bloc',
    ]);
  } catch (e) {
    progress.fail('Could not install flutter_bloc package');
    rethrow;
  }
  progress.complete();
}

Future<void> _installBlocTestPackage(
  HookContext context,
  Map<dynamic, dynamic>? dependencies,
) async {
  context.logger.info('Verifying flutter_bloc version from pubspec.yaml');
  if (dependencies?.containsKey('bloc_test') ?? false) {
    context.logger.info(
      'Found bloc_test version ${dependencies?['bloc_test']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find bloc_test version in pubspec.yaml');
  final progress = context.logger.progress('Installing bloc_test package');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'bloc_test',
      '--dev',
    ]);
  } catch (e) {
    progress.fail('Could not install bloc_test package');
    rethrow;
  }
  progress.complete();
}

Future<void> _installMvcPackage(
  HookContext context,
  Map<dynamic, dynamic> dependencies,
) async {
  context.logger.info('Verifying formigas_mvc version from pubspec.yaml');
  if (dependencies.containsKey('formigas_mvc')) {
    context.logger.info(
      'Found formigas_mvc version ${dependencies['formigas_mvc']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find formigas_mvc version in pubspec.yaml');
  final progress = context.logger.progress('Installing formigas-mvc package');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'formigas_mvc',
    ]);
  } catch (e) {
    progress.fail('Could not install formigas_mvc package');
    rethrow;
  }
  progress.complete();
}

Future<void> _installBuildRunnerPackage(
  HookContext context,
  Map<dynamic, dynamic>? devDependencies,
) async {
  context.logger.info('Verifying build_runner version from pubspec.yaml');
  if (devDependencies?.containsKey('build_runner') ?? false) {
    context.logger.info(
      'Found build_runner version ${devDependencies?['build_runner']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find build_runner version in pubspec.yaml');
  final progress = context.logger.progress('Installing build_runner');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'dev:build_runner: ^2.4.8',
    ]);
  } catch (e) {
    progress.fail('Could not install build_runner');
    rethrow;
  }
  progress.complete();
}

Future<void> _installFreezedAnnotationPackage(
  HookContext context,
  Map<dynamic, dynamic> dependencies,
) async {
  context.logger.info('Verifying freezed_annotation version from pubspec.yaml');
  if (dependencies.containsKey('freezed_annotation')) {
    context.logger.info(
      'Found freezed_annotation version ${dependencies['freezed_annotation']} in pubspec.yaml',
    );
    return;
  }
  context.logger
      .info('Could not find freezed_annotation version in pubspec.yaml');
  final progress = context.logger.progress('Installing freezed_annotation');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'freezed_annotation: ^2.4.1',
    ]);
  } catch (e) {
    progress.fail('Could not install freezed_annotation');
    rethrow;
  }
  progress.complete();
}

Future<void> _installFreezedPackage(
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
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'dev:freezed: ^2.4.5',
    ]);
  } catch (e) {
    progress.fail('Could not install freezed');
    rethrow;
  }
  progress.complete();
}

Future<void> _installEquatablePackage(
  HookContext context,
  Map<dynamic, dynamic> dependencies,
) async {
  context.logger.info('Verifying equatable version from pubspec.yaml');
  if (dependencies.containsKey('equatable')) {
    context.logger.info(
      'Found equatable version ${dependencies['equatable']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find equatable version in pubspec.yaml');
  final progress = context.logger.progress('Installing equatable');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'equatable',
    ]);
  } catch (e) {
    progress.fail('Could not install equatable');
    rethrow;
  }
  progress.complete();
}

Future<void> _installPackages(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  try {
    await _runProcess(context, 'flutter', ['pub', 'get']);
  } catch (e) {
    progress.fail('Installing packages failed');
    rethrow;
  }
  progress.complete();
}

Future<void> _runBuildRunner(HookContext context) async {
  final progress = context.logger.progress('Running build runner');

  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ]);
  } catch (e) {
    progress.fail('Running build runner failed');
    rethrow;
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
