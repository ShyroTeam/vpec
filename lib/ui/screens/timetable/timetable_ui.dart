import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/time_model.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../../ui/widgets/timetable_item/timetable_item.dart';
import 'timetable_logic.dart';

class TimeTableListView extends StatelessWidget {
  const TimeTableListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('time_schedule')
          .orderBy('order', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return LoadingIndicator();
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return TimeTableItem(
              timeModel: TimeModel.fromMap(snapshot.data!.docs[index].data(),
                  snapshot.data!.docs[index].id),
              isLast: snapshot.data!.docs.length == index + 1,
            );
          },
        );
      },
    );
  }
}

class EditorModeButtons extends StatelessWidget {
  const EditorModeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      direction: Axis.vertical,
      children: [
        FloatingActionButton(
            child: Icon(
              Icons.refresh_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().resetTimeTable(context)),
        FloatingActionButton(
            child: Icon(
              Icons.add_outlined,
              size: 24.0,
            ),
            onPressed: () => TimeTableLogic().addTimeTable(context)),
      ],
    );
  }
}

class ResetTimeTableDialogUI extends StatefulWidget {
  @override
  _ResetTimeTableDialogUIState createState() => _ResetTimeTableDialogUIState();
}

class _ResetTimeTableDialogUIState extends State<ResetTimeTableDialogUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
              spacing: 8.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              children: [
                Text(
                  'Большая перемена:',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                OutlinedButton(
                    onPressed: () => context
                        .read<TimeTableLogic>()
                        .startRestoringTimeSchedule(true),
                    child: Text('30 мин')),
                OutlinedButton(
                    onPressed: () => context
                        .read<TimeTableLogic>()
                        .startRestoringTimeSchedule(false),
                    child: Text('40 мин'))
              ]),
        ],
      ),
    );
  }
}

class AddTimeTableItemDialogUI extends StatefulWidget {
  @override
  _AddTimeTableItemDialogUIState createState() =>
      _AddTimeTableItemDialogUIState();
}

class _AddTimeTableItemDialogUIState extends State<AddTimeTableItemDialogUI> {
  TextEditingController name = TextEditingController();
  TextEditingController startLesson = TextEditingController();
  TextEditingController endLesson = TextEditingController();
  TextEditingController pause = TextEditingController();
  bool hasErrorsOnStart = false;
  bool hasErrorsOnEnd = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.0,
      children: [
        TextFormField(
          controller: name,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelText: 'Название (1 пара)',
              labelStyle: Theme.of(context).textTheme.headline3,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: startLesson,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          onChanged: (value) {
            setState(() {
              if (TimeTableLogic().validateToDate(startLesson.text)) {
                hasErrorsOnStart = false;
              } else {
                hasErrorsOnStart = true;
              }
            });
          },
          decoration: InputDecoration(
              errorText: hasErrorsOnStart ? 'Неправильно введено время' : null,
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Время начала пары (08:30)',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: endLesson,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          onChanged: (value) {
            setState(() {
              if (TimeTableLogic().validateToDate(endLesson.text)) {
                hasErrorsOnEnd = false;
              } else {
                hasErrorsOnEnd = true;
              }
            });
          },
          decoration: InputDecoration(
              errorText: hasErrorsOnEnd ? 'Неправильно введено время' : null,
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Время конца пары (10:00)',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        TextFormField(
          controller: pause,
          textInputAction: TextInputAction.next,
          style: Theme.of(context).textTheme.headline3,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline3,
              labelText: 'Перемена после пары (10 минут)',
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).accentColor))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ButtonBar(
            buttonPadding: EdgeInsets.zero,
            children: [
              Wrap(
                spacing: 12,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        if (!hasErrorsOnEnd || !hasErrorsOnStart) {
                          TimeTableLogic().addNewTimeTableItem(TimeModel(
                            name: name.text,
                            startLesson: startLesson.text,
                            endLesson: endLesson.text,
                            pause: pause.text,
                          ));
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Добавить',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}