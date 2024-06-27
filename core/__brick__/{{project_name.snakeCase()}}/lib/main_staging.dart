import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';
import 'package:{{project_name.snakeCase()}}/environment.dart';

void main() {
  bootstrap(
    () => const App(),
    environment: Environment.staging,
  );
}
