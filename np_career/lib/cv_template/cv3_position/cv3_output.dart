import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/cv_template/cv_setting/cv_setting_no1.dart';
import 'package:np_career/model/cv_model_v3.dart';

class Cv3Output extends StatefulWidget {
  final CvModelV3 model;
  const Cv3Output({super.key, required this.model});

  @override
  State<Cv3Output> createState() => _Cv3OutputState();
}

class _Cv3OutputState extends State<Cv3Output> {
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
        ...widget.model.knowledge.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ngày tháng - có thể chiếm một khoảng cố định
                SizedBox(
                  width: 80,
                  child: Text(
                    e.date ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.school ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      ...e.list.map((tx) {
                        return Column(
                          children: [Text(tx)],
                        );
                      })
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
        ...widget.model.certificate.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    e.date ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e.name ?? '',
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
        ...widget.model.workExperience.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    e.date ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.company ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        e.position ?? '',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 6),
                      ...List<Widget>.from(
                        (e.list as List<String>).map(
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
        ...widget.model.activities.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  child: Text(e.date ?? ''),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.name ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(e.position ?? ''),
                      const SizedBox(height: 6),
                      ...List<Widget>.from(
                        (e.list as List<String>).map(
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
        ...widget.model.award.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    e.date ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e.name ?? '',
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
        ...widget.model.skills
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
          widget.model.taste,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildProjectTable(Map<String, dynamic> project) {
    final labels = {
      "name": "Dự án",
      "customer": "Khách hàng",
      "describe": "Mô tả dự án",
      "quality": "Số lượng thành viên",
      "position": "Vị trí công việc",
      "role": "Vai trò trong dự án",
      "technology": "Công nghệ sử dụng",
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
        Text(
          widget.model.introducer,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color titleColor = Color(0xFF0E2452);
    Size size = MediaQuery.of(context).size;
    CvSettingNo1 controller = Get.put(CvSettingNo1());
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
                        _infoRow("Ngày sinh:",
                            "${controller.formatDate(widget.model.dateOfBirth)}"),
                        _infoRow("Giới tính:", "${widget.model.sex}"),
                        _infoRow("Điện thoại:", "${widget.model.phoneNumber}"),
                        _infoRow("Email:", "${widget.model.email}"),
                        _infoRow("Địa chỉ:", "${widget.model.address}"),
                        _infoRow("Website:", "${widget.model.website}"),
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
                  Text(widget.model.occupationalGoals)
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
              _buildProjectsList(widget.model.project
                  .map((project) => project.toMap())
                  .toList()),
              _buildReferees()
            ],
          ),
        ),
      ),
    );
  }
}
