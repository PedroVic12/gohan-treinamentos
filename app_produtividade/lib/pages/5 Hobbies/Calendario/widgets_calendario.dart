import 'package:app_produtividade/api/Gohan_api.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/Eventos.dart';
import 'package:app_produtividade/pages/5%20Hobbies/Calendario/controller/ControleCalendario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/Custom/CustomText.dart';


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
