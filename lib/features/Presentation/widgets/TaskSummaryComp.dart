import 'package:flutter/material.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/fonts.dart';
import 'package:kerjain/Core/Utils/spacings.dart';

class TaskSummaryBarComp extends StatelessWidget {
  final int totalTask;
  final bool statusCard;
  final VoidCallback onAddTask;

  const TaskSummaryBarComp({
    super.key,
    required this.statusCard,
    required this.totalTask,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space14,
            vertical: AppSpacing.space8,
          ),
          decoration: BoxDecoration(
            color: AppColors.chipGray,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Task total",
                style: AppFont.bodySemibold.copyWith(
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$totalTask",
                  style: AppFont.bodySemibold.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),

        if(statusCard)
          GestureDetector(
          onTap: onAddTask,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space18,
              vertical: AppSpacing.space10,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.add,
                  size: 18,
                  color: AppColors.black,
                ),
                const SizedBox(width: AppSpacing.space6),
                Text(
                  "add task",
                  style: AppFont.bodySemibold.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
    );
  }
}
