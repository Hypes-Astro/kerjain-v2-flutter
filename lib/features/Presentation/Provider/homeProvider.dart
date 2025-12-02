import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Domain/Service/taskService.dart';
import 'package:kerjain/features/Presentation/Pages/Home/HomeState.dart';
import 'package:kerjain/features/Presentation/Pages/Home/HomeViewModel.dart';

final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

final homeProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final service = ref.watch(taskServiceProvider);
  return HomeViewModel(service);
});
