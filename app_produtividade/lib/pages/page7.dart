import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_produtividade/controllers/TodoController.dart';
import 'package:app_produtividade/pages/TodoScreen.dart';
import 'package:app_produtividade/widgets/CustomContainer.dart';
import 'package:app_produtividade/widgets/ScrollTela.dart';
import 'package:app_produtividade/pages/TodoListPage.dart';
import 'package:app_produtividade/widgets/YoutubePlayer.dart';
import 'package:http/http.dart';

//! Refatorar esse codigo para ficar funcional e arrumar que eu usei a todo List aqui

class Page7 extends StatelessWidget {
  const Page7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Instanciando o controller usando Getx
    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 199, 199),
      appBar: AppBar(
        title: const Text('Page 7 - Repository'),
      ),

      //! Botão para ir para tela de adicionar Tarefas
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_box_rounded),
          onPressed: () {
            Get.to(TodoScreen());
          }),
      body: MyGestureDetector(
        child: Column(
          //TODO POMODORO TIMER

          // TODO CLASS TODO LIST WITH CRUD

          children: [
            //! Tela mostrando os meus Todo List
            // TodoListWidget(),

            const Text(
              'REPOSITÓRIO DE VIDEOS IMPORTANTES!',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            //!Cards dos videos do youtube
            Card(
              child: Column(
                children: const [
                  Text(
                    'Flutter',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                  YoutubeLink(
                      link:
                          'https://www.youtube.com/watch?v=ewFH0l2CLFo&t=74s'),
                  YoutubeLink(
                      link:
                          'https://www.youtube.com/watch?v=TbVSO0RIQsg&t=449s'),
                  YoutubeLink(
                      link:
                          'https://www.youtube.com/watch?v=odr59ZAx-IU&list=PLnFA4SZ9y0T5FA2dFdNh6NLD6Rm6GB6x7&index=1&t=231s'),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=YMx8Bbev6T4'),
                  YoutubeLink(
                      link:
                          'https://www.youtube.com/watch?v=LwOACmXcNQ8&list=PLRpTFz5_57cvCYRhHUui2Bis-5Ybh78TS&index=1&t=442s'),
                  YoutubeLink(
                      link:
                          'https://www.youtube.com/watch?v=fgloD9-8GNE&list=PL5EmR7zuTn_Yu_YV2pT0h0843vRGiTMtx')
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: const [
                    Text(
                      'C++ and IoT',
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                    YoutubeLink(
                        link: 'https://www.youtube.com/watch?v=1GcMAiIMQYU'),
                    YoutubeLink(
                        link:
                            'https://www.youtube.com/watch?v=6ApIdQKU5uo&t=711s')
                  ],
                ),
              ),
            ),

            Card(
              child: Column(
                children: const [
                  Text(
                    'LOFI',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=HwbaNH3LKCg'),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=YLTRozsCR1M')
                ],
              ),
            ),
            Card(
              child: Column(
                children: const [
                  Text(
                    'Docker and Deploy',
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=TU3P1fYcTyc'),
                  YoutubeLink(
                      link: 'https://www.youtube.com/watch?v=YDNSItBN15w'),
                  YoutubeLink(link: '')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
