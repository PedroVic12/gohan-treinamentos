import 'package:app_produtividade/C3PO/c3po.dart';
import 'package:flutter/material.dart';

class AssistentePessoalPage extends StatelessWidget {
  AssistentePessoalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assistant = C3PoAssistant();

    final assistente = C3PoAssistente();

    assistente.initSpeechState();

    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: Text("c3poAssistente"),
        ),
        body: Column(children: [
          ElevatedButton(
            onPressed: () async {
              String? command = await assistant.listenCommand();
              await assistant.interpretCommand(command);
            },
            child: Text('Ouvir Comando'),
          ),
          Divider(),
          Divider(),
          Divider(),
          TextField(
            controller: assistente.inputText,
            decoration: InputDecoration(
                hintText: "Enter text", border: OutlineInputBorder()),
            maxLines: 3,
          ),
          SizedBox(height: 30),
          TextButton(
              onPressed: () {
                assistente.falar(assistente.inputText.text);
              },
              child: Text("C3po falar")),
          Container(
              child: Column(children: [
            IconButton(
              onPressed: () {},
              icon: Icon(assistente.isListening ? Icons.mic : Icons.mic_none),
              iconSize: 100,
              color: assistente.isListening ? Colors.green : Colors.red,
            ),
            Card(
                child: Text(assistente.textoReconhecido.isNotEmpty
                    ? assistente.textoReconhecido
                    : "Results here...")),
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
        ]));
  }
}
