import 'package:flutter/material.dart';
import 'package:app_produtividade/widgets/Custom/CustomContainer.dart';
import 'package:app_produtividade/widgets/YoutubePlayer.dart';
import 'package:get/get.dart';

Map<String, Map<String, List<Tuple3<String, int, int>>>> exercicios = {
  'TREINO DE COSTAS': {
    'Exercicios': [
      Tuple3('Pull ups', 10, 1),
      Tuple3('Chin ups', 10, 1),
      // ... (Continue com os exercícios de costas aqui)
    ]
  },
  'TREINO DE PEITO': {
    'Exercicios': [
      Tuple3('Supino', 10, 3),
      Tuple3('Supino Inclinado', 10, 3),
      // ... (Continue com os exercícios de peito aqui)
    ]
  },
  // ... (Adicione outros grupos musculares aqui)
};

class TreinoController extends GetxController {
  var exerciciosConcluidos = <String, bool>{}.obs;

  void toggleExercicio(String nomeExercicio) {
    exerciciosConcluidos[nomeExercicio] =
        !(exerciciosConcluidos[nomeExercicio] ?? false);
  }

  bool isConcluido(String nomeExercicio) {
    return exerciciosConcluidos[nomeExercicio] ?? false;
  }
}

class TreinoHomePage extends StatelessWidget {
  final TreinoController treinoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercicios.length,
      itemBuilder: (context, index) {
        String dia = exercicios.keys.elementAt(index);
        return ExpansionTile(
          title: Text(dia),
          children: exercicios[dia]!.keys.map((grupoMuscular) {
            return ListTile(
              title: Text(grupoMuscular),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: exercicios[dia]![grupoMuscular]!.map((exercicio) {
                  return Row(
                    children: [
                      Checkbox(
                        value: treinoController.isConcluido(exercicio.item1),
                        onChanged: (value) {
                          treinoController.toggleExercicio(exercicio.item1);
                        },
                      ),
                      Expanded(
                          child: Text(
                              '${exercicio.item1} - ${exercicio.item2}x${exercicio.item3}')),
                    ],
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class Tuple3<T1, T2, T3> {
  final T1 item1;
  final T2 item2;
  final T3 item3;

  Tuple3(this.item1, this.item2, this.item3);
}

class Page1 extends StatelessWidget {
  Page1({super.key});

  final TreinoController treinoController = Get.put(TreinoController());

  // TODO -> 100 repetiçoes (normal) +

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calistenia APP'),
      ),
      body: ListView(
        children: const [
          Text('ola mundo'),
          Card(
            borderOnForeground: bool.hasEnvironment(AutofillHints.birthday),
            child: Column(
              children: [
                Text('TREINO DE COSTAS'),
                Text('- 10 Pull ups'),
                Text('- 10 Chin ups'),
                Text('- 10 Chin ups hold'),
                Text('- 10 Close Grip Pull ups'),
                Text('- 10 Close Grip Chin ups'),
                Text('- 10 Pull up Open and Close'),
                Text('- 10 Pull up Front Lever'),
                Text('- 10 Pull up Chin Up Slow'),
                Text('- 10 Pull ups Front'),
                Text('- 10 Pull ups back slow')
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text('TREINO DE PEITO'),
                Text('150 Repetições'),
                Text('3x10 {Supino}'),
                Text('3x10 {Supino Inclinado}'),
                Text('3x10 {Voador}'),
                YoutubeLink(
                    link: 'https://www.youtube.com/watch?v=ypxmdLxCK7k&t=441s'),
                YoutubeLink(
                    link: 'https://www.youtube.com/watch?v=1BpYbEi2QcI&t=703s')
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Text('TREINO DE PERNA'),
                YoutubeLink(link: 'https://www.youtube.com/watch?v=qLPrPVz4NzQ')
              ],
            ),
          ),
          Card(
              child: Column(
            children: [
              Text('Calistenics Moves Tutorial',
                  style: TextStyle(fontSize: 30, color: Colors.red)),
              YoutubeLink(link: 'https://www.youtube.com/watch?v=Jeew_oxr5ZA'),
            ],
          )),
          Card(
              child: Column(
            children: [
              Text('TREINO DE ABS',
                  style: TextStyle(fontSize: 30, color: Colors.red)),
              YoutubeLink(link: 'https://www.youtube.com/watch?v=fpK5VZCwJPY'),
            ],
          )),
          Card(
              child: Column(
            children: [
              Text('Treino Calistenia Moves!',
                  style: TextStyle(fontSize: 30, color: Colors.red)),
              YoutubeLink(link: 'https://www.youtube.com/watch?v=0cMXdZL9ESA'),
            ],
          )),
          CustomContainer(
            cor_container: Colors.yellow,
            conteudo: 'Ola mundo',
            cor_texto: Colors.white,
          ),
        ],
      ),
    );
  }
}
