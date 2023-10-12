import 'package:flutter/material.dart';

class DragBox extends StatefulWidget {
  const DragBox({Key? key});

  @override
  State<DragBox> createState() => _ArrastarESoltarExemploState();
}

class _ArrastarESoltarExemploState extends State<DragBox> {
  int dadosAceitos = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Draggable<int>(
          // Os dados são o valor que este Draggable armazena.
          data: 120,
          feedback: const Card(
              color: Colors.greenAccent,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('movendo...'),
                    Icon(Icons.directions_run),
                  ],
                ),
              )),
          childWhenDragging: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.red,
            child: const Center(),
          ),

          child: Column(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                color: Colors.lightGreenAccent,
                child: const Center(
                  child: Text('CLIQUE AQUI'),
                ),
              ),
            ],
          ),
        ),
        DragTarget<int>(
          builder: (
            BuildContext context,
            List dadosAceitos,
            List<dynamic> dadosRejeitados,
          ) {
            return Column(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightBlueAccent,
                  child: const Center(
                    child: Text('Coluna'),
                  ),
                ),
                Text(
                    'Dados aceitos: ${dadosAceitos.where((item) => item != null).join(', ')}'),
              ],
            );
          },
          onAccept: (int? dados) {
            setState(() {
              //dadosAceitos.add(dados);
            });
          },
        ),
      ],
    );
  }
}
