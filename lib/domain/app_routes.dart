import 'package:flutter/cupertino.dart';
import 'package:notes_cubit/ui/screens/add_note_page.dart';
import 'package:notes_cubit/ui/screens/home_page.dart';

class AppRoutes {

  static const String homePage = "/";
  static const String addNotePage = "add_notes";


  static Map<String , WidgetBuilder> routes = {
    homePage : (_) => HomePage(),
    addNotePage : (_) => AddNotesPage(),
  };




}