import 'package:get/get.dart';
import 'package:np_career/view/user/job/job_detail/job_detail_fb.dart';

class JobDetailController extends GetxController {
  final JobDetailFb _fb = JobDetailFb();
  RxBool savedJob = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  Future<void> toggleSavedJobStatus(String jobId) async {
    await _fb.toggleSavedJob(jobId: jobId);
    savedJob.value = await _fb.isJobSaved(jobId: jobId);
  }
}
