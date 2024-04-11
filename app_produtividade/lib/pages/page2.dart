import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app_produtividade/widgets/Custom/CustomContainer.dart';
import 'package:app_produtividade/widgets/ScrollTela.dart';
import 'package:app_produtividade/widgets/Layout/TextRetanguleBox.dart';
import 'package:app_produtividade/widgets/Layout/card_soft.dart';

class Page2 extends StatefulWidget {
  @override
  _RandomTextButtonState createState() => _RandomTextButtonState();
}

class _RandomTextButtonState extends State<Page2> {
  final loopDeHabitos = ['deixa', 'escultura', 'Resposta', 'Recompensa'];

  final coisasBoasDaVida = [
    'Trabalhar',
    'Estudar',
    'Cuidar da Aparência',
    'Treinar o seu corpo'
  ];

  final _momentoChill = [
    "Ver Video no Youtube de como se tornar um dev melhor",
    "Se alongar, meditar ou treinar",
    "Musica de elevador para relaxar"
  ];

  final _objetivos = [
    'Aula Dart + Arquitetura Limpa',
    'Aula IoT',
    'Aula Flutter + GetX',
    'Aula Visão Computacional',
    'Fazer um Projeto Prático com a Linguagem do dia'
  ];

  final _orientacaoObjetos = [
    "Encapsulamento",
    "Imutabilidade",
    "Herança",
    "Polimorfismo"
  ];

  final _lista = [
    "Arrumar o Portifolio (Gohan Treinamentos) ",
    "Fazer 1 Projeto Flutter",
    "Fazer 1 Projeto Arduino",
    "Projeto Chatbot Whatsapp",
    "Projeto C3PO (Assistente)",
    "Arduino Boson Treinamentos + Automação na Veia",
    "Aula Dio Innovation (IoT + Inteligencia Artificial)",
    "Qual a inspiração do dia de hoje? Medite, busque a serenidade e encontre a resposta",
    "Qual a mensagem pro meu coração e como pode ser util para todos os seres humanos e para todos os seres do planeta Terra? (Pense no bem maior)"
  ];

  var _selectedMomentoChill = 'RELAXAR, DESCANSAR, REFLETIR E SUBIR A MONTANHA';
  var _selectedObjetivos = 'OBJETIVOS DO DIA';
  var _selectedOrientacaoObjetos = 'ESCOLHA SUA ARMA!';
  var _selectedLista = 'ACORDA PREGUIÇOSO';

  //Change HERE!
  void _changeText() {
    setState(() {
      int randomIndex = Random().nextInt(4);
      switch (randomIndex) {
        case 0:
          _selectedMomentoChill =
              _momentoChill[Random().nextInt(_momentoChill.length)];
          break;
        case 1:
          _selectedObjetivos = _objetivos[Random().nextInt(_objetivos.length)];
          break;
        case 2:
          _selectedOrientacaoObjetos =
              _orientacaoObjetos[Random().nextInt(_orientacaoObjetos.length)];
          break;
        case 3:
          _selectedLista = _lista[Random().nextInt(_lista.length)];
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2 - Buscando o Auto Conhecimento dos seus poderes'),
      ),
      body: MyGestureDetector(
        child: Center(
          child: Column(
            children: [
              //Debug, COde, Motivation, Rest and Train

// 4 botoes

// 2 cards no centro

// plano de fundo

// setas com svg

// botão bolado que sai som do pokemon ao apertar e tem uma animação --> Seus proprios widgets

              CaixaTextoRetangulo(text: 'Como ser mais produtivo?\n\n'),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 3,
                  ),
                ),
                child: Text(
                  'Objetivos: $_selectedObjetivos',
                  style: TextStyle(fontSize: 25),
                ),
              ),

              Container(
                child: Text('Orientação Objetos: $_selectedOrientacaoObjetos',
                    style: TextStyle(fontSize: 25)),
              ),
              Container(
                child: Text('Lista: $_selectedLista',
                    style: TextStyle(fontSize: 25)),
              ),
              ElevatedButton(
                onPressed: _changeText,
                child: Text('Change Text'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
