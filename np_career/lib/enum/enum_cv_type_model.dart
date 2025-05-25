import 'package:np_career/model/cv_model.dart';
import 'package:np_career/model/cv_model_v2.dart';
import 'package:np_career/model/cv_model_v3.dart';

enum CvTypeModel {
  cv1,
  cv2,
  cv3;

  static CvTypeModel fromString(String type) {
    switch (type) {
      case 'cv1':
        return CvTypeModel.cv1;
      case 'cv2':
        return CvTypeModel.cv2;
      case 'cv3':
        return CvTypeModel.cv3;
      default:
        throw Exception('Unknown CV type: $type');
    }
  }

  dynamic fromSnap(dynamic snapshot) {
    switch (this) {
      case CvTypeModel.cv1:
        return CvModel.fromSnap(snapshot);
      case CvTypeModel.cv2:
        return CvModelV2.fromSnap(snapshot);
      case CvTypeModel.cv3:
        return CvModelV3.fromSnap(snapshot);
    }
  }

  bool validateModel(dynamic model) {
    switch (this) {
      case CvTypeModel.cv1:
        return model is CvModel;
      case CvTypeModel.cv2:
        return model is CvModelV2;
      case CvTypeModel.cv3:
        return model is CvModelV3;
    }
  }
}
