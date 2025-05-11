import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/services/task_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final TaskService taskService = TaskService();
  final Stream<List<Map<String, dynamic>>> tasksStream =
      TaskService().getTasks();
  final Stream<List<Map<String, dynamic>>> completedTasksStream =
      TaskService().getCompletedTasks();
  final Stream<List<Map<String, dynamic>>> favoriteTasksStream =
      TaskService().getFavoriteTasks();

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    final Color primaryColor = Color(0xFF00695c);
    final Color secondaryColor = Color(0xFFFFFFFF);
    final Color teritaoryColor = Color(0xFF212121);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 100,
                child: Text(
                  currentUser != null && currentUser.email != null
                      ? currentUser.email!.split('@').first
                      : 'A',
                  style: TextStyle(color: secondaryColor),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                currentUser != null && currentUser.email != null
                    ? currentUser.email!.split('@').first
                    : 'User',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: teritaoryColor,
                ),
              ),
              const SizedBox(height: 10),

              // Incompleted Tasks
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: tasksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final incompleted =
                        snapshot.data!
                            .where((task) => task['isCompleted'] == false)
                            .length;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [teritaoryColor, primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Incompleted Tasks: $incompleted',
                        style: TextStyle(fontSize: 18, color: secondaryColor),
                      ),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [teritaoryColor, primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Text('Incompleted Tasks: ...')
                      );
                  }
                },
              ),
              const SizedBox(height: 10),

              // Completed Tasks
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: completedTasksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [teritaoryColor, primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Completed Tasks: ${snapshot.data!.length}',
                        style: TextStyle(
                          fontSize: 18,
                          color: secondaryColor,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [teritaoryColor, primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Text('Completed Tasks: ...')
                      );
                  }
                },
              ),
              const SizedBox(height: 10),

              // Favorite Tasks
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: favoriteTasksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [teritaoryColor, primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Favorite Tasks: ${snapshot.data!.length}',
                        style: TextStyle(fontSize: 18, color: secondaryColor),
                      ),
                    );
                  } else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [teritaoryColor, primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Text('Favorite Tasks: ...')
                      );
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
