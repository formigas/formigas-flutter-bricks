import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_model.dart';
import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';

class {{feature_name.pascalCase()}}View extends MViewC<{{feature_name.pascalCase()}}Controller, {{feature_name.pascalCase()}}Model> {
  const {{feature_name.pascalCase()}}View({
    required super.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context, {{feature_name.pascalCase()}}Model model) => Scaffold(
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
                '${model.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
