import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/screens/task_details_screen.dart';
import 'package:tm/services/task_service.dart';

class CompletedTasksscreen extends StatelessWidget {
  final List<Task> completedTasks;
  const CompletedTasksscreen({
    super.key,
    required this.completedTasks,});

  @override
  Widget build(BuildContext context) {

    final TaskService taskService = TaskService();
    final Stream<List<Map<String, dynamic>>> tasksStream = taskService.getCompletedTasks();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TaskListView(
          taskStream: tasksStream,
        ),
      ),
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
                      name: task['name'],
                      description: task['description'],
                      isCompleted: !(task['isCompleted'] ?? false),
                      isFavorite: task['isFavorite'],
                    );
                    TaskService().updateTask(task['id'], updatedTask);
                  }),
                trailing: IconButton(
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
              ),
            );
          },
        );
      },
    );
  }
}