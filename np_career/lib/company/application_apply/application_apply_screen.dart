import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/company/application_apply/application_apply_controller.dart';
import 'package:np_career/company/application_apply/application_apply_fb.dart';
import 'package:np_career/company/application_apply/email_setting/email_setting.dart';
import 'package:np_career/company/application_apply/notification_setting/notification_setting.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/view/user/profile/setting_notification/notification_setting.dart';

class ApplicationApplyScreen extends StatefulWidget {
  final String jobId;
  final String jobName;
  const ApplicationApplyScreen(
      {super.key, required this.jobId, required this.jobName});

  @override
  State<ApplicationApplyScreen> createState() => _ApplicationApplyScreenState();
}

class _ApplicationApplyScreenState extends State<ApplicationApplyScreen> {
  ApplicationApplyFb _fb = Get.put(ApplicationApplyFb());
  ApplicationApplyController controller = Get.put(ApplicationApplyController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.lightBackgroundColor,
          ),
        ),
        title: Center(
          child: Text(
            widget.jobName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.email_outlined),
                          title: Text('Email Setting'),
                          onTap: () => Get.to(EmailSetting()),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Notification Setting'),
                          onTap: () => Get.to(NotificationSettingApply()),
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: () => Get.back(),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: AppColor.lightBackgroundColor,
              ))
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildChoiceChip('All', 'All'),
                _buildChoiceChip('Accepted', 'accept'),
                _buildChoiceChip('Rejected', 'reject'),
                _buildChoiceChip('Pending', 'pending'),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: size.height * 0.8,
              child: StreamBuilder(
                stream: _fb.getApplicationApply(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No job posts found."));
                  }

                  final docs = snapshot.data!.docs;
                  final List<Map<String, dynamic>> applicationList = [];

                  for (var doc in docs) {
                    final data = doc.data() as Map<String, dynamic>;
                    final applications =
                        data['applied_list'] as List<dynamic>? ?? [];

                    for (var application in applications) {
                      if (application['jobId'] == widget.jobId) {
                        if (controller.filter.value == 'All' ||
                            (controller.filter.value == 'accept' &&
                                application['response'] == "accept") ||
                            (controller.filter.value == 'reject' &&
                                application['response'] == "reject") ||
                            (controller.filter.value == 'pending' &&
                                application['response'] == null)) {
                          applicationList
                              .add(application as Map<String, dynamic>);
                        }
                      }
                    }
                  }

                  return ListView.builder(
                    itemCount: applicationList.length,
                    itemBuilder: (context, index) {
                      final application = applicationList[index];
                      return FutureBuilder(
                        future: Future.wait([
                          _fb.getUserDetail(application['userId']),
                        ]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData) {
                            return Center(child: Text('No data found'));
                          }

                          final user =
                              snapshot.data![0] as Map<String, dynamic>;

                          return GestureDetector(
                            onTap: () {
                              if (application['typeCV'] == 'upload') {
                                controller.getCvUpload(application['cvId']);
                              } else {
                                controller.getCv(
                                    application['cvId'], application['typeCV']);
                              }
                            },
                            child: Card(
                              color:
                                  AppColor.orangePrimaryColor.withOpacity(0.66),
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: application['response'] == "accept"
                                      ? AppColor.greenPrimaryColor
                                      : application['response'] == "reject"
                                          ? AppColor.orangeRedColor
                                          : Colors.grey,
                                  width: 3,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.person,
                                                      color:
                                                          Colors.blueGrey[700]),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'User: ${user['username'] ?? "N/A"}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.blueGrey[800],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(Icons.email,
                                                      color:
                                                          Colors.blueGrey[700]),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Email: ${user['email'] ?? "N/A"}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.blueGrey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Icon(Icons.phone,
                                                      color:
                                                          Colors.blueGrey[700]),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Phone: ${user['phone'] ?? "N/A"}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.blueGrey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.all(5),
                                          //   decoration: BoxDecoration(
                                          //       shape: BoxShape.circle,
                                          //       color: AppColor.orangeRedColor),
                                          //   child: Icon(
                                          //     Icons.close,
                                          //     color:
                                          //         AppColor.lightBackgroundColor,
                                          //   ),
                                          // )
                                        ]),
                                    Divider(color: Colors.grey),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _fb.addCvToJobInDate(context,
                                                  idJob: application['jobId'],
                                                  jobName: widget.jobName,
                                                  idCV: application['cvId'],
                                                  userName: user['username'],
                                                  type: application['typeCV']);
                                            },
                                            icon: Icon(
                                              Icons.event,
                                              size: 35,
                                              color: AppColor.greenPrimaryColor,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.3,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _fb.updateResponseStatus(
                                                      application['id'],
                                                      "Accept",
                                                      application['userId']);
                                                  _fb.addNotificationToUser(
                                                      userId:
                                                          application['userId'],
                                                      nameJob: widget.jobName,
                                                      type: 'accept',
                                                      option: 'application');
                                                  Get.dialog(AlertDialog(
                                                    title: Text("Send Email?"),
                                                    content: Text(
                                                        "Do you want to send an email notification to the applicant?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.sendEmail(
                                                              user['email'],
                                                              'accept',
                                                              user['username']);
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                    ],
                                                  ));
                                                },
                                                child: Text("Accept"),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              width: size.width * 0.3,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _fb.updateResponseStatus(
                                                      application['id'],
                                                      "Reject",
                                                      application['userId']);
                                                  _fb.addNotificationToUser(
                                                      userId:
                                                          application['userId'],
                                                      nameJob: widget.jobName,
                                                      type: 'reject',
                                                      option: 'application');
                                                  Get.dialog(AlertDialog(
                                                    title: Text("Send Email?"),
                                                    content: Text(
                                                        "Do you want to send an email notification to the applicant?"),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.sendEmail(
                                                              user['email'],
                                                              'reject',
                                                              user['username']);
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                    ],
                                                  ));
                                                },
                                                child: Text("Reject"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, String value) {
    final isSelected = controller.filter.value == value;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          controller.filter.value = value;
        });
      },
      selectedColor: AppColor.greenPrimaryColor.withOpacity(0.1),
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isSelected
            ? AppColor.greenPrimaryColor.withOpacity(0.8)
            : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? AppColor.greenPrimaryColor : Colors.transparent,
          width: 1.5,
        ),
      ),
    );
  }
}
