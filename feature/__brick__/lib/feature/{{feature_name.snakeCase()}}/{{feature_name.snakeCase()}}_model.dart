import 'package:freezed_annotation/freezed_annotation.dart';

part '{{feature_name.snakeCase()}}_model.freezed.dart';

@freezed
class {{feature_name.pascalCase()}}Model with _${{feature_name.pascalCase()}}Model {
  const factory {{feature_name.pascalCase()}}Model({
    required int count,
  }) = _{{feature_name.pascalCase()}}Model;
}
