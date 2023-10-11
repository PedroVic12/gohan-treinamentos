import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:camorim/widgets/boardview.dart';
import 'package:flutter/material.dart';
import 'package:boardview/boardview.dart';

class WidgetQuadroVisualizacao extends StatelessWidget {
  WidgetQuadroVisualizacao({Key? chave}) : super(key: chave);

  final List<BoardListWidget> dadosLista = [
    BoardListWidget(items: [], title: 'BACKLOG'),
    BoardListWidget(items: [
      BoardItemWidget(titulo: 'Chatbot Groundon', from: 'coding'),
      BoardItemWidget(titulo: 'Projetos Camorim', from: 'eng')
    ], title: 'A FAZER'),
    BoardListWidget(items: [], title: 'FAZENDO'),
    BoardListWidget(items: [], title: 'CONCLUÍDO')
  ];

  final BoardViewController controladorQuadroVisualizacao =
      BoardViewController();

  @override
  Widget build(BuildContext context) {
    List<BoardList> _listas = [];

    for (int i = 0; i < dadosLista.length; i++) {
      _listas.add(criarListaQuadro(dadosLista[i]));
    }

    return Container(
      child: BoardView(
        lists: _listas,
        boardViewController: controladorQuadroVisualizacao,
      ),
    );
  }

  BoardList criarListaQuadro(BoardListWidget lista) {
    List<BoardItem> itens = [];

    for (int i = 0; i < lista.items.length; i++) {
      itens.add(criarItemQuadro(lista.items[i]));
    }

    return BoardList(
      onStartDragList: (indiceLista) {
        print("Iniciou arrastar lista: $indiceLista");
      },
      onTapList: (indiceLista) {
        print("Tocou na lista: $indiceLista");
      },
      onDropList: (indiceLista, indiceListaAntigo) {
        var lista = dadosLista[indiceListaAntigo!];
        dadosLista.removeAt(indiceListaAntigo);
        dadosLista.insert(indiceLista!, lista);
        print("Lista movida para a posição: $indiceLista");
      },
      headerBackgroundColor: Colors.transparent,
      backgroundColor: Colors.blue,
      header: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Text(lista.title),
        ))
      ],
      items: itens,
    );
  }

  BoardItem criarItemQuadro(BoardItemWidget itemObjetos) {
    return BoardItem(
      onStartDragItem: (indiceLista, indiceItem, estado) {
        print("Iniciou arrastar item: $indiceItem da lista: $indiceLista");
      },
      onDropItem: (indiceLista, indiceItem, indiceListaAntigo, indiceItemAntigo,
          estado) {
        var item = dadosLista[indiceListaAntigo!].items[indiceItemAntigo!];

        dadosLista[indiceListaAntigo].items.remove(indiceItemAntigo);
        dadosLista[indiceLista!].items.insert(indiceItem!, item);
        print("Item movido para a posição: $indiceItem na lista: $indiceLista");
      },
      onTapItem: (indiceLista, indiceItem, estado) {
        print("Tocou no item: $indiceItem da lista: $indiceLista");
      },
      item: Container(
        margin: EdgeInsets.all(8),
        child: Card(
          elevation: 7,
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(itemObjetos.titulo),
                  SizedBox(
                    height: 10,
                  )
                ],
              )),
        ),
      ),
    );
  }
}


class BoardItemWidget {
  String titulo;
  String from;

  BoardItemWidget({required this.titulo, required this.from});
}

class BoardListWidget {
  String title;
  List<BoardItemWidget> items;

  BoardListWidget({required this.items, required this.title});
}
