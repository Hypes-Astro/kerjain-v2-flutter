import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Domain/Helper/dateHelper.dart';

class DetailTaskState {
  final TaskModel task;
  final bool isLoading;
  final String? errorMessage;

  const DetailTaskState({
    required this.task,
    this.isLoading = false,
    this.errorMessage,
  });

  factory DetailTaskState.initial(TaskModel task) {
    return DetailTaskState(
      task: task,
      isLoading: false,
      errorMessage: null,
    );
  }

  DetailTaskState copyWith({
    TaskModel? task,
    bool? isLoading,
    String? errorMessage,  DueType? dueType,
  }) {
    return DetailTaskState(
      task: task ?? this.task,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

 
  DueType get dueType {
    return DateHelper.calculateDueType(task.dueDate);
  }
}
