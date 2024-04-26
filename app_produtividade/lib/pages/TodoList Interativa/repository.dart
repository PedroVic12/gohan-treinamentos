import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormSimples extends StatelessWidget {
  final Function(String)? onTap;
  final bool obscureText;
  final TextEditingController controlador;
  final String hintText;
  FormSimples(
      {super.key,
      this.onTap,
      required this.obscureText,
      required this.controlador,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: TextFormField(
        onChanged: onTap,
        obscureText: obscureText,
        autocorrect: true,
        controller: controlador,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, preencha este campo';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}

class Task {
  String titulo;
  bool completed;
  String categoria;
  Task(this.titulo, this.completed, this.categoria);
}

abstract class TodoRepository {
  getAll();
  insert();
  update(Task model);
  delete(int index);
}

class TodoListRepository {
  var items = [];
  var categorias = [
    "Estagio",
    "Frellancer",
    "Faculdade",
    "Iniciação Cientifica",
    "Projetos"
  ];

  fetchAll() async {
    items.add(Task("Ruby Express", false, categorias[1]));
    items.add(Task("Algoritimos Evolutivos", false, categorias[4]));
    items.add(Task("Camorim Manutenção DSA", false, categorias[0]));
    items.add(Task("Relatorios Usinagem", false, categorias[0]));

    return items;
  }
}
