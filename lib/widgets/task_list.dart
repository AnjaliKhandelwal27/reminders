import 'package:flutter/material.dart';
import 'task_tile.dart';

import 'package:provider/provider.dart';
import 'package:mytodoapp/models/task_data.dart';


class TaskList extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return Consumer<TaskData>(
      builder: (context,taskdata,child){
        return ListView.builder(
          itemBuilder: (context, index) {
            final task=taskdata.tasks[index];
            return TaskTile(
              name: task.name,
              time: task.time,


              longPressAction: (){
                taskdata.deleteTask(task);
              },
            );
          },
          itemCount: taskdata.taskCount,
        );
      },

    );
  }
}
