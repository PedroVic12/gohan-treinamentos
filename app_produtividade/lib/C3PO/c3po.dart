import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class C3PoAssistant {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final GenerativeModel _textGenerator = GenerativeModel("gemini-pro");
  final GenerativeModel _visionModel = GenerativeModel("gemini-pro-vision");

  Future<String?> listenCommand() async {
    String? command;
    bool available = await _speechToText.initialize();
    if (available) {
      _speechToText.listen(
        onResult: (result) {
          command = result.recognizedWords;
        },
      );
    }
    return command;
  }

  Future<void> speakResponse(String response) async {
    await _flutterTts.speak(response);
  }

  Future<String?> generateText(String text) async {
    Response response = await _textGenerator.generateContent(text);
    return response.text;
  }

  Future<String?> correctText(String ocrText, String visionText) async {
    String combinedText = "$ocrText $visionText";
    String prompt = """ 
        Corrija o texto para extrair a data, local pegando seu logradouro ou CEP ou nome do estabelecimento, produtos com apenas o nome separando com um \n e total da nota fiscal em cada linha com os rótulos como Data: Local: Produtos: Total:
            """;
    String correctedText = await generateText("$combinedText \n\n\n\n $prompt");
    return correctedText;
  }

  Future<String?> describeImage(String imagePath, String prompt) async {
    Image image = Image.asset(imagePath);
    Response response = await _visionModel.generateContent([prompt, image]);
    return response.text;
  }

  Future<void> interpretCommand(String? command) async {
    if (command != null) {
      if (command.contains("corrigir texto")) {
        String ocrText = "Texto obtido por OCR";
        String visionText = "Texto obtido por visão computacional";
        String correctedText = await correctText(ocrText, visionText);
        await speakResponse(correctedText);
      } else if (command.contains("ver imagem")) {
        String imagePath = "caminho/para/imagem.jpg";
        String prompt = "Descreva a imagem";
        String description = await describeImage(imagePath, prompt);
        await speakResponse(description);
      } else {
        await speakResponse("Desculpe, não entendi o comando.");
      }
    }
  }
}

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
