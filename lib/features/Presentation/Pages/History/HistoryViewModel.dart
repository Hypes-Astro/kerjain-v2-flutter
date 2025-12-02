import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Domain/Service/taskService.dart';
import 'package:kerjain/features/Presentation/Pages/History/HistoryState.dart';

class HistoryViewModel extends StateNotifier<HistoryState> {
  final TaskService _taskService;

  HistoryViewModel(this._taskService) : super(const HistoryState()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final List<TaskModel> tasks = await _taskService.getAllTasks();

      state = state.copyWith(
        isLoading: false,
        tasks: tasks,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refresh() => loadTasks();

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<bool> deleteTask(int id) async {
    try {
      await _taskService.deleteTask(id);
      await loadTasks();
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }
}
