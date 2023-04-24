import 'package:flutter/foundation.dart';

class Item {
  final String descricao;
  bool concluido;

  Item({required this.descricao, this.concluido = false});
}

class Menu with ChangeNotifier {
  final List<Item> _itens = [];

  void adicionarItem(String descricao) {
    _itens.add(Item(descricao: descricao));
    notifyListeners();
  }

  Item getItem(int indice) {
    return _itens[indice];
  }

  int get quantidadeDeItens {
    return _itens.length;
  }

  void alternarItem(int indice) {
    _itens[indice].concluido = !_itens[indice].concluido;
    notifyListeners();
  }
}
