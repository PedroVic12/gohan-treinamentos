import 'package:flutter/material.dart';
import 'package:app_produtividade/widgets/CustomContainer.dart';
import 'package:app_produtividade/widgets/ScrollTela.dart';
import 'package:app_produtividade/widgets/YoutubePlayer.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calistenia APP'),
      ),
      body: MyGestureDetector(
        child: Center(
          child: Column(
            children: [
              Card(
                borderOnForeground: bool.hasEnvironment(AutofillHints.birthday),
                child: Column(
                  children: const [
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
                  children: const [
                    Text('TREINO DE PEITO'),
                    YoutubeLink(
                        link:
                            'https://www.youtube.com/watch?v=ypxmdLxCK7k&t=441s'),
                    YoutubeLink(
                        link:
                            'https://www.youtube.com/watch?v=1BpYbEi2QcI&t=703s')
                  ],
                ),
              ),
              Text('TREINO DE COSTAS'),
              Card(
                child: Column(
                  children: const [
                    Text('TREINO DE PERNA'),
                    YoutubeLink(
                        link: 'https://www.youtube.com/watch?v=qLPrPVz4NzQ')
                  ],
                ),
              ),
              Card(
                  child: Column(
                children: const [
                  Text('Calistenics Moves Tutorial',
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=Jeew_oxr5ZA'),
                ],
              )),
              Card(
                  child: Column(
                children: const [
                  Text('TREINO DE ABS',
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=fpK5VZCwJPY'),
                ],
              )),
              Card(
                  child: Column(
                children: const [
                  Text('Treino Calistenia Moves!',
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=0cMXdZL9ESA'),
                ],
              )),
              CustomContainer(
                cor_container: Colors.yellow,
                conteudo: 'Ola mundo',
                cor_texto: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
