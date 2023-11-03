import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  log('Start init of App');

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
    <Future<void>>[
      // EasyLocalization.ensureInitialized(),
    ],
  ).onError(
    (Object? error, StackTrace stackTrace) => <void>[
      log(error.toString(), stackTrace: stackTrace),
    ],
  );

  runApp(await builder());
  log('End init of App');
}
