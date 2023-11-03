import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _checkFlutter(context);
  await _addMvcMason(context);
  await _makeMvcMason(context);
  await _installPackages(context);
  await _runBuildRunner(context);
}

Future<void> _addMvcMason(HookContext context) async {
  final progress = context.logger.progress('Adding mvc_mason');
  await _runProcess(
    context,
    'mason',
    [
      'add',
      'formigas_mvc',
      '--git-url',
      'git@git.dev.formigas.de:framework/bricks.git',
      '--git-path',
      'formigas_mvc',
      '--git-ref',
      'd3e9bcf54ff56118339b92362af6f5ad150ed851',
    ],
    useFvmIfNeccessary: false,
  );
  progress.complete();
}

Future<void> _makeMvcMason(HookContext context) async {
  final progress = context.logger.progress('Adding example mvc view');
  await _runProcess(
    context,
    'mason',
    [
      'make',
      'formigas_mvc',
      '--project_name',
      context.vars['project_name'].toString(),
      '--mvc_name',
      'counter',
      '--use_fvm',
      context.vars['use_fvm'].toString(),
    ],
    useFvmIfNeccessary: false,
  );
  progress.complete();
}

Future<void> _checkFlutter(HookContext context) async {
  final progress = context.logger.progress('Checking flutter version');
  await _runProcess(context, 'flutter', ['--version']);
  progress.complete();
}

String _getWorkingDirectory(HookContext context) =>
    context.vars['project_name'].toString();

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
  List<String> arguments, {
  bool useFvmIfNeccessary = true,
}) async {
  final exec = useFvmIfNeccessary && _useFvm(context) ? 'fvm' : executable;
  final args = useFvmIfNeccessary && _useFvm(context)
      ? [executable, ...arguments]
      : arguments;
  final result = await Process.run(
    exec,
    args,
    workingDirectory: _getWorkingDirectory(context),
  );
  if (result.exitCode != 0) {
    context.logger.err(result.stdout.toString());
    context.logger.err(result.stderr.toString());
  }
}

bool _useFvm(HookContext context) => context.vars['use_fvm'] == true;
