import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_model.dart';

class {{feature_name.pascalCase()}}View extends StatelessWidget {
  const {{feature_name.pascalCase()}}View({
    required {{feature_name.pascalCase()}}Controller controller,
    required {{feature_name.pascalCase()}}Model model,
    super.key,
  })  : _controller = controller,
        _model = model;
  final {{feature_name.pascalCase()}}Controller _controller;
  final {{feature_name.pascalCase()}}Model _model;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${_model.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _controller.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
