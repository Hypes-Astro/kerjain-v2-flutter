import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/fonts.dart';
import 'package:kerjain/Core/Utils/spacings.dart';
import 'package:kerjain/Core/Utils/icons.dart';
import 'package:kerjain/features/Data/Enum/taskEnum.dart';
import 'package:kerjain/features/Domain/Helper/dateHelper.dart';
import 'package:kerjain/features/Presentation/widgets/ChipHeadComp.dart';
import 'package:kerjain/features/Presentation/widgets/ChipStatusComp.dart';

class TaskCardComp extends StatelessWidget {
  final DueType dueType;
  final TaskStatus status;
  final String title;
  final String description;
  final DateTime date;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteTap;
  final bool cardDone;

  const TaskCardComp({
    super.key,
    required this.dueType,
    required this.status,
    required this.title,
    required this.description,
    required this.date,
    required this.cardDone,
    this.onTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.space16),
        padding: const EdgeInsets.all(AppSpacing.space20),
        constraints: BoxConstraints(
          minHeight: 130,
          maxHeight: cardDone ? 130 : 160,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardGray,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!cardDone) ChipHeadComp(type: dueType),

                      const SizedBox(height: AppSpacing.space6),

                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.bodySemibold,
                      ),

                      Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppFont.bodyRegular.copyWith(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // KANAN: Arrow
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.chipGray,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.textChipGray,
                  ),
                ),
              ],
            ),

            const SizedBox(width: AppSpacing.space12),
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(vertical: 2),
              color: Colors.black.withOpacity(0.08),
            ),

            const SizedBox(width: AppSpacing.space12),
            Container(
              margin: EdgeInsets.only(top: 1),
              child: Row(
                spacing: 12,
                children: [
                  // date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      const SizedBox(width: AppSpacing.space4),
                      Text(
                        DateHelper.formatShort(date),
                        style: AppFont.bodyRegular.copyWith(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChipStatusComp(status: status),
                      const SizedBox(width: AppSpacing.space12),
                      GestureDetector(
                        onTap: onDeleteTap,
                        child: SvgPicture.asset(
                          AppIcons.delete,
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
