import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';

class AddTaskState {
  final bool isEditing;
  final TaskModel? initialTask;

  final String title;
  final String desc;
  final DateTime? dueDate;
  final TaskStatus status;

  final bool isLoading;
  final String? errorMessage;

  const AddTaskState({
    required this.isEditing,
    required this.initialTask,
    required this.title,
    required this.desc,
    required this.dueDate,
    required this.status,
    required this.isLoading,
    required this.errorMessage,
  });

  factory AddTaskState.initial(TaskModel? task) {
    if (task == null) {
      return const AddTaskState(
        isEditing: false,
        initialTask: null,
        title: '',
        desc: '',
        dueDate: null,
        status: TaskStatus.notStarted,
        isLoading: false,
        errorMessage: null,
      );
    }

    return AddTaskState(
      isEditing: true,
      initialTask: task,
      title: task.title,
      desc: task.desc,
      dueDate: task.dueDate,
      status: task.status,
      isLoading: false,
      errorMessage: null,
    );
  }

  AddTaskState copyWith({
    bool? isEditing,
    TaskModel? initialTask,
    String? title,
    String? desc,
    DateTime? dueDate,
    TaskStatus? status,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AddTaskState(
      isEditing: isEditing ?? this.isEditing,
      initialTask: initialTask ?? this.initialTask,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}