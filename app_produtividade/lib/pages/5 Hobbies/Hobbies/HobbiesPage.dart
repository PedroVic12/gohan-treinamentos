import 'package:app_produtividade/pages/5%20Hobbies/Hobbies/HobbiesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HobbiesPage extends StatelessWidget {
  final controller = Get.put(MeuHobbyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 hobbies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Reset counts",
            onPressed: () {
              controller.resetCounts();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const Center(
              child: Card(
                  child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Segunda, 18/06/2023'),
          ))),
          const Center(child: Text('You Only Need 5 hobbies')),
          const Center(
              child: Text('Entender -> Aprender -> Praticar -> Aplicar')),
          Obx(() {
            if (controller.meusHobbies.isEmpty) {
              return Container(
                color: Colors.white,
                width: 100,
                height: 100,
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child:
                            CircularProgressIndicator(), // Ou qualquer outro widget de carregamento
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Carregando...'),
                    )
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context)
                          .size
                          .height, // Defina a altura ou limite a altura conforme necessário
                      child: ListView.builder(
                        itemCount: controller.meusHobbies.length,
                        itemBuilder: (context, index) {
                          final hobby = controller.meusHobbies[index];
                          return Card(
                              color: Colors.amber.shade100,
                              elevation: BorderSide.strokeAlignOutside,
                              margin: const EdgeInsets.all(6),
                              child: ListTile(
                                title: Text(hobby.title!),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: (hobby.description as List<dynamic>)
                                      .map<Widget>((desc) {
                                    return Text(desc.toString());
                                  }).toList(),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('1'),
                                    //Text(hobby.contador.toString()),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        //controller.incrementarContador(hobby);
                                      },
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  ),


                ],
              );
            }
          }),                  const DesempenhoWidget()



        ],
      ),
    );
  }
}

class DesempenhoWidget extends StatelessWidget {
  const DesempenhoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: [
          const Text("Desempenho da semana: {totalHobbiesCount}/35",
              style: TextStyle(fontSize: 20)),
          LinearProgressIndicator(
            value: 100 / 35,
            color: Colors.black,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
