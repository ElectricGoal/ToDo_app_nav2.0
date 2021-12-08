import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/size_config.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          task!.name!,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text(
              'Description',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.textMultiplier * 2.7,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (task != null)
                  Expanded(
                    child: Text(
                      task!.descrip != null ? task!.descrip! : ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: SizeConfig.textMultiplier * 2.5,
                      ),
                    ),
                  )
                else
                  Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: SizeConfig.textMultiplier * 2.5,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
