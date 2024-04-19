import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_produtividade/C3PO/c3po.dart';
import 'package:app_produtividade/C3PO/cardapioView/food_item_page.dart';
import 'package:app_produtividade/C3PO/pages/c3po_page1.dart';
import 'package:app_produtividade/C3PO/pages/c3po_page2.dart';
import 'package:app_produtividade/core/animated_markdown.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Custom/my_tab_bar.dart' as tab;
import 'package:app_produtividade/widgets/Layout/TextRetanguleBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../widgets/Custom/CustomNavBar.dart';
import 'cardapioView/model_food.dart';

class C3poGenaiAssistentePessoal extends StatefulWidget {
  const C3poGenaiAssistentePessoal({super.key});

  @override
  State<C3poGenaiAssistentePessoal> createState() =>
      _C3poStateGenaiAssistentePessoal();
}

class _C3poStateGenaiAssistentePessoal extends State<C3poGenaiAssistentePessoal>
    with SingleTickerProviderStateMixin {
  final assistente = Get.put(C3PoAssistente());
  @override
  void initState() {
    super.initState();
    // Inicializa o reconhecimento de fala
    assistente.initSpeechState();
    print("C3po Configurado");
  }

  @override
  Widget build(BuildContext context) {
    bool _showResponderVoz = false;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('GENAI C3PO Assistente Pessoal'),
      ),
      body: ListView(
        children: [
          //Debug, COde, Motivation, Rest and Train

// 4 botoes

// 2 cards no centro

// plano de fundo

// setas com svg

// botão bolado que sai som do pokemon ao apertar e tem uma animação --> Seus próprios widgets
          //Tab1
          const C3poChatbotSimples(),

          // tab2
          const Divider(),

          const Center(
            child: CustomText(
              text: "C3PO RESPONDE FALANDO",
              color: Colors.white,
              size: 26,
            ),
          ),
          const Divider(),
          c3poTextToSpeech(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
              _showResponderVoz ? Icons.close : Icons.add), // Alterna o ícone

          onPressed: () {
            setState(() {
              _showResponderVoz = !_showResponderVoz;
            });
          }),
      bottomNavigationBar: CustomNavBar(
        navColor: Colors.blue,
        navBarItems: [
          NavigationBarItem(
              label: 'TODO LIST',
              iconData: Icons.bookmark,
              onPress: () {
                Get.to(ItemDetailsPage(
                  produto_selecionado: ProdutoModel(
                    nome: "HAMBÚRGUER",
                    preco_1: 32.0,
                    ingredientes: "Pão, carne, queijo, alface, tomate",
                    sub_categoria: "SIM",
                    categoria: "ARTESANAL",
                    Adicionais: {
                      "Bacon": 5.0,
                      "Ovo": 3.0,
                      "Queijo": 2.0,
                      "Molho especial": 1.0
                    },
                  ),
                ));
              }),
          NavigationBarItem(
              label: 'Assistente Pessoal',
              iconData: Icons.person,
              onPress: () {
                Get.to(const C3poGenaiAssistentePessoal());
              }),
          NavigationBarItem(
              label: 'Chatbot por Voz',
              iconData: Icons.mic_rounded,
              onPress: () {
                Get.to(const ChatbotVozC3po());
              }),
        ],
      ),
    );
  }

  Widget formularioSimples(Function(String)? onTap, bool obscureText,
      TextEditingController controlador, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        onSubmitted: onTap,
        obscureText: obscureText,
        autocorrect: true,
        controller: controlador,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      ),
    );
  }

  Widget c3poTextToSpeech() {
    assistente.initSpeechState();

    return Column(children: [
      TextField(
        controller: assistente.inputText,
        autocorrect: true,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: "Digite o texto para ouvir!",
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
        maxLines: 2,
      ),
      const SizedBox(height: 30),
      Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: assistente.textoReconhecido.isNotEmpty
                  ? assistente.copyText
                  : null,
              child: const Text("Copiar"),
            ),
            ElevatedButton(
              onPressed: () async {
                await assistente.falar(assistente.inputText.text);
              },
              child: const Text("C3po falar"),
            ),
            TextButton(
              onPressed: assistente.textoReconhecido.isNotEmpty
                  ? assistente.clearText
                  : null,
              child: const Text("Cancelar"),
            ),
          ],
        ),
      ]),
    ]);
  }
}
