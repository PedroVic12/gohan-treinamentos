import 'package:app_produtividade/pages/5%20Hobbies/BlogPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/CalendarioController.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/Eventos.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoListPage.dart';
import 'package:app_produtividade/pages/Todo%20List/TodoListViewPage.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/Calendario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../../api/Gohan_api.dart';
import '../../../widgets/Custom/CustomNavBar.dart';
import '../../../widgets/Custom/CustomText.dart';
import 'widgets/BotaoCaixaDialogo.dart';
import 'widgets/TaskList.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  final calendar_controller = Get.put(CalendarioController());
  TextEditingController eventoController = TextEditingController();
  TextEditingController dataController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Calendario'),
            CalendarioWidget(),
            BotaoCaixaDialogo(),
            ListaEventosCalendario(),

            //TaskLists(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            calendar_controller.createOrUpdateTask(context);
          }),
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

class ListaEventosCalendario extends StatelessWidget {
  const ListaEventosCalendario({super.key});

  @override
  Widget build(BuildContext context) {
    final calendar_controller = Get.put(CalendarioController());

    return Obx(() {
      final eventosDoDia = calendar_controller
          .getEventosDoDia(calendar_controller.diaSelecionado);

      if (eventosDoDia.isEmpty) {
        return Center(child: Text("Nenhum evento para este dia."));
      }

      return Container(
        height: 300,
        child: ListView.builder(
          itemCount: eventosDoDia.length,
          itemBuilder: (context, index) {
            Event evento = eventosDoDia[index];

            return CustomListTile(
              evento: evento,
              onDeleted: () {
                calendar_controller.eventos[calendar_controller.diaSelecionado]!
                    .removeAt(index);
                calendar_controller.update();
                // Aqui, você também pode adicionar código para atualizar o arquivo JSON
              },
            );
          },
        ),
      );
    });
  }
}

class CustomListTile extends StatelessWidget {
  final Event evento;
  final Function onDeleted;

  CustomListTile({required this.evento, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: CupertinoColors.systemBlue)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CupertinoListTile(
                  title: CustomText(
                    text: evento.title,
                    size: 20,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Tipo: ${evento.prioridade}', size: 14),
                      CustomText(
                        text: 'Categoria: ${evento.categoria}',
                        size: 14,
                      )
                    ],
                  ),
                  leading: CircleAvatar(child: Icon(Icons.abc)),
                  trailing: Text('Hora: ${evento.hora.format(context)}'),
                ),
              )),
            ),
            CupertinoSwitch(
              value: true,
              onChanged: (bool value) {
                if (value) {
                  //onDeleted();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class EventCardList extends StatefulWidget {
  @override
  _EventCardListState createState() => _EventCardListState();
}

class _EventCardListState extends State<EventCardList> {
  final GohanFastApi api = GohanFastApi();
  late Future<List<Map<String, dynamic>>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = api.getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Erro ao buscar os dados: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text("Nenhum evento encontrado.");
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return EventCard(event: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event["nomeDoEvento"],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Prioridade: ${event["prioridade"]}"),
            Text("Data: ${event["data"]}"),
            Text("Hora: ${event["hora"]}"),
            Text("Categoria: ${event["categoria"]}"),
          ],
        ),
      ),
    );
  }
}
