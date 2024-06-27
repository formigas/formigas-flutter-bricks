part of 'app.dart';

/// The router configuration.
final GoRouter _appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        final controller = CounterControllerImplementation();
        return CounterView(controller: controller);
      },
    ),
  ],
);

extension RouterExt on BuildContext {
  void showCounterView([Object? extra]) => go('/', extra: extra);
}
