import 'package:fluent_ui/fluent_ui.dart';

import 'package:gym_app_project/routes/routes.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initWindowManager();

  runApp(const MyApp());
}

Future<void> initWindowManager() async {
  await WindowManager.instance.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setPreventClose(true);
    await windowManager.setMinimumSize(const Size(600, 720));
    await windowManager.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
      title: 'Gym App',
      themeMode: ThemeMode.dark,
      theme: FluentThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
      ),
      // home: const MyHomePage(),
    );
  }
}
