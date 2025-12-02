import 'package:flutter/material.dart';
import 'package:kerjain/features/Presentation/widgets/NavigationBarComp.dart';

import '../../features/Presentation/Pages/Home/HomeView.dart';
import '../../features/Presentation/Pages/AddTask/AddTaskView.dart';
import '../../features/Presentation/Pages/Login/LoginView.dart';
import '../../features/Presentation/Pages/History/HistoryView.dart';
import '../../features/Presentation/Pages/Detail/DetailView.dart';

class AppRoutes {
  static const login = '/';     
  static const home = '/home';
  static const addTask = '/add-task';
  static const historyTask = '/history-task';
  static const taskDetail = '/task-detail';
}


class TaskDetailArgs {
  final String taskId;
  TaskDetailArgs({required this.taskId});
}

Route<dynamic>? appRouter(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
        settings: settings,
      );

    case AppRoutes.home:
      return MaterialPageRoute(
        builder: (_) => const BottomNavigationComp(),
        settings: settings,
      );

    case AppRoutes.addTask:
      return MaterialPageRoute(
        builder: (_) => const AddTaskView(),
        settings: settings,
      );

    case AppRoutes.historyTask:
      return MaterialPageRoute(
        builder: (_) => const HistoryView(),
        settings: settings,
      );

    case AppRoutes.taskDetail:
      final args = settings.arguments;

    default:
      return MaterialPageRoute(
        builder: (_) => const LoginView(),
        settings: settings,
      );
  }
}


