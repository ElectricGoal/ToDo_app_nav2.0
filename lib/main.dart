import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/task_detail_screen.dart';
import 'package:todo/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool validate = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskData>(create: (context) => TaskData()),
        ChangeNotifierProvider<AppRoute>(create: (context) => AppRoute()),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        
        var createNewTask = context.watch<AppRoute>().createNewTask;
        var selectedTask = context.watch<AppRoute>().selectedTask;

        void handleCreateNewTask() {
          setState(() {
            context.read<AppRoute>().createNewTask = true;
          });
        }

        void handleAddNewTask() {
          setState(() {
            nameController.text.isEmpty ? validate = true : validate = false;
          });
          if (validate == false) {
            context
                .read<TaskData>()
                .addTask(nameController.text, descriptionController.text);
            setState(() {
              context.read<AppRoute>().createNewTask = false;
              nameController.clear();
              descriptionController.clear();
            });
          }
        }

        SizeConfig().init(constraints);
        return MaterialApp(
          title: 'ToDoApp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Colors.white,
            primaryColor: Colors.deepPurpleAccent[700],
          ),
          home: Navigator(
            pages: [
              MaterialPage(
                key: ValueKey('HomePage'),
                child: HomePage(
                  createNewTask: handleCreateNewTask,
                ),
              ),

              if (createNewTask != false && selectedTask == null)
                MaterialPage(
                  key: ValueKey('AddTaskScreen'),
                  child: AddTaskScreen(
                    nameController: nameController,
                    descriptionController: descriptionController,
                    validate: validate,
                    onTap: handleAddNewTask,
                  ),
                ),

              if (selectedTask != null && createNewTask == false)
                MaterialPage(
                  key: ValueKey('AddTaskScreen'),
                  child: TaskDetailScreen(
                    task: context.watch<AppRoute>().selectedTask,
                  ),
                ),
                
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) return false;
              setState(() {
                context.read<AppRoute>().createNewTask = false;
                context.read<AppRoute>().selectedTask = null;
              });
              return true;
            },
          ),
        );
      }),
    );
  }
}

class AppRoute extends ChangeNotifier {
  bool createNewTask = false;
  Task? selectedTask;

  void getTask(Task task) {
    selectedTask = task;
    createNewTask = false;
    notifyListeners();
  }
}
