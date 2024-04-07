
import 'package:flutter/material.dart';




//! app/(public)
class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
    final actions = TodoAction();    

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  void initState(){
    super.initState();
    actions.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
      children:[
        counter(),
        TodoContainer()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget counter()
  {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      );
  }
  
  Widget TodoContainer()
  {
    
    final actions = TodoAction();    
    void editTodoDialog([TodoModel? model]){
      model ??= TodoModel(id:-1,titulo: "", check: false);
      
      showDialog(
      context: context,
        builder: (context){
          return AlertDialog(
          title: const Text("Editar tarefa"),
            content: TextFormField(
            initialValue: model?.titulo,
            onChanged:(value){
              model = model!.copyWith(titulo: value);
            }
            ),
            
            actions: [
              TextButton(
              
              onPressed: (
              ){},
                
               child: const Text("Cancelar")
                ),
              
              TextButton(
              
              onPressed: (
              ){
                actions.add(model!);
              },
                
               child: const Text("Salvar")
                )
            ],
            
          );
        }
      );
    }
    
    return RxBuilder(builder: (_) {
      final todos = todoState.value;
      
      return ListView.builder(
      
      itemCount: todos.lenght,
        itemBuilder: (_,index){
          final tarefa = todos[index];
          return CheckboxListTile(
          value: tarefa.check,
            onChanged: (value) {}
            
          );
        }
      );
    });
  }  
  }


//!app/interecator/models

class TodoModel{
  final int id;
  final String titulo;
  final bool check;
  
  TodoModel({required this.id, required this.titulo, required this.check});
  
  TodoModel copyWith({
    int? id,
    String? titulo,
    bool? check
  })
  {
    return TodoModel(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    check: check ?? this.check
    );
  }
  
}



//!app/interecator/todo_atom
// flutter pug add asp
final todoState = Atom<List<TodoModel>>([]);


//!app/interecator/actions

class TodoAction{
  var _autoIncriment = 4;
    final repository = TodoRepository();

  Future<void> fetchTodos() async {
    
  todoState.value = await repository.getAll();
    

    
   
}
  
  Future<void> putTodo(TodoModel model) async {
     if(model.id == -1){
       await repository.inserir(model);
     } else{
       await repository.update(model);
     }
    
    fetchTodos();
  }
  
  
  
Future<void> add(TodoModel model) async {
  if (model.id == -1){
    _autoIncriment++;
    todoState.value = [
      ...todoState.value,
      model.copyWith(id: _autoIncriment)
    ];
  } else {
    final index= todoState.value.indexWhere(
      (e) => e.id == model.id);
    
    todoState.value[index] = model;
    todoState();
  }
}
Future<void> delete(int id) async {
  todoState.value = todoState.value.where((e)) => e.id != id).toList();
  
  await repository.delete(id);
}

}









//!app/repositorys
abstract class TodoRepository {
  Future<List<TodoModel>> getAll();
  Future<TodoModel> inserir(TodoModel model);
  
  Future<TodoModel> update(TodoModel model);
  
  Future<bool> delete(int id);

  

}


class BancoDeDados implements TodoRepository{
  
  late db;
  
  Future<List<TodoModel>> getAll()
  {
    todoState.value = [
    
    ];
  }   
  
  
    Future<TodoModel> inserir(TodoModel model);
  
  Future<TodoModel> update(TodoModel model);
  
  Future<bool> delete(int id);
}

void registerIntances(){
  var banco = BancoDeDados();
  final actions = TodoAction();    

}



