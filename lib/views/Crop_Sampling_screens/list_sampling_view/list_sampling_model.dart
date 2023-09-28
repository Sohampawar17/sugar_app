import 'package:flutter/cupertino.dart';

import 'package:stacked/stacked.dart';

import '../../../constants.dart';
import '../../../models/list_crop_sampling_model.dart';
import '../../../router.router.dart';
import '../../../services/list_crop_sampling_service.dart';

class ListSamplingModel extends BaseViewModel {
  List<ListSampling> samplingList = [];
  List<ListSampling> filtersamplingList = [];

  TextEditingController idcontroller = TextEditingController();
  Color getTileColor(String? plantationStatus) {
    switch (plantationStatus) {
      case 'New':
        return const Color(0xFFD3E8FD);
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
    filtersamplingList = samplingList;
    setBusy(false);
    if (samplingList[0] == "401") {
      logout(context);
    }
    notifyListeners();
  }

  void filterList(String filter, int query) async {
    notifyListeners();
    filtersamplingList =
        await ListCropSamplingServices().getAllCropListfilter(filter, query);

    notifyListeners();
  }

  void onRowClick(BuildContext context, ListSampling? samplingList) {
    Navigator.pushNamed(
      context,
      Routes.addCropSamplingScreen,
      arguments: AddCropSamplingScreenArguments(
          samplingId: samplingList?.name.toString() ?? ""),
    );
    // Navigator.pushNamed(context, Routes.detailedFarmerScreen,
    //     arguments: DetailedFarmerScreenArguments(id: farmresList?.name ?? ""));
  }
}
