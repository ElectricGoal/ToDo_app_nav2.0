import 'package:flutter/material.dart';
import 'package:todo/size_config.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
    required this.onTap,
    required this.nameController,
    required this.validate,
    required this.descriptionController,
  }) : super(key: key);
  final VoidCallback onTap;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final bool validate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'New task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Task name',
                errorText: validate ? 'Value cannot be empty' : null,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: descriptionController,
              minLines: 5,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: onTap,
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }
}
