import 'package:notes_cubit/domain/app_constants.dart';

class NotesModel {
  int? id;
  String title;
  String desc;
  int createdAt;

  NotesModel({
    this.id,
    required this.title,
    required this.desc,
    required this.createdAt,
  });

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map[AppConstants.notesId],
      title: map[AppConstants.notesTitle],
      desc: map[AppConstants.notesDesc],
      createdAt: map[AppConstants.notesCreatedAt] != null
          ? int.tryParse(map[AppConstants.notesCreatedAt].toString()) ?? DateTime.now().millisecondsSinceEpoch
          : DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String ,dynamic> toMap(){
    return {
      AppConstants.notesTitle : title,
      AppConstants.notesDesc : desc,
      AppConstants.notesCreatedAt : createdAt
    };
  }
}
