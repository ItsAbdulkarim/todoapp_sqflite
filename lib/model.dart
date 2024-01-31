class Student {
 late int? id;
  late String title;
 late String description;

  Student({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
