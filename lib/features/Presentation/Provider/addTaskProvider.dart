import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Domain/Service/taskService.dart';
import 'package:kerjain/features/Presentation/Pages/AddTask/AddTaskState.dart';
import 'package:kerjain/features/Presentation/Pages/AddTask/AddTaskViewModel.dart';

final addTaskProvider =
    StateNotifierProvider.autoDispose
        .family<AddTaskViewModel, AddTaskState, TaskModel?>((ref, task) {
  return AddTaskViewModel(
    taskService: TaskService(),
    initialTask: task,
  );
});
