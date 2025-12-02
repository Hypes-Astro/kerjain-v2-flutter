import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Helper/dateHelper.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Domain/Service/taskService.dart';
import 'package:kerjain/features/Presentation/Pages/Detail/DetailTaskState.dart';

class DetailTaskViewModel extends StateNotifier<DetailTaskState> {
  final TaskService _taskService;

  DetailTaskViewModel({
    required TaskService taskService,
    required TaskModel initialTask,
  })  : _taskService = taskService,
        super(DetailTaskState.initial(initialTask));


  Future<bool> markAsDone() async {
    if (state.task.id == null) {
      state = state.copyWith(
        errorMessage: 'Task ID tidak ditemukan',
      );
      return false;
    }

    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final current = state.task;
      final updatedTask = TaskModel(
        id: current.id,
        title: current.title,
        desc: current.desc,
        dueDate: current.dueDate,
        status: TaskStatus.done,
      );

      await _taskService.updateTask(updatedTask);

      state = state.copyWith(
        task: updatedTask,
        isLoading: false,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> reloadTask() async {
  try {
    if (state.task.id == null) return;
    final allTasks = await _taskService.getAllTasks();
    final updated = allTasks.firstWhere(
      (t) => t.id == state.task.id,
      orElse: () => state.task,
    );

    state = state.copyWith(
      task: updated,
      dueType: DateHelper.calculateDueType(updated.dueDate),
      errorMessage: null,
    );
  } catch (e) {
    state = state.copyWith(
      errorMessage: 'Gagal memuat data task terbaru: ${e.toString()}',
    );
  }
}


  Future<bool> deleteTask() async {
    if (state.task.id == null) {
      state = state.copyWith(
        errorMessage: 'Task ID tidak ditemukan',
      );
      return false;
    }

    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      await _taskService.deleteTask(state.task.id!);

      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}