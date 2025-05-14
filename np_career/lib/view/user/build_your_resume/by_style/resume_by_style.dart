import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/cv_no1/cv_input_no1/cv_input_no1.dart';
import 'package:np_career/enum/enum_cv_input.dart';
import 'package:np_career/enum/enum_cv_no1.dart';
import 'package:np_career/enum/enum_language.dart';
import 'package:np_career/enum/enum_style_cv.dart';
import 'package:np_career/view/screen/home.dart';
import 'package:np_career/view/user/build_your_resume/by_style/resume_by_style_controller.dart';
import 'package:np_career/view/user/home/home_screen_user.dart';

class ResumeByStyle extends StatelessWidget {
  const ResumeByStyle({super.key});

  @override
  Widget build(BuildContext context) {
    final ResumeByStyleController resumeController =
        Get.put(ResumeByStyleController());

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orangePrimaryColor,
        leading: IconButton(
            onPressed: () {
              Get.to(HomeScreenUser());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.lightBackgroundColor,
            )),
        title: Center(
          child: Text(
            "Build your resume",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.lightBackgroundColor),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                children: [
                  GestureDetector(
                      onTap: () => resumeController.changeSelectChoice("style"),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        resumeController.selectChoice.value ==
                                                "style"
                                            ? AppColor.greenPrimaryColor
                                            : AppColor.greyColor,
                                    width: 2))),
                        child: Text(
                          "CV templates by style",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color:
                                  resumeController.selectChoice.value == "style"
                                      ? AppColor.greenPrimaryColor
                                      : AppColor.greyColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () =>
                          resumeController.changeSelectChoice("position"),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        resumeController.selectChoice.value ==
                                                "position"
                                            ? AppColor.greenPrimaryColor
                                            : AppColor.greyColor,
                                    width: 2))),
                        child: Text(
                          "CV templates by position",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: resumeController.selectChoice.value ==
                                      "position"
                                  ? AppColor.greenPrimaryColor
                                  : AppColor.greyColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                ],
              );
            }),
            SizedBox(height: 30),
            Obx(() {
              return resumeController.selectChoice.value == "style"
                  ? buildStyle(resumeController, size)
                  : resumeController.selectPositionList.value == "none"
                      ? buildPosition(size, resumeController)
                      : buildGesture(
                          size,
                          resumeController.choicePosition.value,
                          resumeController.choicePositionName.value,
                          resumeController);
            })
          ],
        ),
      ),
    );
  }

  Widget buildStyle(ResumeByStyleController resumeController, Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        resumeController.selectLanguageAndDesign.value =
                            resumeController.selectLanguageAndDesign.value ==
                                    "language"
                                ? "" // Tắt dropdown khi nhấn lại
                                : "language"; // Mở dropdown
                      },
                      child: Container(
                        height: 50,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: resumeController
                                          .selectLanguageAndDesign.value ==
                                      "language"
                                  ? AppColor.greenPrimaryColor
                                  : AppColor.greyColor,
                              width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: AppColor.orangePrimaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                resumeController.selectedLanguage
                                    .value, // Hiển thị ngôn ngữ đã chọn
                                style: TextStyle(
                                  color: resumeController
                                              .selectLanguageAndDesign.value ==
                                          "language"
                                      ? AppColor.greenPrimaryColor
                                      : AppColor.greyColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                resumeController
                                            .selectLanguageAndDesign.value ==
                                        "language"
                                    ? Icons.arrow_drop_up_outlined
                                    : Icons.arrow_drop_down_outlined,
                                color: resumeController
                                            .selectLanguageAndDesign.value ==
                                        "language"
                                    ? AppColor.greenPrimaryColor
                                    : AppColor.greyColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return resumeController.selectLanguageAndDesign.value ==
                            "language"
                        ? Column(
                            children: EnumLanguage.values
                                .map((EnumLanguage language) {
                              return GestureDetector(
                                onTap: () {
                                  resumeController.selectedLanguage.value =
                                      language
                                          .label; // Update selected language
                                  resumeController.selectLanguageAndDesign
                                      .value = ""; // Close dropdown
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.greyColor)),
                                  ),
                                  child: Text(
                                    language.label,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : SizedBox
                            .shrink(); // Không hiển thị danh sách nếu dropdown không mở
                  }),
                ],
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              Column(
                children: [
                  Obx(
                    () {
                      return GestureDetector(
                        onTap: () {
                          resumeController.selectLanguageAndDesign.value =
                              resumeController.selectLanguageAndDesign ==
                                      "design"
                                  ? ""
                                  : "design";
                        },
                        child: Container(
                          height: 50,
                          width: size.width * 0.48,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: resumeController
                                              .selectLanguageAndDesign.value ==
                                          "design"
                                      ? AppColor.greenPrimaryColor
                                      : AppColor.greyColor,
                                  width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: AppColor.orangePrimaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text(
                                  resumeController.selectedDesign.value,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: resumeController
                                                  .selectLanguageAndDesign
                                                  .value ==
                                              "design"
                                          ? AppColor.greenPrimaryColor
                                          : AppColor.greyColor),
                                ),
                                Spacer(),
                                Icon(
                                  resumeController
                                              .selectLanguageAndDesign.value ==
                                          "design"
                                      ? Icons.arrow_drop_up_outlined
                                      : Icons.arrow_drop_down_outlined,
                                  color: resumeController
                                              .selectLanguageAndDesign.value ==
                                          "design"
                                      ? AppColor.greenPrimaryColor
                                      : AppColor.greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        resumeController.selectLanguageAndDesign.value ==
                                "design"
                            ? SizedBox(
                                height: 90,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: EnumStyleCv.values
                                        .map((EnumStyleCv language) {
                                      return GestureDetector(
                                        onTap: () {
                                          resumeController.selectedDesign
                                              .value = language.label;
                                          resumeController
                                              .selectLanguageAndDesign
                                              .value = "";
                                        },
                                        child: Container(
                                          width: size.width * 0.48,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: AppColor.greyColor)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              language.label,
                                              style: TextStyle(fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    );
                  })
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: size.height * 0.58,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...EnumCvNo1.values.where((cvNo1) {
                          // Kiểm tra theo điều kiện
                          final hasSelectedDesign =
                              resumeController.selectedDesign.value ==
                                      'All Designs' ||
                                  cvNo1.tag.contains(
                                      resumeController.selectedDesign.value);

                          final hasSelectedLanguage = cvNo1.tag.contains(
                              resumeController.selectedLanguage.value);
                          final isStyle = cvNo1.type == "style";

                          return isStyle &&
                              hasSelectedDesign &&
                              hasSelectedLanguage;
                        }).map((EnumCvNo1 cvNo1) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cvNo1.action();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.greenPrimaryColor,
                                        width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: AppColor.orangePrimaryColor
                                        .withOpacity(0.69),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cvNo1.label,
                                        style: TextStyle(
                                            color: AppColor.greenPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              // Hiển thị tối đa 2 tag
                                              ...cvNo1.tag
                                                  .take(2)
                                                  .map((String tag) {
                                                return Container(
                                                  margin:
                                                      EdgeInsets.only(right: 8),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color:
                                                        AppColor.lightTextColor,
                                                  ),
                                                  child: Text(
                                                    tag,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .lightBackgroundColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              }),

                                              // Nếu còn nhiều hơn 2 tag thì hiển thị dấu ...
                                              if (cvNo1.tag.length > 2)
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(right: 8),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color:
                                                        AppColor.lightTextColor,
                                                  ),
                                                  child: Text(
                                                    "...",
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .lightBackgroundColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                            ],
                                          ),
                                          Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              // if (cvNo1.type_input == "no1") {
                                              //   Get.to(
                                              //       CvInputNo1(
                                              //           // type: cvNo1.label
                                              //           //     .toLowerCase(),
                                              //           ),
                                              //       arguments: {
                                              //         'type': cvNo1.label
                                              //             .toLowerCase(),
                                              //         'option': 'save'
                                              //       });
                                              // }
                                              EnumCvInput.cv_input.run(
                                                  cvNo1.type_input,
                                                  cvNo1.label.toLowerCase(),
                                                  'save');
                                            },
                                            icon:
                                                Icon(Icons.edit_note_outlined),
                                            iconSize: 40,
                                            color: AppColor.greenPrimaryColor,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildPosition(Size size, ResumeByStyleController controller) {
    List<Map<String, String>> careers = [
      {'id': 'ENG', 'name': 'Engineer'},
      {'id': 'DOC', 'name': 'Doctor'},
      {'id': 'TEA', 'name': 'Teacher'},
      {'id': 'DES', 'name': 'Designer'},
      {'id': 'LAW', 'name': 'Lawyer'},
      {'id': 'DEV', 'name': 'Developer'},
      {'id': 'NUR', 'name': 'Nurse'},
      {'id': 'ARC', 'name': 'Architect'},
      {'id': 'MKT', 'name': 'Marketer'},
      {'id': 'WRI', 'name': 'Writer'},
      {'id': 'PHO', 'name': 'Photographer'},
      {'id': 'CHE', 'name': 'Chef'},
    ];

    return SizedBox(
      height: size.height * 0.8,
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: careers.length,
        itemBuilder: (context, index) {
          final career = careers[index];
          return GestureDetector(
            onTap: () {
              controller.selectPositionList.value = "detail";
              controller.choicePosition.value = career['id']!;
              controller.choicePositionName.value = career['name']!;
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.greenPrimaryColor, width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      career['id']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      career['name']!,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildGesture(Size size, String position, String name,
      ResumeByStyleController controller) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  controller.selectPositionList.value = "none";
                  controller.choicePosition.value = "";
                  controller.choicePositionName.value = "";
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColor.greenPrimaryColor,
                  size: 25,
                )),
            Text(
              name,
              style: TextStyle(color: AppColor.greenPrimaryColor, fontSize: 25),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: size.height * 0.58,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...EnumCvNo1.values.where((cvNo1) {
                    final isStyle = cvNo1.type == "position";
                    final isPosition = cvNo1.tag.contains(position);

                    return isStyle && isPosition;
                  }).map((EnumCvNo1 cvNo1) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cvNo1.action();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.greenPrimaryColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color:
                                  AppColor.orangePrimaryColor.withOpacity(0.69),
                            ),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cvNo1.label,
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        // Hiển thị tối đa 2 tag
                                        ...cvNo1.tag.take(2).map((String tag) {
                                          return Container(
                                            margin: EdgeInsets.only(right: 8),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: AppColor.lightTextColor,
                                            ),
                                            child: Text(
                                              tag,
                                              style: TextStyle(
                                                  color: AppColor
                                                      .lightBackgroundColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),

                                        // Nếu còn nhiều hơn 2 tag thì hiển thị dấu ...
                                        if (cvNo1.tag.length > 2)
                                          Container(
                                            margin: EdgeInsets.only(right: 8),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: AppColor.lightTextColor,
                                            ),
                                            child: Text(
                                              "...",
                                              style: TextStyle(
                                                  color: AppColor
                                                      .lightBackgroundColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        // Get.to(
                                        //     CvInputNo1(
                                        //         // type: cvNo1.label.toLowerCase(),
                                        //         ),
                                        //     arguments: {
                                        //       'type': cvNo1.label.toLowerCase(),
                                        //       'option': 'save'
                                        //     });

                                        print(
                                            '${cvNo1.type_input}/${cvNo1.label.toLowerCase()}');
                                        EnumCvInput.cv_input.run(
                                            cvNo1.type_input,
                                            cvNo1.label.toLowerCase(),
                                            'save');
                                      },
                                      icon: Icon(Icons.edit_note_outlined),
                                      iconSize: 40,
                                      color: AppColor.greenPrimaryColor,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
