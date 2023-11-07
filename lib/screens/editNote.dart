import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/core/controllers/NoteController.dart';
import 'package:todo_list/core/models/model.dart';
import 'package:todo_list/routes/appRoutes.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key});
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController dataController = TextEditingController();
  String proiorty = "Low";
  DateTime currentTime = DateTime.now();
  final DateFormat _dateFormat = DateFormat('MMM dd , yyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];
  Note ?task;
  _handleDataPicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: currentTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: "Select Date",
    );
    if (date != null && date != currentTime) {
      setState(() {
        currentTime = date;
      });
      dataController.text = _dateFormat.format(date);
    }
  }



  @override
  void initState() {
    super.initState();
    task=Get.arguments;
    title.text=task!.title!;
    dataController.text=_dateFormat.format(task!.date!);
    proiorty=task!.priority!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {
              TaskController.instance.deleteTask(task!);
              Get.offAllNamed(AppRoute.HomePage);
        }, icon: const Icon(Icons.delete))
      ],),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Note',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: title,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        label: Text("Title"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      readOnly: true,
                      style: GoogleFonts.aBeeZee(color: Colors.black),
                      controller: dataController,
                      decoration: const InputDecoration(
                        label: Text("Data"),
                        border: OutlineInputBorder(),
                      ),
                      onTap: _handleDataPicker,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 60.h,
                      child: DropdownButtonFormField(
                        items: _priorities.map((label) => DropdownMenuItem(
                          child: Text(label.toString(),style: GoogleFonts.aBeeZee(color: Colors.black)),
                          value: label,
                        )).toList(),
                        hint: const Text('Rating'),
                        onChanged: (value) {
                          setState(() {
                            proiorty = value.toString();
                          });
                        },
                        value: proiorty,
                        style: GoogleFonts.aBeeZee(fontSize: 16.sp,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Priority",
                            floatingLabelBehavior:FloatingLabelBehavior.always ,
                            floatingLabelStyle: const TextStyle(fontSize: 15,),
                            floatingLabelAlignment: FloatingLabelAlignment.start,
                            labelStyle: TextStyle(fontSize: 18.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  task = Note(title: title.text,date:currentTime, status: task?.status,priority: proiorty,id: task?.id);
                  TaskController.instance.updateTask(task!);
                  Get.offAllNamed(AppRoute.HomePage);
                },
                child: Text("Edit Note",
                    style: GoogleFonts.aBeeZee(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
