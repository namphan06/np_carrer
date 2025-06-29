import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:np_career/company/application_apply/interview_schedule/interview_schedule_controller.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/cv_template/cv_setting/cv_setting_no1.dart';
import 'package:np_career/model/activity.dart';
import 'package:np_career/model/award.dart';
import 'package:np_career/model/certificate.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/knowledge.dart';
import 'package:np_career/model/skill.dart';
import 'package:np_career/model/work_experience.dart';

class Cv1Output extends StatefulWidget {
  final CvModel cvModel;
  const Cv1Output({required this.cvModel});

  @override
  State<Cv1Output> createState() => _Cv1OutputState();
}

class _Cv1OutputState extends State<Cv1Output> {
  final CvSettingNo1 controller = Get.put(CvSettingNo1());
  final InterviewScheduleController controller_interview =
      Get.put(InterviewScheduleController());

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller_interview.repaintKey,
      child: Scaffold(
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
                          widget.cvModel.fullName,
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
                          widget.cvModel.position,
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
                      decoration:
                          BoxDecoration(color: AppColor.greenPrimaryCv1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 155,
                            child: ClipRRect(
                              child: Image.network(
                                widget.cvModel.img.url,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildPersonalInfo(
                                    "Ngày sinh",
                                    controller.formatDate(
                                        widget.cvModel.dateOfBirth)),
                                _buildPersonalInfo(
                                    "Giới tính", widget.cvModel.sex),
                                _buildPersonalInfo("Số điện thoại",
                                    widget.cvModel.phoneNumber),
                                _buildPersonalInfo(
                                    "Email", widget.cvModel.email),
                                _buildPersonalInfo(
                                    "Địa chỉ", widget.cvModel.address),
                                _buildPersonalInfo(
                                    "Website", widget.cvModel.website),
                                SizedBox(
                                  height: 15,
                                ),
                                _buildObjective(),
                                SizedBox(
                                  height: 15,
                                ),
                                _buildSkills(widget.cvModel.skills),
                                SizedBox(
                                  height: 100,
                                  //245
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
                              ...widget.cvModel.workExperience
                                  .map((e) => _buildExperience(e))
                                  .toList(),
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
                                  ...widget.cvModel.knowledge
                                      .map((e) => _buildKnowledge(e))
                                      .toList(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "HOẠT ĐỘNG",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColor.greenPrimaryCv1,
                                    ),
                                  ),
                                  ...widget.cvModel.activities
                                      .map((e) => buildActivity(e))
                                      .toList(),
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
                                  ...widget.cvModel.award
                                      .map((e) => _buildAward(e))
                                      .toList(),
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
                                  ...widget.cvModel.certificate
                                      .map((e) => _buildCertificate(e))
                                      .toList(),
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
                              Text(widget.cvModel.moreInformation),
                              _buildInstructor(widget.cvModel.introducer),
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
          widget.cvModel.occupationalGoals,
          style: TextStyle(color: AppColor.lightBackgroundColor, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildSkills(List<Skill> skills) {
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
        SizedBox(height: 10),
        ...skills.map((skill) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildSkill(skill),
            )),
      ],
    );
  }

  Widget _buildSkill(Skill skill) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skill.name,
          style: TextStyle(
            color: AppColor.lightBackgroundColor,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 100,
          height: 10,
          decoration: BoxDecoration(
            color: AppColor.greyColor.withOpacity(0.5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 10,
              width: (100 * (skill.indicator / 100)).clamp(0, 100).toDouble(),
              decoration: BoxDecoration(
                color: AppColor.lightBackgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExperience(WorkExperience exp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                exp.company,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Text(exp.date),
          ],
        ),
        SizedBox(height: 10),
        Text(exp.position),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: exp.list.length,
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
                    exp.list[index],
                    style: TextStyle(fontSize: 13),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildKnowledge(Knowledge k) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    k.school,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(k.date),
                ],
              ),
            ),
          ],
        ),
        ...k.list.map((text) => Text(text)).toList(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildAward(Award award) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            award.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(award.date),
      ],
    );
  }

  Widget _buildCertificate(Certificate cert) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              cert.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(cert.date),
        ],
      ),
    );
  }

  Widget buildActivity(Activity act) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                act.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Text(act.date),
          ],
        ),
        SizedBox(height: 10),
        Text(act.position),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: act.list.length,
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
                    act.list[index],
                    style: TextStyle(fontSize: 13),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildInstructor(String instructor) {
    List<String> lines = instructor.split(',').map((e) => e.trim()).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        ...lines.map((line) => Text(line)).toList(),
      ],
    );
  }
}
