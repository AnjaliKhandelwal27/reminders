import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/widgets/task_list.dart';
import 'bottom_sheet.dart';

import 'package:provider/provider.dart';
import 'package:mytodoapp/models/task_data.dart';



class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//   SharedPreferences preferences;
//   preferences.getString('name');

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddTasksScreen(),
                ),
              ),
            );
          }),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding:
              EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                child: Icon(
                  Icons.list,
                  size: 30.0,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('Reminders',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              Text(
                '${Provider.of<TaskData>(context).taskCount} tasks',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: TaskList(),
          ),
        )
      ]),
    );
  }
}
