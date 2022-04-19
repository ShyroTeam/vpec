import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../models/full_schedule.dart';
import '../../models/schedule/schedule_item.dart';
import '../../utils/hive_helper.dart';
import '../../utils/routes/routes.dart';
import 'schedule_item_logic.dart';
import 'schedule_logic.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({Key? key, required this.model}) : super(key: key);
  final ScheduleItemModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleItemLogic>(
      builder: (context, logic, _) {
        return GestureDetector(
          onTap: () => logic.toggleWidget(
            context,
            names: model.teachers[model.lessonName],
            lessonName: model.lessonName,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 9.0, bottom: 15.0),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 3,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.lessonBeginning} - ${model.lessonEnding}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 36.0,
                        letterSpacing: 0.15,
                      ),
                    ),
                    Text(
                      '${model.lessonNumber} пара ${model.lessonName}',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        letterSpacing: 0.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      model.timer ?? '',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        letterSpacing: 0.15,
                      ),
                    ),
                    AdditionalInfo(
                      open: logic.open,
                      info: logic.infoWidget,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, top: 9.5, bottom: 9),
                decoration: BoxDecoration(
                  border: RDottedLineBorder(
                    // Меняй этой значение, чтобы дэши попали в расстояние нормально
                    dottedLength: 3.5,
                    dottedSpace: 3,
                    left: BorderSide(
                        width: 3,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                child: Text(
                  model.pauseAfterLesson,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    letterSpacing: 0.15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({
    Key? key,
    required this.open,
    required this.info,
  }) : super(key: key);
  final bool open;
  final Widget info;

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 250),
      child: widget.info,
    );
  }
}

class SchedulePanel extends StatelessWidget {
  const SchedulePanel({
    Key? key,
    required this.fullSchedule,
  }) : super(key: key);
  final FullSchedule fullSchedule;

  @override
  Widget build(BuildContext context) {
    List<Widget> schedulePanel =
        List<Widget>.generate(fullSchedule.timetable.length, (index) {
      String lessonNum = index.toString();
      String lessonEnding = fullSchedule.timetable[lessonNum].split('-').last;
      String nextLessonBeginning() {
        String? time = fullSchedule.timetable[(index + 1).toString()];
        if (time == null) return lessonEnding;

        return time.split('-').first;
      }

      String lessonName() {
        String name = fullSchedule.schedule[lessonNum];
        if (name == '0') name = '';
        if (name.isNotEmpty) name = '- $name';
        return name;
      }

      bool shouldGiveTimers = fullSchedule.timers.isNotEmpty;

      return ChangeNotifierProvider<ScheduleItemLogic>(
        create: (_) => ScheduleItemLogic(),
        child: ScheduleItem(
          model: ScheduleItemModel(
            timer: shouldGiveTimers ? fullSchedule.timers[index] : null,
            lessonNumber: index,
            teachers: fullSchedule.teachers,
            lessonsFullNames: fullSchedule.fullLessonNames,
            lessonsShortNames: fullSchedule.shortLessonNames,
            lessonBeginning: fullSchedule.timetable[lessonNum].split('-').first,
            lessonEnding: fullSchedule.timetable[lessonNum].split('-').last,
            lessonName: lessonName(),
            pauseAfterLesson: ScheduleTime.calculatePauseAfterLesson(
                lessonEnding, nextLessonBeginning()),
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: schedulePanel,
    );
  }
}

class FABPanel extends StatelessWidget {
  const FABPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          mini: true,
          tooltip: 'Полное расписание',
          child: const Icon(Icons.fullscreen_outlined),
          heroTag: null,
          onPressed: () =>
              Navigator.pushNamed(context, Routes.fullScheduleScreen),
        ),
        const SizedBox(
          height: 8,
        ),
        FloatingActionButton(
          tooltip: 'Расписание на завтра/сегодня',
          child: Icon(context.watch<ScheduleLogic>().showingForToday
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_outlined),
          heroTag: null,
          onPressed: () => context.read<ScheduleLogic>().toggleShowingLesson(),
        ),
      ],
    );
  }
}

class AdditionalInfoPanelWidget extends StatelessWidget {
  const AdditionalInfoPanelWidget({
    Key? key,
    required this.names,
    required this.notes,
    required this.lessonName,
  }) : super(key: key);
  final String names;
  final String notes;
  final String lessonName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.people_outline,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  names,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: TextField(
              controller: TextEditingController(text: notes),
              decoration: const InputDecoration(
                labelText: 'Заметки',
              ),
              maxLines: 6,
              style: Theme.of(context).textTheme.bodyText1,
              onChanged: (text) {
                HiveHelper.saveValue(key: 'note_$lessonName', value: text);
              },
            ),
          ),
          Text(
            'Хранится только на данном устройстве',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}