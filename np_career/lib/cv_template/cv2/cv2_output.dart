import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/model/activity.dart';
import 'package:np_career/model/award.dart';
import 'package:np_career/model/certificate.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:np_career/model/knowledge.dart';
import 'package:np_career/model/skill_v2.dart';
import 'package:np_career/model/work_experience.dart';

class Cv2Output extends StatefulWidget {
  final CvModelV2 model;
  Cv2Output({super.key, required this.model});

  @override
  State<Cv2Output> createState() => _Cv2OutputState();
}

class _Cv2OutputState extends State<Cv2Output> {
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

  Widget buildWorkExperience(WorkExperience exp) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exp.position,
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
                exp.date,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF353A3D)),
              ),
            ],
          ),
          Text(
            exp.company,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color(0xFF353A3D)),
          ),
          ...List<Widget>.from(exp.list.map((skill) => Text(
                '- $skill',
                style: const TextStyle(color: Color(0xFF353A3D)),
              ))),
          const SizedBox(height: 8),
        ],
      );

  Widget buildActivities(Activity ac) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ac.position,
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
                ac.date,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF353A3D)),
              ),
            ],
          ),
          Text(
            ac.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color(0xFF353A3D)),
          ),
          ...List<Widget>.from(ac.list.map((skill) => Text(
                '- $skill',
                style: const TextStyle(color: Color(0xFF353A3D)),
              ))),
          const SizedBox(height: 8),
        ],
      );

  Widget buildKnowledge(Knowledge kl) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'position',
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
                kl.date,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF353A3D)),
              ),
            ],
          ),
          Text(
            kl.school,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Color(0xFF353A3D)),
          ),
          ...List<Widget>.from(kl.list.map((note) => Text(
                '$note',
                style: const TextStyle(color: Color(0xFF353A3D)),
              ))),
          const SizedBox(height: 8),
        ],
      );

  Widget buildSkills(SkillV2 skill) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColor.lightBackgroundColor),
          ),
          ...List<Widget>.from(skill.list.map((skill) => Text(
                '- $skill',
                style: const TextStyle(color: AppColor.lightBackgroundColor),
              ))),
          const SizedBox(height: 8),
        ],
      );

  Widget buildAward(Award aw) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            aw.date,
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
            aw.name,
            style: const TextStyle(fontSize: 13, color: Color(0xFF353A3D)),
          ),
          const SizedBox(height: 8),
        ],
      );

  Widget buildCertificate(Certificate cf) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cf.date,
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
            cf.name,
            style: const TextStyle(fontSize: 13, color: Color(0xFF353A3D)),
          ),
          const SizedBox(height: 8),
        ],
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
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(color: Color(0xFF353A3D)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          widget.model.img.url,
                          width: size.width * 0.39,
                          height: size.width * 0.39,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.model.fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEC8F00),
                              fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.model.position,
                          style: TextStyle(
                              color: Color(0xFFEC8F00),
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        const SizedBox(height: 5),
                        const Divider(thickness: 1, color: Color(0xFFEC8F00)),
                        const SizedBox(height: 5),
                        buildContactRow(Icons.phone, widget.model.phoneNumber),
                        const SizedBox(height: 15),
                        buildContactRow(Icons.mail, widget.model.email),
                        const SizedBox(height: 15),
                        buildContactRow(Icons.info, widget.model.website),
                        const SizedBox(height: 15),
                        buildContactRow(
                            Icons.location_on, widget.model.address),
                        const SizedBox(height: 25),
                        buildSectionTitle('CÁC KỸ NĂNG'),
                        const SizedBox(height: 10),
                        ...widget.model.skills
                            .map(
                              (e) => buildSkills(e),
                            )
                            .toList(),
                        const SizedBox(height: 10),
                        buildSectionTitle('SỞ THÍCH'),
                        const SizedBox(height: 10),
                        Text(
                          widget.model.taste,
                          style:
                              TextStyle(color: AppColor.lightBackgroundColor),
                        ),
                        const SizedBox(height: 10),
                        buildSectionTitle('NGƯỜI GIỚI THIỆU'),
                        const SizedBox(height: 10),
                        Text(
                          widget.model.introducer,
                          style:
                              TextStyle(color: AppColor.lightBackgroundColor),
                        ),
                        const SizedBox(height: 10),
                        buildSectionTitle('THÔNG TIN THÊM'),
                        const SizedBox(height: 10),
                        Text(
                          widget.model.moreInformation,
                          style:
                              TextStyle(color: AppColor.lightBackgroundColor),
                        ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSectionTitle('MỤC TIÊU NGHỀ NGHIỆP'),
                          const SizedBox(height: 10),
                          Text(widget.model.occupationalGoals),
                          SizedBox(
                            height: 10,
                          ),
                          buildSectionTitle('KINH NGHIỆM LÀM VIỆC'),
                          const SizedBox(height: 10),
                          ...widget.model.workExperience
                              .map(
                                (e) => buildWorkExperience(e),
                              )
                              .toList(),
                          buildSectionTitle('HỌC VẤN'),
                          const SizedBox(height: 10),
                          ...widget.model.knowledge
                              .map(
                                (e) => buildKnowledge(e),
                              )
                              .toList(),
                          buildSectionTitle('DANH HIỆU VÀ GIẢI THƯỞNG'),
                          const SizedBox(height: 10),
                          ...widget.model.award
                              .map(
                                (e) => buildAward(e),
                              )
                              .toList(),
                          buildSectionTitle('CHỨNG CHỈ'),
                          const SizedBox(height: 10),
                          ...widget.model.certificate
                              .map(
                                (e) => buildCertificate(e),
                              )
                              .toList(),
                          buildSectionTitle('HOẠT ĐỘNG'),
                          const SizedBox(height: 10),
                          ...widget.model.activities
                              .map(
                                (e) => buildActivities(e),
                              )
                              .toList(),
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
