import 'package:flutter/material.dart';
import 'package:kerjain/Core/Utils/colors.dart';
import 'package:kerjain/Core/Utils/fonts.dart';

enum AppButtonSize { large, medium, small }
enum AppButtonVariant { primary, secondary }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonSize size;
  final AppButtonVariant variant;
  final bool fullWidth;
  final bool enabled;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.size = AppButtonSize.large,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = true,
    this.enabled = true,
  });

  double get _height {
    switch (size) {
      case AppButtonSize.large:
        return 56;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.small:
        return 40;
    }
  }

  Color get _backgroundColor {
    if (!enabled) return Colors.grey.shade300;

    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.primary; 
      case AppButtonVariant.secondary:
        return AppColors.black;   
    }
  }

  Color get _foregroundColor {
    if (!enabled) return Colors.grey.shade600;

    switch (variant) {
      case AppButtonVariant.primary:
        return AppColors.black;  
      case AppButtonVariant.secondary:
        return AppColors.white;  
    }
  }

  @override
  Widget build(BuildContext context) {
    final btn = ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor,
        foregroundColor: _foregroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: AppFont.bodySemibold,
      ),
    );

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: _height,
        child: btn,
      );
    }

    return SizedBox(
      height: _height,
      child: btn,
    );
  }
}
