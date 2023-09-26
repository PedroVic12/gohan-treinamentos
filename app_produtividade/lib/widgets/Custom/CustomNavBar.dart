import 'package:app_produtividade/pages/TodoListPage.dart';
import 'package:app_produtividade/pages/TodoListViewPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/5 Hobbies/BlogPage.dart';

class CustomNavBar extends StatelessWidget {
  final List<NavigationBarItem> navBarItems;

  CustomNavBar({required this.navBarItems});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: navBarItems
          .map((item) => BottomNavigationBarItem(
                label: item.label,
                icon: Icon(item.iconData),
              ))
          .toList(),
      onTap: (index) {
        // Chame a função onPress do item selecionado
        navBarItems[index].onPress();
      },
    );
  }
}

class NavigationBarItem {
  final String label;
  final IconData iconData;
  final Function onPress;

  NavigationBarItem({
    required this.label,
    required this.iconData,
    required this.onPress,
  });
}
