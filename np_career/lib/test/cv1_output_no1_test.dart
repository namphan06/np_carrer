import 'package:flutter/material.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/skill.dart';
import 'package:np_career/model/work_experience.dart';
import 'package:np_career/model/knowledge.dart';
import 'package:np_career/model/activity.dart';
import 'package:np_career/model/award.dart';
import 'package:np_career/model/certificate.dart';

class ButtonTrigger extends StatelessWidget {
  const ButtonTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trigger Data to Cv1Output')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Tạo dữ liệu CvModel
            CvModel cvModel = CvModel(
              uid: "test1",
              fullName: "Nguyễn Văn A",
              position: "Nhân viên tư vấn",
              linkImage:
                  "https://drive.google.com/file/d/1gIISUN3vuGFXXVVC2IIFwd5FMvV22JKb/view?usp=sharing",
              dateOfBirth: "15/05/1990",
              sex: "Nam/Nữ/khác",
              phoneNumber: "0123456789",
              email: "tencuaban@example.com",
              address: "Quận X, Thành phố Y",
              website: "be.net/tencuaban",
              occupationalGoals:
                  "02 năm kinh nghiệm tư vấn sản phẩm và khoá học tại các trung tâm tiếng Anh và cửa hàng công nghệ. Có thế mạnh trong việc tìm kiếm khách hàng mới, cung cấp thông tin và thuyết phục khách hàng. Là người nhanh nhạy, chịu áp lực tốt và thích làm việc trong môi trường áp lực cao. Hiện đang tìm kiếm công việc tư vấn khách hàng để giúp công ty tăng doanh thu và có thêm nhiều khách hàng mới.",
              skills: [
                Skill(name: "Tìm kiếm thông tin", indicator: 60),
                Skill(name: "Chăm sóc khách hàng", indicator: 60),
                Skill(name: "Tư vấn thông tin sản phẩm", indicator: 60),
                Skill(name: "Tìm kiếm khách hàng tiềm năng", indicator: 60),
                Skill(
                    name: "Giao tiếp, thuyết trình, đàm phán tốt",
                    indicator: 60),
              ],
              workExperience: [
                WorkExperience(
                  company: "Công ty ABC",
                  date: "08/2023 - 08/2025",
                  position: "Tổng đài viên chăm sóc khách hàng",
                  list: [
                    "Tiếp nhận lắng nghe nhu cầu của 100 khách hàng mỗi ngày",
                    "Giới thiệu sản phẩm phù hợp đến với sở thích, nhu cầu của khách. Nêu rõ tính năng, lợi ích của sản phẩm và so sánh với sản phẩm cùng loại của hãng hàng khác để thấy được sự khác biệt.",
                    "Giới thiệu các chương trình khuyến mãi, ưu đãi riêng biệt dành cho khách để thúc đẩy nhu cầu mua hàng cao hơn. Đạt thành tích vượt 150% KPI được giao",
                    "Thu thập những thông tin cần thiết dữ lượng data 5000 khách hàng tiềm năng để quảng bá sản phẩm, chăm sóc khách hàng.",
                    "Phối hợp với các phòng ban khác lập phương án tăng doanh thu. Doanh thu công ty tăng 200% trong 1 năm.",
                  ],
                ),
                WorkExperience(
                  company: "Công ty BCD",
                  date: "08/2023 - 08/2025",
                  position: "Chuyên Viên Tư Vấn Giải Pháp Phần Mềm",
                  list: [
                    "Tìm kiếm, tư vấn, giới thiệu cho khoảng 50 Khách hàng mỗi ngày về các Phần mềm hoặc các thiết bị Phần cứng (máy in, máy quét mã vạch...) dựa trên 5000 Data công ty có sẵn và nguồn tự tìm kiếm (khoảng 100 data mỗi ngày). ",
                    "Hỗ trợ, hướng dẫn Khách hàng sử dụng Phần mềm qua Online hoặc Offline",
                    "Thực hiện Sale và Ký kết hợp đồng. Vượt 150% KPI doanh thu năm.",
                    "Duy trì, phát triển nguồn khách hàng tiềm năng",
                  ],
                ),
              ],
              knowledge: [
                Knowledge(
                  school: "Đại học A",
                  date: "2023 - 2024",
                  list: ["Quản trị kinh doanh", "Tốt nghiệp loại giỏi"],
                ),
                Knowledge(
                  school: "Đại học B",
                  date: "2024 - 2025",
                  list: ["Khóa học Kỹ năng tư vấn và chăm sóc khách hàng"],
                ),
              ],
              activities: [
                Activity(
                  name: "Câu lạc bộ Sự kiện A",
                  date: "08/2023 - 08/2025",
                  position: "Ban Sự Kiện",
                  list: [
                    "Xây dựng 5 sự kiện chào đón tân sinh viên với 5000 sinh viên tham gia.",
                    "Hỗ trợ 500 tân sinh viên mỗi năm làm hồ sơ, tìm hiểu về nhà trường.",
                    "Giao tiếp và hỗ trợ thông tin cho phụ huynh.",
                  ],
                ),
              ],
              award: [
                Award(
                    name: "Tư vấn viên xuất sắc nhất Quý 3/2025", date: "2025"),
                Award(name: "Giải nhất Cuộc thi Văn Nghệ X", date: "2024"),
              ],
              certificate: [
                Certificate(
                    name:
                        "Chương trình đào tạo: Kỹ Năng Bán Hàng Qua Điện Thoại",
                    date: "2024"),
                Certificate(
                    name:
                        "Khóa đào tạo Quản Lý Chăm Sóc Khách Hàng Chuyên Nghiệp",
                    date: "2023"),
              ],
              moreInformation: "Không có",
              introducer:
                  "Ông Nguyễn Văn A,CEO công ty A,Email: abc@gmail.com,Điện thoại: 0123 456 789",
              type: "CV1",
            );

            // Gọi enum để điều hướng
            EnumCvNo1Output.cv1_no1.run(cvModel.type, cvModel);
          },
          child: const Text('Truyền dữ liệu đến Cv1Output'),
        ),
      ),
    );
  }
}
