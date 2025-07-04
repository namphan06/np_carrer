import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/enum/enum_city.dart';
import 'package:np_career/enum/enum_currency_unit.dart';
import 'package:np_career/enum/enum_experience.dart';
import 'package:np_career/enum/enum_type_job_category.dart';
import 'package:np_career/model/job_post_model.dart';
import 'package:np_career/view/not_found/job_not_found.dart';
import 'package:np_career/view/not_found/not_found.dart';
import 'package:np_career/view/user/job/job_detail/job_detail_screen.dart';
import 'package:np_career/view/user/search/search_job/search_job_controller.dart';
import 'package:np_career/view/user/search/search_job/search_job_fb.dart';

class SearchJobScreen extends StatefulWidget {
  final String? nameRole;
  final SearchJobController controller;
  const SearchJobScreen({super.key, this.nameRole, required this.controller});

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobScreen> {
  final SearchJobFb _fb = Get.put(SearchJobFb());
  // final SearchJobController controller = Get.put(SearchJobController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.controller.fetchSavedJobStatus();
    widget.controller.nameRole.value = widget.nameRole ?? '';

    widget.controller.clearSearch();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.02),
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
                          onTap: () => widget.controller.isExpanded.value =
                              !widget.controller.isExpanded.value,
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
                        widget.controller.isExpanded.value == true
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
                                          controller:
                                              widget.controller.nameController,
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
                                          "Salary",
                                          style: TextStyle(
                                              color:
                                                  AppColor.orangePrimaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.269,
                                              child: TextField(
                                                controller:
                                                    widget.controller.minSalary,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                decoration: InputDecoration(
                                                    label: Text("Min")),
                                                style: TextStyle(
                                                    color: AppColor
                                                        .greenPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.269,
                                              child: TextField(
                                                controller:
                                                    widget.controller.maxSalary,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                decoration: InputDecoration(
                                                    label: Text("Max")),
                                                style: TextStyle(
                                                    color: AppColor
                                                        .greenPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.dialog(Dialog(
                                                  child: Container(
                                                    padding: EdgeInsets.all(16),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Currency Unit",
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .greenPrimaryColor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Expanded(
                                                          child: ListView
                                                              .separated(
                                                            itemCount:
                                                                EnumCurrencyUnit
                                                                    .values
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
                                                                  EnumCurrencyUnit
                                                                          .values[
                                                                      index];
                                                              return InkWell(
                                                                onTap: () {
                                                                  widget
                                                                      .controller
                                                                      .selectCurrencyUnit
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
                                                                    vertical:
                                                                        12,
                                                                    horizontal:
                                                                        8,
                                                                  ),
                                                                  child: Text(
                                                                    e.label,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
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
                                                      horizontal: 5),
                                                  width: size.width * 0.252,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColor
                                                              .greenPrimaryColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        widget
                                                            .controller
                                                            .selectCurrencyUnit
                                                            .value,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .greenPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                          ],
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
                                                                  .contains(widget
                                                                      .controller
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
                                                                final isSelectedC = widget
                                                                    .controller
                                                                    .list_city
                                                                    .contains(e
                                                                        .label);
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (isSelectedC) {
                                                                      widget
                                                                          .controller
                                                                          .list_city
                                                                          .remove(
                                                                              e.label);
                                                                    } else {
                                                                      widget
                                                                          .controller
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
                                            children: widget
                                                .controller.list_city
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
                                                              widget.controller
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
                                                              widget
                                                                  .controller
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
                                                    widget
                                                            .controller
                                                            .selectExperience
                                                            .isEmpty
                                                        ? "Experience"
                                                        : widget
                                                            .controller
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
                                                            widget
                                                                    .controller
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
                                                          final filteredList = EnumTypeJobCategory
                                                              .values
                                                              .where((e) => e
                                                                  .label
                                                                  .toLowerCase()
                                                                  .contains(widget
                                                                      .controller
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
                                                                final isSelected = widget
                                                                    .controller
                                                                    .list_type_job_category
                                                                    .contains(e
                                                                        .label);
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (isSelected) {
                                                                      widget
                                                                          .controller
                                                                          .list_type_job_category
                                                                          .remove(
                                                                              e.label);
                                                                    } else {
                                                                      widget
                                                                          .controller
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
                                            children: widget.controller
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
                                                              widget.controller
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
                                              widget.controller.isExpanded
                                                  .value = false;
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
                            stream: widget.controller.appliedJobIdStream(),
                            builder: (context, appliedSnapshot) {
                              if (appliedSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              final appliedJobIdList =
                                  appliedSnapshot.data ?? [];

                              return StreamBuilder(
                                stream: _fb.getListJob(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text("Error: ${snapshot.error}"));
                                  }

                                  if (!snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: NoFoundWidget(),
                                    );
                                  }

                                  return Obx(() {
                                    final docs = snapshot.data!.docs;
                                    final List<Map<String, dynamic>> jobPosts =
                                        [];

                                    widget.controller.fetchSavedJobIds();
                                    // controller.fetchAppliedJobIds();
                                    final _ = widget.controller.fix.value;

                                    for (var doc in docs) {
                                      final data =
                                          doc.data() as Map<String, dynamic>;
                                      final jobs =
                                          data['jps'] as List<dynamic>? ?? [];

                                      for (var job in jobs) {
                                        if (widget.nameRole == "Saved Job" &&
                                            widget.controller.savedJobIdList
                                                .contains(job['id'])) {
                                          jobPosts
                                              .add(job as Map<String, dynamic>);
                                        } else if (widget.nameRole ==
                                                "Applied Job" &&
                                            appliedJobIdList
                                                .contains(job['id'])) {
                                          jobPosts
                                              .add(job as Map<String, dynamic>);
                                        } else if (widget.nameRole ==
                                                "Jobs Today" &&
                                            widget.controller.getCreatedAtLabel(
                                                    job['createdAt']) ==
                                                'New') {
                                          jobPosts
                                              .add(job as Map<String, dynamic>);
                                        } else if (widget.nameRole == null) {
                                          jobPosts
                                              .add(job as Map<String, dynamic>);
                                        }
                                      }
                                    }

                                    if (jobPosts.isEmpty) {
                                      return Center(
                                        child: NoFoundWidget(),
                                      );
                                    }

                                    final filterJobPosts =
                                        widget.controller.filterJobs(jobPosts);

                                    // PHÂN TRANG
                                    final startIndex =
                                        widget.controller.currentPage.value *
                                            widget.controller.itemsPerPage;
                                    final endIndex = (startIndex +
                                            widget.controller.itemsPerPage)
                                        .clamp(0, filterJobPosts.length);
                                    final paginatedJobs = filterJobPosts
                                        .sublist(startIndex, endIndex);

                                    return Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: paginatedJobs.length,
                                          itemBuilder: (context, index) {
                                            final job = paginatedJobs[index];
                                            final name =
                                                job['name'] ?? 'No name';
                                            final companyName =
                                                job['nameCompany'] ??
                                                    'No company';
                                            final minSalary = job['minSalary'];
                                            final maxSalary = job['maxSalary'];
                                            final currency =
                                                job['currencyUnit'] ?? '';
                                            final city =
                                                job['city'] as List<dynamic>? ??
                                                    [];
                                            final label = widget.controller
                                                .getCreatedAtLabel(
                                                    job['createdAt']);
                                            final isNew = label == 'New';

                                            String salary;
                                            if (minSalary == null &&
                                                maxSalary == null) {
                                              salary = "Negotiable";
                                            } else if (minSalary != null &&
                                                maxSalary != null) {
                                              salary =
                                                  "$minSalary - $maxSalary $currency";
                                            } else if (minSalary != null) {
                                              salary = "$minSalary $currency";
                                            } else {
                                              salary = "$maxSalary $currency";
                                            }

                                            String cityText = '';
                                            if (city.isNotEmpty) {
                                              cityText = city.length > 1
                                                  ? '${city[0]} +${city.length - 1}'
                                                  : city.join(', ');
                                            }

                                            return GestureDetector(
                                              onTap: () async {
                                                await widget.controller
                                                    .loadJobDetail(job['id']);

                                                if (widget.controller.job ==
                                                    null) {
                                                  Get.to(() =>
                                                      const JobNotFoundScreen());
                                                } else {
                                                  Get.to(() => JobDetailScreen(
                                                        job: widget
                                                            .controller.job!,
                                                        isSave: widget
                                                                .controller
                                                                .savedJobStatusList[
                                                            index +
                                                                5 *
                                                                    widget
                                                                        .controller
                                                                        .currentPage
                                                                        .value],
                                                        companyId:
                                                            job['companyId'],
                                                      ));
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 16),
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: AppColor
                                                      .orangePrimaryColor
                                                      .withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: appliedJobIdList
                                                            .contains(job['id'])
                                                        ? AppColor
                                                            .greenPrimaryColor
                                                        : AppColor.greyColor,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      offset: Offset(0, 4),
                                                      blurRadius: 10,
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(name,
                                                              style: TextStyle(
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColor
                                                                    .greenPrimaryColor,
                                                              )),
                                                          SizedBox(height: 5),
                                                          Text(
                                                              "Company: $companyName",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .grey[600],
                                                              )),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: AppColor
                                                                          .greyColor
                                                                          .withOpacity(
                                                                              0.8),
                                                                    ),
                                                                    child: Text(
                                                                        salary,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColor
                                                                              .greenPrimaryColor
                                                                              .withOpacity(0.9),
                                                                        )),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: AppColor
                                                                          .greyColor
                                                                          .withOpacity(
                                                                              0.8),
                                                                    ),
                                                                    child: Text(
                                                                        cityText,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColor
                                                                              .greenPrimaryColor
                                                                              .withOpacity(0.9),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    (widget.nameRole !=
                                                                "Applied Job" &&
                                                            widget.nameRole !=
                                                                "Jobs Today")
                                                        ? Obx(() => Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: AppColor
                                                                        .greyColor
                                                                        .withOpacity(
                                                                            0.5),
                                                                  ),
                                                                  child: widget.controller.savedJobStatusList.length > (index + 5 * widget.controller.currentPage.value) &&
                                                                          widget.controller.savedJobStatusList[index + 5 * widget.controller.currentPage.value] ==
                                                                              false
                                                                      ? IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            widget.controller.toggleSavedJobStatus(index + 5 * widget.controller.currentPage.value,
                                                                                job['id']);
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.bookmark_border_outlined,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                AppColor.greenPrimaryColor,
                                                                          ))
                                                                      : IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            widget.controller.toggleSavedJobStatus(index + 5 * widget.controller.currentPage.value,
                                                                                job['id']);
                                                                            if (widget.nameRole ==
                                                                                "Job Applied") {
                                                                              jobPosts.remove(job);
                                                                            }
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.bookmark,
                                                                            size:
                                                                                30,
                                                                            color:
                                                                                AppColor.greenPrimaryColor,
                                                                          )),
                                                                ),
                                                                SizedBox(
                                                                    height: 35),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              6,
                                                                          vertical:
                                                                              2),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: isNew
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .grey,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: isNew
                                                                          ? Colors
                                                                              .green
                                                                              .shade700
                                                                          : Colors
                                                                              .grey
                                                                              .shade400,
                                                                      width:
                                                                          0.8,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child: Text(
                                                                    label,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isNew
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                              border:
                                                                  Border.all(
                                                                color: isNew
                                                                    ? Colors
                                                                        .green
                                                                        .shade700
                                                                    : Colors
                                                                        .grey
                                                                        .shade400,
                                                                width: 0.8,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Text(
                                                              label,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: widget.controller
                                                          .currentPage.value >
                                                      0
                                                  ? () => widget.controller
                                                      .currentPage.value--
                                                  : null,
                                              icon: Icon(Icons.arrow_back),
                                            ),
                                            Text(
                                              "Page ${widget.controller.currentPage.value + 1} of ${(filterJobPosts.length / widget.controller.itemsPerPage).ceil()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: (widget
                                                                  .controller
                                                                  .currentPage
                                                                  .value +
                                                              1) *
                                                          widget.controller
                                                              .itemsPerPage <
                                                      filterJobPosts.length
                                                  ? () => widget.controller
                                                      .currentPage.value++
                                                  : null,
                                              icon: Icon(Icons.arrow_forward),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                                },
                              );
                            }),
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
