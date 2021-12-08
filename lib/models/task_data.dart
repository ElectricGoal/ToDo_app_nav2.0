import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class TaskData extends ChangeNotifier {
  int countCompletedTask = 0;

  List<Task> tasks = [
    Task(
      name: 'Meet friend',
      descrip: 'Meet friend at 7 a.m',
      isDone: false,
      id: uuid.v1(),
    ),
    Task(
      name: 'Go to gym',
      descrip: 'Go to gym at 4 p.m\nDrink more',
      isDone: false,
      id: uuid.v1(),
    ),
    Task(
      name: 'Meal the dog',
      isDone: false,
      id: uuid.v1(),
    ),
  ];

  //check task có tồn tại trong list không
  bool checkExistTask(String taskId) {
    final int count = tasks.length;
    tasks = [...tasks]..removeWhere((t) => t.id == taskId);

    if (tasks.length == count) {
      return false;
    }
    return true;
  }

  void addTask(String newTaskName, String newTaskDescrip) {
    final task = Task(
      name: newTaskName,
      descrip: newTaskDescrip,
      isDone: false,
      id: uuid.v1(),
    );
    tasks = [...tasks]..insert(0, task);
    notifyListeners();
  }

  bool upgradeTask(Task task) {
    if (!checkExistTask(task.id!)) {
      return false;
    }
    //nếu task chưa check done thì khi bị check done
    //thì sẽ chuyển xuống cuối list. Ngược lại, khi task
    //bị check done rồi khi bị check undone thì sẽ di
    //chuyển lên trên đầu list
    final Task updatedTask;
    if (task.isDone == false) {
      updatedTask = task.copyWith(isDone: true);
      tasks = [...tasks]..add(updatedTask);
    } else {
      updatedTask = task.copyWith(isDone: false);
      tasks = [...tasks]..insert(0, updatedTask);
    }

    notifyListeners();
    return true;
  }

  bool deleteTask(String taskId) {
    if (!checkExistTask(taskId)) {
      return false;
    }
    notifyListeners();
    return true;
  }
}
