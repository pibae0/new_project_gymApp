import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_app_project/modules/clients/pages/clients_home.dart';
import 'package:gym_app_project/modules/clients/pages/clients_register_page.dart';
import 'package:gym_app_project/utils/const_colors.dart';
import 'package:window_manager/window_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  int paneIndex = 0;

  @override
  void onWindowClose() {
    // TODO: Incrementar pergunta se ele quer realmente fechar o aplicativo
    super.onWindowClose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        // backgroundColor: backgroundColors,
        height: 36,
        title: DragToMoveArea(
          child: SizedBox(
            height: 36,
            child: Row(
              children: [
                //TODO: MELHORAR QUALIDADE DA IMAGEM
                SizedBox(
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    'lib/assets/image/logoex.png',
                    // color: Colors.white,
                  ),
                ),
                const SizedBox(width: 18),
                const Text(
                  'GYM_APP_TEST',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: const ButtonsWindow(),
      ),
      pane: NavigationPane(
          displayMode: PaneDisplayMode.compact,
          size: const NavigationPaneSize(compactWidth: 52),
          selected: paneIndex,
          onItemPressed: (value) {
            setState(() {
              paneIndex = value;
            });
          },
          items: [
            //home
            PaneItem(
              icon: const Icon(
                FluentIcons.people,
                size: 18.7,
              ),
              title: const Text('Alunos'),
              body: const ClientsHomePage(),
            ),

            //Treino
            PaneItem(
              icon: SizedBox(
                height: 19,
                width: 19,
                child: Image.asset(
                  'lib/assets/image/dumbellnew.png',
                  color: Colors.white,
                ),
              ),
              title: const Text('Treinos'),
              body: const Text('TREINO'),
            ),
            //Nutrição
            PaneItem(
              icon: SizedBox(
                height: 19,
                width: 19,
                child: Image.asset(
                  'lib/assets/image/apple.png',
                  color: Colors.white,
                ),
              ),
              title: const Text('Nutrição'),
              body: const Text('Nutrição'),
            ),

            //
          ],
          footerItems: [
            //cadastro
            PaneItem(
              icon: const Icon(
                FluentIcons.edit,
                color: AppTheme.accent,
              ),
              title: const Text('Cadastro'),
              body: const ClientsRegisterPage(),
            ),
            //Opcoes
            PaneItem(
              icon: const Icon(
                FluentIcons.settings,
              ),
              title: const Text('Opções'),
              body: const Text('OPÇOES'),
            ),
          ]),
    );
  }
}

class ButtonsWindow extends StatelessWidget {
  const ButtonsWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);
    return SizedBox(
      width: 138,
      height: 36,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
