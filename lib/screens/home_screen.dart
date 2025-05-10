import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/screens/task_details_screen.dart';
import 'package:tm/services/task_service.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final Stream<List<Map<String, dynamic>>> tasksStream = taskService.getTasks();


    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth * 0.4,
                  child: Text(
                    'Welcome, ${FirebaseAuth.instance.currentUser?.email?.split('@').first ?? 'User'}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
                StreamBuilder<List<Map<String, dynamic>>>(
                        stream: tasksStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final recentTasks = snapshot.data!.take(3).toList();
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: recentTasks.map((task) {
                                  return Container(
                                    margin: const EdgeInsets.all(10.0),
                                    padding: const EdgeInsets.all(30.0),
                                    width: screenWidth * 0.3,
                                    height: screenWidth * 0.3,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, const Color.fromARGB(255, 40, 255, 255)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          task['name'] != '' ?
                                          Text(
                                             task['name'],
                                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ) : Text('No Name'),
                                          const SizedBox(height: 4.0),
                                          task['description'] != '' ?
                                          Text(
                                            task['description'],
                                            style: TextStyle(color: Colors.white70, fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ) : Text('No Decription')
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const Text('Loading...');
                          }
                        },
                      ),
            const SizedBox(height: 10),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            const Text(
              'All Tasks',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TaskListView(
                taskStream: tasksStream,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          addTask(context);
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }




  Future<dynamic> addTask(BuildContext context) {

    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
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
                      Task newTask = Task(
                        userId: userId!,
                        name: nameController.text,
                        description: descriptionController.text,
                      );
                      try {
                        await taskService.addTask(newTask);
                        print(newTask.toMap());
                        Navigator.of(context).pop(); 
                      } catch (e) {
                        print('Error adding task: $e');
                      }
                    },
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
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
            return GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (context) {
                            return TaskDetailsScreen(
                              name: task['name'] ?? 'No name',
                              description: task['description'] ?? 'No description',
                              task: task,
                            );
                          });
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue, Colors.blueAccent], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    textColor: Colors.white,
                    title: task['name'] != null && task['name'] != '' ? Text(task['name'], overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)) : Text('No Name'),
                    subtitle: Text(task['description'] ?? 'No description', overflow: TextOverflow.ellipsis,),
                    leading: Icon(Icons.work, size: 50, color: Colors.blue,),
                    trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.favorite),
                      //   color: task['isFavorite'] ?? false ? Colors.red : Colors.grey,
                      //   onPressed: () {
                      //     Task updatedTask = Task(
                      //       userId: userId!,
                      //       name: task['name'],
                      //       description: task['description'],
                      //       isFavorite: !(task['isFavorite']),
                      //       isCompleted: task['isCompleted'],
                      //     );
                      //     TaskService().updateTask(task['id'], updatedTask);
                      //   },
                      // ),
                    IconButton(
                    icon: Icon(
                      task['isCompleted'] ?? false ? Icons.check_box : Icons.check_box_outline_blank,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Task updatedTask = Task(
                        userId: userId!,
                        name: task['name'],
                        description: task['description'],
                        isCompleted: !(task['isCompleted'] ?? false),
                        isFavorite: task['isFavorite'],
                      );
                      TaskService().updateTask(task['id'], updatedTask);
                      }),
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios),
                      //   onPressed: () {
                      //     print('TaskDetail: $task');
                      //     showDialog(context: context, builder: (context) {
                      //       return TaskDetailsScreen(
                      //         name: task['name'] ?? 'No name',
                      //         description: task['description'] ?? 'No description',
                      //         task: task,
                      //       );
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            )
            );
          },
        );
      },
    );
  }
}




