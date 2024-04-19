import 'package:app_produtividade/C3PO/assistente.dart';
import 'package:app_produtividade/C3PO/c3po.dart';
import 'package:app_produtividade/widgets/Custom/CustomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cardapioView/food_item_page.dart';
import '../cardapioView/model_food.dart';

class ChatbotVozC3po extends StatefulWidget {
  const ChatbotVozC3po({super.key});

  @override
  State<ChatbotVozC3po> createState() => _ChatbotVozC3poState();
}

class _ChatbotVozC3poState extends State<ChatbotVozC3po> {
  @override
  Widget build(BuildContext context) {
    final assistente = C3PoAssistente();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GENAI C3po Chatbot por Voz'),
      ),
      body: Container(
        color: Colors.black.withBlue(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (assistente.isListening) {
                      assistente.stopListening();
                    } else {
                      assistente.startListening();
                    }
                  });
                },
                icon: Icon(assistente.isListening ? Icons.mic_off : Icons.mic),
                iconSize: 100,
                color: assistente.isListening ? Colors.green : Colors.red,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(assistente.textoReconhecido.isNotEmpty
                      ? assistente.textoReconhecido
                      : "Aqui aparecerão os resultados..."),
                ),
              ),
              InkWell(
                onLongPress: () {
                  setState(() {
                    assistente.startListening();
                  });
                },
                onDoubleTap: () {
                  setState(() {
                    assistente.stopListening();
                    assistente.c3poRespondeGENAI(assistente.chatbotInput.text);
                  });
                },
                child: FloatingActionButton(
                  onPressed:
                      () {}, // Necessário para que o botão seja arrastável
                  child:
                      Icon(assistente.isListening ? Icons.mic_off : Icons.mic),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: assistente.chatbotInput,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Texto Reconhecido por Voz",
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),

                  maxLines: null,
                  readOnly: true, // Para impedir a edição do texto pelo usuário
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        navColor: Colors.blueGrey,
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
}
