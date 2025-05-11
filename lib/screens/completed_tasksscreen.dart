import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/screens/task_details_screen.dart';
import 'package:tm/services/task_service.dart';
import 'package:marquee/marquee.dart';

class CompletedTasksscreen extends StatelessWidget {
  const CompletedTasksscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskService taskService = TaskService();
    final Stream<List<Map<String, dynamic>>> tasksStream =
        taskService.getCompletedTasks();

    final Color primaryColor = Color(0xFF00695c);
    final Color secondaryColor = Color(0xFFFFFFFF);
    final Color teritaoryColor = Color(0xFF212121);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Divider(thickness: 1),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(color: Colors.transparent),
              child: Marquee(
                text:
                    'You\'re doing great! Keep it up                             ',
                style: TextStyle(
                  color: teritaoryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.ltr,
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 25,
                velocity: 100,
                pauseAfterRound: Duration(seconds: 2),
                startPadding: 10,
                accelerationCurve: Curves.linear,
                accelerationDuration: Duration(seconds: 1),
                decelerationCurve: Curves.easeOut,
                decelerationDuration: Duration(seconds: 1),
              ),
            ),
            const Divider(thickness: 1),
            Expanded(
              child: TaskListView(
                taskStream: tasksStream,
                primaryColor: primaryColor,
                teritaoryColor: teritaoryColor,
                secondaryColor: secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final Stream<List<Map<String, dynamic>>> taskStream;
  final Color primaryColor;
  final Color teritaoryColor;
  final Color secondaryColor;

  const TaskListView({
    super.key,
    required this.taskStream,
    required this.primaryColor,
    required this.secondaryColor,
    required this.teritaoryColor,
  });

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
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [teritaoryColor, primaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Card(
                    color: Colors.transparent,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      textColor: secondaryColor,
                      title:
                          task['name'] != ''
                              ? Text(
                                task['name'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: secondaryColor,
                                ),
                              )
                              : Text('No Name'),
                      subtitle: Text(
                        task['description'] ?? 'No description',
                        style: TextStyle(color: secondaryColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Icon(
                        Icons.work,
                        size: 50,
                        color: secondaryColor,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: secondaryColor,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => confirmDelete(
                                      context,
                                      task,
                                      primaryColor,
                                      teritaoryColor,
                                      secondaryColor,
                                    ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.settings_backup_restore_sharp,
                              color: secondaryColor,
                            ),
                            // color: Colors.white,
                            onPressed: () {
                              Task updatedTask = Task(
                                userId: userId!,
                                name: task['name'],
                                description: task['description'],
                                isCompleted: !(task['isCompleted'] ?? false),
                                isFavorite: task['isFavorite'],
                              );
                              TaskService().updateTask(task['id'], updatedTask);
                            },
                          ),
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
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Dialog confirmDelete(
  BuildContext context,
  Map<String, dynamic> task,
  Color primaryColor,
  Color teritaoryColor,
  Color secondaryColor,
) {
  return Dialog(
    backgroundColor: primaryColor,
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [teritaoryColor, primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text(
              'Delete this task permenentally?',
              style: TextStyle(color: secondaryColor, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('No', style: TextStyle(color: secondaryColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Yes', style: TextStyle(color: secondaryColor)),
                  onPressed: () {
                    TaskService().deleteTask(task['id']);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    ),
  );
}
