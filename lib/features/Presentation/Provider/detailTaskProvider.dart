
import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Domain/Service/taskService.dart';
import 'package:kerjain/features/Presentation/Pages/Detail/DetailTaskState.dart';
import 'package:kerjain/features/Presentation/Pages/Detail/DetailTaskViewModel.dart';

final detailTaskProvider = StateNotifierProvider.autoDispose
    .family<DetailTaskViewModel, DetailTaskState, TaskModel>((ref, task) {
  return DetailTaskViewModel(
    taskService: TaskService(),
    initialTask: task,
  );
});
