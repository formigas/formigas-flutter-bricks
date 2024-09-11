import 'dart:io';

import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

Future<void> run(HookContext context) async {
  _implementGoRouter(context);
  String pubspec;
  try {
    pubspec = File('${Directory.current.path}/pubspec.yaml').readAsStringSync();
  } catch (e) {
    context.logger.err('Could not read pubspec.yaml');
    rethrow;
  }
  await _installGoRouterPackage(
    context,
    (loadYaml(pubspec) as Map)['dependencies'] as Map,
  );
  await _installPackages(context);
  await _dartFormat(context);
  await _dartFix(context);
}

void _implementGoRouter(HookContext context) {
  try {
    String appFile = File(
            '${Directory.current.path}/${context.vars['app_directory']}/app.dart')
        .readAsStringSync();
    var beginSecondLine = appFile.indexOf('\n');
    appFile = appFile.substring(0, beginSecondLine) +
        'import \'package:${context.vars['project_name']}/services/navigation_service/go_router.dart\';' +
        '\n' +
        appFile.substring(beginSecondLine + 1);
    appFile = appFile.replaceAll('MaterialApp(', 'MaterialApp.router(');
    appFile = _findHomeWidget(appFile, context) ?? appFile;
    File('${Directory.current.path}/${context.vars['app_directory']}/app.dart')
        .writeAsStringSync(appFile);
  } catch (e) {
    context.logger.err('Could not implement go_router in app.dart,\nerror: $e');
  }
}

String? _findHomeWidget(String appFile, HookContext context) {
  int start = appFile.indexOf('home: ');
  if (start == -1) {
    context.logger.err('Could not find home widget in app.dart');
    return null;
  }
  final int indexNextBracket = start + appFile.substring(start).indexOf('(');
  final int indexNextComma = start + appFile.substring(start).indexOf(',');
  context.logger.info('start: $start');
  context.logger.info('indexNextBracket: $indexNextBracket');
  context.logger.info('indexNextComma: $indexNextComma');
  int end = 0;
  if (indexNextBracket < indexNextComma && indexNextBracket - start != -1) {
    end = indexNextBracket;
    int bracketCount = 1;
    while (bracketCount != 0) {
      end++;
      if (appFile[end] == '(') {
        bracketCount++;
      } else if (appFile[end] == ')') {
        bracketCount--;
      }
    }
  } else {
    (start, end, appFile) = _findParameterWidget(
      start,
      indexNextComma,
      appFile,
      context,
    );
  }
  return appFile.replaceRange(start, end + 1, 'routerConfig: appRouter');
}

(int newStart, int end, String appfile) _findParameterWidget(
  int start,
  int indexNextComma,
  String appFile,
  HookContext context,
) {
  // +6 to remove the 'home: '
  final String parameter = appFile.substring(start + 6, indexNextComma);
  final int definitionStart = appFile.indexOf('$parameter = ');

  int definitionEnd =
      appFile.substring(definitionStart).indexOf('(') + definitionStart;
  int bracketCount = 1;
  while (bracketCount != 0) {
    definitionEnd++;
    if (appFile[definitionEnd] == '(') {
      bracketCount++;
    } else if (appFile[definitionEnd] == ')') {
      bracketCount--;
    }
  }
  context.vars.addAll({
    'home_widget': appFile.substring(
      // +3 to remove the space and equal sign
      definitionStart + parameter.length + 3,
      definitionEnd + 1, // +1 to include the closing bracket
    )
  });

  appFile = appFile.replaceRange(
    // -7 to remove the Type and space before the parameter
    definitionStart - 7,
    // +2 to remove the closing Bracket and Semicolon after the parameter
    definitionEnd + 2,
    '',
  );

  final int removedCharCount = (definitionEnd + 2) - (definitionStart - 7);
  context.logger.info('removedCharCount: $removedCharCount');
  // if the definition is before the start of the parameter
  // the replacement indices change
  if (definitionStart < start) {
    start = start - removedCharCount;
    indexNextComma = indexNextComma - removedCharCount;
  }
  // -1 to get the end of the parameter and not the coma after
  return (start, indexNextComma - 1, appFile);
}

void _implementHomeRoute(HookContext context) {
  try {
    String goRouterFile = File(
      '${Directory.current.path}/lib/services/navigation_service/go_router.dart',
    ).readAsStringSync();
    goRouterFile = goRouterFile.replaceAll(
      'placeholder',
      context.vars['home_widget'] as String,
    );
    File('${Directory.current.path}/lib/services/navigation_service/go_router.dart')
        .writeAsStringSync(goRouterFile);
  } catch (e) {
    context.logger.err('Could not implement home route in go_router.dart');
  }
}

Future<void> _installGoRouterPackage(
  HookContext context,
  Map<dynamic, dynamic>? dependencies,
) async {
  context.logger.info('Verifying go_router version from pubspec.yaml');
  if (dependencies?.containsKey('go_router') ?? false) {
    context.logger.info(
      'Found go_router version ${dependencies?['go_router']} in pubspec.yaml',
    );
    return;
  }
  context.logger.info('Could not find go_router version in pubspec.yaml');
  final progress = context.logger.progress('Installing go_router package');
  try {
    await _runProcess(context, 'flutter', [
      'pub',
      'add',
      'go_router',
    ]);
  } catch (e) {
    progress.fail('Could not install go_router package');
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

Future<void> _dartFormat(HookContext context) async {
  final progress = context.logger.progress('Formatting files');
  try {
    await _runProcess(context, 'dart', ['format', '.']);
  } catch (e) {
    progress.fail('Formatting files failed');
    rethrow;
  }

  progress.complete();
}

Future<void> _dartFix(HookContext context) async {
  final progress = context.logger.progress('Resolving linter issues');
  final appFilePath =
      '${Directory.current.path}/${context.vars['app_directory']}/app.dart';
  try {
    await _runProcess(context, 'dart', ['fix', '--apply', "${appFilePath}"]);
  } catch (e) {
    progress.fail('Resolving linter issues failed');
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
