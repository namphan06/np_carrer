import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:np_career/api_key.dart';

import 'package:np_career/tool/mi/gemini_action.dart'; // Đảm bảo đường dẫn này đúng

class MiResultScreen extends StatefulWidget {
  final List<Map<String, dynamic>> answers; // Chỉ nhận dữ liệu câu trả lời

  const MiResultScreen({
    Key? key,
    required this.answers,
    // Bỏ geminiApiKey khỏi constructor
  }) : super(key: key);

  @override
  State<MiResultScreen> createState() => _MiResultScreenState();
}

class _MiResultScreenState extends State<MiResultScreen> {
  // _geminiService có thể null ban đầu, sẽ được khởi tạo sau khi load key
  GeminiMiService? _geminiService;
  Map<String, dynamic>? _analysisResult;
  bool _isLoading = true; // Bắt đầu với trạng thái loading
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeAndFetchAnalysis(); // Hàm mới để load key và bắt đầu phân tích
  }

  Future<void> _initializeAndFetchAnalysis() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true; // Đảm bảo đang loading
      _errorMessage = null; // Reset lỗi cũ
    });

    try {
      // 1. Load file .env
      // await dotenv.load(fileName: ".env");
      final String apiKey =
          //  dotenv.env['GEMINI_API_KEY'] ??
          geminiApiKey1 ?? ''; // Lấy key, mặc định là chuỗi rỗng

      // 2. Kiểm tra API Key
      if (apiKey.isEmpty) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _errorMessage =
              "Lỗi: GEMINI_API_KEY không được tìm thấy hoặc rỗng trong file .env. Vui lòng kiểm tra cấu hình.";
        });
        print(_errorMessage);
        return;
      }

      // 3. Khởi tạo GeminiMiService với API Key
      _geminiService = GeminiMiService(apiKey: apiKey);

      // 4. Thực hiện phân tích (chỉ khi service đã được khởi tạo thành công)
      await _fetchAnalysisData();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = "Lỗi khi tải API key hoặc khởi tạo dịch vụ: $e";
      });
      print("Lỗi trong _initializeAndFetchAnalysis: $e");
    }
  }

  // Hàm riêng để lấy dữ liệu phân tích, được gọi sau khi service sẵn sàng
  Future<void> _fetchAnalysisData() async {
    if (_geminiService == null) {
      if (!mounted) return;
      // Trường hợp này không nên xảy ra nếu logic trong _initializeAndFetchAnalysis đúng
      // nhưng vẫn kiểm tra để an toàn
      setState(() {
        _isLoading = false;
        _errorMessage =
            _errorMessage ?? "Lỗi: Dịch vụ phân tích chưa được khởi tạo.";
      });
      print("Lỗi: _fetchAnalysisData được gọi nhưng _geminiService là null.");
      return;
    }

    // Không cần setState isLoading = true ở đây nữa vì _initializeAndFetchAnalysis đã làm
    // hoặc nút "Thử lại" sẽ gọi lại _initializeAndFetchAnalysis

    try {
      final result = await _geminiService!.getMiAnalysis(
          widget.answers); // Sử dụng ! vì đã kiểm tra null ở trên
      if (!mounted) return;
      setState(() {
        _analysisResult = result;
        if (result.containsKey('error')) {
          _errorMessage = result['error'];
        }
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = "Lỗi không xác định khi phân tích: $e";
        _isLoading = false;
      });
      print("Lỗi trong _fetchAnalysisData: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results of Multiple Intelligence Analysis'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lỗi: $_errorMessage',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                // Nút "Thử lại" sẽ chạy lại toàn bộ quá trình load key và fetch
                onPressed: _initializeAndFetchAnalysis,
                child: const Text('Thử lại'),
              )
            ],
          ),
        ),
      );
    }

    if (_analysisResult == null) {
      // Trường hợp này có thể xảy ra nếu fetch thành công nhưng kết quả là null
      // Hoặc nếu có lỗi không mong muốn mà không set _errorMessage
      return const Center(
          child: Text(
              'Không có dữ liệu phân tích hoặc đã xảy ra lỗi không xác định.'));
    }

    List<dynamic> strengths = _analysisResult!['strengths'] ?? [];
    List<dynamic> weaknesses = _analysisResult!['weaknesses'] ?? [];
    String thinkingStyle = _analysisResult!['thinkingStyle'] ?? 'N/A';

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (strengths.isNotEmpty) _buildSectionTitle('Điểm mạnh'),
        ...strengths
            .map((item) => _buildListItem(item['title'], item['description'])),
        if (weaknesses.isNotEmpty) _buildSectionTitle('Điểm Yếu'),
        ...weaknesses
            .map((item) => _buildListItem(item['title'], item['description'])),
        _buildSectionTitle('Phong cách Tư duy'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Text(thinkingStyle),
        ),
        _buildSectionTitle('Phong cách Sáng tạo'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Text(_analysisResult!['creativityStyle'] ?? 'N/A'),
        ),
        _buildSectionTitle('Phong cách Giao tiếp'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Text(_analysisResult!['communicationStyle'] ?? 'N/A'),
        ),
        _buildSectionTitle('Phong cách Ra quyết định'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Text(_analysisResult!['decisionMakingStyle'] ?? 'N/A'),
        ),
        _buildSectionTitle('Tiềm năng Lãnh đạo'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Text(_analysisResult!['leadershipPotential'] ?? 'N/A'),
        ),
        _buildSectionTitle('Tiêu chí công việc phù hợp'),
        ...((_analysisResult!['suitableJobCriteria'] as List<dynamic>?)
                ?.map((item) => Padding(
                      padding: const EdgeInsets.only(left: 32.0, bottom: 4.0),
                      child: Text("• $item"),
                    )) ??
            [
              const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text("Không có dữ liệu"))
            ]),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListItem(String? title, String? description) {
    if (title == null || description == null) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8.0),
            Text(description),
          ],
        ),
      ),
    );
  }
}
