import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NotesController controller = Get.put(NotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: GetBuilder<NotesController>(
        builder: (contador) {
          return ListView.builder(
            itemCount: contador.notesCount,
            itemBuilder: ((context, index) {
              Note? note = contador.observableBox.getAt(index);

              return Card(
                child: ListTile(
                  title: Text(note?.title ?? "N/A"),
                  subtitle: Text(note?.note ?? 'blank'),
                  leading: IconButton(
                    onPressed: () {
                      _editarNota(index);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      contador.deleteNote(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _editarNota(-1); // -1 indica uma nova nota
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _editarNota(int index) {
    Get.dialog(
      EditarNotas(
        index: index,
        onSave: (note) async {
          if (index == -1) {
            await controller.adicionarNota(note: note);
          } else {
            await controller.atualizarNota(index, note);
          }
          Get.back();
        },
      ),
    );
  }
}

class EditarNotas extends StatefulWidget {
  final int index;
  final Function(Note) onSave;

  EditarNotas({Key? key, required this.index, required this.onSave})
      : super(key: key);

  @override
  State<EditarNotas> createState() => _EditarNotasState();
}

class _EditarNotasState extends State<EditarNotas> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    noteController = TextEditingController();

    if (widget.index >= 0) {
      // Editando uma nota existente
      Note? note =
          Get.find<NotesController>().observableBox.getAt(widget.index);
      titleController.text = note.title ?? '';
      noteController.text = note.note ?? '';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.index == -1 ? 'Nova Nota' : 'Editar Nota'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: 'Título'),
              controller: titleController,
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um título';
                }
                return null;
              }),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Nota'),
              controller: noteController,
              maxLines: 10,
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma nota';
                }
                return null;
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.onSave(
                Note(
                  title: titleController.text,
                  note: noteController.text,
                ),
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
