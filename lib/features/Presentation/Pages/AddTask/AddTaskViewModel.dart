import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Domain/Service/taskService.dart';
import 'package:kerjain/features/Presentation/Pages/AddTask/AddTaskState.dart';

class AddTaskViewModel extends StateNotifier<AddTaskState> {
  final TaskService taskService;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  Function(bool isEditing)? onSaveSuccess;

  AddTaskViewModel({
    required this.taskService,
    required TaskModel? initialTask,
  }) : super(AddTaskState.initial(initialTask)) {
    _initialize();
  }

  void _initialize() {
    if (state.isEditing && state.initialTask != null) {
      titleController.text = state.title;
      descController.text = state.desc;
      if (state.dueDate != null) {
        dueDateController.text =
            state.dueDate!.toIso8601String().substring(0, 10);
      }
    }
  }

  void updateTitle(String value) {
    state = state.copyWith(title: value);
  }

  void updateDescription(String value) {
    state = state.copyWith(desc: value);
  }

  void updateStatus(TaskStatus status) {
    state = state.copyWith(status: status);
  }

  void updateDueDate(DateTime date) {
    dueDateController.text = date.toIso8601String().substring(0, 10);
    state = state.copyWith(dueDate: date);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  String? validateDueDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Due date is required';
    }
    return null;
  }

  bool _validateForm(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (state.dueDate == null) {
      state = state.copyWith(errorMessage: 'Please select due date');
      return false;
    }

    return true;
  }

  Future<void> handleSave(GlobalKey<FormState> formKey) async {
    clearError();
    if (!_validateForm(formKey)) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final title = titleController.text.trim();
      final desc = descController.text.trim();

      if (state.isEditing && state.initialTask != null) {
        final updatedTask = TaskModel(
          id: state.initialTask!.id,
          title: title,
          desc: desc,
          dueDate: state.dueDate!,
          status: state.status,
        );

        await taskService.updateTask(updatedTask);
      } else {
        final newTask = TaskModel(
          title: title,
          desc: desc,
          dueDate: state.dueDate!,
          status: state.status,
        );

        await taskService.addTask(newTask);
      }

      state = state.copyWith(isLoading: false);
      onSaveSuccess?.call(state.isEditing);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Gagal menyimpan task: ${e.toString()}',
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    dueDateController.dispose();
    super.dispose();
  }
}
