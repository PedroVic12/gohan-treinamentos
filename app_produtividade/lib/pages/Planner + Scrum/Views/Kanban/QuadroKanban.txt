import 'package:flutter/material.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:get/get.dart';

class QuadroKanban extends StatefulWidget {
  const QuadroKanban({Key? chave}) : super(key: chave);

  @override
  State<QuadroKanban> createState() => _QuadroKanbanState();
}

class _QuadroKanbanState extends State<QuadroKanban> {
  final colunasNomes = ['BACKLOG', 'TODO', 'DOING', 'DONE'];
  final coresColunas = [Colors.red, Colors.blue, Colors.green, Colors.purple];

  final KanbanController _kanbanController = Get.put(KanbanController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Obx(
        () => KanbanBoard(
          List.generate(
            colunasNomes.length,
            (index) => BoardListsData(
              title: colunasNomes[index],
              items: _kanbanController.colunas[index]
                  .map((titulo) => _criarItemQuadro(titulo.toString(), index))
                  .toList(),
              header: Text(colunasNomes[index]),
              backgroundColor: coresColunas[index],
            ),
          ),
          onItemReorder:
              (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {
            _kanbanController.moverItem(
                oldListIndex!, oldCardIndex!, newListIndex!, newCardIndex!);
          },
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _criarItemQuadro(String titulo, int indiceColuna) {
    return InkWell(
      onTap: () => _onItemTap(titulo, indiceColuna),
      onLongPress: () {
        print('card pressionado...');
      },
      child: Card(
        color: Colors.grey.shade400,
        child: ListTile(
          title: Text(
            titulo,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableFeedback(String titulo) {
    return Material(
      type: MaterialType.transparency,
      child: Card(
        child: ListTile(
          title: Text(
            titulo,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTap(String titulo, int indiceColuna) {
    print('Item $titulo na coluna $indiceColuna foi tocado.');
  }
}

class KanbanController extends GetxController {
  // Observe as listas de itens em cada coluna
  var colunas = [
    ['Item de Exemplo'].obs, // BACKLOG
    [].obs, // TODO
    [].obs, // DOING
    [].obs // DONE
  ].obs;

  @override
  void onInit() {
    super.onInit();
    adicionarItemQuadro('Camorim Projects');
  }

  void moverItem(
      int oldListIndex, int oldItemIndex, int newListIndex, int newItemIndex) {
    var item = colunas[oldListIndex][oldItemIndex];
    colunas[oldListIndex].removeAt(oldItemIndex);
    colunas[newListIndex].insert(newItemIndex, item);
  }

  // Adiciona um novo item à primeira coluna
  void adicionarItemQuadro(String itemTitulo) {
    colunas[0].add(itemTitulo);
  }
}
