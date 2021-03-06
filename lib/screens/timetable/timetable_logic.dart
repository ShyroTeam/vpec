import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/time_model.dart';
import '/utils/hive_helper.dart';
import '/utils/utils.dart';
import '/widgets/confirm_delete_dialog.dart';
import '../../widgets/snackbars.dart';
import 'timetable_ui.dart';

class TimeTableLogic {
  String collectionPath = HiveHelper.getValue('timetable_path');

  static void resetTimeTable(BuildContext context) {
    showRoundedModalSheet(
        context: context,
        title: 'Сбросить расписание звонков',
        child: Provider(
            create: (_) => TimeTableLogic(),
            child: const ResetTimeTableDialogUI()));
  }

  static void addTimeTable(BuildContext context) {
    showRoundedModalSheet(
        context: context,
        title: 'Добавить расписание звонков',
        child: const AddTimeTableItemDialogUI());
  }

  static bool validateToDate(String value) {
    RegExp regex = RegExp(r'^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$');
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  void addNewTimeTableItem(TimeModel model) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection(collectionPath);

    int docID = DateTime.now().millisecondsSinceEpoch;
    schedule.doc(docID.toString()).set(model.toMap(docID));
  }

  Future<void> deleteAllDocs() async {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection(collectionPath);
    // delete all docs in time_schedule
    schedule.get().then((value) async {
      for (DocumentSnapshot doc in value.docs) {
        await doc.reference.delete();
      }
    });
  }

  static void showDeleteAllDocsDialog(BuildContext context) {
    showRoundedModalSheet(
        context: context,
        title: 'Подтвердите действие',
        child: const ConfirmDeleteAllDocsDialogUI());
  }

  void restoreFiles(BuildContext context, bool isThirtyMinBreak) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection(collectionPath);
    Navigator.pop(context);
    // add default time schedule
    schedule.get().then((value) async {
      if (value.docs.isEmpty) {
        for (int i = 1; i < 6; i++) {
          int docID = DateTime.now().millisecondsSinceEpoch;
          await schedule.doc(docID.toString()).set(
                getDefaultTimeSchedule(
                        isThirtyMinBreak: isThirtyMinBreak, numOfLesson: i)
                    .toMap(docID),
              );
        }
      } else {
        showSnackBar(context,
            text: 'Чтобы восстановить расписание, сперва удалите все записи');
      }
    });
  }

  TimeModel getDefaultTimeSchedule(
      {required bool isThirtyMinBreak, required int numOfLesson}) {
    switch (numOfLesson) {
      case 1:
        return const TimeModel(
          startLesson: '08:30',
          endLesson: '10:00',
          name: '1 пара',
          pause: '10 минут',
        );
      case 2:
        return TimeModel(
          startLesson: '10:10',
          endLesson: '11:40',
          name: '2 пара',
          pause: isThirtyMinBreak ? '30 минут' : '40 минут',
        );
      case 3:
        return TimeModel(
          startLesson: isThirtyMinBreak ? '12:10' : '12:20',
          endLesson: isThirtyMinBreak ? '13:40' : '13:50',
          name: '3 пара',
          pause: '10 минут',
        );
      case 4:
        return TimeModel(
          startLesson: isThirtyMinBreak ? '13:50' : '14:00',
          endLesson: isThirtyMinBreak ? '15:20' : '15:30',
          name: '4 пара',
          pause: '10 минут',
        );
      case 5:
        return TimeModel(
          startLesson: isThirtyMinBreak ? '15:30' : '15:40',
          endLesson: isThirtyMinBreak ? '17:00' : '17:10',
          name: '5 пара',
          pause: '0 минут',
        );
      default:
        return const TimeModel(
          startLesson: '08:00',
          endLesson: '08:10',
          name: 'Указаны неправильные данные',
          pause: 'Проверьте правильность ввода',
        );
    }
  }

  void editTimeTableItem(String docID, TimeModel model) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection(collectionPath);
    schedule.doc(docID.toString()).set(
          model.toMap(int.parse(docID)),
        );
  }

  void confirmDelete(BuildContext context, TimeModel model) {
    Navigator.pop(context);
    showRoundedModalSheet(
        context: context,
        title: 'Подтвердите действие',
        child: DeleteDialogUI(
          onDelete: () {
            deleteDoc(model.id!);
          },
        ));
  }

  void deleteDoc(String docID) {
    CollectionReference schedule =
        FirebaseFirestore.instance.collection(collectionPath);
    schedule.doc(docID.toString()).delete();
  }
}
