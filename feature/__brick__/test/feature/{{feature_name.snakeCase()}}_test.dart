import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller_implementation.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_model.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_view.dart';

void main() {
  group('App', () {
    final controller = {{feature_name.pascalCase()}}ControllerImplementation();
    const model = {{feature_name.pascalCase()}}Model(count: 2);
    testWidgets('renders {{feature_name.pascalCase()}}', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: {{feature_name.pascalCase()}}View(
            controller: controller,
            model: model,
          ),
        ),
      );
      expect(
        find.byType({{feature_name.pascalCase()}}View),
        findsOneWidget,
      );
    });
  });
}
