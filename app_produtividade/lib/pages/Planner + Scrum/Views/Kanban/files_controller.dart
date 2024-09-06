import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class FilesController {
  void abrirArquivo(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void lerArquivo(arquivo_selecionado) {
    arquivo_selecionado = FilePicker.platform.pickFiles();
    return arquivo_selecionado;
  }

  void lerVariosArquivos(arquivo_selecionado) async {
    arquivo_selecionado =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    return arquivo_selecionado;
  }

  void abrirVariosArquivos(List<PlatformFile> files) {
    //3:50

    //Navigator.of(context).push(MaterialPageRoute(
    //  builder: (context) => FilesPage(
    //      files: files,
    //    onOpnedFile: openFile,
    //)));
  }

  void verDadosArquivo(file) {
    print(file.bytes);
    print(file.size);
    print(file.extension);
    print(file.path);
  }

  Future salvarArquivoPermanente(PlatformFile file) async {
    //final appStorage = await getApplicationDocumentsDirectory();
    //final newFile = File('${appStorage.path}/${file.name}');

    //return File(file.path!).copy(newFile.path);
  }
}
