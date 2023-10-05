import 'package:app_produtividade/pages/5%20Hobbies/Calendario/widgets/ModalCreateTask.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BotaoCaixaDialogo extends StatelessWidget {
  const BotaoCaixaDialogo({super.key});

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height * 0.7;
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Event Name'),
                  content: Padding(
                      padding: EdgeInsets.all(8),
                      child: ModalPegarEventosCalendario(
                        altura: altura,
                      )),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar')),
                    ElevatedButton(
                        onPressed: () {
                          print('teste');

                          Navigator.of(context).pop();
                        },
                        child: Text('Adicionar')),
                  ],
                );
              }));
        },
        child: Text('Adicionar Evento'));
  }
}
