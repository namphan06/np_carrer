import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:np_career/model/mi.dart';
import 'package:np_career/services/call_api.dart';

class MiProvider extends ChangeNotifier {
  final AppService apiService;

  List<Mi> mis = [];

  bool _isFirstLoad = true;
  Timer? _timer;

  MiProvider({required this.apiService}) {
    init();
    _startPolling();
  }

  Future<void> init() async {
    mis = await apiService.fetchMis();
    _isFirstLoad = false;
    notifyListeners();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final newMis = await apiService.fetchMis();
      mis = newMis;
      notifyListeners();
    });
  }

  bool get isLoading => _isFirstLoad && mis.isEmpty;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
