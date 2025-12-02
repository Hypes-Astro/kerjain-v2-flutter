
import 'package:flutter/material.dart';
import 'package:kerjain/features/Data/Enum/taskEnum.dart';

class DateHelper {
  static const List<String> _monthShort = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  // Format: Nov 24, 2025
  static String formatShort(DateTime d) {
    return "${_monthShort[d.month]} ${d.day}, ${d.year}";
  }

  static DueType calculateDueType(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(dueDate.year, dueDate.month, dueDate.day);

    if (dateOnly.isBefore(today)) {
      return DueType.deadline;
    }

    if (dateOnly == today) {
      return DueType.today;
    }

    if (dateOnly == today.add(const Duration(days: 1))) {
      return DueType.tomorrow;
    }

    if (dateOnly.isAfter(today) &&
        dateOnly.isBefore(today.add(const Duration(days: 7)))) {
      return DueType.soon;
    }

    return DueType.later;
  }
}