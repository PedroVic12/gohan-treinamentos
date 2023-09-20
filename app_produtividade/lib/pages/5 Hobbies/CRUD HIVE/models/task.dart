import 'package:hive/hive.dart';
//flutter packages pub run build_runner build
part 'task.g.dart';


@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  //late List description; // Adicione o campo de descrição.

  Task(this.title); // Atualize o construtor.
}
