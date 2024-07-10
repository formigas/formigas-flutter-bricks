import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:{{project_name.snakeCase()}}/{{{ homepage_path }}}{{homepage_name.snakeCase()}}.dart';

GoRouter appRouter = GoRouter(
  navigatorKey: GlobalKey(debugLabel: 'root'),
  initialLocation: '/{{homepage_name}}',
  routes: <GoRoute>[
    GoRoute(
      builder: (
        _,
        __,
      ) =>
          const {{homepage_name}}(),
      path: '/{{homepage_name}}',
    ),
  ],
);
