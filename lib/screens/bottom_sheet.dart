import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytodoapp/models/task_data.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


String newTask;
String newTime;
class AddTasksScreen extends StatefulWidget {
  @override
  _AddTasksScreenState createState() => _AddTasksScreenState();
}

class _AddTasksScreenState extends State<AddTasksScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  DateTime time = DateTime.now();
  DateTime picked;
  var textEditController = TextEditingController();

  void _selectDate() async {
    await DatePicker.showDateTimePicker(
      context,
      minTime: DateTime.now().subtract(Duration(seconds: 10)),
      currentTime: DateTime.now(),
      onConfirm: (time) {
        setState(() {
          picked=time;
        });
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var initializeSettingsAndroid=new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initalizeSettingsios=new IOSInitializationSettings();
    var initializationSettings=new InitializationSettings(initializeSettingsAndroid, initalizeSettingsios);
    flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);

  }
  Future onSelectNotification(String payload) async{
    showDialog(
        context: context,
        builder:(_)=>AlertDialog(
          title: const Text('Here is your payload '),
          content:  Text(
             newTask ),
        ) );

  }
  Future _showNotificationWithDefaultSound(String name) async {

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '001', 'notices', 'This is for notifications',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'title of notifications',
      name,
      picked,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }



  @override
  Widget build(BuildContext context) {



    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(40.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Reminder',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            TextField(
              controller: textEditController,
              autofocus: true,
              textAlign: TextAlign.center,

            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
              _selectDate();
              },
              child: Text(
                'Set Time',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              onPressed: () {
                int n=picked.weekday;
                String day;
                switch(n){
                  case 1: day='Monday'; break;
                  case 2: day='Tuesday'; break;
                  case 3: day='Wednesday'; break;
                  case 4: day='Thrusday'; break;
                  case 5: day='Friday'; break;
                  case 6: day='Saturday'; break;
                  case 7: day='Sunday'; break;

                }
                String min=picked.minute<9?"0"+picked.minute.toString():picked.minute.toString();

                String setTime =day+"       "+
                    picked.hour.toString() + ":" + min;


                Provider.of<TaskData>(context, listen: false)
                    .addTask(textEditController.text, setTime);

                _showNotificationWithDefaultSound(newTask);

                Navigator.pop(context);
              },
              color: Colors.lightBlueAccent,
              child: Text(
                'Add',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
