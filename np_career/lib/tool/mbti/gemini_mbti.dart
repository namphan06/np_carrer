import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiMbtiService {
  final String apiKey;
  late final GenerativeModel _model;

  GeminiMbtiService({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
  }

  Future<String> analyzeMbti(List<String> selectedAnswers) async {
    final input = '''
Tôi có một người dùng đã hoàn thành bài kiểm tra MBTI. Đây là danh sách các câu trả lời đã chọn:
${selectedAnswers.join('\n')}

Dựa vào các câu trả lời đó, hãy:
1. Dự đoán nhóm MBTI phù hợp nhất (ví dụ: INTJ, ENFP...).
2. Giải thích ngắn gọn (dưới 100 từ) về tính cách người dùng theo nhóm đó.
''';

    try {
      final response = await _model.generateContent([Content.text(input)]);
      return response.text ?? "❌ Không nhận được phản hồi từ Gemini.";
    } catch (e) {
      return "❌ Lỗi khi gửi yêu cầu đến Gemini: $e";
    }
  }
}
