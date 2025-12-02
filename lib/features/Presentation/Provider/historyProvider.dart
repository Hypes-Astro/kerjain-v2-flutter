import 'package:flutter_riverpod/legacy.dart';

import 'package:kerjain/features/Presentation/Pages/History/HistoryState.dart';
import 'package:kerjain/features/Presentation/Pages/History/HistoryViewModel.dart';
import 'package:kerjain/features/Presentation/Provider/homeProvider.dart'; 


final historyProvider =
    StateNotifierProvider<HistoryViewModel, HistoryState>((ref) {
  final service = ref.watch(taskServiceProvider);
  return HistoryViewModel(service);
});
