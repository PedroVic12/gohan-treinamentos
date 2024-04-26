import 'package:app_produtividade/pages/TodoList%20Interativa/repository.dart';
import 'package:flutter/material.dart';

class TodoListController implements TodoRepository {
  var repository = TodoListRepository();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  get repo => repository;

  @override
  delete(int index) {
    repository.items.removeAt(index);
  }

  @override
  getAll() {
    return repository.fetchAll();
  }

  @override
  insert() async {
    repository.items.add(Task(_controller1.text, false, _controller2.text));

    _controller1.clear();
    _controller2.clear();
  }

  @override
  update(Task model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  showCadastroDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Preencha os campos para:'),
            content: Form(
              key: _formKey,
              child: ListView(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  FormSimples(
                      obscureText: false,
                      controlador: _controller1,
                      hintText: "NOME"),
                  FormSimples(
                      obscureText: false,
                      controlador: _controller2,
                      hintText: "PRECO"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("salvando...");
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Salvar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
            ],
          );
        });
  }
}
