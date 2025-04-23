import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:np_career/core/app_color.dart';
import 'package:np_career/model/job_post_model.dart';

class JobDetailScreen extends StatefulWidget {
  final JobPostModel job;
  const JobDetailScreen({super.key, required this.job});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
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
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                        color: AppColor.greenPrimaryColor, width: 2)),
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
                              color:
                                  AppColor.greenPrimaryColor.withOpacity(0.5)),
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
                            final currency = widget.job.currencyUnit ?? '';

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
                              color:
                                  AppColor.greenPrimaryColor.withOpacity(0.5)),
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
                                if (i < 1 && widget.job.city.length > 1)
                                  TextSpan(text: ", "),
                              ],
                              if (widget.job.city.length > 2)
                                TextSpan(
                                  text: "+${widget.job.city.length - 2}",
                                  style: TextStyle(
                                      color: AppColor.greenPrimaryColor,
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
                              color:
                                  AppColor.greenPrimaryColor.withOpacity(0.5)),
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
