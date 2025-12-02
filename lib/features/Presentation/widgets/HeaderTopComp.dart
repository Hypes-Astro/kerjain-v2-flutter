import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerjain/Core/Utils/fonts.dart';
import 'package:kerjain/Core/Utils/icons.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/spacings.dart';

class HeaderTopComp extends StatelessWidget {
  final String username;
  final bool detailCard;
  final VoidCallback? onAction;
  final VoidCallback? onBack;

  const HeaderTopComp({
    super.key,
    required this.username,
    required this.detailCard,
    this.onAction,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (detailCard)
                GestureDetector(
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      Navigator.of(context).maybePop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: AppSpacing.space8,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.backArrow,
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, $username",
                    style: AppFont.bodySemibold,
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    detailCard
                        ? "Solved your task now"
                        : "you have some tasks to complete today.",
                    style: AppFont.bodyRegular
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(width: AppSpacing.space12),

        GestureDetector(
          onTap: onAction,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.space10),
            decoration: BoxDecoration(
              color: detailCard ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SvgPicture.asset(
              detailCard ? AppIcons.pencil : AppIcons.logout,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
