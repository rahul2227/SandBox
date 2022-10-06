import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sandbox/ToDo/data/database.dart';
import 'package:sandbox/ToDo/utils/dialog_box.dart';
import 'package:sandbox/ToDo/utils/todoListTile.dart';

class ToDoMain extends StatefulWidget {
  const ToDoMain({super.key});

  @override
  State<ToDoMain> createState() => _ToDoMainState();
}

class _ToDoMainState extends State<ToDoMain> {
  // reference the box
  final _myBox = Hive.box('mybox');
  // Text Editing Conteoller
  final TextEditingController _controller = TextEditingController();
  // demo data for to do list
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time opening the app then create a default data
    if (_myBox.get("DEMOLIST") == null) {
      db.createInitialData();
    } else {
      //the data already exists
      db.loadData();
    }
    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.demoTile[index][1] = !db.demoTile[index][1];
    });
    db.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.demoTile.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  //deleteTask
  void deleteTask(int index) {
    setState(() {
      db.demoTile.removeAt(index);
    });
    db.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: ((context) {
        return DialogBox(
          controller: _controller,
          saveButtonPressed: saveNewTask,
          cancelButtonPressed: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do Application"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.demoTile.length,
        itemBuilder: (context, index) {
          return ToDoListTile(
            taskName: db.demoTile[index][0],
            taskCompleted: db.demoTile[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
