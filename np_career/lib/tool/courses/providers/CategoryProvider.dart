import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:np_career/model/category.dart';
import 'package:np_career/services/call_api.dart';

class CategoryProvider extends ChangeNotifier {
  final AppService apiService;

  List<MyCategory> categories = [];

  bool _isFirstLoad = true; // Biến kiểm soát loading lần đầu

  Timer? _timer; // Timer để gọi API định kỳ

  CategoryProvider({required this.apiService}) {
    init();
    _startPolling();
  }

  Future<void> init() async {
    categories = await apiService.fetchCategories();
    _isFirstLoad = false;
    notifyListeners();
  }

  void _startPolling() {
    // Gọi API định kỳ mỗi 5 giây để cập nhật categories
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final newCategories = await apiService.fetchCategories();
      // So sánh dữ liệu mới và cũ nếu muốn tránh notifyListeners không cần thiết
      categories = newCategories;
      notifyListeners();
    });
  }

  bool get isLoading => _isFirstLoad && categories.isEmpty;

  @override
  void dispose() {
    _timer?.cancel(); // Hủy timer khi Provider bị hủy
    super.dispose();
  }
}
