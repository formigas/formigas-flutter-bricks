import 'package:mason/mason.dart';

enum Platform {
  android,
  ios,
}

void run(HookContext context) {
  _selectAppId(context);
  _selectStateManagementSolution(context);
}

void _selectAppId(HookContext context) {
  context.vars['application_id_android'] =
      _createAppId(context, platform: Platform.android);
  context.vars['application_id'] = _createAppId(context);
}

String _createAppId(HookContext context, {Platform? platform}) {
  final orgName = context.vars['org_name'] as String;
  final projectName = context.vars['project_name'] as String;

  var applicationId = context.vars['application_id'] as String?;
  applicationId = (applicationId?.isNotEmpty ?? false)
      ? applicationId
      : '''$orgName.${projectName.snakeCase}''';

  return applicationId!;
}

void _selectStateManagementSolution(HookContext context) {
  final stateManagementSolution =
      context.vars['state_management_solution'] as String?;
  switch (stateManagementSolution) {
    case 'Formigas MVC':
      context.vars = {...context.vars, 'formigas_mvc': true};
    case 'BLoC':
      context.vars = {...context.vars, 'bloc': true};
    default:
  }
}
