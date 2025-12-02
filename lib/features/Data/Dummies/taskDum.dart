import 'package:kerjain/features/Data/Enum/taskEnum.dart';

class DummyTask {
  final String title;
  final String description;
  final DateTime date;
  final DueType dueType;
  final TaskStatus status;

  DummyTask({
    required this.title,
    required this.description,
    required this.date,
    required this.dueType,
    required this.status,
  });
}


final List<DummyTask> dummyTasks = [
  DummyTask(
    title: "Design E-commerce Mobile App",
    description: "Design E-commerce Mobile App need to so...",
    date: DateTime(2025, 11, 24),
    dueType: DueType.today,
    status: TaskStatus.inProgress,
  ),
  DummyTask(
    title: "Create Landing Page",
    description: "Create landing page for new marketing campaign.",
    date: DateTime(2025, 11, 24),
    dueType: DueType.deadline,
    status: TaskStatus.notStarted,
  ),
  DummyTask(
    title: "Fix Bug on Checkout Flow",
    description: "Investigate and fix bug on checkout payment step.",
    date: DateTime(2025, 11, 25),
    dueType: DueType.tomorrow,
    status: TaskStatus.inProgress,
  ),
  DummyTask(
    title: "Prepare Sprint Planning",
    description: "Prepare backlog and estimation for next sprint.",
    date: DateTime(2025, 11, 30),
    dueType: DueType.later,
    status: TaskStatus.done,
  ),
];