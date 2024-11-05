import 'package:app_produtividade/pages/Home%20Page/GohanTreinamentosPage.dart';
import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/KanbanPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_produtividade/pages/Lista%20de%20Filmes/Page8.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:app_produtividade/pages/Calistenia%20App/page1.dart';
import 'package:app_produtividade/pages/page2.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/5 Hobbies/BlogPage.dart';

List<String> titles = <String>['Cloud', 'Beach', 'Sunny', '(24)99319-9126 '];
ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
  background: Colors.grey.shade300,
  primary: Colors.grey.shade500,
  secondary: Colors.grey.shade100,
  tertiary: Colors.white,
  error: Colors.red,
  inversePrimary: Colors.grey.shade700,
));

void main() async {
  // iniciando
  GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  try {
    //flutter run –dart-define-from-files=.env

    //Gemini.init(apiKey: const String.fromEnvironment('chave_key'));
    Gemini.init(apiKey: "AIzaSyDVufkW23RIvdiTrUY3_ql67cnyVTMMIq8");
    print("C3po conectado!");

    final bot = Gemini.instance;
    bot.listModels();
  } on Exception catch (e) {
    print("Erro no c3po ao conectar com api ${e}");
  }

  // Rodando o App
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GOHAN TREINAMENTOS',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          scaffoldBackgroundColor: Colors.blueGrey,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        initialRoute: '/', // Rota inicial
        getPages: [
          GetPage(name: '/', page: () => GohanTreinamentosPage()),
          GetPage(name: '/blog', page: () => BlogPage2()),
          GetPage(name: '/calisteniaApp', page: () => Page1()),
          GetPage(name: '/page2', page: () => Page2()),
          GetPage(name: '/page8', page: () => ListaDeFilmesPage()),
          GetPage(name: '/KanbanBoard', page: () => KanbanPage()),

          //... (adicione todas as outras rotas aqui)
        ],
        home: const GohanTreinamentosPage());
  }
}

// Page Controller getx

//Page controller Provider
class PageController extends ChangeNotifier {
  int _page = 0;

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }
}
