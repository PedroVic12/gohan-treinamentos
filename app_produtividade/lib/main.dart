import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:app_produtividade/models/TodoList.dart';
import 'package:app_produtividade/pages/GetXHomePage.dart';
import 'package:app_produtividade/pages/home_page.dart';
import 'package:app_produtividade/pages/page1.dart';
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
            bodyText2: TextStyle(
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
      body: MyHomePage(), //GetxHomePage(), tambem tem!
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

//! WIDGETs

//! 1)
// class NightWolfAppBar extends StatelessWidget {
//   final String commentButtonTitle;
//   final String settingsButtonTitle;
//   final String menuButtonTitle;

//   const NightWolfAppBar({
//     required Key key,
//     this.commentButtonTitle = Comment,
//     this.settingsButtonTitle = Settings,
//     this.menuButtonTitle = Menu,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text('🐺 -> NIGHT WOLF 1 - TodoList🐺'),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.comment),
//           tooltip: commentButtonTitle,
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.settings),
//           tooltip: settingsButtonTitle,
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.menu),
//           tooltip: menuButtonTitle,
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }

//! 2)
class CloneAppBar extends StatelessWidget {
  const CloneAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    const int tabsCount = 3;

    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Night Wolf 2 - CloneAppBar'),
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: const Icon(Icons.cloud_outlined),
                text: titles[0],
              ),
              Tab(
                icon: const Icon(Icons.beach_access_sharp),
                text: titles[1],
              ),
              Tab(
                icon: const Icon(Icons.brightness_5_sharp),
                text: titles[2],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: const Text(' '),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: const Text(' '),
                );
              },
            ),
            ListView.builder(
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: index.isOdd ? oddItemColor : evenItemColor,
                  title: const Text(' '),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
