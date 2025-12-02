import 'package:flutter/material.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/fonts.dart';
import 'package:kerjain/features/Data/Enum/taskEnum.dart';



class ChipHeadComp extends StatelessWidget {
  final DueType type;

  const ChipHeadComp({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    String text = "";
    Color bg = AppColors.chipGray;
    Color textColor = AppColors.textChipGray;

    switch (type) {
      case DueType.today:
        text = "Due Today";
        bg = AppColors.chipRed;
        textColor = AppColors.textChipRed;
        break;
      case DueType.tomorrow:
        text = "Due Tomorrow";
        bg = AppColors.chipOrange;
        textColor = AppColors.textChipOrange;
        break;
      case DueType.deadline:
        text = "Deadline";
        bg = AppColors.chipRed;
        textColor = AppColors.textChipRed;
        break;
      case DueType.soon:
        text = "Due Soon";
        bg = AppColors.chipOrange;
        textColor = AppColors.textChipOrange;
        break;
      case DueType.later:
        text = "Due Later";
        bg = AppColors.chipGreen;
        textColor = AppColors.textChipGreen;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
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


// nanti :
/*
ChipHeadComp(type: DueType.tomorrow)
 */