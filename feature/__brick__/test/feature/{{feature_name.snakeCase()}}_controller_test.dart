import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('The {{feature_name.pascalCase()}} controller', () {
    final controller = {{feature_name.pascalCase()}}ControllerImplementation();
    test('should increment the count', () {
      controller.increment();
      expect(controller.model.count, 1);
    });

    test('should decrement the count', () {
      controller.decrement();
      expect(controller.model.count, 0);
    });
  });
}