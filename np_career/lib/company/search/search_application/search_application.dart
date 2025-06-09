import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:np_career/company/search/search_application/search_application_controller.dart';
import 'package:np_career/company/search/search_application/search_application_fb.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_city.dart';
import 'package:np_career/enum/enum_experience.dart';
import 'package:np_career/enum/enum_type_job_category.dart';
import 'package:np_career/view/not_found/enroll.dart';
import 'package:np_career/view/not_found/not_found.dart';
import 'package:np_career/view/user/profile/my_profile/my_profile_data.dart';

class SearchApplication extends StatefulWidget {
  final String nameType;
  const SearchApplication({super.key, required this.nameType});

  @override
  State<SearchApplication> createState() => _SearchApplicationState();
}

class _SearchApplicationState extends State<SearchApplication> {
  SearchApplicationController controller =
      Get.put(SearchApplicationController());
  SearchApplicationFb _fb = Get.put(SearchApplicationFb());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Obx(
                  () => SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => controller.isExpanded.value =
                              !controller.isExpanded.value,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.greenPrimaryColor,
                                    width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColor.greenPrimaryColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Search ...",
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        controller.isExpanded.value == true
                            ? Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: AppColor.lightBackgroundColor,
                                      border: Border.all(
                                          color: AppColor.greenPrimaryColor,
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(0, 4),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: controller.nameController,
                                          decoration: InputDecoration(
                                              label: Text(
                                            "Name",
                                          )),
                                          style: TextStyle(
                                              color: AppColor.greenPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "City",
                                          style: TextStyle(
                                              color:
                                                  AppColor.orangePrimaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              Dialog(
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor: AppColor
                                                    .lightBackgroundColor,
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'City',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .greenPrimaryColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      TextField(
                                                        // onChanged: (value) => controller
                                                        //     .searchQuery.value = value.toLowerCase(),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Search city...',
                                                          prefixIcon: Icon(
                                                              Icons.search),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Expanded(
                                                        child: Obx(() {
                                                          final filteredList = EnumCity
                                                              .values
                                                              .where((e) => e
                                                                  .label
                                                                  .toLowerCase()
                                                                  .contains(controller
                                                                      .searchQueryC
                                                                      .value))
                                                              .toList();
                                                          return ListView
                                                              .separated(
                                                            itemCount:
                                                                filteredList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                Divider(
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final e =
                                                                  filteredList[
                                                                      index];

                                                              return Obx(() {
                                                                final isSelectedC =
                                                                    controller
                                                                        .list_city
                                                                        .contains(
                                                                            e.label);
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (isSelectedC) {
                                                                      controller
                                                                          .list_city
                                                                          .remove(
                                                                              e.label);
                                                                    } else {
                                                                      controller
                                                                          .list_city
                                                                          .add(e
                                                                              .label);
                                                                    }
                                                                  },
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            8),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: isSelectedC
                                                                          ? Colors
                                                                              .orange
                                                                              .withOpacity(0.3)
                                                                          : null,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: Text(
                                                                      e.label,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: isSelectedC
                                                                            ? Colors.orange
                                                                            : Colors.black87,
                                                                        fontWeight: isSelectedC
                                                                            ? FontWeight.bold
                                                                            : FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            },
                                                          );
                                                        }),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ElevatedButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: Text(
                                                            'Done',
                                                            style: TextStyle(
                                                                color: AppColor
                                                                    .lightBackgroundColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                AppColor
                                                                    .greenPrimaryColor,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 55,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(""),
                                                Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Wrap(
                                            spacing: 10,
                                            runSpacing: 5,
                                            children: controller.list_city
                                                .map(
                                                  (e) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor
                                                                .greenPrimaryColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        color: AppColor
                                                            .greyColor
                                                            .withOpacity(0.5)),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .greenPrimaryColor),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .list_city
                                                                  .remove(e);
                                                            },
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(Dialog(
                                              child: Container(
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Experience",
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .greenPrimaryColor,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: ListView.separated(
                                                        itemCount:
                                                            EnumExperience
                                                                .values.length,
                                                        separatorBuilder:
                                                            (_, __) => Divider(
                                                                color: Colors
                                                                    .grey[300]),
                                                        itemBuilder:
                                                            (context, index) {
                                                          final e =
                                                              EnumExperience
                                                                      .values[
                                                                  index];
                                                          return InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .selectExperience
                                                                  .value = e.label;
                                                              Get.back();
                                                            },
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 12,
                                                                horizontal: 8,
                                                              ),
                                                              child: Text(
                                                                e.label,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                          },
                                          child: Obx(
                                            () => Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColor
                                                          .greenPrimaryColor,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller.selectExperience
                                                            .isEmpty
                                                        ? "Experience"
                                                        : controller
                                                            .selectExperience
                                                            .value,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: AppColor
                                                            .greenPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_drop_down,
                                                    color: AppColor
                                                        .greenPrimaryColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Job Interests",
                                          style: TextStyle(
                                              color:
                                                  AppColor.orangePrimaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.dialog(
                                              Dialog(
                                                insetPadding: EdgeInsets.zero,
                                                backgroundColor: AppColor
                                                    .lightBackgroundColor,
                                                child: Container(
                                                  padding: EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Job Interests',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .greenPrimaryColor,
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      TextField(
                                                        onChanged: (value) =>
                                                            controller
                                                                    .searchQuery
                                                                    .value =
                                                                value
                                                                    .toLowerCase(),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Search job category...',
                                                          prefixIcon: Icon(
                                                              Icons.search),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Expanded(
                                                        child: Obx(() {
                                                          final filteredList =
                                                              EnumTypeJobCategory
                                                                  .values
                                                                  .where((e) => e
                                                                      .label
                                                                      .toLowerCase()
                                                                      .contains(controller
                                                                          .searchQuery
                                                                          .value))
                                                                  .toList();
                                                          return ListView
                                                              .separated(
                                                            itemCount:
                                                                filteredList
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                Divider(
                                                                    color: Colors
                                                                            .grey[
                                                                        300]),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final e =
                                                                  filteredList[
                                                                      index];

                                                              return Obx(() {
                                                                final isSelected =
                                                                    controller
                                                                        .list_type_job_category
                                                                        .contains(
                                                                            e.label);
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (isSelected) {
                                                                      controller
                                                                          .list_type_job_category
                                                                          .remove(
                                                                              e.label);
                                                                    } else {
                                                                      controller
                                                                          .list_type_job_category
                                                                          .add(e
                                                                              .label);
                                                                    }
                                                                  },
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12,
                                                                        horizontal:
                                                                            8),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: isSelected
                                                                          ? Colors
                                                                              .orange
                                                                              .withOpacity(0.3)
                                                                          : null,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child: Text(
                                                                      e.label,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: isSelected
                                                                            ? Colors.orange
                                                                            : Colors.black87,
                                                                        fontWeight: isSelected
                                                                            ? FontWeight.bold
                                                                            : FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            },
                                                          );
                                                        }),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ElevatedButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          child: Text(
                                                            'Done',
                                                            style: TextStyle(
                                                                color: AppColor
                                                                    .lightBackgroundColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                AppColor
                                                                    .greenPrimaryColor,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 55,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                  width: 2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(""),
                                                Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Wrap(
                                            spacing: 10,
                                            runSpacing: 5,
                                            children: controller
                                                .list_type_job_category
                                                .map(
                                                  (e) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor
                                                                .greenPrimaryColor,
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        color: AppColor
                                                            .greyColor
                                                            .withOpacity(0.5)),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          e,
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .greenPrimaryColor),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        IconButton(
                                                            onPressed: () {
                                                              controller
                                                                  .list_type_job_category
                                                                  .remove(e);
                                                            },
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              controller.isExpanded.value =
                                                  false;
                                            },
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: AppColor
                                                      .lightBackgroundColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            : SizedBox.shrink(),
                        StreamBuilder(
                          stream: _fb.getListApplication(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(child: Enroll());
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(child: NoFoundWidget());
                            }

                            // Lấy tất cả documents
                            final docs = snapshot.data!.docs;

                            final applicationApply = docs
                                .where((doc) =>
                                    (doc.data() as Map<String, dynamic>)[
                                        'securitySetting'] ==
                                    true)
                                .map(
                                    (doc) => doc.data() as Map<String, dynamic>)
                                .toList();

                            if (applicationApply.isEmpty) {
                              return Center(
                                  child: Text("No job posts available."));
                            }

                            final filterApplicationApplys =
                                controller.filterApplications(applicationApply);

                            final filteredList = filterApplicationApplys
                                .asMap()
                                .entries
                                .where((entry) {
                                  final index = entry.key;
                                  final job = entry.value;
                                  return controller.savedApplicationStatusList
                                              .length >
                                          index &&
                                      controller.savedApplicationStatusList[
                                              index] ==
                                          true;
                                })
                                .map((entry) => entry.value)
                                .toList();

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // Lọc danh sách theo điều kiện
                              itemCount: widget.nameType == 'follow'
                                  ? filteredList.length
                                  : filterApplicationApplys.length,
                              itemBuilder: (context, index) {
                                // Lấy danh sách đã lọc nếu là 'follow', còn bình thường lấy nguyên list
                                final job = widget.nameType == 'follow'
                                    ? filteredList[index]
                                    : filterApplicationApplys[index];

                                final name = job['fullName'] ?? 'No name';
                                final educationLevel = job['educationLevel'] ??
                                    'No educationLevel';

                                final city =
                                    job['city'] as List<dynamic>? ?? [];
                                String cityText = '';
                                if (city.isNotEmpty) {
                                  if (city.length > 1) {
                                    cityText = '${city[0]} +${city.length - 1}';
                                  } else {
                                    cityText = city.join(', ');
                                  }
                                }

                                return GestureDetector(
                                  onTap: () {
                                    Get.to(MyProfileData(
                                      userID: job['id'],
                                    ));
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColor.orangePrimaryColor
                                          .withOpacity(0.66),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: Offset(0, 4),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor
                                                      .greenPrimaryColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "Education Level: $educationLevel",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[600],
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: AppColor.greyColor
                                                          .withOpacity(0.8),
                                                    ),
                                                    child: Text(
                                                      cityText,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColor
                                                            .greenPrimaryColor
                                                            .withOpacity(0.9),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(
                                          () => Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.greyColor
                                                    .withOpacity(0.5)),
                                            child: controller
                                                            .savedApplicationStatusList
                                                            .length >
                                                        index &&
                                                    controller.savedApplicationStatusList[
                                                            index] ==
                                                        false
                                                ? IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .toggleSavedApplicationStatus(
                                                              index, job['id']);
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .bookmark_border_outlined,
                                                      size: 30,
                                                      color: AppColor
                                                          .greenPrimaryColor,
                                                    ))
                                                : IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .toggleSavedApplicationStatus(
                                                              index, job['id']);
                                                    },
                                                    icon: Icon(
                                                      Icons.bookmark,
                                                      size: 30,
                                                      color: AppColor
                                                          .greenPrimaryColor,
                                                    )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
