import 'package:{{project_name.snakeCase()}}/common/custom_themes.dart';
import 'package:{{project_name.snakeCase()}}/feature/counter/counter_controller.dart';
import 'package:{{project_name.snakeCase()}}/feature/counter/counter_view.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '{{project_name.pascalCase()}} App',
      theme: CustomTheme().light,
      darkTheme: CustomTheme().dark,
      home: CounterView(controller: CounterControllerImplementation()),
    );
  }
}
