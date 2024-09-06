import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class C3PoAssistente {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final gemini = Gemini.instance;

  bool isListening = false;
  String textoReconhecido = '';
  final inputText = TextEditingController();
  final chatbotInput = TextEditingController();
  var question = '';
  String? answer = '';
  var isLoading = false;
  final txtController = TextEditingController();
  String response = '';

  Future<void> initSpeechState() async {
    await _speechToText.initialize();
    await _flutterTts
        .setLanguage('pt-BR'); // Define o idioma como português do Brasil
    await _flutterTts.setVoice({"name": "Google português do Brasil"});
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);

    await _flutterTts.setSpeechRate(1.2); // 1.0 is the default rate
  }

  void c3poRespondeGENAI(String prompt_user) {
    String c3poDefault =
        """use texto simples e puro sem formatação e asteriscos, nao use markdown!! \n\n

     Voce é meu assistente pessoal C3po de um programdor jovem e  apaixonado por tecnologia. Voce vai me ajudar durante meu curso de engenharia eletrica e meus projetos mobile com flutter, machine learning com python e backend. Sou tdah entao tenho dificuldade de me lembrar das coisas entao seu dever é me lembrar e me ajudar a ser uma pessoa mais produtiva
    
    responda minhas perguntas de forma simples e direta e va sempre direto ao ponto! \n\n
    """;

    gemini.streamGenerateContent(c3poDefault + prompt_user).listen((value) {
      //print(value.output);

      String textoSemMarkdown =
          value.output!.replaceAll(RegExp(r'\*\*|\*|\\n|\\t'), ' ');
      falar(value.output!);
    }).onError((e) {
      print(
        'exception',
      );
    });
  }

  void configVozes() async {
    var voices = await _flutterTts.getVoices;
    if (voices != null) {
      var castVoices = voices.map<Map<String, dynamic>>((voice) {
        return Map<String, dynamic>.from(voice as Map);
      }).toList();

      print("\n\nVozes = ${castVoices}");

      for (var voz in castVoices) {
        if (voz["locale"] == "pt-BR") {
          print("Voz portugues ${voz}");
        }
      }
    }
  }

  Future<void> falar(String texto) async {
    await _flutterTts.speak(texto);
    print("\nFalando: $texto");
  }

  String? startListening() {
    String textoReconhecido = "";
    if (!isListening) {
      _speechToText.listen(
        onResult: (result) {
          textoReconhecido = result.recognizedWords;
          print(textoReconhecido);
          chatbotInput.text = textoReconhecido;
        },
      );
      isListening = true;
      return textoReconhecido;
    }
    return null;
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

  Future<String?> generateText(String text) async {
    return null;
  }

  Future<String?> describeImage(String imagePath, String prompt) async {
    return null;
  }

  pickImage() {}

  void pickPDFfile() {}

  Future<void> interpretCommand(String? command) async {
    if (command != null) {
      if (command.contains("corrigir texto")) {
        String ocrText = "Texto obtido por OCR";
        String visionText = "Texto obtido por visão computacional";
        await falar(visionText);
      } else if (command.contains("ver imagem")) {
        String imagem = pickImage();
        String prompt = "Descreva a imagem";
        //String description = await describeImage(imagem, prompt);
        await falar(prompt);
      } else {
        await falar("Desculpe, não entendi o comando.");
      }
    }
  }
}
