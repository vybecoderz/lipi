import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_tagalog/services/notificaiton_service.dart';
import 'package:learn_tagalog/utilities/reminder_logic.dart';
import 'package:learn_tagalog/widgets/theme_background_color.dart';

import 'bottom_nav_bar.dart';

class Reminder extends StatefulWidget {
  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  double _value = 12.5;

  ReminderLogic reminderLogic;

  @override
  void initState() {
    NotificationService.init();
    listenNotifications();
    super.initState();
    reminderLogic = ReminderLogic();
  }

  void listenNotifications() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String payload) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => BottomNavBar()));


  @override
  Widget build(BuildContext context) {
    var hour = _value.floor();
    var min = _value - hour;
    String timeString = '${reminderLogic.getHourString(hour)}:${reminderLogic.getMinuteString(min)}';

    return Scaffold(
      body: ThemeColor(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 250.0,
                    child: Center(
                      child: Text(
                        'Reminder',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 10.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            FontAwesomeIcons.times,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  'What time would you like set your daily reminders?',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  inactiveTrackColor: Colors.red,
                ),
                child: Slider(
                  value: _value,
                  min: 0,
                  max: 24,
                  divisions: 1441,
                  label: reminderLogic.getTimeStringFromDouble(_value),
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  reminderLogic.getTimeStringFromDouble(_value),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    NotificationService.showScheduledNotification(
                        title: 'Let\'s make a habit',
                        body: 'Time to start a lesson!',
                        scheduledHour: int.parse(reminderLogic.getHourString(hour)),
                        scheduledMin: int.parse(reminderLogic.getMinuteString(min)));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Scheduled every day at $timeString successfully',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Set Reminder',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
