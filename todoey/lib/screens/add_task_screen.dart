import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_data.dart';

// The content of the modal bottom sheet that slides up from the FAB.
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      color: const Color(0xFF757575), // dim backdrop behind the rounded sheet
      child: Container(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          // Lift the sheet above the on-screen keyboard.
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // only as tall as its content
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30.0, color: Colors.lightBlueAccent),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText; // remember what the user typed
              },
            ),
            const SizedBox(height: 20.0),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              onPressed: () {
                if (newTaskTitle.trim().isEmpty) return; // ignore empty input

                // listen: false — we're only firing an action here, not
                // rebuilding this widget when the data changes.
                Provider.of<TaskData>(
                  context,
                  listen: false,
                ).addTask(newTaskTitle.trim());

                Navigator.pop(context); // close the sheet
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
