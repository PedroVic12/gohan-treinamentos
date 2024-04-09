import 'package:app_produtividade/C3PO/assistente.dart';
import 'package:app_produtividade/C3PO/chat_page.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/TextRetanguleBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class PortifolioPage extends StatelessWidget {
  PortifolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Portifolio de PV"),
      ),
      body: Center(
        child: ListView(children: [
          CaixaTextoRetangulo(
              string_parametro: "Como ter um assistente pessoal"),
          header(),
          apresetationInfo(),
          Row(children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.sensor_occupied)),
            IconButton(onPressed: () {}, icon: Icon(Icons.social_distance)),
            IconButton(onPressed: () {}, icon: Icon(Icons.media_bluetooth_off)),
            IconButton(onPressed: () {}, icon: Icon(Icons.install_mobile))
          ]),
          projectSection()
        ]),
      ),
      bottomNavigationBar: CustomNavBar(navBarItems: [
        NavigationBarItem(
            label: 'c3po IA',
            iconData: Icons.radio_button_unchecked_outlined,
            onPress: () {
              Get.to(TextPage());
            }),
        NavigationBarItem(
            label: 'chat page',
            iconData: Icons.sms,
            onPress: () {
              Get.to(Basic());
            }),
      ]),
    );
  }

  Widget ProjectCard(String titulo, imagem, String description, link) {
    return Card(
      child: Column(children: [
        InkWell(
          child: Column(children: [Text(description), Text(link)]),
        ),
        Image.network(imagem),
        Text(titulo)
      ]),
    );
  }

  Widget projectSection() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(children: [
          Text("Meus Projetos"),
          ProjectCard("Projeto 1", "https://via.placeholder.com/515X700",
              "Projeto Analise de Dados", "link github"),
          ProjectCard("Projeto 2", "https://via.placeholder.com/515X700",
              "Projeto Sistema de Cadastro", "link github"),
          ProjectCard("Projeto 3", "https://via.placeholder.com/515X700",
              "Chatbot Ruby com aplicativo gestao de pedidos", "link github"),
        ]));
  }

  Widget apresetationInfo() {
    return Container(
      child: Row(children: [
        Container(
            child: Column(children: [
          Text("Hello World! Sou o Pedro Victor Veras"),
          SizedBox(
            height: 5,
          ),
          Text(
              "Um desenvolvedor frontend em formação apaixonado por tecnologia.\nEstou sempre me desafiando com novos projetos e buscando feedback na comunidade de programação, além de compartilhar meus conhecimentos.\n 😁Ah, também sou fã de jogos, filmes, séries e animes. 💜"),
          SizedBox(
            height: 5,
          ),
        ])),
        CircleAvatar(child: Placeholder())
      ]),
    );
  }

  Widget header() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      CircleAvatar(
        child: Icon(Icons.abc),
      ),
      TextButton(
          child: CustomText(
            text: "Meus Projetos",
            size: 24,
          ),
          onPressed: () {})
    ]);
  }
}
