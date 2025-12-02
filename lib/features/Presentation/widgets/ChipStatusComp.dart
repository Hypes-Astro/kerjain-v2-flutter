import 'package:flutter/material.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/fonts.dart';
import 'package:kerjain/features/Data/Enum/taskEnum.dart';



class ChipStatusComp extends StatelessWidget {
  final TaskStatus status;

  const ChipStatusComp({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String text = "";
    Color bg = AppColors.chipGray;
    Color textColor = AppColors.textChipGray;

    switch (status) {
      case TaskStatus.inProgress:
        text = "In Progress";
        bg = AppColors.chipBlue;
        textColor = AppColors.textChipBlue;
        break;

      case TaskStatus.notStarted:
        text = "Not Started";
        bg = AppColors.chipGray;
        textColor = AppColors.textChipGray;
        break;

      case TaskStatus.done:
        text = "Done";
        bg = AppColors.chipGreen;
        textColor = AppColors.textChipGreen;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppFont.bodySemibold.copyWith(
          fontSize: 13,
          color: textColor,
        ),
      ),
    );
  }
}


// cara pake : ChipStatusComp(status: TaskStatus.inProgress),
