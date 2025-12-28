import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/Data/model/note_model.dart';
import 'package:notes_cubit/domain/app_constants.dart';
import 'package:notes_cubit/ui/cubit/notes_cubit.dart';

class AddNotesPage extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  NotesModel? notes;
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    notes = ModalRoute.of(context)!.settings.arguments as NotesModel?;
    if (notes != null) {
      titleController.text = notes!.title;
      descController.text = notes!.desc;
      isUpdate = true;
    }
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  InkWell(
                    onTap: () {
                      if (isUpdate) {
                        context.read<NotesCubit>().updateNotes(
                          newNotes: NotesModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch
                          ), id: notes!.id!,
                        );
                      }
                      else{
                        context.read<NotesCubit>().addNotes(
                          newNotes: NotesModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                          ),
                        );
                      }
                      Navigator.pop(context);

                    },
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text("Save")),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: titleController,
                decoration: myDecor(hint: "Enter your title ", label: "Title"),
              ),
              SizedBox(height: 11),
              Expanded(
                child: TextField(
                  maxLines: 4,
                  controller: descController,
                  decoration: myDecor(
                    hint: "Enter your desc ",
                    label: "Description",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration myDecor({required String hint, required String label}) {
    return InputDecoration(
      alignLabelWithHint: true,
      hintText: hint,
      labelText: label,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
