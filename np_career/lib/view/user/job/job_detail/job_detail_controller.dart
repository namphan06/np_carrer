import 'package:get/get.dart';
import 'package:np_career/enum/enum_cv_no1_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/view/user/job/job_detail/job_detail_fb.dart';

class JobDetailController extends GetxController {
  final JobDetailFb _fb = JobDetailFb();
  RxBool savedJob = false.obs;
  RxString cvId = "".obs;
  RxString companyId = "".obs;
  RxString typeCv = "".obs;
  var searchQuery = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  Future<void> toggleSavedJobStatus(String jobId) async {
    await _fb.toggleSavedJob(jobId: jobId);
    savedJob.value = await _fb.isJobSaved(jobId: jobId);
  }

  Future<void> getCv(String uid, String type) async {
    try {
      dynamic model = await _fb.getCvModel(uid, type);
      CvOutputRouter.run(type, model);
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }
}
