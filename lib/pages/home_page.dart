import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friendly_spaces/data/emotions.dart';
import 'package:friendly_spaces/data/firestore.dart';
import 'package:friendly_spaces/my_components/my_fab.dart';
import 'package:friendly_spaces/my_components/note_tile.dart';
import 'package:friendly_spaces/pages/dialog_page.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore db = FirebaseFirestore.instance;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();

    //selecting day and notes
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _newNoteController = TextEditingController();

  //create a new note
  void createNewEmotionNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => DialogPage(
                controller: _newNoteController,
                hintText: "Enter your note",
                onSave: saveNewNote,
                onCancel: cancelDialogBox,
              )),
    );
  }

  //save new note
  void saveNewNote(String emotion, [int? index]) {
    //add new note to the list
    setState(() {
      //db.addNote(_newNoteController.text, emotion, _selectedDay);
    });
    db.collection('Users').doc(user!.email).collection('Notes').add({
      'noteText': _newNoteController.text,
      'emotion': emotion,
      'timestamp': Timestamp.fromDate(_selectedDay)
    });
    //clear text field
    _newNoteController.clear();
    //pop dialog box
    Navigator.of(context).pop();
  }

  //cancel new note
  void cancelDialogBox() {
    //clear text field
    _newNoteController.clear();
    //pop dialog box
    Navigator.of(context).pop();
  }

  void openNoteEdit(int index) {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return DialogPage(
    //           controller: _newNoteController,
    //           hintText: db.todayNotesList[index][0],
    //           onSave: (String e, [int? i]) => saveExistingNote(e, index),
    //           onCancel: cancelDialogBox);
    //     });
  }

  //save an existing note with new text
  void saveExistingNote(String emotion, [int? index]) {}

  //delete note
  void deleteNote(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewEmotionNote,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TableCalendar(
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    weekendStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withAlpha(200))),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                    disabledTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceVariant),
                    weekendTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                    todayDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    )),
                firstDay: DateTime(2023, 12, 1),
                lastDay: DateTime.now(),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      //db.getNotes(_selectedDay);
                      //db.updateDatabase();
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user!.email)
                        .collection('Notes')
                        .where("timestamp",
                            isEqualTo: Timestamp.fromDate(_selectedDay))
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int itemCount = snapshot.data!.docs.length;
                        return ListView.builder(
                          itemCount: itemCount + 1,
                          itemBuilder: (context, index) {
                            if (index != itemCount) {
                              //get the note
                              final note = snapshot.data!.docs[index];
                              return NoteTile(
                                noteText: note['noteText'],
                                emotionIcon: emotionsMap[note['emotion']],
                                editTapped: (context) => openNoteEdit(index),
                                deleteTapped: (context) => deleteNote(index),
                              );
                            } else {
                              return const SizedBox(height: 80);
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error.toString()}'),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
