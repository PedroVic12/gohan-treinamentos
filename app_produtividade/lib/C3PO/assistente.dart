import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_produtividade/C3PO/c3po.dart';
import 'package:app_produtividade/C3PO/cardapioView/food_item_page.dart';
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

class C3poGenaiAssistentePessoal extends StatefulWidget {
  const C3poGenaiAssistentePessoal({super.key});

  @override
  State<C3poGenaiAssistentePessoal> createState() =>
      _C3poStateGenaiAssistentePessoal();
}

class _C3poStateGenaiAssistentePessoal extends State<C3poGenaiAssistentePessoal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var question = '';
  String? answer = '';
  var isLoading = false;
  final txtController = TextEditingController();
  bool _isLoading = false;
  String _response = '';
  final assistente = Get.put(C3PoAssistente());

  @override
  void initState() {
    super.initState();
    // Inicializa o reconhecimento de fala
    assistente.initSpeechState();
    print("C3po Configurado");
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //Debug, COde, Motivation, Rest and Train

// 4 botoes

// 2 cards no centro

// plano de fundo

// setas com svg

// botão bolado que sai som do pokemon ao apertar e tem uma animação --> Seus proprios widgets

    return Scaffold(
      appBar: AppBar(
        title: const Text('GENAI C3po Assistente'),
      ),
      body: ListView(
        children: [
          //Tab1
          c3poColumn(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(question),
            ),
          ),

          // tab3
          showRespostaAssistente(),
          c3poTextToSpeech(),

          //Tab3
          chatbot()
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        navBarItems: [
          NavigationBarItem(
              label: 'Habit Tracker',
              iconData: Icons.home,
              onPress: () {
                Get.toNamed('/blog');
              }),
          NavigationBarItem(
              label: 'TODO LIST',
              iconData: Icons.search,
              onPress: () {
                Get.to(ItemDetailsPage());
              }),
          NavigationBarItem(
              label: 'ORGANIZE', iconData: Icons.person, onPress: () {}),
          NavigationBarItem(
              label: 'ORGANIZE', iconData: Icons.person, onPress: () {}),
          NavigationBarItem(
              label: 'ORGANIZE', iconData: Icons.person, onPress: () {}),
        ],
      ),
    );
  }

  Widget chatbot() {
    return Container(
      color: Colors.lightGreenAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                onPressed: () {}, // Necessário para que o botão seja arrastável
                child: Icon(assistente.isListening ? Icons.mic_off : Icons.mic),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: assistente.chatbotInput,
                decoration: InputDecoration(
                  hintText: 'Texto reconhecido',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                readOnly: true, // Para impedir a edição do texto pelo usuário
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showRespostaAssistente() {
    return Column(
      children: [
        Visibility(
          visible: isLoading,
          child: const CircularProgressIndicator(),
        ),
        Visibility(
          visible: !isLoading,
          child: Align(
            alignment: Alignment.topLeft,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: AnimatedTextKit(
                    key: ValueKey(answer),
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperMarkdownAnimatedText(answer!,
                          speed: Duration(milliseconds: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: answer!));
            },
            child: Text("Copiar Resposta")),
        Visibility(
          visible: question.isEmpty && !isLoading,
          child: const Center(
            child: CustomText(
              text: 'Faça uma pergunta ao c3po seu assistnte virtual TDAH!',
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget formularioSimples(Function(String)? onTap, bool obscureText,
      TextEditingController controlador, String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
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

  Widget c3poColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: formularioSimples((text) async {
            setState(() {
              question = text;
              isLoading = true;
            });
            txtController.clear();

            final response =
                await assistente.gemini.text(question).then((value) {
              print(value?.output);
              var resposta = value?.output;

              setState(() {
                answer = resposta;
                isLoading = false;
              });
            });

            //print(response);
          }, false, txtController, "Pergunte ao TDAH"),
        ),
        SizedBox(height: 20),
        _isLoading
            ? CircularProgressIndicator()
            : _response.isEmpty
                ? Image.network(
                    'https://moseisleychronicles.files.wordpress.com/2015/11/untitled-215.gif') // Substitua pela sua imagem estática
                : Column(
                    children: [
                      Image.network(
                          'https://moseisleychronicles.files.wordpress.com/2015/11/untitled-215.gif'), // Substitua pela sua imagem estática
                      SizedBox(height: 10),
                      Text(_response),
                    ],
                  ),
      ],
    );
  }

  Widget c3poTextToSpeech() {
    assistente.initSpeechState();

    return Column(children: [
      TextField(
        controller: assistente.inputText,
        decoration: InputDecoration(
          hintText: "Digite o texto para ouvir!",
          border: OutlineInputBorder(),
        ),
        maxLines: 2,
      ),
      SizedBox(height: 30),
      Form(
        child: Column(children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: assistente.textoReconhecido.isNotEmpty
                    ? assistente.copyText
                    : null,
                child: Text("Copiar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await assistente.falar(assistente.inputText.text);
                },
                child: Text("C3po falar"),
              ),
              TextButton(
                onPressed: assistente.textoReconhecido.isNotEmpty
                    ? assistente.clearText
                    : null,
                child: Text("Cancelar"),
              ),
            ],
          ),
        ]),
      ),
    ]);
  }
}
