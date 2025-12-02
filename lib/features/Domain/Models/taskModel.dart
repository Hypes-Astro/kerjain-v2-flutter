import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Presentation/widgets/TaskCardComp.dart';

class TaskModel {
  final int? id;
  final String title;
  final String desc;
  final DateTime dueDate;
  final TaskStatus status; // notStarted / inProgress / done

  TaskModel({
    this.id,
    required this.title,
    required this.desc,
    required this.dueDate,
    required this.status,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      desc: map['desc'] as String,
      dueDate: DateTime.parse(map['dueDate'] as String),
      status: _intToStatus(map['status'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'dueDate': dueDate.toIso8601String().substring(0, 10), // yyyy-MM-dd
      'status': _statusToInt(status),
    };
  }

  static TaskStatus _intToStatus(int value) {
    switch (value) {
      case 1:
        return TaskStatus.inProgress;
      case 2:
        return TaskStatus.done;
      case 0:
      default:
        return TaskStatus.notStarted;
    }
  }

  static int _statusToInt(TaskStatus status) {
    switch (status) {
      case TaskStatus.inProgress:
        return 1;
      case TaskStatus.done:
        return 2;
      case TaskStatus.notStarted:
      default:
        return 0;
    }
  }
}
