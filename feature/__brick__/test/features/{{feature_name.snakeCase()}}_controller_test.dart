import 'package:{{project_name.snakeCase()}}/features/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_controller.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('The {{feature_name.pascalCase()}} controller', () {
    {{feature_name.pascalCase()}}Controller createTestController() =>
      {{feature_name.pascalCase()}}ControllerImplementation();
    
    test('should increment the count', () {
      final controller = createTestController()
      ..increment();
      expect(controller.model.count, 1);
    });

    test('should decrement the count', () {
      final controller = createTestController()
      ..decrement();
      expect(controller.model.count, 0);
    });
  });
}
