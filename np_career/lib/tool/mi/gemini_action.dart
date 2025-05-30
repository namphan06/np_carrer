import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

// Định nghĩa các loại trí thông minh và tên đầy đủ của chúng
const Map<String, String> intelligenceTypeFullNames = {
  'IA': 'Thấu hiểu Nội tâm (Intrapersonal - IA)',
  'BO': 'Vận động Cơ thể (Bodily/Kinesthetic - BO)',
  'NA': 'Thấu hiểu Thiên nhiên (Naturalist - NA)',
  'SP': 'Bao quát Không gian (Spatial - SP)',
  'LI': 'Xử lý Ngôn ngữ (Linguistic - LI)',
  'LO': 'Tư duy Logic/Toán (Logic/Mathematical - LO)',
  'MU': 'Âm nhạc (Musical - MU)',
  'IN': 'Tương tác Xã hội (Interpersonal - IN)', // Thêm nếu có
  'EX': 'Triết học/Hiện sinh (Existential - EX)', // Thêm nếu có
  // Thêm các loại khác nếu có trong bài trắc nghiệm của bạn
};

// Định nghĩa ý nghĩa điểm số
const Map<int, String> scoreMeanings = {
  1: 'Hoàn toàn sai',
  2: 'Thường là sai',
  3: 'Không rõ ràng',
  4: 'Đôi lúc đúng',
  5: 'Hoàn toàn đúng',
};

class GeminiMiService {
  final String apiKey; // Thay bằng API Key của bạn
  late final GenerativeModel _model;

  GeminiMiService({required this.apiKey}) {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest', // Hoặc 'gemini-pro'
      apiKey: apiKey,
      // Cấu hình an toàn có thể được điều chỉnh nếu cần
      // safetySettings: [
      //   SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
      //   SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      // ],
    );
  }

  Future<Map<String, dynamic>> getMiAnalysis(
      List<Map<String, dynamic>> userAnswers) async {
    // Chuyển đổi danh sách câu trả lời thành chuỗi JSON để đưa vào prompt
    final answersJsonString = jsonEncode(userAnswers);
    final scoreMeaningsString = jsonEncode(
        scoreMeanings.map((key, value) => MapEntry(key.toString(), value)));
    final intelligenceTypesString = jsonEncode(intelligenceTypeFullNames);

    final prompt = """
    Dựa trên kết quả trắc nghiệm Đa trí thông minh MI sau đây:
    Dữ liệu câu trả lời của người dùng (định dạng: [{"answer": điểm, "type": "mã_loại_trí_thông_minh"}]):
    $answersJsonString

    Giải thích ý nghĩa điểm số:
    $scoreMeaningsString

    Giải thích các mã loại trí thông minh:
    $intelligenceTypesString

    YÊU CẦU:
    Hãy phân tích các câu trả lời này để đưa ra nhận xét chi tiết.
    - Điểm mạnh: Là những loại hình trí thông minh mà người dùng có nhiều câu trả lời là 4 ('Đôi lúc đúng') hoặc 5 ('Hoàn toàn đúng').
    - Điểm yếu: Là những loại hình trí thông minh mà người dùng có nhiều câu trả lời là 1 ('Hoàn toàn sai') hoặc 2 ('Thường là sai').
    - Các câu trả lời 3 ('Không rõ ràng') được coi là trung tính hoặc không nổi bật.

    Vui lòng trả về kết quả dưới dạng một đối tượng JSON DUY NHẤT, không có bất kỳ văn bản nào khác trước hoặc sau JSON.
    Cấu trúc JSON mong muốn như sau:
    {
      "strengths": [
        {
          "title": "Tên đầy đủ của điểm mạnh (ví dụ: ${intelligenceTypeFullNames['IA']})",
          "description": "Mô tả chi tiết về điểm mạnh này, dựa trên các câu trả lời và theo văn phong đã cho. Nội dung cần sâu sắc và cá nhân hóa."
        }
      ],
      "weaknesses": [
        {
          "title": "Tên đầy đủ của điểm yếu (ví dụ: ${intelligenceTypeFullNames['SP']})",
          "description": "Mô tả chi tiết về điểm yếu này, dựa trên các câu trả lời và theo văn phong đã cho. Nội dung cần sâu sắc và cá nhân hóa."
        }
      ],
      "thinkingStyle": "Mô tả phong cách tư duy dựa trên các điểm mạnh và điểm yếu tổng hợp. Ví dụ: 'Bạn có khả năng tư duy khi làm việc một mình...'",
      "creativityStyle": "Mô tả phong cách sáng tạo. Ví dụ: 'Sự sáng tạo của bạn rất tuyệt vời...'",
      "communicationStyle": "Mô tả phong cách giao tiếp. Ví dụ: 'Có lẽ bạn thường là người ngồi im lặng...'",
      "decisionMakingStyle": "Mô tả phong cách ra quyết định. Ví dụ: 'Những quyết định của bạn đôi khi bị người khác nói là bảo thủ...'",
      "leadershipPotential": "Đánh giá tiềm năng lãnh đạo (ví dụ: '1 / 5 (Trung bình)', '3 / 5 (Khá)'). Hãy ước lượng dựa trên tổng thể.",
      "suitableJobCriteria": [
        "Tiêu chí công việc phù hợp 1 (ví dụ: Có không gian làm việc giữ được tính riêng tư)",
        "Tiêu chí công việc phù hợp 2",
        "Tiêu chí công việc phù hợp 3"
      ]
    }

    LƯU Ý QUAN TRỌNG:
    - Văn phong của các mô tả phải tương tự như ví dụ bạn đã cung cấp trong yêu cầu ban đầu (ví dụ về 'Thấu hiểu Nội tâm', 'Vận động Cơ thể', 'Bao quát Không gian',...).
    - Nội dung mô tả cho từng phần (điểm mạnh, điểm yếu, tư duy,...) phải sâu sắc, chi tiết, được cá nhân hóa dựa trên các câu trả lời và các loại trí thông minh được xác định.
    - Nếu một loại trí thông minh không có đủ dữ liệu nổi bật (ví dụ, tất cả câu trả lời đều là 3, hoặc không có câu hỏi nào cho loại đó), không cần liệt kê nó trong điểm mạnh hay điểm yếu.
    - Trong phần "strengths" và "weaknesses", hãy sử dụng tên đầy đủ của loại trí thông minh (bao gồm cả mã trong ngoặc đơn) như trong `intelligenceTypeFullNames` đã cung cấp.
    - Đảm bảo rằng kết quả trả về CHỈ LÀ một chuỗi JSON hợp lệ, không có markdown formatting (như ```json ... ```) bao quanh.
    """;

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final responseText = response.text;

      if (responseText == null) {
        throw Exception('Không nhận được phản hồi từ Gemini.');
      }

      // Cố gắng loại bỏ các dấu ```json và ``` nếu có
      String cleanedJsonString = responseText.trim();
      if (cleanedJsonString.startsWith("```json")) {
        cleanedJsonString = cleanedJsonString.substring(7);
      }
      if (cleanedJsonString.endsWith("```")) {
        cleanedJsonString =
            cleanedJsonString.substring(0, cleanedJsonString.length - 3);
      }
      cleanedJsonString = cleanedJsonString.trim();

      // Parse JSON
      final Map<String, dynamic> analysisResult = jsonDecode(cleanedJsonString);
      return analysisResult;
    } catch (e) {
      print('Lỗi khi gọi Gemini API hoặc parse JSON: $e');
      print('Prompt đã gửi: $prompt');
      print(
          'Phản hồi thô từ Gemini (nếu có): ${(e is GenerativeAIException && e.message != null) ? e.message : "Không có"}');
      // Trả về một map rỗng hoặc cấu trúc lỗi tùy theo cách bạn muốn xử lý
      return {
        "error": "Đã xảy ra lỗi trong quá trình phân tích: ${e.toString()}",
        "strengths": [],
        "weaknesses": [],
        "thinkingStyle": "Không thể phân tích.",
        "creativityStyle": "Không thể phân tích.",
        "communicationStyle": "Không thể phân tích.",
        "decisionMakingStyle": "Không thể phân tích.",
        "leadershipPotential": "Không thể đánh giá.",
        "suitableJobCriteria": []
      };
    }
  }
}
