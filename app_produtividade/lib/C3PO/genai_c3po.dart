import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  String _response = '';
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech.initialize(onError: (error) => print(error));
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _textController.text = result.recognizedWords;
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _submitText(String text) {
    setState(() {
      _isLoading = true;
    });

    // Simulando uma operação assíncrona
    Future.delayed(Duration(seconds: 3), () {
      // Lógica de como você obteria a resposta do GeminiStepper
      setState(() {
        _response = "Resposta do Gemini: $text";
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Gemini Example'),
      ),
      body: Column(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isListening) {
            _stopListening();
          } else {
            _startListening();
          }
        },
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
