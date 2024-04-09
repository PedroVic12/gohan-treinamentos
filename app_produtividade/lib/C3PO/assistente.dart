import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_produtividade/core/animated_markdown.dart';
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

class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  //late final Gemini gemini;

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

    return Scaffold(
      body: Column(
        children: [
          const Text('GENAI C3po'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  c3poColumn(),
                  Text(question),
                  Visibility(
                    visible: isLoading,
                    child: const CircularProgressIndicator(),
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: Align(
                      alignment: Alignment.topLeft,
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
                  Visibility(
                    visible: question.isEmpty && !isLoading,
                    child: const Center(
                      child: Text('Faça uma pergunta ao GEMINI!'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtController,
              onSubmitted: (text) async {
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

                print(response);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isListening) {
            //_stopListening();
          } else {
            //_startListening();
          }
        },
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }

  Widget c3poColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: 'Digite o texto...',
          ),
        ),
        SizedBox(height: 20),
        _isLoading
            ? Image.asset(
                'assets/loading.gif') // Substitua pelo seu GIF de carregamento
            : _response.isEmpty
                ? Image.asset(
                    'assets/static_image.png') // Substitua pela sua imagem estática
                : Column(
                    children: [
                      Image.asset(
                          'assets/static_image.png'), // Substitua pela sua imagem estática
                      SizedBox(height: 10),
                      Text(_response),
                    ],
                  ),
      ],
    );
  }
}
