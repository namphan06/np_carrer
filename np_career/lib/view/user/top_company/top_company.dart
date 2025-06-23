import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final TopCompanyFb _fb = Get.put(TopCompanyFb());
  final TopCompanyController controller = Get.put(TopCompanyController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                    fontSize: isTablet ? 22 : 18,
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
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                style: TextStyle(
                  color: AppColor.greenPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 20 : 16,
                ),
                onChanged: (value) {
                  controller.inputSearch.value = value;
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: _fb.getAllCompanies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Enroll());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: NoFoundWidget());
                  }

                  final companies = snapshot.data!;

                  return Obx(() {
                    final filteredCompanies = companies.where((company) {
                      final companyName = company['username'] ?? '';
                      return companyName
                          .toLowerCase()
                          .contains(controller.inputSearch.value.toLowerCase());
                    }).toList();

                    final crossAxisCount = isTablet ? 3 : 2;

                    return GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
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
                          child: SizedBox(
                            height: 260,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: AppColor.greenPrimaryColor,
                                    width: 3),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.greenPrimaryColor
                                            .withOpacity(0.1),
                                      ),
                                      child: Icon(
                                        Icons.business,
                                        color: AppColor.greenPrimaryColor,
                                        size: 60,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      company['username'] ?? 'No name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Email: ${company['email'] ?? 'No email'}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700]),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Phone: ${company['phone'] ?? 'No phone'}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),

                                    // ✅ Bọc Obx cho phần Follow
                                    Obx(() {
                                      final isFollowed =
                                          controller.followedCompanyStatusMap[
                                                  company['uid']] ??
                                              false;

                                      return GestureDetector(
                                        onTap: () {
                                          controller
                                              .toggleFollowedCompanyStatus(
                                                  company['uid']);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColor.greenPrimaryColor,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: isFollowed
                                                ? AppColor.greenPrimaryColor
                                                : Colors.transparent,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (!isFollowed)
                                                const Icon(Icons.add,
                                                    size: 18,
                                                    color: AppColor
                                                        .greenPrimaryColor),
                                              if (!isFollowed)
                                                const SizedBox(width: 4),
                                              Text(
                                                isFollowed
                                                    ? 'Followed'
                                                    : 'Follow',
                                                style: TextStyle(
                                                  color: isFollowed
                                                      ? Colors.white
                                                      : AppColor
                                                          .greenPrimaryColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }
}
