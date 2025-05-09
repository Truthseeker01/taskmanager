import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';
import 'package:tm/services/task_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final TaskService taskService = TaskService();
  final Stream<List<Map<String, dynamic>>> tasksStream = TaskService().getTasks();
  final Stream<List<Map<String, dynamic>>> completedTasksStream = TaskService().getCompletedTasks();
  final Stream<List<Map<String, dynamic>>> favoriteTasksStream = TaskService().getFavoriteTasks();

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: Text(currentUser != null && currentUser.email != null ? currentUser.email!.split('@').first : 'A'),
              ),
              const SizedBox(height: 20),
              Text(
                currentUser != null && currentUser.email != null ? currentUser.email!.split('@').first : 'User',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Incompleted Tasks
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: tasksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final incompleted = snapshot.data!.where((task) => task['isCompleted'] == false).length;
                    return Text(
                      'Incompleted Tasks: $incompleted',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    );
                  } else {
                    return const Text('Incompleted Tasks: ...');
                  }
                },
              ),
              const SizedBox(height: 10),

              // Completed Tasks
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: completedTasksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Completed Tasks: ${snapshot.data!.length}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    );
                  } else {
                    return const Text('Completed Tasks: ...');
                  }
                },
              ),
              const SizedBox(height: 10),

              // Favorite Tasks
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: favoriteTasksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Favorite Tasks: ${snapshot.data!.length}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    );
                  } else {
                    return const Text('Favorite Tasks: ...');
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
