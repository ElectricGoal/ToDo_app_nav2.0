import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:uuid/uuid.dart';

// var uuid = Uuid();
// Important note: use final everytime you can. Lower priority than const but higher than var
final uuid = Uuid();

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
  // Better naming for example: isTaskExisted
  // Keyword to improve: should read more code of google's team app
  bool checkExistTask(String taskId) {
    final int count = tasks.length;
    tasks = [...tasks]..removeWhere((t) => t.id == taskId);

    if (tasks.length == count) {
      return false;
    }
    return true;
  }

  // better naming
  // addTask means create new task so we should add "new" keyword to
  // "newTaskName" or "newTaskDescrip"
  // => addTask(String name, String description)
  void addTask(String newTaskName, String newTaskDescrip) {
    final task = Task(
      name: newTaskName,
      descrip: newTaskDescrip,
      isDone: false,
      id: uuid.v1(),
    );
    // tasks = [...tasks]..insert(0, task);
    tasks = [task, ...tasks];
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
      // tasks = [...tasks]..add(updatedTask);
      tasks = [...tasks, updatedTask];
    } else {
      updatedTask = task.copyWith(isDone: false);
      tasks = [...tasks]..insert(0, updatedTask);
      tasks = [updatedTask, ...tasks];
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
