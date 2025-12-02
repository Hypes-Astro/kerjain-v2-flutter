import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kerjain/Config/Routes/Routes.dart';
import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Presentation/Provider/addTaskProvider.dart';
import 'package:kerjain/features/Presentation/widgets/appButtonComp.dart';

class AddTaskView extends ConsumerStatefulWidget {
  final TaskModel? task;

  const AddTaskView({super.key, this.task});

  @override
  ConsumerState<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends ConsumerState<AddTaskView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = ref.read(addTaskProvider(widget.task).notifier);

      viewModel.onSaveSuccess = (isEditing) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing ? 'Task berhasil diupdate' : 'Task berhasil disimpan',
            ),
          ),
        );
        Navigator.pop(context, true);
      };
    });
  }

  Future<void> _pickDueDate() async {
    final viewModel = ref.read(addTaskProvider(widget.task).notifier);
    final state = ref.read(addTaskProvider(widget.task));

    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: state.dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );

    if (picked != null) {
      viewModel.updateDueDate(picked);
    }
  }

  void _handleSave() {
    final viewModel = ref.read(addTaskProvider(widget.task).notifier);
    viewModel.handleSave(_formKey);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskProvider(widget.task));
    final viewModel = ref.read(addTaskProvider(widget.task).notifier);

    ref.listen(
      addTaskProvider(widget.task).select((state) => state.errorMessage),
      (previous, next) {
        if (next != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next)));
          viewModel.clearError();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(title: Text(state.isEditing ? 'Edit Task' : 'Add Task')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: viewModel.titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: viewModel.updateTitle,
                    validator: viewModel.validateTitle,
                    enabled: !state.isLoading,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: viewModel.descController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Enter task description',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: viewModel.updateDescription,
                    validator: viewModel.validateDescription,
                    enabled: !state.isLoading,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Due Date',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: viewModel.dueDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Select due date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: state.isLoading ? null : _pickDueDate,
                    validator: viewModel.validateDueDate,
                    enabled: !state.isLoading,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),

                  DropdownButtonFormField2<TaskStatus>(
                    isExpanded: true,
                    value: state.status,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: TaskStatus.notStarted,
                        child: Text('Not Started'),
                      ),
                      DropdownMenuItem(
                        value: TaskStatus.inProgress,
                        child: Text('In Progress'),
                      ),
                      DropdownMenuItem(
                        value: TaskStatus.done,
                        child: Text('Done'),
                      ),
                    ],
                    onChanged: state.isLoading
                        ? null
                        : (value) {
                            if (value != null) {
                              viewModel.updateStatus(value);
                            }
                          },
                    buttonStyleData: const ButtonStyleData(height: 20),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: MediaQuery.of(context).size.width - 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      offset: const Offset(0, -4),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Save',
                          size: AppButtonSize.medium,
                          onPressed: state.isLoading
                              ? null
                              : () => _handleSave(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          label: 'Cancel',
                          size: AppButtonSize.medium,
                          variant: AppButtonVariant.secondary,
                          onPressed: state.isLoading
                              ? null
                              : () => _handleCancel(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (state.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
