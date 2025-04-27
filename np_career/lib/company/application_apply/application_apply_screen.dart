import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/company/application_apply/application_apply_controller.dart';
import 'package:np_career/company/application_apply/application_apply_fb.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/model/cv_model.dart';

class ApplicationApplyScreen extends StatefulWidget {
  final String jobId;
  const ApplicationApplyScreen({super.key, required this.jobId});

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
            "Application",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.lightBackgroundColor,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
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
                      applicationList.add(application as Map<String, dynamic>);
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

                        final user = snapshot.data![0] as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            controller.getCv(
                                application['cvId'], application['typeCV']);
                          },
                          child: Card(
                            color:
                                AppColor.orangePrimaryColor.withOpacity(0.66),
                            margin: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.blueGrey[700]),
                                      SizedBox(width: 10),
                                      Text(
                                        'User: ${user['username'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          color: Colors.blueGrey[700]),
                                      SizedBox(width: 10),
                                      Text(
                                        'Email: ${user['email'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          color: Colors.blueGrey[700]),
                                      SizedBox(width: 10),
                                      Text(
                                        'Phone: ${user['phone'] ?? "N/A"}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: Colors.grey),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Accept"),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Reject"),
                                        ),
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
    );
  }
}
