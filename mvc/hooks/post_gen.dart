import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _installPackages(context);
  await _runBuildRunner(context);
}

Future<void> _installPackages(HookContext context) async {
  final progress = context.logger.progress('Installing formigas-mvc library');
  await _runProcess(context, 'dart', [
    'pub',
    'add',
    'formigas_mvc:{"git":{"url":"git@git.dev.formigas.de:framework/lib-formigas-mvc.git","ref":"main"}}',
  ]);
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
    '--build-filter',
    './lib/ui/',
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
