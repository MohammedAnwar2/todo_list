import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/controllers/NoteController.dart';
import 'package:todo_list/core/models/model.dart';
import 'package:todo_list/routes/appRoutes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateFormat _dateFormat = DateFormat('MMM dd , yyy');

  @override
  void initState() {
    super.initState();
    // Sqflite().MydeleteDatabase();
    TaskController.instance
        .fetchTasks(); //عند التوجه الى هذه الصفحة بيتم جلب البانات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoute.AddNote);
          },
          child: Icon(Icons.add)),
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 30.h),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Notes',
                    style: GoogleFonts.aBeeZee(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold)),
                Obx(() {
                  return Text(
                      '${TaskController.instance.completedTasks} - ${TaskController.instance.tasks.length}',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold));
                }),
              ],
            ),
            Obx(() {
              return TaskController.instance.tasks.isNotEmpty?ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: TaskController.instance.tasks.length,
                itemBuilder: (context, index) {
                  Note task = TaskController.instance.tasks[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          task.title.toString(),
                        ),
                        subtitle: Text(
                          "${_dateFormat.format(task.date!)} - ${task.priority}",
                          style: GoogleFonts.aBeeZee(
                              decoration: task.status == 1
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color:
                                  task.status == 1 ? Colors.red : Colors.black,
                              fontSize: 10),
                        ),
                        trailing: Checkbox(
                            value: task.status == 1 ? true : false,
                            onChanged: (value) {
                              value == true ? task.status = 1 : task.status = 0;
                              TaskController.instance.updateTask(task);
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.black),
                        onTap: () {
                          Get.toNamed(AppRoute.EditNote, arguments: task);
                        },
                      ),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  );
                },
              ):Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
              child: Center(child: Text("There is no tasks",style: GoogleFonts.aBeeZee(fontSize: 20.sp)),),
              );
            })
          ],
        ),
      ),
    );
  }
}
