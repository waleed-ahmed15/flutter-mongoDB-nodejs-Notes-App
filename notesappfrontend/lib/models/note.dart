class Note {
  String? id;
  String? userId;
  String? title;
  String? content;
  DateTime? dateAdded;

  Note({this.id, this.userId, this.title, this.content, this.dateAdded});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    content = json['content'];
    dateAdded = DateTime.tryParse(json['dateAdded']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['content'] = content;
    data['dateAdded'] = dateAdded!.toIso8601String();
    return data;
  }
}
