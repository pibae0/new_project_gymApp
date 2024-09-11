import 'package:go_router/go_router.dart';
import 'package:gym_app_project/modules/clients/routes/clients_routes.dart';
import 'package:gym_app_project/modules/home/routes/home_routes.dart';

final GoRouter routes = GoRouter(routes: [
  homeRoutes,
  clientRoute,
]);
