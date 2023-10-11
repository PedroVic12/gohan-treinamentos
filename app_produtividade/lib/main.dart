import 'package:app_produtividade/pages/Home%20Page/GohanTreinamentosPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_produtividade/pages/Lista%20de%20Filmes/Page8.dart';
import 'package:get/get.dart';
import 'package:app_produtividade/pages/Calistenia%20App/page1.dart';
import 'package:app_produtividade/pages/page2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/5 Hobbies/BlogPage.dart';
import 'pages/5 Hobbies/CRUD HIVE/models/task.dart';

List<String> titles = <String>['Cloud', 'Beach', 'Sunny', '(24)99319-9126 '];

void main() async {
  // iniciando
  GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();

  //Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');

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
        title: 'Titulo',
        theme: ThemeData(
          primaryColor: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.deepOrangeAccent),
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
