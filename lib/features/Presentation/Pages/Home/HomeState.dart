import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';

class HomeState {
  final List<TaskModel> tasks;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  const HomeState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  HomeState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  
  List<TaskModel> get activeTasks {
    return tasks.where((t) => t.status != TaskStatus.done).toList();
  }


  List<TaskModel> get filteredTasks {
    if (searchQuery.isEmpty) {
      return activeTasks;
    }

    return activeTasks.where((task) {
      final title = task.title.toLowerCase();
      final desc = task.desc.toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query) || desc.contains(query);
    }).toList();
  }
}