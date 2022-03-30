class TodoItem{
  final String header;
  final String description;

  TodoItem(
    this.header,
    this.description
  );

  TodoItem.fromMap(Map<String, dynamic> map):
    header = map['header'],
    description = map['description'];
  
  Map<String, dynamic> toJson(){
    return{
      'header': header,
      'description': description
    };
  }
}