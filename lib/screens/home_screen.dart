import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/screens/task_details_screen.dart';
import 'package:tm/services/task_service.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({
    super.key,
    });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    final Stream<List<Map<String, dynamic>>> tasksStream = taskService.getTasks();


    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16.0),
        child: TaskListView(
          taskStream: tasksStream,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add task action
          addTask(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }




  Future<dynamic> addTask(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    // TextEditingController duedateController = TextEditingController();
    final TaskService taskService = TaskService();

    final userId = FirebaseAuth.instance.currentUser?.uid;

    return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(hintText: 'Task Name'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(hintText: 'Task Description'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () async {
                      // Add your add action here
                      Task newTask = Task(
                        userId: userId!,
                        name: nameController.text,
                        description: descriptionController.text,
                      );
                      try {
                        await taskService.addTask(newTask);
                        print(newTask.toMap());
                        Navigator.of(context).pop(); // Close the dialog
                      } catch (e) {
                        // Handle error
                        print('Error adding task: $e');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
  }
}



class TaskListView extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> taskStream;

  const TaskListView({super.key, required this.taskStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: taskStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return const Center(child: Text('No tasks available.'));
        }

        final userId = FirebaseAuth.instance.currentUser?.uid;

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(task['name'] ?? 'No name'),
                subtitle: Text(task['description'] ?? 'No description'),
                leading: IconButton(
                  icon: Icon(
                    task['isCompleted'] ?? false ? Icons.check_circle : Icons.circle,
                    color: (task['isCompleted'] ?? false) ? Colors.green : Colors.grey,
                  ),
                  color: (task['isCompleted'] ?? false) ? Colors.green : Colors.grey,
                  onPressed: () {
                    // Handle task completion toggle
                    Task updatedTask = Task(
                      userId: userId!,
                      name: task['name'],
                      description: task['description'],
                      isCompleted: !(task['isCompleted'] ?? false),
                      isFavorite: task['isFavorite'],
                    );
                    TaskService().updateTask(task['id'], updatedTask);
                  }),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: task['isFavorite'] ?? false ? Colors.red : Colors.grey,
                      onPressed: () {
                        // Handle task favorite toggle
                        Task updatedTask = Task(
                          userId: userId!,
                          name: task['name'],
                          description: task['description'],
                          isFavorite: !(task['isFavorite']),
                          isCompleted: task['isCompleted'],
                        );
                        TaskService().updateTask(task['id'], updatedTask);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        print('TaskDetail: $task');
                        showDialog(context: context, builder: (context) {
                          return TaskDetailsScreen(
                            name: task['name'] ?? 'No name',
                            description: task['description'] ?? 'No description',
                            task: task,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}




