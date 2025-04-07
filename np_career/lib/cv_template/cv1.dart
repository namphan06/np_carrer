import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class Cv1 extends StatelessWidget {
  const Cv1({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> item1s = [
      "Tiếp nhận lắng nghe nhu cầu của 100 khách hàng mỗi ngày",
      "Giới thiệu sản phẩm phù hợp đến với sở thích, nhu cầu của khách. Nêu rõ tính năng, lợi ích của sản phẩm và so sánh với sản phẩm cùng loại của hãng hàng khác để thấy được sự khác biệt.",
      "Giới thiệu các chương trình khuyến mãi, ưu đãi riêng biệt dành cho khách để thúc đẩy nhu cầu mua hàng cao hơn. Đạt thành tích vượt 150% KPI được giao",
      "Thu thập những thông tin cần thiết dữ lượng data 5000 khách hàng tiềm năng để quảng bá sản phẩm, chăm sóc khách hàng.",
      "Phối hợp với các phòng ban khác lập phương án tăng doanh thu. Doanh thu công ty tăng 200% trong 1 năm."
    ];

    List<String> item2s = [
      "Tìm kiếm, tư vấn, giới thiệu cho khoảng 50 Khách hàng mỗi ngày về các Phần mềm hoặc các thiết bị Phần cứng (máy in, máy quét mã vạch...) dựa trên 5000 Data công ty có sẵn và nguồn tự tìm kiếm (khoảng 100 data mỗi ngày). ",
      "Hỗ trợ, hướng dẫn Khách hàng sử dụng Phần mềm qua Online hoặc Offline",
      "Thực hiện Sale và Ký kết hợp đồng. Vượt 150% KPI doanh thu năm.",
      "Duy trì, phát triển nguồn khách hàng tiềm năng",
    ];

    List<String> item3s = [
      "Xây dựng 5 sự kiện chào đón tân sinh viên với 5000 sinh viên tham gia.",
      "Hỗ trợ 500 tân sinh viên mỗi năm làm hồ sơ, tìm hiểu về nhà trường. ",
      "Giao tiếp và hỗ trợ thông tin cho phụ huynh.",
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(color: AppColor.greenPrimaryCv1),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColor.lightBackgroundColor),
                      child: Center(
                          child: Text(
                        "Nguyễn Văn A",
                        style: TextStyle(
                            color: AppColor.greenPrimaryCv1,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "Nhân viên tư vấn",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.greyColor),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(color: AppColor.greenPrimaryCv1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          child: ClipRRect(
                              child: Image.asset(
                            "assets/images_cv/pro_1_v2.webp",
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPersonalInfo("Ngày sinh", "15/05/1990"),
                              _buildPersonalInfo("Giới tính", "Nam/Nữ/khác"),
                              _buildPersonalInfo("Số điện thoại", "0123456789"),
                              _buildPersonalInfo(
                                  "Email", "tencuaban@example.com"),
                              _buildPersonalInfo(
                                  "Địa chỉ", "Quận X, Thành phố Y"),
                              _buildPersonalInfo("Website", "be.net/tencuaban"),
                              SizedBox(
                                height: 15,
                              ),
                              _buildObjective(),
                              SizedBox(
                                height: 15,
                              ),
                              _buildSkills(),
                              SizedBox(
                                height: 245,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "KINH NGHIỆM LÀM VIỆC",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColor.greenPrimaryCv1,
                                  ),
                                ),
                              ],
                            ),
                            _buildExperience(
                                item1s,
                                "Công ty ABC",
                                "08/2023 - 08/2025",
                                "Tổng đài viên chăm sóc khách hàng"),
                            SizedBox(
                              height: 10,
                            ),
                            _buildExperience(
                                item2s,
                                "Công ty BCD ",
                                "08/2023 - 08/2025",
                                "Chuyên Viên Tư Vấn Giải Pháp Phần Mềm"),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "HỌC VẤN",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColor.greenPrimaryCv1,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Đại học A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("2023 - 2024"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Quản trị kinh doanh"),
                                Text("Tốt nghiệp loại giỏi"),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Đại học B",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("2024 - 2025"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    "Khóa học Kỹ năng tư vấn và chăm sóc khách hàng"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "HOẠT ĐỘNG",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColor.greenPrimaryCv1,
                                  ),
                                ),
                              ],
                            ),
                            _buildExperience(item3s, "Câu lạc bộ Sự kiện A",
                                "08/2023 - 08/2025", "Ban Sự Kiện"),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "DANH HIỆU VÀ GIẢI THƯỞNG",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppColor.greenPrimaryCv1,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Tư vấn viên xuất sắc nhất Quý 3/2025",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text("2025"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Giải nhất Cuộc thi Văn Nghệ X",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text("2024"),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "CHỨNG CHỈ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColor.greenPrimaryCv1,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Chương trình đào tạo: Kỹ Năng Bán Hàng Qua Điện Thoại",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text("2024"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Khóa đào tạo Quản Lý Chăm Sóc Khách Hàng Chuyên Nghiệp",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text("2023"),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "THÔNG TIN THÊM",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColor.greenPrimaryCv1,
                                  ),
                                ),
                              ],
                            ),
                            Text("(Thông tin khác nếu có)"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "NGƯỜI GIỚI THIỆU",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColor.greenPrimaryCv1,
                                  ),
                                ),
                              ],
                            ),
                            Text("Ông Nguyễn Văn A"),
                            Text("CEO công ty A"),
                            Text("Email: abc@gmail.com"),
                            Text("Điện thoại: 0123 456 789")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.greyColor,
                fontSize: 12),
          ),
          Text(
            content,
            style:
                TextStyle(color: AppColor.lightBackgroundColor, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildObjective() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "MỤC TIÊU NGHỀ NGHIỆP",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.greyColor,
              fontSize: 20),
        ),
        Text(
          "02 năm kinh nghiệm tư vấn sản phẩm và khoá học tại các trung tâm tiếng Anh và cửa hàng công nghệ. Có thế mạnh trong việc tìm kiếm khách hàng mới, cung cấp thông tin và thuyết phục khách hàng. Là người nhanh nhạy, chịu áp lực tốt và thích làm việc trong môi trường áp lực cao. Hiện đang tìm kiếm công việc tư vấn khách hàng để giúp công ty tăng doanh thu và có thêm nhiều khách hàng mới.",
          style: TextStyle(color: AppColor.lightBackgroundColor, fontSize: 15),
        ),
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
              fontWeight: FontWeight.bold,
              color: AppColor.greyColor,
              fontSize: 20),
        ),
        _buildSkill("Tìm kiếm thông tin"),
        SizedBox(
          height: 10,
        ),
        _buildSkill("Chăm sóc khách hàng"),
        SizedBox(
          height: 10,
        ),
        _buildSkill("Tư vấn thông tin sản phẩm"),
        SizedBox(
          height: 10,
        ),
        _buildSkill("Tìm kiếm khách hàng tiềm năng"),
        SizedBox(
          height: 10,
        ),
        _buildSkill("Giao tiếp, thuyết trình, đàm phán tốt"),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildSkill(String label) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style:
                  TextStyle(color: AppColor.lightBackgroundColor, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 10,
              decoration:
                  BoxDecoration(color: AppColor.greyColor.withOpacity(0.5)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 10,
                  width: 60,
                  decoration:
                      BoxDecoration(color: AppColor.lightBackgroundColor),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildExperience(
      List<String> item1s, String company, String year, String position) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                company,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8), // Khoảng cách nhỏ giữa 2 Text
            Text(year),
          ],
        ),
        SizedBox(height: 10),
        Text(position),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: item1s.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "•",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item1s[index],
                    style: TextStyle(fontSize: 13),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
