import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {

final String name;
final String time;
//final bool isChecked;
final Function onChangeAction;
final Function longPressAction;
TaskTile({this.name,this.time,this.onChangeAction,this.longPressAction});

  @override
  Widget build(BuildContext context) {


    return ListTile(
      onLongPress: longPressAction,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            time,
            style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold
            ),
          )

        ],
      ),

    );
  }
}

