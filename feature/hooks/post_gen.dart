import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final usefreezed = context.vars['use_freezed'];

  await _installMvcLibrary(context);
  await _installFreezedLibrary(context);
  if (usefreezed == true) {
    await _installFreezedAnnotationLibrary(context);
    await _installBuildRunnerLibrary(context);
    await _installPackages(context);
    // build_runner fails, because install packages is not ready
    await Future<void>.delayed(const Duration(seconds: 1));
    await _runBuildRunner(context);
  } else {
    await _installPackages(context);
  }
}

Future<void> _installMvcLibrary(HookContext context) async {
  final progress = context.logger.progress('Installing formigas-mvc library');
  await _runProcess(context, 'dart', [
    'pub',
    'add',
    'formigas_mvc:{"git":{"url":"git@git.dev.formigas.de:framework/lib-formigas-mvc.git","ref":"develop"}}',
  ]);
  progress.complete();
}

Future<void> _installBuildRunnerLibrary(HookContext context) async {
  final progress = context.logger.progress('Installing build_runner');
  await _runProcess(context, 'dart', [
    'pub',
    'add',
    'dev:build_runner: ^2.4.8',
  ]);
  progress.complete();
}

Future<void> _installFreezedAnnotationLibrary(HookContext context) async {
  final progress = context.logger.progress('Installing freezed_annotation');
  await _runProcess(context, 'dart', [
    'pub',
    'add',
    'freezed_annotation: ^2.4.1',
  ]);
  progress.complete();
}

Future<void> _installFreezedLibrary(HookContext context) async {
  final progress = context.logger.progress('Installing freezed');
  await _runProcess(context, 'dart', [
    'pub',
    'add',
    'dev:freezed: ^2.4.5',
  ]);
  progress.complete();
}

Future<void> _installPackages(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  await _runProcess(context, 'flutter', ['packages', 'get']);
  progress.complete();
}

Future<void> _runBuildRunner(HookContext context) async {
  final progress = context.logger.progress('Running build runner');

  await _runProcess(context, 'dart', [
    'pub',
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);
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
  }
}

bool _useFvm(HookContext context) => context.vars['use_fvm'] == true;
