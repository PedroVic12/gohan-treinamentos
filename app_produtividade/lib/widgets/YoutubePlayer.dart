import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class YoutubeLink extends StatefulWidget {
  final String link;

  const YoutubeLink({Key? key, required this.link}) : super(key: key);

  @override
  _YoutubeLinkState createState() => _YoutubeLinkState();
}

class _YoutubeLinkState extends State<YoutubeLink> {
  late final YoutubePlayerController _youtubePlayerController;
  late String _videoTitle;
  late String _thumbnailUrl = ''; // Inicialize com uma string vazia
  late bool _isControllerReady = false;

  @override
  void initState() {
    super.initState();

    // Obter o ID do vídeo a partir do link
    String videoId = YoutubePlayer.convertUrlToId(widget.link) ?? '';

    // Inicializar o controlador do player do YouTube
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    )..addListener(() {
        if (_youtubePlayerController.value.isReady && !_isControllerReady) {
          _isControllerReady = true;
          setState(() {});
        }
      });

    // Fazer solicitação HTTP para obter informações sobre o vídeo
    _getVideoInfo(videoId);
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  void _getVideoInfo(String videoId) async {
    try {
      var response = await http.get(Uri.parse(
          'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=AIzaSyDXh0wul4agmQGk6vPKrMQyPTpMDrONG-Q'));

      if (response.statusCode == 200) {
        // Analisar a resposta JSON e obter o título e a URL da thumbnail do vídeo
        Map<String, dynamic> videoData = jsonDecode(response.body);
        if (videoData['items'].isNotEmpty) {
          // Verificar se a lista não está vazia
          _videoTitle = videoData['items'][0]['snippet']['title'];
          _thumbnailUrl =
              videoData['items'][0]['snippet']['thumbnails']['high']['url'];
        } else {
          _videoTitle = 'Vídeo não encontrado';
        }
      } else {
        _videoTitle = 'Erro ao obter informações do vídeo';
      }
    } catch (e) {
      Text('Não foi possivel ter conexão');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          // Imagem em miniatura do vídeo
          _thumbnailUrl.isNotEmpty
              ? Column(
                  children: [
                    Image.network(
                      _thumbnailUrl,
                      width: 300, // Largura da imagem
                      height: 200, // Altura da imagem
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _videoTitle,
                        style: TextStyle(
                          fontSize: 17, // Tamanho da fonte
                          color: Colors.blue, // Cor do texto
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),

          // Adicionando um botão para visualização do vídeo na plataforma
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                if (await canLaunch(widget.link)) {
                  await launch(widget.link);
                } else {
                  throw 'Could not launch ${widget.link}';
                }
              },
              child: Text('Ver vídeo no YouTube'),
            ),
          ),
        ],
      ),
    );
  }
}

//! CHAVE API DO YOUTUBE: AIzaSyDXh0wul4agmQGk6vPKrMQyPTpMDrONG-Q