import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:np_career/company/profile_company/profile_company.dart';
import 'package:np_career/company/profile_company/profile_company_data.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/view/not_found/enroll.dart';
import 'package:np_career/view/not_found/not_found.dart';
import 'package:np_career/view/user/top_company/top_company_controller.dart';
import 'package:np_career/view/user/top_company/top_company_fb.dart';

class TopCompany extends StatefulWidget {
  const TopCompany({super.key});

  @override
  State<TopCompany> createState() => _TopCompanyState();
}

class _TopCompanyState extends State<TopCompany> {
  TopCompanyFb _fb = Get.put(TopCompanyFb());
  TopCompanyController controller = Get.put(TopCompanyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: AppColor.greenPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColor.greenPrimaryColor,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.greenPrimaryColor,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(
                  color: AppColor.greenPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                onChanged: (value) {
                  controller.inputSearch.value = value;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: _fb.getAllCompanies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Enroll());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: NoFoundWidget(),
                  );
                }

                final companies = snapshot.data!;

                // final filteredCompanies = companies.where((company) {
                //   final companyName = company['username'] ?? '';
                //   return companyName
                //       .toLowerCase()
                //       .contains(controller.inputSearch.text.toLowerCase());
                // }).toList();

                // controller.fetchFollowedCompanyIds();

                return Obx(() {
                  final filteredCompanies = companies.where((company) {
                    final companyName = company['username'] ?? '';
                    return companyName
                        .toLowerCase()
                        .contains(controller.inputSearch.value.toLowerCase());
                  }).toList();
                  return Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // Disable grid scroll
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredCompanies.length,
                        itemBuilder: (context, index) {
                          final company = filteredCompanies[index].data()
                              as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () => Get.to(ProfileCompanyData(),
                                arguments: {'uid': company['uid']}),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: AppColor.greenPrimaryColor,
                                      width: 3)),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.greenPrimaryColor
                                              .withOpacity(0.1),
                                        ),
                                        child: Icon(
                                          Icons.business,
                                          color: AppColor.greenPrimaryColor,
                                          size: 80,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Center(
                                      child: Text(
                                        company['username'] ?? 'No name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "Email : ${company['email'] ?? 'No email'}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700]),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "Phone : ${company['phone'] ?? 'No phone'}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Obx(
                                      () => Column(
                                        children: [
                                          Center(
                                            child: Container(
                                              child: !(controller
                                                              .followedCompanyStatusMap[
                                                          company['uid']] ??
                                                      false)
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .toggleFollowedCompanyStatus(
                                                                company['uid']);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColor
                                                                .greenPrimaryColor, // Màu viền
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: Colors
                                                              .transparent, // Màu nền cho Follow
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color: AppColor
                                                                  .greenPrimaryColor,
                                                              size: 20,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Follow',
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .greenPrimaryColor, // Màu chữ
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .toggleFollowedCompanyStatus(
                                                                company['uid']);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: AppColor
                                                                .greenPrimaryColor, // Màu viền
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: AppColor
                                                              .greenPrimaryColor, // Màu nền cho Followed
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              'Followed',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white, // Màu chữ khi Followed
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
