import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/model/my_profile_model.dart';
import 'package:np_career/model/work_experience.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_controller.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_fb.dart';

class MyProfileData extends StatefulWidget {
  const MyProfileData({super.key});

  @override
  State<MyProfileData> createState() => _MyProfileDataState();
}

class _MyProfileDataState extends State<MyProfileData> {
  MyProfileFb _fb = Get.put(MyProfileFb());
  MyProfileController controller = Get.put(MyProfileController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double iconContainerWidth = size.width - 20; // cách 2 bên 10

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            /// Stack chứa Divider và Container icon
            Stack(
              alignment: Alignment.center,
              children: [
                // Divider
                Container(
                  width: double.infinity,
                  height: 2,
                  color: AppColor.greenPrimaryColor,
                ),

                // Container chứa icon, cách 2 bên mỗi bên 10
                Container(
                  width: iconContainerWidth,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColor.greenPrimaryColor,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(25),
                    child: SvgPicture.asset(
                      'assets/images/profile-round-1342-svgrepo-com.svg',
                      color: AppColor.greenPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            StreamBuilder<MyProfileModel>(
              stream: _fb.getProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No data found'));
                }

                // Lấy dữ liệu từ snapshot
                MyProfileModel profile = snapshot.data!;

                return Column(
                  children: [
                    // Gọi widget ProfileCard và truyền thông tin vào
                    ProfileCard(
                      icon: FontAwesomeIcons.user,
                      title: 'Full Name',
                      subtitle: profile.fullName,
                    ),
                    ProfileCard(
                      icon: FontAwesomeIcons.phone,
                      title: 'Phone',
                      subtitle: profile.phoneNumber,
                    ),
                    ProfileSection(
                      sectionTitle: 'Cities',
                      items: profile.city
                          .map((city) => {
                                'title': city,
                                'subtitle': '',
                              })
                          .toList(),
                      icon: FontAwesomeIcons.city,
                    ),
                    ProfileCard(
                      icon: FontAwesomeIcons.mapMarkerAlt,
                      title: 'Address',
                      subtitle: profile.address,
                    ),
                    ProfileCard(
                      icon: FontAwesomeIcons.graduationCap,
                      title: 'Education Level',
                      subtitle: profile.educationLevel,
                    ),
                    ProfileSection(
                      sectionTitle: 'Job Interests',
                      items: profile.jobInterests
                          .map((jobInterest) => {
                                'title': jobInterest,
                                'subtitle': '',
                              })
                          .toList(),
                      icon: FontAwesomeIcons.heart,
                    ),
                    ProfileSection(
                      sectionTitle: 'Preferred Job Types',
                      items: profile.preferredJobType
                          .map((jobType) => {
                                'title': jobType,
                                'subtitle': '',
                              })
                          .toList(),
                      icon: FontAwesomeIcons.briefcase,
                    ),
                    WorkExperienceSection(
                        workExperience: profile.workExperience),
                    InkWell(
                      onTap: () => controller.getCv(
                          profile.resumeId, profile.resumeType),
                      child: ProfileCard(
                        icon: FontAwesomeIcons.idCard,
                        title: 'Resume Name',
                        subtitle: profile.resumePosition,
                      ),
                    ),
                    // Bạn có thể thêm các Card tương tự cho các trường khác
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget ProfileCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColor.greenPrimaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget ProfileSection({
    required String sectionTitle, // Tiêu đề của nhóm
    required List<Map<String, String>> items, // Danh sách các item để hiển thị
    required IconData icon, // Icon dùng chung cho nhóm
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greenPrimaryColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.orangePrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            // Sử dụng SingleChildScrollView để cuộn nếu danh sách quá dài
            Container(
              height: 100, // Giới hạn chiều cao của container
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return ProfileCard(
                      icon: icon,
                      title: item['title']!,
                      subtitle: item['subtitle']!,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget WorkExperienceSection({
    required List<WorkExperience> workExperience,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greenPrimaryColor, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Work Experience", // Tiêu đề phần Work Experience
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.orangePrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            // Sử dụng SingleChildScrollView để cuộn nếu danh sách quá dài
            Container(
              height: 350, // Giới hạn chiều cao của container
              child: SingleChildScrollView(
                child: Column(
                  children: workExperience.map((exp) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColor.greyColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hiển thị thông tin công ty, thời gian, vị trí
                            ProfileCard(
                              icon: FontAwesomeIcons.building,
                              title: 'Company',
                              subtitle: exp.company,
                            ),
                            ProfileCard(
                              icon: FontAwesomeIcons.calendar,
                              title: 'Date',
                              subtitle: exp.date,
                            ),
                            ProfileCard(
                              icon: FontAwesomeIcons.userTie,
                              title: 'Position',
                              subtitle: exp.position,
                            ),
                            // Hiển thị chi tiết công việc (nếu có)
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                children: exp.list.map((detail) {
                                  return Text(
                                    '- $detail',
                                    style: TextStyle(fontSize: 14),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
