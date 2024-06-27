import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:{{project_name.snakeCase()}}/environment.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required Environment environment,
}) async {
  log('Start init of App - $environment');

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  runApp(await builder());
  log('End init of App');
}
