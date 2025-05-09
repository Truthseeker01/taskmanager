import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/services/task_service.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Task> favoriteTasks;
  const FavoritesScreen({
    super.key,
    required this.favoriteTasks,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TaskListView(
          taskStream: TaskService().getFavoriteTasks(),
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
                  trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Add your delete action here
                        TaskService().deleteTask(task['id']);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      onPressed: () {
                        // Add your delete action here
                        Task updatedTask = Task(
                          name: task['name'],
                          description: task['description'],
                          isCompleted: task['isCompleted'],
                          isFavorite: false, // Set to false to remove from favorites
                        );
                        TaskService().updateTask(task['id'], updatedTask);
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