import 'package:flutter/material.dart';

class PortifolioPage extends StatelessWidget {
  PortifolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: Text("widget.title"),
        ),
        body: Center(
          child: ListView(
              children: [header(), apresetationInfo(), projectSection()]),
        ));
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
        child: SizedBox(
            width: 700, // Adjust as needed
            child: Column(children: [
              Text("Meus Projetos"),
              ProjectCard("Projeto 1", "https://via.placeholder.com/515X700",
                  "descição", "link github"),
              ProjectCard("Projeto 2", "https://via.placeholder.com/515X700",
                  "descição", "link github"),
              ProjectCard("Projeto 3", "https://via.placeholder.com/515X700",
                  "descição", "link github"),
            ])));
  }

  Widget apresetationInfo() {
    return Row(children: [
      Container(
          child: Column(children: [
        Text("Hello World! Sou o Pedro Victor Veras"),
        SizedBox(
          height: 5,
        ),
        Text(
            "Um desenvolvedor frontend em formação apaixonado por tecnologia.Estou sempre me desafiando com novos projetos e buscando feedback na comunidade de programação, além de compartilhar meus conhecimentos. 😁Ah, também sou fã de jogos, filmes, séries e animes. 💜"),
        SizedBox(
          height: 5,
        ),
        Row(children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.sensor_occupied)),
          IconButton(onPressed: () {}, icon: Icon(Icons.social_distance)),
          IconButton(onPressed: () {}, icon: Icon(Icons.media_bluetooth_off)),
          IconButton(onPressed: () {}, icon: Icon(Icons.install_mobile))
        ])
      ])),
      CircleAvatar(child: Image.network(""))
    ]);
  }

  Widget header() {
    return Row(children: [
      CircleAvatar(
        child: Icon(Icons.abc),
      ),
      TextButton(child: Text("Meus Projetos"), onPressed: () {})
    ]);
  }
}
