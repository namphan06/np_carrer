import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class Cv2 extends StatefulWidget {
  const Cv2({super.key});

  @override
  State<Cv2> createState() => _Cv2State();
}

class _Cv2State extends State<Cv2> {
  final List<Map<String, dynamic>> item1s = const [
    {
      'category': 'KỸ NĂNG CHUYÊN MÔN',
      'skills': [
        'Thành thạo ngôn ngữ lập trình JavaScript, Python, C, C++, Java',
        'Có kinh nghiệm HTML5, LESS, SASS/CSS3',
        'Thành thạo GitHub and PR-driven development',
        'Am hiểu về cấu trúc dữ liệu'
      ]
    },
    {
      'category': 'KỸ NĂNG MỀM',
      'skills': [
        'Kỹ năng giao tiếp rõ ràng, súc tích',
        'Tinh thần tự học, ham tìm hiểu',
        'Giải quyết vấn đề hiệu quả'
      ]
    },
  ];

  final List<Map<String, dynamic>> item2s = [
    {
      'position': 'Tổng Đài Viên Chăm Sóc Khách Hàng',
      'date': '08/2020 - 08/2022',
      'company': 'Công ty ABC TopCV',
      'responsibilities': [
        'Tiếp nhận lắng nghe nhu cầu của 100 khách hàng mỗi ngày',
        'Giới thiệu sản phẩm phù hợp đến với sở thích, nhu cầu của khách. Nêu rõ tính năng, lợi ích của sản phẩm và so sánh với sản phẩm cùng loại của hãng hàng khác để thấy được sự khác biệt.',
        'Giới thiệu các chương trình khuyến mãi, ưu đãi riêng biệt dành cho khách để thúc đẩy nhu cầu mua hàng cao hơn. Đạt thành tích vượt 150% KPI được giao.',
        'Thu thập những thông tin cần thiết dữ lượng data 5000 khách hàng tiềm năng để quảng bá sản phẩm, chăm sóc khách hàng.',
        'Phối hợp với các phòng ban khác lập phương án tăng doanh thu. Doanh thu công ty tăng 200% trong 1 năm.',
      ],
    },
    {
      'position': 'Chuyên Viên Tư Vấn Giải Pháp Phần Mềm',
      'date': '08/2018 - 08/2020',
      'company': 'Công ty BCD TopCV',
      'responsibilities': [
        'Tìm kiếm, tư vấn, giới thiệu cho khoảng 50 Khách hàng mỗi ngày về các Phần mềm hoặc các thiết bị Phần cứng (máy in, máy quét mã vạch...) dựa trên 5000 Data công ty có sẵn và nguồn tự tìm kiếm (khoảng 100 data mỗi ngày).',
        'Hỗ trợ, hướng dẫn Khách hàng sử dụng Phần mềm qua Online hoặc Offline',
        'Thực hiện Sale và Ký kết hợp đồng. Vượt 150% KPI doanh thu năm.',
        'Duy trì, phát triển nguồn khách hàng tiềm năng',
      ],
    },
  ];

  final List<Map<String, dynamic>> item3s = [
    {
      'major': 'Quản trị kinh doanh',
      'date': '2016 - 2020',
      'school': 'Đại học TopCV',
      'note': [
        'Tốt nghiệp loại Giỏi',
      ],
    },
    {
      'major': 'Khóa học Kỹ năng tư vấn và chăm sóc khách hàng',
      'date': '2021 - 2021',
      'school': 'Đại học TopCV',
      'note': [
        'Hoàn thành khóa học',
      ],
    },
  ];

  final List<Map<String, dynamic>> item4s = [
    {
      'achievement': 'Tư vấn viên xuất sắc nhất Quý 3/2020',
      'date': '2020',
    },
    {
      'achievement': 'Giải nhất Cuộc thi Văn Nghệ X',
      'date': '2019',
    },
  ];

  final List<Map<String, dynamic>> item5s = [
    {
      'training': 'Chương trình đào tạo: Kỹ Năng Bán Hàng Qua Điện Thoại',
      'date': '2022',
    },
    {
      'training': 'Khóa đào tạo Quản Lý Chăm Sóc Khách Hàng Chuyên Nghiệp',
      'date': '2021',
    },
  ];

  final List<Map<String, dynamic>> item6s = [
    {
      'role': 'Ban Sự Kiện',
      'date': '06/2016 - 09/2020',
      'organization': 'Câu lạc bộ Sự kiện, trường Đại học A',
      'responsibilities': [
        'Xây dựng 5 sự kiện chào đón tân sinh viên với 5000 sinh viên tham gia.',
        'Hỗ trợ 500 tân sinh viên mỗi năm làm hồ sơ, tìm hiểu về nhà trường.',
        'Giao tiếp và hỗ trợ thông tin cho phụ huynh.',
      ],
    },
  ];

  Widget buildSectionTitle(String title) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Divider(thickness: 1, color: Color(0xFFEC8F00)),
          ),
        ],
      );

  Widget buildContactRow(IconData icon, String text) => Row(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: const TextStyle(color: AppColor.lightBackgroundColor)),
          ),
        ],
      );

  Widget buildWorkExperience() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item2s.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item['position'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF353A3D)),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item['date'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF353A3D)),
                  ),
                ],
              ),
              Text(
                item['company'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF353A3D)),
              ),
              ...List<Widget>.from(item['responsibilities'].map((skill) => Text(
                    '- $skill',
                    style: const TextStyle(color: Color(0xFF353A3D)),
                  ))),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      );

  Widget buildActivities() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item6s.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item['role'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF353A3D)),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item['date'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF353A3D)),
                  ),
                ],
              ),
              Text(
                item['organization'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF353A3D)),
              ),
              ...List<Widget>.from(item['responsibilities'].map((skill) => Text(
                    '- $skill',
                    style: const TextStyle(color: Color(0xFF353A3D)),
                  ))),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      );

  Widget buildKnowledge() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item3s.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item['major'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF353A3D)),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item['date'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF353A3D)),
                  ),
                ],
              ),
              Text(
                item['school'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF353A3D)),
              ),
              ...List<Widget>.from(item['note'].map((note) => Text(
                    '$note',
                    style: const TextStyle(color: Color(0xFF353A3D)),
                  ))),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      );

  Widget buildSkills() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item1s.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['category'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColor.lightBackgroundColor),
              ),
              ...List<Widget>.from(item['skills'].map((skill) => Text(
                    '- $skill',
                    style:
                        const TextStyle(color: AppColor.lightBackgroundColor),
                  ))),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      );

  Widget buildAward() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item4s.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['date'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF353A3D)),
                    softWrap: true,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item['achievement'],
                    style:
                        const TextStyle(fontSize: 13, color: Color(0xFF353A3D)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      );

  Widget buildCertificate() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item5s.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['date'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF353A3D)),
                    softWrap: true,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item['training'],
                    style:
                        const TextStyle(fontSize: 13, color: Color(0xFF353A3D)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.01),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(size.width * 0.01),
                    width: size.width * 0.36,
                    decoration: const BoxDecoration(color: Color(0xFF353A3D)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/default.webp',
                          width: size.width * 0.35,
                          height: size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Nguyễn Mai Anh",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEC8F00),
                              fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "KY SƯ PHẦN MỀM IT",
                          style: TextStyle(
                              color: Color(0xFFEC8F00),
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: 1, color: Color(0xFFEC8F00)),
                        const SizedBox(height: 5),
                        buildContactRow(Icons.phone, '(024)6680 5588'),
                        const SizedBox(height: 15),
                        buildContactRow(Icons.mail, 'hotro@npcareers.vn'),
                        const SizedBox(height: 15),
                        buildContactRow(Icons.info, 'be.net/trungus'),
                        const SizedBox(height: 15),
                        buildContactRow(Icons.location_on, 'Quận A, Ha Noi'),
                        const SizedBox(height: 25),
                        buildSectionTitle('CÁC KỸ NĂNG'),
                        const SizedBox(height: 10),
                        buildSkills(),
                        const SizedBox(height: 10),
                        buildSectionTitle('SỞ THÍCH'),
                        const SizedBox(height: 10),
                        const Text(
                          'Teambuilding, ca hát, văn nghệ, thể thao.',
                          style:
                              TextStyle(color: AppColor.lightBackgroundColor),
                        ),
                        const SizedBox(height: 10),
                        buildSectionTitle('NGƯỜI GIỚI THIỆU'),
                        const SizedBox(height: 10),
                        const Text(
                          'Ông Nguyễn Văn A\n'
                          'CEO công ty A\n'
                          'Email: abc@gmail.com\n'
                          'Điện thoại: 0123 456 789\n\n'
                          'Bà Lê Thị B\n'
                          'Trưởng phòng nhân sự công ty B\n'
                          'Email: xyz@gmail.com\n'
                          'Điện thoại: 0123 456 789',
                          style:
                              TextStyle(color: AppColor.lightBackgroundColor),
                        ),
                        const SizedBox(height: 10),
                        buildSectionTitle('THÔNG TIN THÊM'),
                        const SizedBox(height: 10),
                        const Text(
                          '(Các thông tin khác nếu có)',
                          style:
                              TextStyle(color: AppColor.lightBackgroundColor),
                        ),
                        SizedBox(
                          height: 800,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          buildSectionTitle('MỤC TIÊU NGHỀ NGHIỆP'),
                          const SizedBox(height: 10),
                          Text(
                              "02 năm kinh nghiệm tư vấn sản phẩm và khoá học tại các trung tâm tiếng Anh và cửa hàng công nghệ. Có thế mạnh trong việc tìm kiếm khách hàng mới, cung cấp thông tin và thuyết phục khách hàng. Là người nhanh nhạy, chịu áp lực tốt và thích làm việc trong môi trường áp lực cao. Hiện đang tìm kiếm công việc tư vấn khách hàng để giúp công ty tăng doanh thu và có thêm nhiều khách hàng mới."),
                          SizedBox(
                            height: 10,
                          ),
                          buildSectionTitle('KINH NGHIỆM LÀM VIỆC'),
                          const SizedBox(height: 10),
                          buildWorkExperience(),
                          buildSectionTitle('HỌC VẤN'),
                          const SizedBox(height: 10),
                          buildKnowledge(),
                          buildSectionTitle('DANH HIỆU VÀ GIẢI THƯỞNG'),
                          const SizedBox(height: 10),
                          buildAward(),
                          buildSectionTitle('CHỨNG CHỈ'),
                          const SizedBox(height: 10),
                          buildCertificate(),
                          buildSectionTitle('HOẠT ĐỘNG'),
                          const SizedBox(height: 10),
                          buildActivities()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
