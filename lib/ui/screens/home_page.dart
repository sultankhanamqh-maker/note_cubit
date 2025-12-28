import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_cubit/Data/model/note_model.dart';
import 'package:notes_cubit/domain/app_constants.dart';
import 'package:notes_cubit/domain/app_routes.dart';
import 'package:notes_cubit/ui/cubit/notes_cubit.dart';
import 'package:notes_cubit/ui/cubit/notes_state.dart';

class HomePage extends StatelessWidget {
  DateFormat df = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    context.read<NotesCubit>().fatchNotes();
    return Scaffold(

        appBar: AppBar(
          title: Text("Notes"),
          centerTitle: true,
        ),
        body: BlocBuilder<NotesCubit, NotesState>(builder: (context, state) {
          return state.mNotes.isNotEmpty ? ListView.builder(
            itemCount: state.mNotes.length,
              itemBuilder: (context, index) {
              NotesModel eachNotes = state.mNotes[index];
                return Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.addNotePage, arguments: eachNotes);
                    },
                    title:Text(eachNotes.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eachNotes.desc),
                        Text(df.format(DateTime.fromMillisecondsSinceEpoch(eachNotes.createdAt)).toString()),
                      ],
                    ),
                    trailing: IconButton(onPressed: (){
                      context.read<NotesCubit>().deleteNotes(id: eachNotes.id!);
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                  ),
                );
              }) : Center(child: Text("No Notes Yet!"),);
        }),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, AppRoutes.addNotePage);
        },child: Icon(Icons.add),),

    );
  }


}