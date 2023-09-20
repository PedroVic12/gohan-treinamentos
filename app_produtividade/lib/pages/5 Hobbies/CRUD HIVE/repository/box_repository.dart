import 'package:hive/hive.dart';

import '../models/note_model.dart';

class BoxRepository {
  static const String boxName = 'CRUD';

  static Future<void> openBox() async {
    await Hive.openBox<Note>(boxName);
  }

  static Box<Note> getBox() {
    return Hive.box<Note>(boxName);
  }

  static Future<void> closeBox() async {
    await Hive.close();
  }
}
