import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:np_career/services/call_api.dart';
import 'package:np_career/model/mbti_question.dart';

class MbtiQuestionProvider extends ChangeNotifier {
  final AppService apiService;

  List<MbtiQuestion> questions = [];
  bool _isFirstLoad = true;

  Timer? _timer;

  MbtiQuestionProvider({required this.apiService}) {
    init();
    _startPolling();
  }

  Future<void> init() async {
    questions = await apiService.fetchMbtiQuestions();
    _isFirstLoad = false;
    notifyListeners();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final newQuestions = await apiService.fetchMbtiQuestions();
      questions = newQuestions;
      notifyListeners();
    });
  }

  bool get isLoading => _isFirstLoad && questions.isEmpty;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
