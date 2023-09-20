import 'package:hive/hive.dart';

//part 'notes.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? note;

  Note({required this.title, required this.note});
}
