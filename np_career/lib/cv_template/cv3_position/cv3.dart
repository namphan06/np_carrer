import 'package:flutter/material.dart';

class Cv3 extends StatefulWidget {
  const Cv3({super.key});

  @override
  State<Cv3> createState() => _Cv3State();
}

class _Cv3State extends State<Cv3> {
  final List<Map<String, dynamic>> item3s = [
    {
      'major': 'Quản trị kinh doanh',
      'date': '2016 - 2020',
      'school': 'Đại học NPCareers',
      'detail': 'Chuyên ngành Quản trị doanh nghiệp'
    },
    {
      'major': 'Khóa học Kỹ năng tư vấn và chăm sóc khách hàng',
      'date': '2021 - 2021',
      'school': 'Đại học NPCareers',
      'detail': "Chuyên ngành Maketing"
    },
  ];

  final List<String> hobbies = [
    "Đọc sách",
    "Du lịch",
    "Thể thao",
  ];

  final List<Map<String, dynamic>> workExperiences = [
    {
      'date': '2023 - 2024',
      'company': 'H GROUP NPCareers',
      'position': 'Nhân viên kinh doanh',
      'details': [
        'Quản lý hồ sơ của 15+ nhóm khách hàng lớn',
        'Tìm kiếm khách hàng mới thông qua các kênh: LinkedIn, Facebook, Zalo, Email Marketing. Phát triển mạng lưới khách hàng lên đến 1500 dữ liệu khách hàng tiềm năng',
        'Phân tích nhu cầu khách hàng, đưa ra đề xuất cải tiến hoạt động bán hàng',
        'Tư vấn gói sản phẩm/dịch vụ phù hợp với nhu cầu sử dụng và ngân sách khách hàng',
        'Phối hợp cùng bộ phận Marketing triển khai các hoạt động quảng cáo, khuyến mãi để mở rộng khách hàng tiềm năng',
        'Tiếp nhận và xử lý đơn đặt hàng',
        'Chăm sóc, hỗ trợ khách hàng sau mua',
        'Doanh số vượt 15% KPI mỗi Quý',
      ],
    },
    {
      'date': '2021 - 2022',
      'company': 'S GROUP NPCareers',
      'position': 'Nhân viên kinh doanh',
      'details': [
        'Tìm kiếm 1000+ khách hàng mới và chăm sóc tệp khách hàng cũ',
        'Hỗ trợ giải đáp thắc mắc, khiếu nại của khách hàng về sản phẩm/dịch vụ',
        'Tổng hợp thông tin, đánh giá tình hình kinh doanh của đối thủ, đề xuất phương án triển khai để tăng doanh số bán hàng cho doanh nghiệp',
        'Gửi mail thông báo chương trình khuyến mãi, hội chợ, trải nghiệm sản phẩm cho khách hàng',
        'Tổ chức triển khai sự kiện, chương trình PR sản phẩm của công ty',
        'Lên dự thảo hợp đồng, báo giá gửi khách hàng',
        'Làm báo cáo tuần/tháng/quý về tiến độ công việc cho cấp trên',
      ],
    }
  ];

  final List<Map<String, dynamic>> activities = [
    {
      'date': '2015 - 2017',
      'organization': 'Câu lạc bộ Kinh doanh, ĐH Phenikaa',
      'position': 'Ban truyền thông',
      'details': [
        'Tham gia giao lưu, chia sẻ kiến thức kinh doanh',
        'Tìm kiếm nhà tài trợ, kêu gọi tài trợ để thêm ngân sách tổ chức các hoạt động cho câu lạc bộ',
        'Hỗ trợ các công ty Startup tổ chức các chương trình hướng nghiệp cùng sinh viên của Phenikaa',
      ],
    },
  ];

  final List<Map<String, String>> certificates = [
    {
      'year': '2021',
      'name': 'SCPS™ – Chuyên viên bán hàng chuyên nghiệp',
    },
    {
      'year': '2022',
      'name': 'Kỹ năng bán hàng - Selling Skill (Chứng chỉ Quốc tế CBP)',
    },
  ];

  final List<Map<String, String>> awards = [
    {
      'year': '2022',
      'title': 'Nhân viên Kinh doanh xuất sắc nhất Quý 3/2022',
    },
  ];

  final List<String> skills = [
    "Kỹ năng giao tiếp",
    "Kỹ năng đàm phán",
    "Kỹ năng lập kế hoạch",
    "Kỹ năng tư duy sáng tạo",
  ];

  final List<Map<String, dynamic>> projects = [
    {
      "projectName":
          "NỀN TẢNG ĐÁNH GIÁ NĂNG LỰC ỨNG VIÊN/NHÂN VIÊN - h group (2022 - 2024)",
      "client": "Công ty/Doanh nghiệp, Trường ĐH",
      "projectDescription": "",
      "teamSize": "10",
      "position": "NHÂN VIÊN KINH DOANH",
      "roleInProject": [
        "Nghiên cứu thị trường, đối thủ để tìm kiếm khách hàng tiềm năng...",
        "Tiếp nhận data khách hàng, phân nhóm (khách hàng duy trì và khách hàng mới)",
        "Gọi điện, gửi mail marketing, pitching trực tiếp với khách hàng...",
        "Hướng dẫn khách hàng sử dụng nền tảng (tạo tài khoản, soạn đề test, tính điểm, xuất file...)",
        "Đàm phán, soạn thảo hợp đồng",
        "Tổng hợp phản hồi của khách hàng và báo lỗi cho bộ phận IT",
        "Tham gia các workshop giới thiệu nền tảng",
        "Tạo báo cáo định kỳ gửi cấp trên",
      ],
      "technologiesUsed": "",
    },
    {
      "projectName": "Dự án khác 1 (2020 - 2021)",
      "client": "Khách hàng ví dụ khác",
      "projectDescription": "Mô tả dự án ví dụ",
      "teamSize": "5",
      "position": "Chuyên viên phát triển",
      "roleInProject": [
        "Phát triển tính năng A",
        "Phân tích và thiết kế hệ thống",
        "Hỗ trợ triển khai và đào tạo người dùng",
      ],
      "technologiesUsed": "Flutter, Firebase",
    },
    // Thêm dự án khác ở đây nếu cần
  ];

  Widget _infoRow(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 6),
        // Expanded để text content có thể xuống dòng và không bị tràn
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildKnowledge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "HỌC VẤN",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
                child: Divider(
              thickness: 1,
            )),
          ],
        ),
        ...item3s.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ngày tháng - có thể chiếm một khoảng cố định
                SizedBox(
                  width: 80,
                  child: Text(
                    e['date'] ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['school'] ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(e['major'] ?? ''),
                      const SizedBox(height: 4),
                      Text(e['detail'] ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCertificates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CHỨNG CHỈ",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
                child: Divider(
              thickness: 1,
            )),
          ],
        ),
        ...certificates.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    e['year'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e['name'] ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildWorkExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "KINH NGHIỆM LÀM VIỆC",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(thickness: 1),
        ...workExperiences.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    e['date'] ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['company'] ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        e['position'] ?? '',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 6),
                      ...List<Widget>.from(
                        (e['details'] as List<String>).map(
                          (detail) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("• ",
                                    style: TextStyle(fontSize: 14)),
                                Expanded(
                                  child: Text(
                                    detail,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "HOẠT ĐỘNG",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
                child: Divider(
              thickness: 1,
            )),
          ],
        ),
        ...activities.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(e['date'] ?? ''),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['organization'] ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(e['position'] ?? ''),
                      const SizedBox(height: 6),
                      ...List<Widget>.from(
                        (e['details'] as List<String>).map(
                          (detail) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("• ",
                                    style: TextStyle(fontSize: 14)),
                                Expanded(
                                  child: Text(
                                    detail,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAwards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DANH HIỆU VÀ GIẢI THƯỞNG",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
                child: Divider(
              thickness: 1,
            )),
          ],
        ),
        ...awards.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    e['year'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e['title'] ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CÁC KỸ NĂNG",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
        ...skills
            .map((skill) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        skill,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ],
                ))
            .toList(),
      ],
    );
  }

  Widget _buildHobbies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "SỞ THÍCH",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          hobbies.join(", "),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildProjectTable(Map<String, dynamic> project) {
    final labels = {
      "projectName": "Dự án",
      "client": "Khách hàng",
      "projectDescription": "Mô tả dự án",
      "teamSize": "Số lượng thành viên",
      "position": "Vị trí công việc",
      "roleInProject": "Vai trò trong dự án",
      "technologiesUsed": "Công nghệ sử dụng",
    };

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(150),
        1: FlexColumnWidth(),
      },
      border: TableBorder.all(color: Colors.grey.shade300, width: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: labels.entries.map((entry) {
        final key = entry.key;
        final label = entry.value;
        final value = project[key];

        Widget content;
        if (value is List<String>) {
          content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: value.map((detail) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 14)),
                    Expanded(
                        child:
                            Text(detail, style: const TextStyle(fontSize: 14))),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          content = Text(value ?? '', style: const TextStyle(fontSize: 14));
        }

        return TableRow(
          children: [
            Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.all(8),
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: content,
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildProjectsList(List<Map<String, dynamic>> projects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DỰ ÁN",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            return _buildProjectTable(projects[index]);
          },
        ),
      ],
    );
  }

  Widget _buildReferees() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "NGƯỜI GIỚI THIỆU",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          '''Ông Lê Quang Q

Sales Manager H GROUP

Email: abc@gmail.com

Điện thoại: 0123 456 789

Bà Mai Ngọc H

Sales Manager S GROUP

Email: xyz@gmail.com

Điện thoại: 0123 456 789
''',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color titleColor = Color(0xFF0E2452);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nguyễn Văn A",
                          style: TextStyle(
                            color: titleColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _infoRow("Ngày sinh:", "15/05/1990"),
                        _infoRow("Giới tính:", "Nam/Nữ"),
                        _infoRow("Điện thoại:", "0123456789"),
                        _infoRow("Email:", "tencuaban@example.com"),
                        _infoRow("Địa chỉ:", "Quận X, Thành phố Y"),
                        _infoRow("Website:", "be.nettencuaban"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'assets/images/default.webp',
                      width: size.width * 0.35,
                      height: size.width * 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MỤC TIÊU NGHỀ NGHIỆP",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                      )),
                    ],
                  ),
                  Text(
                      "Tôi có 3 năm kinh nghiệm tại vị trí Nhân viên kinh doanh đa ngành. Với nền tảng kiến thức về quy trình bán hàng, kỹ năng nắm bắt tâm lý khách hàng và kinh nghiệm chốt sales đã tích lũy được, tôi tin rằng mình có thể phát triển mạnh mẽ hơn trong ngành Sales. Trong vòng 5 năm tới, tôi mong muốn thăng tiến lên vị trí Trưởng Phòng Kinh Doanh.")
                ],
              ),
              SizedBox(
                height: 15,
              ),
              _buildKnowledge(),
              _buildWorkExperience(),
              _buildActivities(),
              _buildCertificates(),
              _buildAwards(),
              _buildSkills(),
              _buildHobbies(),
              SizedBox(
                height: 15,
              ),
              _buildProjectsList(projects),
              _buildReferees()
            ],
          ),
        ),
      ),
    );
  }
}
