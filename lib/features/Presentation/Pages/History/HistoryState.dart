import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';

class HistoryState {
  final List<TaskModel> tasks;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  const HistoryState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  HistoryState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return HistoryState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<TaskModel> get completedTasks {
    return tasks.where((t) => t.status == TaskStatus.done).toList();
  }

  List<TaskModel> get filteredTasks {
    final base = completedTasks;

    if (searchQuery.isEmpty) {
      return base;
    }

    final query = searchQuery.toLowerCase();

    return base.where((task) {
      final title = task.title.toLowerCase();
      final desc = task.desc.toLowerCase();
      return title.contains(query) || desc.contains(query);
    }).toList();
  }
}
