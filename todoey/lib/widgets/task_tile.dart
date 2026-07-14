import 'package:flutter/material.dart';

// One row in the list: a checkbox + the task name.
// It holds no state of its own — it just displays what it's given and reports
// taps back up via callbacks.
class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.taskTitle,
    required this.isChecked,
    required this.checkboxCallback,
    required this.longPressCallback,
  });

  final String taskTitle;
  final bool isChecked;
  final ValueChanged<bool?> checkboxCallback;
  final VoidCallback longPressCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback, // long-press to delete
      title: Text(
        taskTitle,
        style: TextStyle(
          // Strike the text through once it's done.
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
