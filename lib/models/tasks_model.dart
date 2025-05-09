class Task {
  final String id; // Optional: Firestore document ID
  final String name;
  final String description;
  final bool isCompleted;
  final bool isFavorite; // Optional: For favorite tasks

  Task({
    this.id = '', // default empty
    required this.name,
    required this.description,
    this.isCompleted = false,
    this.isFavorite = false, // default false
  });

  // Convert Task to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
    };
  }

  // Factory constructor to create Task from Firestore
  factory Task.fromMap(Map<String, dynamic> map, {String id = ''}) {
    return Task(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
