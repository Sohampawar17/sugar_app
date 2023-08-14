import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../models/List_Crop_sampling_model.dart';
import '../../../services/list_crop_sampling_service.dart';

class ListSamplingModel extends BaseViewModel {
  List<ListSampling> samplingList = [];

  Color getTileColor(String? plantationStatus) {
    switch (plantationStatus) {
      case 'To Sampling':
        return const Color(0xFFEAF5EE);
      case 'To Harvesting':
        return const Color(0xFFFFF5F5);
      default:
        return const Color(0xFF404944);
    }
  }

  initialise(BuildContext context) async {
    setBusy(true);
    samplingList = (await ListCropSamplingServices().getAllCropSamplingList());
    // filteredagriList = agriList;
    setBusy(false);
    notifyListeners();
  }
}
