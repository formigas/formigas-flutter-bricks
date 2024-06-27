import 'package:{{project_name.snakeCase()}}/common/custom_themes.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter_controller.dart';
import 'package:{{project_name.snakeCase()}}/features/counter/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter,
      title: '{{project_name.pascalCase()}} App',
      theme: CustomTheme().light,
      darkTheme: CustomTheme().dark,
    );
  }
}
