import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/spacings.dart';
import 'package:kerjain/features/Domain/Helper/dateHelper.dart';
import 'package:kerjain/features/Domain/Models/taskModel.dart';
import 'package:kerjain/features/Presentation/Pages/AddTask/AddTaskView.dart';
import 'package:kerjain/features/Presentation/Provider/detailTaskProvider.dart';
import 'package:kerjain/features/Presentation/widgets/AppButtonComp.dart';
import 'package:kerjain/features/Presentation/widgets/HeaderTopComp.dart';
import 'package:kerjain/features/Presentation/widgets/ChipHeadComp.dart';
import 'package:kerjain/features/Presentation/widgets/ChipStatusComp.dart';

class DetailView extends ConsumerStatefulWidget {
  final TaskModel task;

  const DetailView({super.key, required this.task});

  @override
  ConsumerState<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends ConsumerState<DetailView> {
  Future<void> _handleMarkDone() async {
    final vm = ref.read(detailTaskProvider(widget.task).notifier);
    final ok = await vm.markAsDone();
    final state = ref.read(detailTaskProvider(widget.task));

    if (!mounted) return;

    if (!ok) {
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task marked as done')),
    );

    Navigator.pop(context, true);
  }

  Future<void> _handleDelete() async {
    final stateBefore = ref.read(detailTaskProvider(widget.task));

    if (stateBefore.task.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task ID tidak ditemukan')),
      );
      return;
    }

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text(
            'Are you sure you want to delete "${stateBefore.task.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    final vm = ref.read(detailTaskProvider(widget.task).notifier);
    final ok = await vm.deleteTask();
    final state = ref.read(detailTaskProvider(widget.task));

    if (!mounted) return;

    if (!ok) {
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task deleted')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailTaskProvider(widget.task));
    final task = state.task;
    final dueType = state.dueType;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space12,
            vertical: AppSpacing.space26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTopComp(
  username: "Alif",
  detailCard: true,
  onAction: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskView(task: widget.task),
      ),
    );

   
    if (result == true) {
      if (!mounted) return;
     
      Navigator.pop(context, true);
    }
  },
),



              const SizedBox(height: AppSpacing.space24),

              ChipHeadComp(type: dueType),

              const SizedBox(height: AppSpacing.space16),

              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: AppSpacing.space10),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    DateHelper.formatShort(task.dueDate),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 12),

                  ChipStatusComp(status: task.status),
                ],
              ),

              const SizedBox(height: AppSpacing.space20),

              Container(height: 1, color: Colors.black12),

              const SizedBox(height: AppSpacing.space20),

              Text(
                task.desc,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: "Done",
                      onPressed: state.isLoading ? null : _handleMarkDone,
                      size: AppButtonSize.large,
                      variant: AppButtonVariant.primary,
                      fullWidth: true,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.space16),

                  InkWell(
                    onTap: state.isLoading ? null : _handleDelete,
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: AppColors.cardGray,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
