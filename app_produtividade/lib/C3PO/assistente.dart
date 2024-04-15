import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_produtividade/core/animated_markdown.dart';
import 'package:app_produtividade/widgets/Custom/CustomText.dart';
import 'package:app_produtividade/widgets/Layout/TextRetanguleBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class C3PoAssistente {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  bool isListening = false;
  String textoReconhecido = '';
  final inputText = TextEditingController();

  Future<void> initSpeechState() async {
    await _speechToText.initialize();
  }

  Future<void> falar(String texto) async {
    await _flutterTts.speak(texto);
  }

  void startListening() {
    if (!isListening) {
      _speechToText.listen(
        onResult: (result) {
          textoReconhecido = result.recognizedWords;
          print(textoReconhecido);
        },
      );
      isListening = true;
    }
  }

  void stopListening() {
    _speechToText.stop();
    isListening = false;
  }

  void clearText() {
    inputText.clear();
    textoReconhecido = '';
  }

  void copyText() {
    Clipboard.setData(ClipboardData(text: textoReconhecido));
  }
}

class C3poGenaiAssistentePessoal extends StatefulWidget {
  const C3poGenaiAssistentePessoal({super.key});

  @override
  State<C3poGenaiAssistentePessoal> createState() =>
      _C3poStateGenaiAssistentePessoal();
}

class _C3poStateGenaiAssistentePessoal
    extends State<C3poGenaiAssistentePessoal> {
  final gemini = Gemini.instance;
  var question = '';
  String? answer = '';
  var isLoading = false;
  final txtController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  String _response = '';
  //stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void show_prompt() {
      final String prompt_user =
          "Me de 3 ideias de projetos simples onde tenha circuitos digitais com portas logicas";

      gemini.streamGenerateContent(prompt_user).listen((value) {
        print(value.output);
      }).onError((e) {
        print(
          'exception',
        );
      });
    }

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
          c3poColumn(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(text: question),
            ),
          ),
          showRespostaAssistente(),
          myColumn()
        ],
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
                      TyperMarkdownAnimatedText(answer!),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: question.isEmpty && !isLoading,
          child: const Center(
            child:
                Text('Faça uma pergunta ao c3po seu assistnte virtual TDAH!'),
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
            fillColor: Theme.of(context).colorScheme.secondary,
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
        formularioSimples((text) async {
          setState(() {
            question = text;
            isLoading = true;
          });
          txtController.clear();

          final response = await gemini.text(question).then((value) {
            print(value?.output);
            var resposta = value?.output;

            setState(() {
              answer = resposta;
              isLoading = false;
            });
          });

          //print(response);
        }, false, txtController, "Pergunte ao TDAH"),
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

  Widget myColumn() {
    final assistente = C3PoAssistente();

    assistente.initSpeechState();
    return Column(children: [
      TextField(
        controller: assistente.inputText,
        decoration: InputDecoration(
            hintText: "Enter text", border: OutlineInputBorder()),
        maxLines: 3,
      ),
      SizedBox(height: 30),
      ElevatedButton(
          onPressed: () async {
            assistente.falar(assistente.inputText.text);

            //String? command = await assistant.listenCommand();
            //await assistant.interpretCommand(command);
          },
          child: Text("C3po falar")),
      Container(
          child: Column(children: [
        IconButton(
          onPressed: () {
            if (_isListening) {
              //_stopListening();
            } else {
              //_startListening();
            }
          },
          icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
          iconSize: 100,
          color: assistente.isListening ? Colors.green : Colors.red,
        ),
        Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(assistente.textoReconhecido.isNotEmpty
              ? assistente.textoReconhecido
              : "Results here..."),
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(
              onPressed: assistente.textoReconhecido.isNotEmpty
                  ? assistente.copyText
                  : null,
              child: Text("Copiar")),
          TextButton(
              onPressed: assistente.textoReconhecido.isNotEmpty
                  ? assistente.clearText
                  : null,
              child: Text("Cancelar"))
        ])
      ]))
    ]);
  }
}
