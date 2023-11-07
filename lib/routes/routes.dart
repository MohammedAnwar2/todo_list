import 'package:get/get.dart';
import 'package:todo_list/routes/appRoutes.dart';
import 'package:todo_list/screens/HomePage.dart';
import 'package:todo_list/screens/addNote.dart';
import 'package:todo_list/screens/editNote.dart';

List<GetPage<dynamic>> route = [
  GetPage(name: AppRoute.HomePage ,page: () => HomePage()),
  GetPage(name: AppRoute.AddNote ,page: () => AddNote()),
  GetPage(name: AppRoute.EditNote ,page: () => EditNote()),

];