import 'package:flutter/material.dart';
import 'package:todo_app/utilities/dialog_box.dart';
import 'package:todo_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List activities = [
    ["Clean the house", false],
    ["Clean the house1", false],
    ["Clean the house2", false],
    ["Clean the house3", false],
  ];
  void checkBoxChanged (bool? value, int index) {
    setState(() {
      activities[index][1] = !activities[index][1];
    });
  }
  void saveNewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        activities.add([_controller.text, false]);
        _controller.clear();
      });
    }
    Navigator.of(context).pop();
  }
  void cancelTask() {
    _controller.clear();
    Navigator.of(context).pop();
  }

  
  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogBox(controller: _controller, onSave: saveNewTask, onCancel: cancelTask,);
    });
  }

  void deleteTask(int index) {
    activities.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("To do"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: activities[index][0],
            taskCompleted: activities[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deleteTask(index),
          );
        },
      )
    );
  }
}