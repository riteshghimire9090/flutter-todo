class Todo {
  int id;
  String note;

  Todo({this.id, this.note});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    print("id:$id \n note:$note");
    print(json.toString());
  }

  // Todo.toJson(Map<String, dynamic> data = new Map<String , dynamic>() {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['note'] = note;
    return data;
  }
}
