import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:app_produtividade/models/TodoList.dart';
import 'package:app_produtividade/pages/GetXHomePage.dart';
import 'package:app_produtividade/pages/home_page.dart';
import 'package:app_produtividade/pages/Calistenia%20App/page1.dart';
import 'package:app_produtividade/pages/page2.dart';
import 'package:app_produtividade/pages/page3.dart';
import 'package:app_produtividade/provider/menu_provider.dart';
import 'package:provider/provider.dart';

List<String> titles = <String>['Cloud', 'Beach', 'Sunny', '(24)99319-9126 '];

void main() {
  // iniciando
  GetStorage.init();

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
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
          scaffoldBackgroundColor: Colors.blueGrey,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        home: const GohanTreinamentos());
  }
}

// Page Controller getx
class GohanTreinamentos extends StatelessWidget {
  const GohanTreinamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyHomePage(), //GetxHomePage(),  tem!
    );
  }
}

//Page controller Provider
class PageController extends ChangeNotifier {
  int _page = 0;

  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }
}
