import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:np_career/view/not_found/not_found.dart';
import 'package:np_career/view/user/job/chat_interview/interview_screen.dart';
import 'package:np_career/view/user/job/job_detail/job_detail_controller.dart';
import 'package:np_career/view/user/job/job_detail/job_detail_fb.dart';
import 'package:np_career/view/user/search/search_job/search_job_controller.dart';
import 'package:np_career/view/user/search/search_job/search_job_screen.dart';

class JobDetailScreen extends StatefulWidget {
  final JobPostModel job;
  final bool isSave;
  final String companyId;
  const JobDetailScreen(
      {super.key,
      required this.job,
      required this.isSave,
      required this.companyId});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  JobDetailController controller = Get.put(JobDetailController());
  SearchJobController searchController = Get.put(SearchJobController());
  JobDetailFb fb = Get.put(JobDetailFb());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.savedJob.value = widget.isSave;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            searchController.fetchSavedJobStatus();
            Get.back(result: true);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            "Job Detail",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(vertical: 15, horizontal: size.width * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: AppColor.greenPrimaryColor, width: 2)),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.greenPrimaryColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.greenPrimaryColor
                                              .withOpacity(0.5)),
                                      child: Icon(
                                        Icons.attach_money,
                                        color: AppColor.lightBackgroundColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      () {
                                        final min = widget.job.minSalary;
                                        final max = widget.job.maxSalary;
                                        final currency =
                                            widget.job.currencyUnit ?? '';

                                        if (min != null && max != null) {
                                          return "$min - $max $currency";
                                        } else if (min != null) {
                                          return "$min $currency";
                                        } else if (max != null) {
                                          return "$max $currency";
                                        } else {
                                          return "Negotiable";
                                        }
                                      }(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.greenPrimaryColor
                                              .withOpacity(0.5)),
                                      child: Icon(
                                        Icons.location_on,
                                        color: AppColor.lightBackgroundColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  (widget.job.city.length > 2
                                                      ? 2
                                                      : widget.job.city.length);
                                              i++) ...[
                                            TextSpan(text: widget.job.city[i]),
                                            if (i < 1 &&
                                                widget.job.city.length > 1)
                                              TextSpan(text: ", "),
                                          ],
                                          if (widget.job.city.length > 2)
                                            TextSpan(
                                              text:
                                                  "+${widget.job.city.length - 2}",
                                              style: TextStyle(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.greenPrimaryColor
                                              .withOpacity(0.5)),
                                      child: Icon(
                                        FontAwesomeIcons.hourglass,
                                        color: AppColor.lightBackgroundColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(widget.job.experience)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.greenPrimaryColor,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color:
                                          AppColor.greyColor.withOpacity(0.5)),
                                  child: Text(
                                      "Application deadline : ${widget.job.applicationDeadline}"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.greyColor.withOpacity(0.5)),
                              child: controller.savedJob == false
                                  ? IconButton(
                                      onPressed: () {
                                        controller.toggleSavedJobStatus(
                                            widget.job.id);
                                      },
                                      icon: Icon(
                                        Icons.bookmark_border_outlined,
                                        size: 30,
                                        color: AppColor.greenPrimaryColor,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        controller.toggleSavedJobStatus(
                                            widget.job.id);
                                      },
                                      icon: Icon(
                                        Icons.bookmark,
                                        size: 30,
                                        color: AppColor.greenPrimaryColor,
                                      )),
                            ),
                          )
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: ElevatedButton(
                              onPressed: () {
                                Get.dialog(
                                  buildSelectCvDialog(context),
                                  // barrierDismissible: false,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.send,
                                      color: AppColor.lightBackgroundColor,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Apply now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.lightBackgroundColor,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          width: size.width * 0.15,
                          child: InkWell(
                            onTap: () {
                              Get.to(InterviewScreen(), arguments: {
                                "uid": widget.job.id,
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: AppColor.greenPrimaryColor
                                      .withOpacity(0.5)),
                              child: SvgPicture.asset(
                                "assets/images/smart_toy_24dp_1F1F1F_FILL0_wght400_GRAD0_opsz24.svg",
                                width: 15,
                                height: 25,
                                color: AppColor.lightBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Job Details",
                style: TextStyle(
                    color: AppColor.orangePrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.job.jobInterests
                    .map<Widget>((e) => Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: AppColor.greyColor,
                          ),
                          child: Text(
                            e,
                            style:
                                TextStyle(color: AppColor.lightBackgroundColor),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              // Job Description Section
              _buildSection("Job Description", widget.job.jobDescription),
              SizedBox(height: 15),

              // Required Application Section
              _buildSection(
                  "Required Application", widget.job.requiredApplication),
              SizedBox(height: 15),

              // Benefits Section
              _buildSection("Benefits", widget.job.benefits),
              SizedBox(height: 15),

              // Work Location Section
              _buildSection("Work Location", widget.job.workLocation),
              SizedBox(height: 15),

              // Time Work Section
              _buildSection("Time Work", [widget.job.timeWork]),
              SizedBox(
                height: 10,
              ),
              Text("Application deadline : ${widget.job.applicationDeadline}"),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            buildSelectCvDialog(context),
                            // barrierDismissible: false,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: size.width * 0.05),
                          child: Text(
                            "Apply now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.lightBackgroundColor),
                          ),
                        )),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(title),
            SizedBox(height: 10),
            ...items.map((e) => _buildItem(e)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Icon(Icons.info_outline, color: AppColor.orangePrimaryColor),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: AppColor.orangePrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: AppColor.greenPrimaryColor),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "$text",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectCvDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: size.height * 0.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                "Select Your CV",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColor.orangePrimaryColor),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) =>
                    controller.searchQuery.value = value.toLowerCase(),
                decoration: InputDecoration(
                  hintText: 'Search cv...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: fb.getListCv(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(
                        child: NoFoundWidget(),
                      );
                    }

                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    var cvs = data["cvs"];

                    if (cvs == null || !(cvs is List)) {
                      return Center(
                        child: NoFoundWidget(),
                      );
                    }

                    return Obx(() {
                      var filteredCvs = cvs.where((cv) {
                        final position =
                            (cv["position"] ?? "").toString().toLowerCase();
                        final search =
                            controller.searchQuery.value.toLowerCase();
                        return position.contains(search);
                      }).toList();
                      return ListView.builder(
                        itemCount: filteredCvs.length,
                        itemBuilder: (context, index) {
                          var cv = filteredCvs[index];
                          return InkWell(
                            onTap: () {
                              if (cv['type'] == 'upload') {
                                controller.getCvUpload(cv['id']);
                              } else {
                                controller.getCv(cv['id'], cv['type']);
                              }
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => Radio<int>(
                                        value: index,
                                        groupValue:
                                            (controller.cvId.value == cv["id"])
                                                ? index
                                                : -1,
                                        onChanged: (value) {
                                          controller.cvId.value = cv["id"];
                                          controller.companyId.value =
                                              widget.companyId;
                                          controller.typeCv.value = cv["type"];
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        cv["position"] ?? "Unnamed CV",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: AppColor.greenPrimaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: AppColor.greenPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        fb.applyCv(
                            controller.cvId.value,
                            controller.companyId.value,
                            widget.job.id,
                            controller.typeCv.value,
                            widget.job.jobInterests);
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Apply now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
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
}
