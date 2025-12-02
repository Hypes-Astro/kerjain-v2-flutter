import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kerjain/Config/Routes/Routes.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/spacings.dart';
import 'package:kerjain/features/Domain/Helper/dateHelper.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Presentation/Pages/Detail/DetailView.dart';
import 'package:kerjain/features/Presentation/Pages/Login/LoginViewModel.dart';
import 'package:kerjain/features/Presentation/Provider/historyProvider.dart';
import 'package:kerjain/features/Presentation/Provider/homeProvider.dart';
import 'package:kerjain/features/Presentation/widgets/HeaderTopComp.dart';
import 'package:kerjain/features/Presentation/widgets/TaskCardComp.dart';
import 'package:kerjain/features/Presentation/widgets/TaskSummaryComp.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout(BuildContext context) async {
    await ref.read(authViewModelProvider.notifier).logout();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  Future<void> _onAddTaskPressed() async {
    final vm = ref.read(homeProvider.notifier);
    final result = await Navigator.pushNamed(context, AppRoutes.addTask);
    if (result == true) {
      await vm.refresh();
    }
  }

  Future<void> _onDeleteTaskPressed(int taskId, String title) async {
    final vm = ref.read(homeProvider.notifier);

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete task'),
          content: Text('Are you sure you want to delete "$title"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    final ok = await vm.deleteTask(taskId);
    final state = ref.read(homeProvider);

    if (!mounted) return;

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage ?? 'Failed to delete task')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task deleted')));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final vm = ref.read(homeProvider.notifier);

    final tasks = state.filteredTasks;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space12,
            vertical: AppSpacing.space26,
          ),
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Failed to load tasks:\n${state.errorMessage}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: vm.refresh,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderTopComp(
                      username: 'Alif',
                      detailCard: false,
                      onAction: () => _handleLogout(context),
                    ),

                    const SizedBox(height: AppSpacing.space24),

                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        vm.updateSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search task',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black.withOpacity(0.7),
                          size: 22,
                        ),
                        filled: true,
                        fillColor: AppColors.cardGray,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space16,
                          vertical: AppSpacing.space12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.space20),

                    TaskSummaryBarComp(
                      totalTask: tasks.length,
                      statusCard: true,
                      onAddTask: _onAddTaskPressed,
                    ),

                    const SizedBox(height: AppSpacing.space24),

                    Expanded(
                      child: tasks.isEmpty
                          ? const Center(
                              child: Text(
                                'No tasks yet.\nTap + to add your first task!',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                final dueType = DateHelper.calculateDueType(
                                  task.dueDate,
                                );

                                return TaskCardComp(
                                  dueType: dueType,
                                  status: task.status,
                                  title: task.title,
                                  description: task.desc,
                                  date: task.dueDate,
                                  cardDone: false,
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailView(task: task),
                                      ),
                                    );

                                    if (result == true) {
                                      await vm.refresh();
                                      await ref
                                          .read(historyProvider.notifier)
                                          .refresh();
                                    }
                                  },

                                  onDeleteTap: () => _onDeleteTaskPressed(
                                    task.id!,
                                    task.title,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
