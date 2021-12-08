import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/size_config.dart';
import 'package:todo/widgets/task_count_card.dart';
import 'package:todo/widgets/task_list.dart';

class HomePage extends StatelessWidget {
  final VoidCallback createNewTask;
  // final ValueChanged<Task> onTapTask;

  const HomePage({
    Key? key,
    required this.createNewTask,
    // required this.onTapTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Hello',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 4,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          TaskCountCard(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TaskList(
                // onTap: onTapTask,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
