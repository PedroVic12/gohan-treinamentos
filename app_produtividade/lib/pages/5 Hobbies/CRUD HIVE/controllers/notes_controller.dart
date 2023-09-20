import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/note_model.dart';
import '../repository/box_repository.dart';

class NotesController extends GetxController {
  final Box<Note> _observableBox = BoxRepository.getBox();

  Box<Note> get observableBox => _observableBox;

  int get notesCount => _observableBox.length;

  Future<void> adicionarNota({required Note note}) async {
    await _observableBox.add(note);
    print('Nota criada');
    update();
  }

  Future<void> atualizarNota(int index, Note note) async {
    await _observableBox.putAt(index, note);
    print('Nota atualizada');
    update();
  }

  Future<void> deleteNote(int index) async {
    await _observableBox.deleteAt(index);
    print('Nota deletada');
    update();
  }
}
