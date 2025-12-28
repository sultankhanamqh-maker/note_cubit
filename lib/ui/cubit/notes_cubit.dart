import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/Data/local/db_helper.dart';
import 'package:notes_cubit/Data/model/note_model.dart';
import 'package:notes_cubit/ui/cubit/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  DbHelper? dbHelper;

  NotesCubit({required this.dbHelper}) : super(NotesState(mNotes: []));

  List<NotesModel> _allNotes = [];

  fatchNotes() async {
    _allNotes = await dbHelper!.getNotes();
    emit(NotesState(mNotes: _allNotes));
  }

  addNotes({required NotesModel newNotes}) async {
    bool isAdded = await dbHelper!.addNotes(newNotes: newNotes);
    if (isAdded) {
      fatchNotes();
    }
  }

  updateNotes({required NotesModel newNotes,required int id})async{
    bool isUpdated =await  dbHelper!.updateNotes(newNotes: newNotes,id: id);
    if(isUpdated){
      fatchNotes();
    }
  }

  deleteNotes({required int id})async{
    bool isDeleted = await dbHelper!.deleteNotes(id: id);
    if(isDeleted){
      fatchNotes();
    }
  }
}
