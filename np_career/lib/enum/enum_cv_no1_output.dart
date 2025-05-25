import 'package:get/get.dart';
import 'package:np_career/cv_template/cv1/cv1_output.dart';
import 'package:np_career/cv_template/cv2/cv2_output.dart';
import 'package:np_career/cv_template/cv3_position/cv3_output.dart';
import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:np_career/model/cv_model_v3.dart';

// Định nghĩa type của handler
typedef CvHandler = void Function(String type, dynamic model);

class CvOutputRouter {
  static final Map<_TypeModelKey, CvHandler> _handlers = {
    // CvModel handlers
    _TypeModelKey('cv1', CvModel): _cv1_no1,
    _TypeModelKey('cv1_special', CvModel): _cv1_special,

    // CvModelV2 handlers
    _TypeModelKey('cv2', CvModelV2): _cv2_no2,
    _TypeModelKey('cv2_alt', CvModelV2): _cv2_alt,

    // CvModelV3 handlers
    _TypeModelKey('cv3', CvModelV3): _cv3_no3,
    _TypeModelKey('cv3_special', CvModelV3): _cv3_special,
  };

  static void run(String type, dynamic model) {
    final key = _TypeModelKey(type.toLowerCase(), model.runtimeType);
    final handler = _handlers[key];
    if (handler != null) {
      handler(type, model);
    } else {
      Get.snackbar("Error",
          "No handler found for type: $type and model: ${model.runtimeType}");
    }
  }
}

class _TypeModelKey {
  final String type;
  final Type modelType;

  _TypeModelKey(this.type, this.modelType);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TypeModelKey &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          modelType == other.modelType;

  @override
  int get hashCode => type.hashCode ^ modelType.hashCode;
}

// === Handlers ===

void _cv1_no1(String type, dynamic model) {
  if (model is CvModel) {
    Get.to(() => Cv1Output(cvModel: model));
  } else {
    Get.snackbar("Error", "Invalid model type for _cv1_no1");
  }
}

void _cv1_special(String type, dynamic model) {
  if (model is CvModel) {
    // Ví dụ: mở màn hình khác hoặc xử lý đặc biệt
    Get.snackbar("Info", "Handling cv1_special with CvModel");
    // Bạn thêm code xử lý ở đây
  } else {
    Get.snackbar("Error", "Invalid model type for _cv1_special");
  }
}

void _cv2_no2(String type, dynamic model) {
  if (model is CvModelV2) {
    Get.to(() => Cv2Output(model: model));
  } else {
    Get.snackbar("Error", "Invalid model type for _cv2_no2");
  }
}

void _cv2_alt(String type, dynamic model) {
  if (model is CvModelV2) {
    // Xử lý khác cho cv2_alt
    Get.snackbar("Info", "Handling cv2_alt with CvModelV2");
  } else {
    Get.snackbar("Error", "Invalid model type for _cv2_alt");
  }
}

void _cv3_no3(String type, dynamic model) {
  if (model is CvModelV3) {
    Get.to(() => Cv3Output(model: model));
  } else {
    Get.snackbar("Error", "Invalid model type for _cv3_no3");
  }
}

void _cv3_special(String type, dynamic model) {
  if (model is CvModelV3) {
    // Xử lý khác cho cv3_special
    Get.snackbar("Info", "Handling cv3_special with CvModelV3");
  } else {
    Get.snackbar("Error", "Invalid model type for _cv3_special");
  }
}
