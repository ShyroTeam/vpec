import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/holiday_helper.dart';
import '../../../utils/theme_helper.dart';
import '../../widgets/snow_widget.dart';
import 'lessons_schedule_logic.dart';
import 'lessons_schedule_ui.dart';

class LessonsScheduleScreen extends StatefulWidget {
  @override
  _LessonsScheduleScreenState createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<LessonsScheduleLogic>().onInitState(this);
    super.initState();
  }

  @override
  void dispose() {
    context.read<LessonsScheduleLogic>().onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (HolidayHelper().isNewYear())
            SnowWidget(
              isRunning: true,
              totalSnow: 20,
              speed: 0.4,
              snowColor:
                  ThemeHelper().isDarkMode() ? Colors.white : Color(0xFFD6D6D6),
            ),
          LessonImage(),
        ],
      ),
      floatingActionButton: FabMenu(),
    );
  }
}