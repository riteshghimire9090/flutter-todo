class Todo {
  var id;
  String note;
  String color;

  Todo({this.id, this.note, this.color = "0xffffff"});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    color = json['color'];
    print("id:$id \n note:$note");
    print(json.toString());
  }

  // Todo.toJson(Map<String, dynamic> data = new Map<String , dynamic>() {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['note'] = note;
    data['color'] = color;
    return data;
  }
}
