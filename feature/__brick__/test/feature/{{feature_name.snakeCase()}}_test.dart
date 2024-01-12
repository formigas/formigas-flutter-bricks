import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_model.dart';
import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    const model = {{feature_name.pascalCase()}}Model(count: 2);
    final controller = {{feature_name.pascalCase()}}ControllerImplementation()..model = model;
    testWidgets('renders {{feature_name.pascalCase()}}', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: {{feature_name.pascalCase()}}View(controller: controller),
        ),
      );
      expect(
        find.byType({{feature_name.pascalCase()}}View),
        findsOneWidget,
      );
    });
  });
}
