class Task {
  final String id;
  final String userId; 
  final String name;
  final String description;
  final bool isCompleted;
  final bool isFavorite; 

  Task({
    this.id = '',
    required this.userId,
    required this.name,
    required this.description,
    this.isCompleted = false,
    this.isFavorite = false, 
  });

  // Convert Task to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'description': description,
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
    };
  }

  // Factory constructor to create Task from Firestore
  factory Task.fromMap(Map<String, dynamic> map, {String id = ''}) {
    return Task(
      id: id,
      userId: map['userId'] ?? '', 
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
