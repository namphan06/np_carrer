import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:np_career/services/call_api.dart';

class FormulaProvider extends ChangeNotifier {
  final AppService apiService;

  List<dynamic> deductions = [];
  List<dynamic> rows = [];

  bool _isFirstLoad = true;
  Timer? _timer;

  FormulaProvider({required this.apiService}) {
    init();
    _startPolling(); // Gọi lại API định kỳ nếu muốn
  }

  Future<void> init() async {
    final data = await apiService.fetchFormula();
    if (data.isNotEmpty) {
      deductions = data['deductions'] ?? [];
      rows = data['rows'] ?? [];
    }
    _isFirstLoad = false;
    notifyListeners();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      final data = await apiService.fetchFormula();
      if (data.isNotEmpty) {
        deductions = data['deductions'] ?? [];
        rows = data['rows'] ?? [];
        notifyListeners();
      }
    });
  }

  bool get isLoading => _isFirstLoad && (deductions.isEmpty && rows.isEmpty);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
