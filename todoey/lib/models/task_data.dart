import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'task.dart';

// The single source of truth for the task list.
//
// ChangeNotifier is the key: any widget that "listens" to this class gets
// rebuilt automatically whenever we call notifyListeners(). That's how data
// is shared across screens without passing it down by hand.
class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
  ];

  // Expose a read-only view: the UI can read tasks but can't mutate the list
  // directly (it must go through the methods below, which notify listeners).
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

  void addTask(String newTaskTitle) {
    _tasks.add(Task(name: newTaskTitle));
    notifyListeners(); // "data changed — rebuild anyone watching"
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
