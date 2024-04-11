import 'package:app_produtividade/C3PO/assistente.dart';
import 'package:app_produtividade/C3PO/chat_page.dart';
import 'package:app_produtividade/pages/PlanosGENAI/Planos%20de%20treino/rascunho_ia_meal_planner.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/TextRetanguleBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class PortifolioPage extends StatelessWidget {
  PortifolioPage({super.key});

  var selected_project = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: const Text("Portifolio de PV"),
      ),
      body: Center(
        child: ListView(children: [
          const CaixaTextoRetangulo(
              text:
                  "DESENVOLVEDOR FULLSTACK PLENO E ESTUDANTE DE ENGENHARIA ELETRICA UFF"),
          header(),
          apresetationInfo(),
          redesSociais(),
          projectSection(),
          Obx(
            () {
              return ElevatedButton(
                  onPressed: () {
                    //_showProjectDescription();
                  },
                  child: CustomText(
                    text: "Mostrar mais sobre ${selected_project}",
                  ));
            },
          ),
        ]),
      ),
      bottomNavigationBar: CustomNavBar(navBarItems: [
        NavigationBarItem(
            label: 'c3po IA',
            iconData: Icons.radio_button_unchecked_outlined,
            onPress: () {
              Get.to(const C3poGenaiAssistentePessoal());
            }),
        NavigationBarItem(
            label: 'chat page',
            iconData: Icons.sms,
            onPress: () {
              Get.to(Basic());
            }),
        NavigationBarItem(
            label: 'IA trainer',
            iconData: Icons.sms,
            onPress: () {
              Get.to(PlanoDeTreinoWidget());
            }),
      ]),
    );
  }

  Widget redesSociais() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      IconButton(
          onPressed: () {},
          icon: const CircleAvatar(child: Icon(Icons.sensor_occupied))),
      IconButton(
          onPressed: () {},
          icon: const CircleAvatar(child: Icon(Icons.social_distance))),
      IconButton(
          onPressed: () {},
          icon: CircleAvatar(child: Icon(Icons.media_bluetooth_off))),
      IconButton(
          onPressed: () {},
          icon: CircleAvatar(child: Icon(Icons.install_mobile)))
    ]);
  }

  Widget ProjectCard(String titulo, imagem, String description, link) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.blueGrey.shade200,
        child: Column(children: [
          InkWell(
            child: Column(children: [Text(description), Text(link)]),
          ),
          Image.network(imagem),
          Text(titulo)
        ]),
      ),
    );
  }

  Widget projectSection() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        child: const Column(
          children: [
            CustomText(
              text: "Projetos",
              size: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(),
                CircleAvatar(),
                CircleAvatar(),
              ],
            )
          ],
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                child: ProjectCard(
                    "Projeto 1",
                    "https://via.placeholder.com/515X700",
                    "Projeto Analise de Dados",
                    "link github"),
                onTap: () {
                  selected_project = "Projeto 1";
                },
              ),
              ProjectCard("Projeto 2", "https://via.placeholder.com/515X700",
                  "Projeto Sistema de Cadastro", "link github"),
              ProjectCard(
                  "Projeto 3",
                  "https://via.placeholder.com/515X700",
                  "Chatbot Ruby com aplicativo gestao de pedidos",
                  "link github"),
              ProjectCard(
                  "Projeto 3",
                  "https://via.placeholder.com/515X700",
                  "Chatbot Ruby com aplicativo gestao de pedidos",
                  "link github"),
              ProjectCard(
                  "Projeto 3",
                  "https://via.placeholder.com/515X700",
                  "Chatbot Ruby com aplicativo gestao de pedidos",
                  "link github"),
              ProjectCard(
                  "Projeto 3",
                  "https://via.placeholder.com/515X700",
                  "Chatbot Ruby com aplicativo gestao de pedidos",
                  "link github"),
              ProjectCard(
                  "Projeto 3",
                  "https://via.placeholder.com/515X700",
                  "Chatbot Ruby com aplicativo gestao de pedidos",
                  "link github"),
              ProjectCard(
                  "Projeto 3",
                  "https://via.placeholder.com/515X700",
                  "Chatbot Ruby com aplicativo gestao de pedidos",
                  "link github"),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget apresetationInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            const Expanded(
              child: Column(children: [
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      CustomText(text: "Hello World! Sou o Pedro Victor Veras"),
                )),
                SizedBox(
                  height: 5,
                ),
                CustomText(
                    text:
                        "Um desenvolvedor frontend em formação apaixonado por tecnologia.Estou sempre me desafiando com novos projetos e buscando feedback na comunidade de programação, além de compartilhar meus conhecimentos.\n 😁Ah, também sou fã de jogos, filmes, séries e animes. 💜"),
                SizedBox(
                  height: 5,
                ),
              ]),
            ),
            Container(
                width: 200,
                height: 200,
                child: CircleAvatar(child: Placeholder())),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const CircleAvatar(
        child: Icon(
          Icons.abc,
          size: 40,
        ),
      ),
      TextButton(
          child: const CustomText(
            text: "Meus Projetos",
            size: 36,
          ),
          onPressed: () {})
    ]);
  }
}
