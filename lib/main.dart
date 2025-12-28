import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/Data/local/db_helper.dart';
import 'package:notes_cubit/domain/app_routes.dart';
import 'package:notes_cubit/ui/cubit/notes_cubit.dart';
import 'package:notes_cubit/ui/screens/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => NotesCubit(dbHelper: DbHelper.instance),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homePage,
      routes: AppRoutes.routes,
    );
  }
}
