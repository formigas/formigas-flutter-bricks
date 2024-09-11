import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  context.logger.info('running post_gen hook...');
  _implementCustomTheme(context);
  await _dartFormat(context);
  context.logger.info('post_gen hook completed');
}

void _implementCustomTheme(HookContext context) {
  String appFile = File(
          '${Directory.current.path}/${context.vars['app_directory']}/app.dart')
      .readAsStringSync();
  final int start = appFile.indexOf('theme: ThemeData(');
  if (start == -1) {
    context.logger.info('Could not find theme: ThemeData in app.dart');
    return;
  }
  int end = start + appFile.substring(start).indexOf('(');
  int bracketCount = 1;
  while (bracketCount != 0) {
    end++;
    if (appFile[end] == '(') {
      bracketCount++;
    } else if (appFile[end] == ')') {
      bracketCount--;
    }
  }
  appFile = appFile.replaceRange(start, end + 1,
      'theme: CustomTheme().light,darkTheme: CustomTheme().dark');
  var beginSecondLine = appFile.indexOf('\n');
  appFile = appFile.substring(0, beginSecondLine) +
      'import \'package:${context.vars['project_name']}/common/custom_themes.dart\';\n' +
      appFile.substring(beginSecondLine + 1);
  File('${Directory.current.path}/${context.vars['app_directory']}/app.dart')
      .writeAsStringSync(appFile);
}

Future<void> _dartFormat(HookContext context) async {
  final progress = context.logger.progress('Formatting files');
  try {
    var command;
    if (context.vars['use_fvm']) {
      command = 'fvm dart';
    } else {
      command = 'dart';
    }
    await _runProcess(context, command, ['format', '.']);
  } catch (e) {
    progress.fail('Formatting files failed');
    rethrow;
  }

  progress.complete();
}

Future<void> _runProcess(
  HookContext context,
  String executable,
  List<String> arguments,
) async {
  final result = await Process.run(
    executable,
    arguments,
  );
  if (result.exitCode != 0) {
    context.logger.err(result.stdout.toString());
    context.logger.err(result.stderr.toString());
    throw Exception('process exited with code ${result.exitCode}');
  }
}
