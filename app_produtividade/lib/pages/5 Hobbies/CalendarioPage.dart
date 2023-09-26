import 'package:app_produtividade/pages/5%20Hobbies/BlogPage.dart';
import 'package:app_produtividade/pages/TodoListPage.dart';
import 'package:app_produtividade/pages/TodoListViewPage.dart';
import 'package:app_produtividade/widgets/Calendario/Calendario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/Custom/CustomNavBar.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  final calendar_controller = Get.put(CalendarioController());
  TextEditingController eventoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  void _adicionarEvento() async {
    Future<DateTime?> dataSelecionada = _mostrarDatePicker();
    if (dataSelecionada != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Adicionar Evento"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Text(                    "Data selecionada: ${DateFormat('dd/MM/yyyy').format(dataSelecionada)}"),
                TextField(
                  controller: eventoController,
                  decoration:
                      const InputDecoration(labelText: "Nome do Evento"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  String titulo = eventoController.text;
                  if (titulo.isNotEmpty) {
                    calendar_controller.adicionarEvento(
                        dataSelecionada as DateTime, titulo);
                    eventoController.clear();
                  }
                  Navigator.of(context).pop();
                },
                child: const Text("Adicionar"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<DateTime?> _mostrarDatePicker() async {
    DateTime dataAtual = DateTime.now();
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: dataAtual,
      firstDate: dataAtual.subtract(const Duration(days: 365)),
      lastDate: dataAtual.add(const Duration(days: 365)),
    );
    return dataSelecionada;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
      ),
      body: Column(
        children: [
          const Text('Calendario'),
          CalendarioWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: calendar_controller
                  .getEventosDoDia(calendar_controller.diaSelecionado)
                  .length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(calendar_controller
                        .getEventosDoDia(
                            calendar_controller.diaSelecionado)[index]
                        .title),
                  ),
                );
              },
            ),
          ),
          if (calendar_controller
              .getEventosDoDia(calendar_controller.diaSelecionado)
              .isEmpty)
            const Text('Nenhum evento para o dia selecionado'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarEvento,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: '5 Hobbies',
              iconData: Icons.home,
              onPress: () {
                Get.to(BlogPage2());
              }),
          NavigationBarItem(
              label: 'Todo List',
              iconData: Icons.search,
              onPress: () {
                Get.to(TodoListPage());
              }),
          NavigationBarItem(
              label: 'Tab 3',
              iconData: Icons.person,
              onPress: () {
                Get.to(TodoListViewPage());
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    eventoController.dispose();
    super.dispose();
  }
}
