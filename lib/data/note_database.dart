//reference our box
import 'package:friendly_spaces/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Note_Database");

class NoteDatabase {
  List todayNotesList = [];

  //create initial default data
  void createDefaultData() {
    //data structure for today notes
    todayNotesList = [
      ["To edit or delete this note, swipe to the left", "joy"],
    ];
    var today = DateTime.now();
    //last available day - one month before first day
    _myBox.put("START_DATE", DateTime(today.year, today.month - 1, today.day));
  }

  // load data if it already exists
  void loadData(DateTime? date) {
    if (date != null) {
      todayNotesList = _myBox.get(convertDateTimeToString(date)) ?? [];
    }
  }

  //update database
  void updateDatabase(DateTime? date) {
    if (date != null) {
      _myBox.put(convertDateTimeToString(date), todayNotesList);
    }
  }
}
