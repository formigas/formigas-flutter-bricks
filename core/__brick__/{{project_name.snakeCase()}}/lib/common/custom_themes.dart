import 'package:{{project_name.snakeCase()}}/common/color_scheme.dart';
import 'package:{{project_name.snakeCase()}}/common/text_style.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData get dark => ThemeData(
        useMaterial3: {{#use_material_3}}true{{/use_material_3}}{{^use_material_3}}false{{/use_material_3}},
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        textTheme: textTheme(darkColorScheme),
      );

  ThemeData get light => ThemeData(
        useMaterial3: {{#use_material_3}}true{{/use_material_3}}{{^use_material_3}}false{{/use_material_3}},
        brightness: Brightness.light,
        colorScheme: lightColorScheme,
        textTheme: textTheme(lightColorScheme),
      );
}
