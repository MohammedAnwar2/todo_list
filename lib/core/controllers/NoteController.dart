import 'package:get/get.dart';
import 'package:todo_list/core/models/model.dart';
import 'package:todo_list/database/Tables.dart';
import 'package:todo_list/database/configrations.dart';

class TaskController extends GetxController {
  static TaskController instance = Get.find();
  final RxList<Note> tasks = <Note>[].obs;
  Sqflite sq = Sqflite();
  RxInt completedTasks=0.obs;

  Future<void> fetchTasks() async {
    final List<Map<String, dynamic>> taskMaps = await sq.readData(table: NoteTable.noteTable);
    tasks.value=taskMaps.map((data) => Note.fromMap(data)).toList();
    print("---------------fetchTasks-------------");
    print(taskMaps);
    completedTasks.value=tasks.where((note) => note.status==1).toList().length;
  }

  Future<void> addTask(Note task) async {
    var response = await sq.insertData(table: NoteTable.noteTable,values: task.toMap());//add data to database
    print("addTask done------------->$response");
    fetchTasks();//reset the tasks
  }

  Future<void> updateTask(Note task) async {
    int response =await sq.updateData(table: NoteTable.noteTable,values: task.toMap(),my_where: "`${NoteTable.col_id}`=${task.id} ");//update data to database
    print("updateTask done------------->$response");
    fetchTasks();//reset the tasks
  }

  Future<void> deleteTask(Note task) async {
    int response = await sq.deleteData(table: NoteTable.noteTable,my_where:"`${NoteTable.col_id}`=${task.id}");//delete data to database
    print("deleteTask done------------->$response");
    fetchTasks();//reset the tasks
  }

}