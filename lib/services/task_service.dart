import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tm/models/tasks_model.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;


class TaskService {
  final CollectionReference _taskCollection = firestore.collection('tasks');

  Future<void> addTask(Task taskData) async {
    try {
      DocumentReference docRef = await _taskCollection.add(taskData.toMap());
      await docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception("Error adding task: $e");
    }
  }

  Future<void> updateTask(String taskId, Task taskData) async {
    try {
      await _taskCollection.doc(taskId).update(taskData.toMap());
    } catch (e) {
      throw Exception("Error updating task: $e");
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _taskCollection.doc(taskId).delete();
    } catch (e) {
      throw Exception("Error deleting task: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> getTasks() {
    return _taskCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }

  Stream<List<Map<String, dynamic>>> getCompletedTasks() {
    return _taskCollection
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
  Stream<List<Map<String, dynamic>>> getFavoriteTasks() {
    return _taskCollection
        .where('isFavorite', isEqualTo: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}