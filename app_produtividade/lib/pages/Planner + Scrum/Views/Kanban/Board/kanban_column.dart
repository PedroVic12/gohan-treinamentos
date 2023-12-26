import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/Board/kanban_controller.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//! Coluna
class KanbanColumn extends StatefulWidget {
  final String title;
  final List<ItemTrabalho> tasks;
  final Color color;
  final int index;

  KanbanColumn({
    required this.title,
    required this.tasks,
    required this.color,
    required this.index,
  });

  @override
  State<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends State<KanbanColumn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KanbanController>(); // Obtenha o controlador
    return Expanded(
      child: Container(
        color: widget.color,
        child: DragTarget(
          builder: (context, candidateData, rejectedData) {
            return Column(
              children: [
                Text(widget.title,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(),
                Text('COLUNA: ${widget.index}'),

// Lista de itens de trabalho
                const Divider(),
                Obx(() => Column(
                      children: controller
                          .columns[controller.columnKeys[widget.index]]!
                          .map((item) => CardItemDeTrabalho(
                                titulo: item.title,
                                coluna: widget.index,
                              ))
                          .toList(),
                    )),
              ],
            );
          },
          onAccept: (Map data) {
            final colunaOrigem = controller.columnKeys[data['column']];
            final itemTitulo = data['title'];

            print('\nColuna: $colunaOrigem');
            print('Item: $itemTitulo');

            final itemIndex = controller.columns[colunaOrigem]!
                .indexWhere((item) => item.title == itemTitulo);

            if (itemIndex != -1) {
              final item =
                  controller.columns[colunaOrigem]!.removeAt(itemIndex);
              controller.columns[controller.columnKeys[widget.index]]!
                  .add(item);
            }

            print('Coluna Destino: ${controller.columnKeys[widget.index]}');
          },
        ),
      ),
    );
  }
}

//!Controller
class KanbanController extends GetxController {
  Map<String, RxList<ItemTrabalho>> columns = {};

  List<String> columnKeys =
      []; // Mantenha as chaves das colunas para referência

  @override
  void onInit() {
    super.onInit();

    //Arrays de trabalho
    columns['backlog'] = <ItemTrabalho>[].obs;
    columns['todo'] = <ItemTrabalho>[].obs;
    columns['inProgress'] = <ItemTrabalho>[].obs;
    columns['done'] = <ItemTrabalho>[].obs;

    // Adicionar as chaves das colunas
    columnKeys.addAll(columns.keys);

    // Adicionar itens às colunas
    columns['todo']!.add(ItemTrabalho(title: 'APP KYOGRE UI'));
    columns['todo']!.add(ItemTrabalho(title: 'CAMORIM PROJECTS'));
    columns['todo']!.add(ItemTrabalho(title: 'Machine Learning Python'));
  }

  void adicionarTarefa(int coluna, ItemTrabalho item) {
    final columnKey = columnKeys[coluna];
    columns[columnKey]!.add(item);
  }

  void removerItem(int coluna, String titulo) {
    final columnKey = columnKeys[coluna];
    final itemIndex =
        columns[columnKey]!.indexWhere((item) => item.title == titulo);
    if (itemIndex != -1) {
      columns[columnKey]!.removeAt(itemIndex);
    }
  }

  void trocarItem(String origem, String destino, String itemTitle) {
    final origemColuna = columns[origem];
    final destinoColuna = columns[destino];

    final itemIndex =
        origemColuna?.indexWhere((item) => item.title == itemTitle);

    if (itemIndex != -1) {
      final item = origemColuna?.removeAt(itemIndex!);
      destinoColuna!.add(item!);
    }
  }
}

//!Models
class CardItemDeTrabalho extends StatelessWidget {
  final controller = Get.find<KanbanController>(); // Obtenha o controlador

  final String titulo;
  final int coluna;
  CardItemDeTrabalho({
    super.key,
    required this.titulo,
    required this.coluna,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Map>(
      // Os dados são o valor que este Draggable armazena.
      data: {
        'column': coluna,
        'title': titulo
      }, // Identificação do item sendo arrastado
      feedback: const Card(
          color: Colors.greenAccent,
          child: Padding(
            padding: EdgeInsets.all(48.0),
            child: Column(
              children: [
                Text('movendo...'),
                Icon(
                  Icons.directions_run,
                  size: 32,
                ),
              ],
            ),
          )),
      childWhenDragging: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
        child: const Center(),
      ),

      child: Container(
        child: Card(
            color: Colors.lightGreenAccent,
            child: CupertinoListTile(
                leading: CircleAvatar(
                  child: CustomText(
                    text: coluna.toString(),
                    color: Colors.white,
                  ),
                ),
                subtitle: Text('desk'),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                  ),
                  onPressed: () {
                    controller.removerItem(coluna, titulo);
                  },
                ),
                title: CustomText(
                  text: titulo,
                  size: 12,
                  weight: FontWeight.bold,
                ))),
      ),
    );
  }
}
