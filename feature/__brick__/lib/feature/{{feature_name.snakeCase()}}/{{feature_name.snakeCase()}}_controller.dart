import 'package:{{project_name.snakeCase()}}/feature/{{feature_name.snakeCase()}}/{{feature_name.snakeCase()}}_model.dart';
import 'package:formigas_mvc/formigas_mvc.dart';

abstract class {{feature_name.pascalCase()}}Controller extends MVController<{{feature_name.pascalCase()}}Model> {
  {{feature_name.pascalCase()}}Controller(super.initialModel);

  void increment();

  void decrement();
}

class {{feature_name.pascalCase()}}ControllerImplementation extends {{feature_name.pascalCase()}}Controller {
  {{feature_name.pascalCase()}}ControllerImplementation() : super(const {{feature_name.pascalCase()}}Model(count: 0));

  @override
  void increment() => model = model.copyWith(count: model.count + 1);

  @override
  void decrement() => model = model.copyWith(count: model.count - 1);
}
