import 'package:app_produtividade/pages/Planner%20+%20Scrum/Views/Kanban/files_controller.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';

class PegandoArquivosPage extends StatefulWidget {
  const PegandoArquivosPage({Key? key}) : super(key: key);

  @override
  State<PegandoArquivosPage> createState() => _PegandoArquivosPageState();
}

class _PegandoArquivosPageState extends State<PegandoArquivosPage> {
  final controller = FilesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('minha app bar'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                //pegando o arquivo
                final result = await FilePicker.platform.pickFiles();

                if (result == null) return;

                //abrindo o arquivo
                final file_object = result.files.first;
                controller.abrirArquivo(file_object);
                controller.verDadosArquivo(file_object);
              },
              child: Text('Pegar um arquivo')),
          ElevatedButton(
              onPressed: () async {
                //pegando o arquivo
                var results;
                controller.lerVariosArquivos(results);

                return;

                //abrindo o arquivo
                final file_object = results.files.first;
                controller.abrirArquivo(file_object);
                controller.verDadosArquivo(file_object);
              },
              child: Text('Pegar varios arquivos'))
        ],
      ),
    );
  }
}
