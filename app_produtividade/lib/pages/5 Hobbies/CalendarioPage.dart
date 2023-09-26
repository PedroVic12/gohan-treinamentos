import 'package:app_produtividade/widgets/Calendario/Calendario.dart';
import 'package:flutter/material.dart';

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
      ),
      body: Column(
        children: [const Text('Calendario'), CalendarioWidget()],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {});
            print('Tarefa adicionada!');
          },
          child: Text('add')),
    );
  }
}
