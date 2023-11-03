import 'package:freezed_annotation/freezed_annotation.dart';

part '{{mvc_name.snakeCase()}}_model.freezed.dart';

@freezed
class {{mvc_name.pascalCase()}}Model with _${{mvc_name.pascalCase()}}Model {
  const factory {{mvc_name.pascalCase()}}Model({
    required int count,
  }) = _{{mvc_name.pascalCase()}}Model;
}
