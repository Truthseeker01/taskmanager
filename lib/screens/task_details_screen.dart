import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/services/task_service.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  // final String duedate;
  final Map<String, dynamic> task;
  const TaskDetailsScreen({
    super.key,
    required this.name,
    required this.description,
    required this.task,
    // required this.duedate,
    });

  
  

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {

  final TaskService taskService = TaskService();

  var _isEditing = false;
  @override
  Widget build(BuildContext context) {

    void _toggleEdit() {
      setState(() {
        _isEditing = !_isEditing;
      });
    }

    return _isEditing ? editScreen(context, _toggleEdit, widget.task) : taskDetails(context, _toggleEdit);
  }

  AlertDialog taskDetails(BuildContext context, onTap) {
    return AlertDialog(
    title: const Text('Task Details'),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text(widget.name),
          SizedBox(height: 10),
          Text(widget.description),
          SizedBox(height: 10),
          // Text(widget.duedate),
        ],
      ),
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: const Text('Edit'),
            onPressed: () {
              onTap();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              taskService.deleteTask(widget.task['id'].toString());
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ],
  );
  }
}

AlertDialog editScreen (BuildContext context, onTap, task) {

    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    // TextEditingController duedateController = TextEditingController();
    final TaskService taskService = TaskService();

    return AlertDialog(
      title: const Text('Edit Task'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('Save'),
              onPressed:() async{
                Task updatedTask = Task(
                  name: nameController.text,
                  description: descriptionController.text,
                  // duedate: duedateController.text,
                );
                try {
                  await taskService.updateTask(task['id'].toString(), updatedTask);
                  print(updatedTask.toMap());
                } catch (e) {
                  // Handle error
                  print('Error updating task: $e');
                }

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                onTap();
              },
            ),
          ],
        ),
      ],
    );
}
