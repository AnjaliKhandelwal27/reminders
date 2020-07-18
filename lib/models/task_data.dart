import 'package:flutter/material.dart';
import 'tasks.dart';
import 'dart:collection';


class TaskData extends ChangeNotifier{
  //SharedPreferences preferences;
  List<Tasks> _tasks = [

  ];
UnmodifiableListView <Tasks> get tasks {
   return UnmodifiableListView(_tasks);
}
  int get taskCount{
    return _tasks.length;
  }
  void addTask(String newTask,String newTime) {
 //  preferences=await SharedPreferences.getInstance();


    _tasks.add( Tasks(name: newTask,time: newTime));
  //  preferences.setString('name', newTask);
    notifyListeners();
  }



  void deleteTask(Tasks task){
  _tasks.remove(task);
  //preferences.remove('name');
  notifyListeners();
  }
}