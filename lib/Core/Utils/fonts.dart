import 'package:flutter/widgets.dart';

class AppFont {
  
  // Title 1
  static const TextStyle title1Regular = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400, // regular
  );

  static const TextStyle title1SemiBold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600, // semibold
  );

  static const TextStyle title1Bold = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700, // bold
  );

  // Title 2
  static const TextStyle title2Regular = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title2SemiBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title2Bold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  // Title 3
  static const TextStyle title3Regular = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle title3Semibold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle title3Bold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // Body
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySemibold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  // Subheadline
  static const TextStyle subheadlineRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle subheadlineSemibold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subheadlineBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // Footnote
  static const TextStyle footnoteRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle footnoteSemiBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle footnoteBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}

// caranya lif:
// Text(
//   'Hello Morro',
//   style: AppFont.title2Regular,
// );