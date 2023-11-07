class Note{
  int?id;
  String?title;
  DateTime?date;
  String?priority;
  int?status;
  Note({this.id,this.title,this.date,this.priority,this.status,});

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'date':date?.toIso8601String(),
      'priority':priority,
      'status':status,
    };
  }
  Note.fromMap(Map<String, dynamic> task){
    id =  task['id'];
    title = task['title'];
    date = DateTime.parse(task['date']);//convert to String
    priority = task['priority'];
    status = task['status'];
  }
}