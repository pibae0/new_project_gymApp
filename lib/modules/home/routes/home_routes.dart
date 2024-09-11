import 'package:go_router/go_router.dart';
import 'package:gym_app_project/modules/home/pages/homenew_page.dart';

final GoRoute homeRoutes = GoRoute(
    path: '/',
    name: 'home',
    builder: (
      context,
      state,
    ) =>
        const MyHomePage());
