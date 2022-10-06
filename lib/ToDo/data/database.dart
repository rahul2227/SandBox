import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List demoTile = [];
  // reference the box
  final _mybox = Hive.box('mybox');

  // first time ever opening this app.
  void createInitialData() {
    demoTile = [
      ["Make tutorial", false],
      ["Do Exercise", false],
    ];
  }

  // load the database
  void loadData() {
    demoTile = _mybox.get("DEMOLIST");
  }

  // update the database
  void updateDatabase() {
    _mybox.put("DemoList", demoTile);
  }
}
