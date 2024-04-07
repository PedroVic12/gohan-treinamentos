import 'package:flutter/material.dart';

import "package:flutter_tts";
import "package:speech_to_text" as stt;


class c3poAssistente{
    final FlutterTts tts - FlutterTts();
    final TextEditingController input_text = TextEditingController();
    final sst.SpeechToText _speech = sst.SpeechToText();
    String _textoReconhecido = "";
    bool _isListening = false;
    
    
    void conectApi() {
    }
    
    String modeloGenerativoTexto(){}
    
    modeloGenerativoImagem(){}
    
    
    
    void initSpeechState() async {
        bool avaiable = await _speech.initialize();
        if (!mounted) return;
        setState((){
            _isListening = avaiable;
        })
    }
    
    
    
    void ouvir() async {
    
        _speech.listen(onResult: (result) {
        
            setState((){
                _textoReconhecido =  await result.recognizedWords;
                Get.SnackBar("Foi!", "Texto extraido por voz")
                
            })
            
            setState((){
                _isListening = True;
                
            })
        })
    }
    
    void _copyText() {
        Clipboard.setData(ClipboardData(text: _textoReconhecido))
    }
    
    void _clearText() {
    
        setState((){
           _textoReconhecido = ""; 
        });
    }

    
    void falar(String text) async {
    
        await tts.setLanguage("pt-BR");
        await tts.setPitch(1.0);
        await tts.setSpeechRate(0.5);
        await tts.speak(text);
    
    }
    
}


class AssistentePessoalPage extends StatelessWidget {
   AssistentePessoalPage({super.key});

  @override
  Widget build(BuildContext context) {
  
      final assistente = c3poAssistente();
      
      assistente.initSpeechState();
  
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(        title: Text("c3poAssistente"),       ),
      body: Column(
        children: [
            
            TextField(controller: assistente.input_text,
            decoration: InputDecoration(
                hintText: "Enter text",
                border: OutlineInputBorder()
            ),
            maxLines: 3,
            
            
            ),
            
            SizedBox(height:30),
            
            TextButton(
                onPressed: () {
                    assistente.falar(assistente.input_text.text)
                },
                child: Text("C3po falar")
                
            ),
            
            
            Container(
                child: Column(
                    children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(assistente._isListening ? Icons.mic : Icons.mic_none),
                        iconSize: 100,
                        color: assistente._isListening ? Colors.green : Colors.red,
                    ),
                    
                    Card(
                        child: Text(assistente._textoReconhecido.isNotEmpty ? assistente._textoReconhecido : "Results here...")
                    ),
                    
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            TextButton(
                                onPressed: assistente._textoReconhecido.isNotEmpty ? assistente._copyText : null,
                                child: Text("Copiar")
                            ),
                            
                            TextButton(
                                onPressed: assistente._textoReconhecido.isNotEmpty ? assistente._clearText : null,
                                child: Text("Cancelar")
                            )
                        ]
                    )
                    
                    ]
                )
            )
        
        ]
        )
        );
        }
        }
        


class PortifolioPage extends StatelessWidget {
   PortifolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(        title: Text("widget.title"),       ),
      body: Center(
        child: ListView(
		

          children: [
            
            header(),
            apresetationInfo(),
            projectSection()
            
            
          ]
        ),)
      );
  }
  
  Widget ProjectCard(String titulo, imagem,String description, link){
    return Card(
      child: Column(
        children: [
          InkWell(
            child: Column(
              children:[
                Text(description),
                Text(link)
              ]
            ),
          ),
          Image.network(imagem),
          Text(titulo)
        ]
      ),
    );
  }
  
  Widget projectSection(){
    return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: 700, // Adjust as needed
      child: Column(
      children:[
        Text("Meus Projetos"),
        
        ProjectCard("Projeto 1", "https://via.placeholder.com/515X700","descição","link github"),
        
        ProjectCard("Projeto 2", "https://via.placeholder.com/515X700","descição","link github"),
        
        ProjectCard("Projeto 3", "https://via.placeholder.com/515X700","descição","link github"),
        
        
      ]
    )));
  }
  
  Widget apresetationInfo(){
    return Row(
    children:[
      Container(
        child: Column(
          children:[
            Text("Hello World! Sou o Pedro Victor Veras"),
            SizedBox(height: 5,),
            Text("Um desenvolvedor frontend em formação apaixonado por tecnologia.Estou sempre me desafiando com novos projetos e buscando feedback na comunidade de programação, além de compartilhar meus conhecimentos. 😁Ah, também sou fã de jogos, filmes, séries e animes. 💜"),
                        SizedBox(height: 5,),

            Row(
              children:[
                IconButton(
            onPressed: (  ) {},
              icon: Icon(Icons.sensor_occupied)
              ),
                IconButton(
            onPressed: (  ) {},
              icon: Icon(Icons.social_distance)
              ),
                IconButton(
            onPressed: (  ) {},
              icon: Icon(Icons.media_bluetooth_off)
              ),
                IconButton(
            onPressed: (  ) {},
              icon: Icon(Icons.install_mobile)
              )
              ]
            )
          ]
        )
      ),
      
      CircleAvatar(
      
        child: Image.network("")
      )
    ]
    );
  }
  
  Widget header(){
    return Row(children:[
      CircleAvatar(
      child: Icon(Icons.abc) ,),
      
      TextButton(
      child: Text("Meus Projetos"),
        onPressed: (      ){}
        )
    ]);
  }
  
}


